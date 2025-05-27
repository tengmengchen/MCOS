#include "os.h"

MC_list_t timer_list;

/**
 * 定时器插入链表
*/
void MC_timer_list_insert(MC_list_t node)
{
    MC_list_t timerListOperator = timer_list;
    MC_timer_t timer, timerOperator;
    timer = MC_container_of(node, struct MC_timer, node);
    while(timerListOperator->next != NULL)
    {
        timerOperator = MC_container_of(timerListOperator->next, struct MC_timer, node);
        if(timerOperator->timeout_tick > timer->timeout_tick)
        {
            break;
        }
        timerListOperator = timerListOperator->next;
    }   
    
    if(timerListOperator->next == NULL)
    {
        timerListOperator->next = node;
        node->prev = timerListOperator;
        node->next = NULL;
    }
    else
    {
        node->prev = timerListOperator;
        node->next = timerListOperator->next;
        timerListOperator->next = node;
        node->next->prev = node;
    }
}

/**
 * 从定时器链表中移除指定定时器
*/
void MC_timer_list_remove(MC_list_t node)
{
    //定时器已经移除,避免重复操作
    if(node->prev == NULL)
    {
        return ;
    }

    node->prev->next = node->next;
    if(node->next != NULL)
    {
        node->next->prev = node->prev;
    }
    node->next = node->prev = NULL;
}

/**
 * 设置定时器属性
 * 注意设置的时候会把定时器从定时器队列中移除
*/
uint8_t MC_timer_control(MC_timer_t timer, int cmd, void *arg)
{
    switch(cmd)
    {
        case MC_TIMER_CTRL_SET_TIME:
            if(timer->flag & MC_TIMER_FLAG_ACTIVATED) //
            {
                MC_timer_list_remove(&timer->node);//移除定时器
                timer->flag &= ~MC_TIMER_FLAG_ACTIVATED;
            }
            timer->timeout_tick = *(uint32_t *)arg + MC_get_tick();
            break;
    }
    return 0;
}

/**
 * 启动定时器
*/
uint8_t MC_timer_start(MC_timer_t timer)
{
    MC_timer_list_insert(&timer->node);
    return 0;
}

/**
 * 初始化定时器, time以毫秒为单位
*/
void _timer_init(MC_timer_t timer,
                char *name,
                void (*timeout)(void *parameter),
                void *parameter,
                uint32_t time,
                uint8_t flag)
{
    if(timer_list == NULL)
    {
        timer_list = (MC_list_t)MC_PageMalloc(sizeof(struct MC_list));
        if(timer_list == NULL)
        {
            return ;
        }
        timer_list->prev = NULL;
        timer_list->next = NULL;
    }

    int len = MC_strlen(name);
    MC_memcpy(timer->name, name, len);

    timer->flag = flag;

    /*设置挂起*/
    timer->flag |= 1;

    timer->timeout_func = timeout;
    timer->parameter = parameter;

    timer->init_tick = time;
    timer->timeout_tick = time + MC_get_tick();
    timer->node.prev = NULL;
    timer->node.next = NULL;

    // MC_timer_list_insert(&timer->node);
}

/**
 * 静态初始化一个定时器
*/
uint8_t MC_timer_init(MC_timer_t timer,
                    char *name,
                    void (*timeout)(void *parameter),
                    void *parameter,
                    uint32_t time,
                    uint8_t flag)
{
    if(timer == NULL)
    {
        return 1;
    }

    _timer_init(timer, name, timeout, parameter, time, flag);

    return 0;
}

/**
 * 动态创建一个定时器
 */
MC_timer_t MC_timer_create(char *name,
                     void (*timeout)(void *parameter),
                     void *parameter,
                     uint32_t time,
                     uint8_t flag)
{
    MC_timer_t timer;

    timer = (struct MC_timer*)MC_PageMalloc(sizeof(struct MC_timer));
    if(timer == NULL)
    {
        return NULL;
    }
    
    _timer_init(timer, name, timeout, parameter, time, flag);
    return timer;
}




uint32_t _tick=0;

/**
 * systick周期设置
*/
void MC_timer_load(int interval)
{
    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    uint64_t  mtime;

    mtime = ((uint64_t)(rtk_controller->CNTH) << 32) + rtk_controller->CNTL;
    mtime += interval;
    rtk_controller->CMPHR = (uint32_t)(mtime >> 32);
    rtk_controller->CMPLR = (uint32_t)(mtime & 0xffffffff);

    rtk_controller->CTRL = 0x00000007;
}

/**
 * systick init
*/
void MC_SysTick_init()
{
    PFIC_IENR_t pfic_ienr = (PFIC_IENR_t)PFIC_IENR_BASE;
    pfic_ienr->IENRx[0] |= 1 << SYS_TICK_IRQ;//使能systick中断
    pfic_ienr->IENRx[0] |= 1 << SOFTWARE_IRQ; //使能软件中断

    MC_timer_load(TIMER_INTERVAL);
}

uint32_t MC_get_tick()
{
    return _tick;
}

/**
 * 执行定时器回调，并设置定时器
*/

void MC_timer_realse(MC_list_t node)
{
    MC_thread_t thread = NULL;
    MC_timer_t timer = NULL;

    timer = MC_container_of(node, struct MC_timer, node);

    

    if(node->next != NULL)
    {
        timer_list->next = node->next;
        node->next->prev = timer_list;
    }
    else
    {
        timer_list->next = NULL;
    }

    if(timer->timeout_func != NULL)
    {
        timer->timeout_func(timer->parameter);
    }
    
    // 如果不是线程定时器
    if(! (timer->flag & MC_TIMER_FLAG_THREAD_TIMER) )
    {
        if(timer->flag & MC_TIMER_FLAG_CYCLE_TIMER)
        {
            timer->timeout_tick = timer->init_tick + MC_get_tick();

            //再次插入定时器节点
            MC_timer_list_insert(node);
        }
        else
        {  
            timer->flag &= ~MC_TIMER_FLAG_ACTIVATED;
        }
    }
    

    //如果是线程定时器
    if(timer->flag & MC_TIMER_FLAG_THREAD_TIMER)
    {   
        thread = MC_container_of(timer, struct MC_thread, timer);

        //如果当前线程在运行中，则调度
        if(thread->state == MC_THREAD_STATE_RUNNING)
        {
            MC_scheduler_begin();
        }

        //如果当前线程被挂起，则恢复就绪态
        if(thread->state == MC_THREAD_STATE_SUSPEND)
        {
            MC_suspend_list_dequeue_timeout(thread);
        }
        
    }
    
}   

/**
 *  检查定时器超时情况
 */
void MC_timer_check()
{
    uint32_t next_timeout;
    
    if(timer_list->next != NULL)
    {
        MC_timer_t timer = MC_container_of(timer_list->next, struct MC_timer, node);
        next_timeout = timer->timeout_tick;
        if(next_timeout <= MC_get_tick())
        {
            MC_timer_realse(timer_list->next);
        }
    }
}

void MC_timer_handler() 
{
	_tick++;
    // if(_tick % 1000 == 0)
	//     printf("tick: %d\r\n", _tick / 1000);

    MC_timer_check();

    RTK_Controller_t rtk_controller = (RTK_Controller_t)RTK_BASE;
    rtk_controller->SR = 0;
	MC_timer_load(TIMER_INTERVAL);

}