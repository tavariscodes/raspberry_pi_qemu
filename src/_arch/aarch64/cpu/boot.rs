use core::arch::global_asm;

// Load assembly from boot.s
global_asm!(include_str!("boot.s")); 