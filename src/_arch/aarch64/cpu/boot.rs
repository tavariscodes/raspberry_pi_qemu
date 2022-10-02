use core::arch::global_asm;
// Load assembly from boot.s
global_asm!(include_str!("boot.s"), CONST_CORE_ID_MASK = const 0b11); 