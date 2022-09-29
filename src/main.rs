#![no_std]
#![no_main]
//! The `kernel` binary.
//! 1. The kernel's entry point is the function `cpu::boot::arch_boot::_start()`.
//!     - It is implemented in `src/_arch/__arch_name__/cpu/boot.s`.

mod cpu;
mod bsp;
mod panic;