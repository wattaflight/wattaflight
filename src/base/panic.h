/*
 * SPDX-FileCopyrightText:  2026 WattaFlight contributors
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#pragma once

#define panic(msg)    panic_at(__FILE__, __LINE__, msg)
#define unreachable() panic("Unreachable code")

[[noreturn]] inline static void panic_at(const char *file, unsigned int line, const char *msg) {
    (void)file;
    (void)line;
    (void)msg;

    __builtin_unreachable();
}
