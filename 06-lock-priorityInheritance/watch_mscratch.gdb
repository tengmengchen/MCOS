# 定义变量记录当前 mscratch 值
set $last_mscratch = 0

# 定义钩子函数：每次单步后检查 mscratch
define hook-step
    # 读取当前 mscratch 值
    set $current_mscratch = $mscratch
    
    # 检测值变化
    if $current_mscratch != $last_mscratch
        printf "mscratch changed: 0x%lx → 0x%lx\n", $last_mscratch, $current_mscratch
        set $last_mscratch = $current_mscratch
    end
end

# 开始执行并监控
continue