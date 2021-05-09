.global task2
.syntax unified

task2:
	push {lr}
	mov r0, #2
	mov r1, #3
	
// 1)
	add r7, r1, r0
	
// 2)
	mul r7, r1, r0
	
// II
	bl first

jmp_to_3:
// 3)
	sub r7, r1, r0
	
// 4)
	ITEE VS
	
// 6)
	addVS r7, r1, r0
	
// 5)
	mulVC r7, r1, r0
	
// 7)
	subVC r7, r1, r0
	
// 8)
	bEQ jmp_to_3
	
// 9)
	add r7, r1, r0
	
	pop {pc}


first:
	push {lr}
	
jmp_to_10:
// 10)
	mov r7, #1
	lsrs r7, #1
	
// 11)
	bCC jmp_to_13
	
// X
	bl second

// 12)
	lsrs r7, #1
jmp_to_13:

// 13)
	bVC jmp_to_10
	
// 14)
	sub r7, r1, r0
	
// 15)
	add r7, r1, r0
	
	pop {pc}
	

second:
	push {lr}
	
// 17)
	and r7, r1, r0
	
// 18)
	orr r7, r1, r0
	
	pop {pc}
