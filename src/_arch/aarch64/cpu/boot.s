; Here we create a macro that takes in 
; a register and a symbol
.macro ADR_REL register symbol
    adrp    \register, \symbol
    add     \register, \register, #lo12:\symbol
.endm

.section .text._start

_start:
    ; move contents of the Program Status Register to a general purpose register
    ; PSR in this case is the `Multiprocessor Affinity Register`
    mrs     x0, MPIDR_EL1
    ; store result of `bitwise AND` for r0 & the bootCore 
    ; into r0
    and     x0, x0, {CONST_CORE_ID_MASK}
    ; store the found early boot core value into r1 
    ldr     x1, BOOT_CORE_ID
    ; compare (CORE_ID_MASK + MPIDR_EL1) with current BOOT_CORE_ID 
    cmp     x0, x1
    // if 
    b.ne    .L_parking_loop


.L_parking_loop:
	wfe
	b	.L_parking_loop

.size	_start, . - _start
.type	_start, function
.global	_start