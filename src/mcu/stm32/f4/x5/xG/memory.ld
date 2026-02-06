/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

MEMORY
{
  FLASH (rx)   : ORIGIN = 0x8000000,  LENGTH = 1024K
  CCMRAM (rwx) : ORIGIN = 0x10000000, LENGTH = 64K
  RAM (rwx)    : ORIGIN = 0x20000000, LENGTH = 128K
}

REGION_ALIAS("FASTRAM", CCMRAM);
