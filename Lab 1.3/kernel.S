.syntax unified
.cpu cortex-m4
.thumb
#define a #5
#define b #3
#define c #3

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    start: .asciz "kernel started!\n"
    final: .asciz "Value in register #3: "
.section .text
__kernel_reset__:
    ldr r0, =start
    bl dbgput_line
// calculate 
    ldr r0, =final
    bl dbgput

lab1:    
    mov r0, a
    mov r1, b
    mov r2, c

    mov r3, 1       

    add r1, r1, r0  
    asr r1, r1, #1  

    cmp r2, #1
    ble factorial_end
    factorial: 
        mul r3, r3, r2  
        sub r2, r2, #1  
        cmp r2, #1
        bgt factorial   
    factorial_end:
    
    add r3, r3, r1 

    mov r0, r3
    bl dbgput_num   

end:
    b end
