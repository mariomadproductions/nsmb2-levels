@
@   New Super Mario Bros. 2 - romfs2sdmc
@
@   by RicBent
@   heavily based on SaltySD by shinyquagsire
@

@ Functions in NSMB2
@   - 0013FC70 fsTryOpenFile
@   - 001109E4 fsMountArchive
@   - 00117DAC fsRegisterArchive
@   - 001416E0 fsMountSd    (calls fsMountArchive and fsRegisterArchive)

.text
.align 4

@ Helper Functions

@ MemCopy(void* dest, void* src, uint num)
MemCopy:
    ldrb r3, [r1], #1
    strb r3, [r0], #1
    subs r2, r2, #1
    bge MemCopy
    bx lr


.global TryOpenFile_Payload
TryOpenFile_Payload:
    mov r6, r0              @ file ptr
    cmp r4, #0xBA           @ magic check
    beq exit

    push {r0-r12, lr}
        sub sp, sp, #0x20
        mov r7, r1          @ input file path
        mov r8, r2          @ mode

        ldrh r3, [r7, #0x0]
        cmp r3, #0x64       @ Filter out "data:/"
        beq abort

        @ Mount SD if necessary
        bl check_mount_sd

        @ Modify path so that it points to our sdmc path
        ldr r0, =path_buf
        ldr r1, =sdmount_wchar
        mov r2, #(sdmount_wchar_end-sdmount_wchar-2)
        bl MemCopy

        ldr r0, =path_buf
        add r0, #(sdmount_wchar_end-sdmount_wchar-2)
        mov r1, r7
        ldrh r3, [r7, #0x6]
        cmp r3, #0x3A           @ if path[3] == ':'
        addeq r1, #0x8
        addne r1, #0xA
        mov r3, #(sdmount_wchar_end-sdmount_wchar-2)
        mov r2, #0x400
        sub r2, r2, r3
        bl MemCopy

        @ Try to load file from sdmc
        mov r0, r6          @ file ptr
        ldr r1, =path_buf   @ modified path
        mov r2, r8          @ mode
        mov r4, #0xBA       @ magic check
        bl 0x0013FC70       @ TryOpenFile(filePtr, modifiedPath, mode, magicCheck)

        @ If we get a 0 result, we have a good file handle
        @ and can return
        cmp r0, #0x0
        beq success

abort:
        add sp, sp, #0x20
    pop {r0-r12, lr}

exit:
    b (0x0013FC70+8)

success:
    add sp, sp, #0x20
    pop {r0-r12, lr}
    b (0x0013FC70+0x8C)


check_mount_sd:
    push {r0-r4, lr}
        ldr r0, =sdmounted
        ldrb r0, [r0]
        cmp r0, #0x0
        bne skip_mount
        ldr r0, =sdmount
        mov r1, #0xF0000001
        bl 0x001416E0   @ fsMountSdmc
        ldr r0, =sdmounted
        mov r1, #0x1
        strb r1, [r0]
skip_mount:
    pop {r0-r4, pc}


.data
.align 4

sdmount:
    .ascii "sd_:"
    .byte 0

sdmounted:
    .byte 0

sdmount_wchar:
    @ sd_:/nsmb2/
    .2byte 0x0073, 0x0064, 0x005f, 0x003a, 0x002f, 0x006e, 0x0073, 0x006d, 0x0062, 0x0032, 0x002f
sdmount_wchar_end:

.align 4
path_buf:
    .space  0x400, 0x00
