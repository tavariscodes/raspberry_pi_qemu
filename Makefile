##----------------------------------------------------------------------------------------------
## Board Support Package: config
##----------------------------------------------------------------------------------------------
BSP 					= rpi4

TARGET					= aarch64-unknown-none-softfloat
KERNEL_BIN 				= kernel8.img
QEMU_BINARY 			= qemu-system-aarch64
QEMU_MACHINE_TYPE		= 	
OBJDUMP_BINARY			= aarch64-none-elf-objdump
NM_BINARY				= aarch64-none-elf-nm
READELF_BINARY 			= aarch64-none-elf-readelf
LD_SCRIPT_PATH			= $(shell pwd)/src/bsp/rasberrypi

export LD_SCRIPT_PATH

##----------------------------------------------------------------------------------------------
## Targets and prerequisites
##----------------------------------------------------------------------------------------------
KERNEL_MANIFEST			= Cargo.toml
KERNEL_LINKER_SCRIPT	= kernel.ld
LAST_BUILD_CONFIG		= target/$(BSP)/release/kernel

KERNEL_ELF 				= target/$(TARGET)/release/kernel

##----------------------------------------------------------------------------------------------
## Command variables
##----------------------------------------------------------------------------------------------
FEATURES 				= --features bsp_$(BSP)

COMPILER_ARGS			= --target=$(TARGET) $(FEATURES) --release
QEMU_RELEASE_ARGS		= -d in_asm -display none
RUSTC_CMD  				= cargo rustc $(COMPILER_ARGS)
DOC_CMD					= cargo doc $(COMPILER_ARGS)

EXEC_QEMU 				= $(QEMU_BINARY) -M $(QEMU_MACHINE_TYPE)

##----------------------------------------------------------------------------------------------
## Targets
##----------------------------------------------------------------------------------------------

.PHONY: doc qemu

doc: 
		$(call color_header, "Generating docs")
		@$(DOC_CMD) --document-private-items --open
qemu: $(KERNEL_BIN)
		$(call color_header, "Launching QEMU")
		$(EXEC_QEMU) $(QEMU_RELEASE_ARGS) -kernel $(KERNEL_BIN)