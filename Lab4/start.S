.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

// Global memory locations.
.global vtable
.global __hard_reset__

.global io_data

/*
 * vector table
 */
.type vtable, %object
.type __hard_reset__, %function
vtable:
	.word __stack_start 
	.word __hard_reset__+1
	.size vtable, .-vtable

__hard_reset__:
// initialize stack here
// if not initialized yet
	bl task1
	bl task2
	_loop: b _loop
	.size __hard_reset__, .-__hard_reset__

io_data:
	.word 	0
	.word	12
	.word	0
	.word	2
	.word	0xC0000000
	.word	10
	.word	0
	.word	15
	.word	0
	.word	0
