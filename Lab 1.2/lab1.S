.global lab1
.syntax unified
.global lab1
.syntax unified
#define a #2
#define b #8
#define c #3
lab1:
    push {lr}
    // calculate 
    mov r0, a
    mov r1, b
    mov r2, c
    bl calc
    pop {pc}
calc:
    push { r4, r5, lr }
    add r5, r0, r1
    mov r4, #2
    sdiv r5, r4
    mov r0, r2
    bl factorial
    add r0, r5
    pop { r4, r5, pc }

factorial:
    //param: 1 number
    push { r4 }
    mov r4, 1
    .fact_calc:
        mul r4, r0
        subs r0, #1
        bne .fact_calc
    mov r0, r4
    pop { r4 }
    bx lr
