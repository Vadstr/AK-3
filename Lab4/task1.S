.global task1
.syntax unified

#define NZK #8225

task1:
	push {lr}

// calculate function F = 8(X1 | X2) + (X3 - 1 - X4)/16

// get data memory
	ldr r7, =io_data
	
// load X1, X2 to regs
	ldm r7!, {r0, r1, r2, r3}
	
// X1 | X2
	orr r0, r2
	orr r1, r3
	
// to DK
	mov r5, r0
	mov r6, r1
	bl DK
	mov r0, r5
	mov r1, r6
	
// 8(X1 | X2)
	mov r2, #3	
.mult_8:
	lsls r1, #1
	lsl r0, r0, #1
	adc r0, #0
	subs r2, #1
	bne .mult_8
	
// load X3, X4 to regs
	ldm r7!, {r2, r3, r8, r9}
	
// X3 to DK
	mov r5, r2
	mov r6, r3
	bl DK
	mov r2, r5
	mov r3, r6
	
// X4 to DK
	mov r5, r8
	mov r6, r9
	bl DK
	mov r8, r5
	mov r9, r6
	
// X3 - 1
	subs r3, #1
	sbc r2, #0
	
// (X3 - 1 - X4)
	subs r3, r9
	sbc r2, r8
	
// (X3 - 1 - X4)/16
	mov r8, #4
.div_16:
	asrs r2, #1
	lsr r3, r3, #1
	IT CS
	orrCS r3, #0x80000000
	subs r8, #1
	bne .div_16
	
// 8(X1 | X2) + (X3 - 1 - X4)/16 in DK
	adds r3, r1
	adc r2, r0

// result correction
// 1)
	ITTT VS
	lsrVS r2, r2, #1
	lsrVS r3, r3, #1
	orrVS r2, #0x80000000
	
// 2)
	cmp r3, 0

// 3)	
	ITT EQ
	movEQ r3, NZK
	lslEQ r3, r3, #4
	
// 4)
	mov r2, NZK
	
// 5)
	and r0, r2, #0xC0000000
	cmp r0, #0x80000000
	
// 6)
	ITT EQ
	asrEQ r2, r2, #1
	lsrEQ r3, r3, #1
	
// 7)
	IT VC

// result to mem
	stmVC r7!, {r2, r3}

	pop {pc}


DK:
	push { lr }
	
// to DK
	cmp r5, 0
	
	IT GE
	popGE { pc }
	
	eor r6, #0xFFFFFFFF
	eor r5, #0xFFFFFFFF
	adds r6, #1
	adc r5, r5, #0
	orr r5, #0xC0000000
	
	pop { pc }
