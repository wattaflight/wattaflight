/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

ENTRY(reset_handler);

_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
  .vector_table : {
    KEEP(*(.vector_table))
    . = ALIGN(4);
  } >FLASH

  .text : {
    *(.text.reset_handler)
    *(.text*)
    *(SORT_BY_ALIGNMENT(.rodata*))
    . = ALIGN(4);
  } >FLASH

  .data : {
    _sidata = LOADADDR(.data);
    _sdata = .;
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >RAM AT> FLASH

  .bss (NOLOAD) : {
    _sbss = .;
    *(.bss*)
    . = ALIGN(4);
    _ebss = .;
  } >RAM

  .fastdata : {
    _sifastdata = LOADADDR(.fastdata);
    _sfastdata = .;
    *(.fastdata*)
    . = ALIGN(4);
    _efastdata = .;
  } >FASTRAM AT> FLASH

  .fastbss (NOLOAD) : {
    _sfastbss = .;
    *(.fastbss*)
    . = ALIGN(4);
    _efastbss = .;
  } >FASTRAM

  end = .;
}
