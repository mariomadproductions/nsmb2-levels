OUTPUT_ARCH(arm)

SECTIONS
{
    . = 0x0056a520;
    .text : {
        __text_start = . ;
        *(.text)
        *(.text.*)
        __text_end  = . ;
    }
    
    . = 0x006c5610;
    .data : {
        __data_start = . ;
        *(.rodata)
        *(.data)
        *(.bss)
        *(COMMON)
        __data_end  = . ;
    }
}
