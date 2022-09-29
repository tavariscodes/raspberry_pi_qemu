_this_should_be_entry = 0x80000;

ENTRY(_this_should_be_entry)

/* Flags:
 *     4 == R
 *     5 == RX
 *     6 == RW
 */

PHDRS
{
    segment_code PT_LOAD FLAGS(5);
}


SECTIONS 
{
    . = _this_should_be_entry;

    .text : 
    {
        KEEP(*(.text._start))
    } :segment_code
}