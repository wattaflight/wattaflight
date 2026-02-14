/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

MEMORY
{
  ITCMRAM (rwx)    : ORIGIN = 0x00000000, LENGTH = 64K
  FLASH   (rx)     : ORIGIN = 0x08000000, LENGTH = 2048K
  DTCMRAM (rwx)    : ORIGIN = 0x20000000, LENGTH = 128K
  RAM_D1  (rwx)    : ORIGIN = 0x24000000, LENGTH = 512K
  RAM_D2  (rwx)    : ORIGIN = 0x30000000, LENGTH = 288K
  RAM_D3  (rwx)    : ORIGIN = 0x38000000, LENGTH = 64K
  BACKUP_SRAM (rw) : ORIGIN = 0x38800000, LENGTH = 4K
}

REGION_ALIAS("RAM", RAM_D1);
REGION_ALIAS("FASTRAM", DTCMRAM);

INCLUDE "src/mcu/stm32/layout.ld"
