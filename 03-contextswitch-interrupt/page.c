#include "os.h"

extern ptr_t TEXT_START;
extern ptr_t TEXT_END;
extern ptr_t DATA_START;
extern ptr_t DATA_END;
extern ptr_t RODATA_START;
extern ptr_t RODATA_END;
extern ptr_t BSS_START;
extern ptr_t BSS_END;
extern ptr_t HEAP_START;
extern ptr_t HEAP_SIZE;
extern ptr_t STACK_START;
extern ptr_t STACK_END;

#define HEAP_ADDRESS_MASK (0x00000007) //块大小为8字节

#define heapBITS_PER_BYTE  ( 8 )
static size_t BlockAllocatiedBit;// (((size_t) 1) << (sizeof(size_t) * heapBITS_PER_BYTE - 1))
static size_t HeapSizeRemaing = 0;



typedef struct MC_BLOCK_LINK
{
    struct MC_BLOCK_LINK *MC_NextFreeBlock;
    size_t MC_BlockSize;
}BlockLink_t;

BlockLink_t Block_Start, *Block_End;

size_t Block_Size = (sizeof(BlockLink_t) + HEAP_ADDRESS_MASK) & (~HEAP_ADDRESS_MASK);

#define HEAP_MINMUM_SIZE ((size_t) (Block_Size << 1))

void MC_PageInit(void);

static void MC_InsertFreeBlock(BlockLink_t *New_Block)
{
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    for(BlockIterator = &Block_Start; BlockIterator->MC_NextFreeBlock < New_Block; BlockIterator = BlockIterator->MC_NextFreeBlock)
    {}
    
    BlockOperator = BlockIterator;

    if(BlockOperator + BlockIterator->MC_BlockSize == (uint8_t *)New_Block)
    {
        BlockIterator->MC_BlockSize += New_Block->MC_BlockSize;
        New_Block = BlockIterator;
    }else{}

    BlockOperator = (uint8_t *)New_Block;
    if(BlockOperator + New_Block->MC_BlockSize == (uint8_t *)BlockIterator->MC_NextFreeBlock)
    {
        if(BlockIterator->MC_NextFreeBlock != Block_End)
        {
            New_Block->MC_BlockSize += BlockIterator->MC_NextFreeBlock->MC_BlockSize;
            New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock->MC_NextFreeBlock;
        }
        else
        {
            New_Block->MC_NextFreeBlock = Block_End;
        }
    }
    else
    {
        New_Block->MC_NextFreeBlock = BlockIterator->MC_NextFreeBlock;
    }

    if(BlockIterator != New_Block)
    {
        BlockIterator->MC_NextFreeBlock = New_Block;
    }else{}

}

void *MC_PageMalloc(size_t MallocSize)
{
    BlockLink_t *Prev_Block = NULL, *Block = NULL, *New_Block = NULL;
    void *ReturnAddr = NULL;
    /* 应当挂起所有任务 */
    MC_scheduler_stop();
    /*----------------*/
    if(Block_End == NULL)
    {
        MC_PageInit();
    }
    else{}

    if((MallocSize & BlockAllocatiedBit) == 0)
    {
        if(MallocSize > 0)
        {
            MallocSize += Block_Size;
            if(MallocSize & HEAP_ADDRESS_MASK)
            {
                MallocSize = (MallocSize + HEAP_ADDRESS_MASK) & (~HEAP_ADDRESS_MASK);
            }
            
            if(MallocSize <= HeapSizeRemaing)
            {
                Prev_Block = &Block_Start;
                Block = Prev_Block->MC_NextFreeBlock;
                while(Block->MC_BlockSize < MallocSize && Block->MC_NextFreeBlock != NULL)
                {
                    Prev_Block = Block;
                    Block = Block->MC_NextFreeBlock;
                }

                if(Block != Block_End)
                {
                    ReturnAddr = (void *)((uint8_t *)Block + Block_Size);

                    Prev_Block->MC_NextFreeBlock = Block->MC_NextFreeBlock;

                    if(Block->MC_BlockSize - MallocSize > HEAP_MINMUM_SIZE)
                    {
                        New_Block = (BlockLink_t *)((uint8_t *)Block + MallocSize);

                        New_Block->MC_BlockSize = Block->MC_BlockSize - MallocSize;
                        Block->MC_BlockSize = MallocSize;
                        MC_InsertFreeBlock(New_Block);
                    }else{}
                    HeapSizeRemaing -= Block->MC_BlockSize;

                    Block->MC_BlockSize |= BlockAllocatiedBit;
                    Block->MC_NextFreeBlock = NULL;
                }else{}
            }else{}
        }else{}
    }else{}

    /* 应当恢复任务调度 */
    MC_scheduler_start();
    /*----------------*/


    return ReturnAddr;
}

void MC_PageInit(void)
{
    BlockLink_t *FirstFreeBlock;

    size_t TotalHeapSize = HEAP_SIZE;
    size_t HeapStart_Address = HEAP_START, HeapEnd_Address;

    if(HeapStart_Address & (HEAP_ADDRESS_MASK))
    {
        HeapStart_Address = (HeapStart_Address + HEAP_ADDRESS_MASK) & (~(HEAP_ADDRESS_MASK));
        TotalHeapSize -= HeapStart_Address - HEAP_START;
    }

    HeapEnd_Address = HeapStart_Address + TotalHeapSize;
    HeapEnd_Address -= Block_Size;
    
    Block_End = (BlockLink_t *)HeapEnd_Address;
    Block_End -> MC_BlockSize = 0;
    Block_End -> MC_NextFreeBlock = NULL;
    
    Block_Start.MC_BlockSize = 0;
    Block_Start.MC_NextFreeBlock = (BlockLink_t *)HeapStart_Address;

    FirstFreeBlock = (BlockLink_t *)HeapStart_Address;
    FirstFreeBlock -> MC_BlockSize = HeapEnd_Address - HeapStart_Address;
    FirstFreeBlock -> MC_NextFreeBlock = Block_End;

    HeapSizeRemaing = FirstFreeBlock -> MC_BlockSize;
    BlockAllocatiedBit = (((size_t) 1) << (sizeof(size_t) * heapBITS_PER_BYTE - 1));
}

void MC_PageFree(void *FreeAddr)
{
    BlockLink_t *BlockIterator;
    uint8_t *BlockOperator;
    if(FreeAddr != NULL)
    {
        BlockOperator = (uint8_t *)FreeAddr - Block_Size;
        BlockIterator = BlockOperator;

        if((BlockIterator->MC_BlockSize & BlockAllocatiedBit) != 0 && BlockIterator->MC_NextFreeBlock == NULL)
        {
            /*此处应该挂起所有任务*/
            MC_scheduler_stop();
            /*------------------*/
            BlockIterator->MC_BlockSize &= ~BlockAllocatiedBit;
            {
                HeapSizeRemaing += BlockIterator->MC_BlockSize;
                MC_InsertFreeBlock(BlockIterator);
            }
            /*此处应该取消所有被挂任务*/
            MC_scheduler_start();
            /*----------------------*/
        }else{}
    }else{}
}