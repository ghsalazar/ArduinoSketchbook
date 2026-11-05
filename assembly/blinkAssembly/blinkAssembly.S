// blinkAssembly -- Blinks BUILTIN_LED using assembly.
//
// BSD Zero Clause License
// 
// Copyright (c) 2026 Instituto Politécnico Nacional, and Gastón Hugo Salazar Silva
//
// Permission to use, copy, modify, and/or distribute this software for any
// purpose with or without fee is hereby granted.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
// REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
// AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
// INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
// LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
// OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
// PERFORMANCE OF THIS SOFTWARE.

.syntax unified

.global pinMode
.global digitalWrite
.global delay

.global setup
.global loop

.equ    LED_BUILTIN, 13
.equ    OUTPUT, 1
.equ    HIGH, 1
.equ    LOW, 0

setup:  push {lr}
        mov r0, LED_BUILTIN
        mov r1, OUTPUT
        bl pinMode
        pop {lr}
        bx lr

loop:   push {lr}
        mov r0, LED_BUILTIN
        mov r1, HIGH
        bl digitalWrite
        ldr r0, =500
        bl delay
        mov r0, LED_BUILTIN
        mov r1, LOW
        bl digitalWrite
        ldr r0, =500
        bl delay
        pop {lr}
        bx lr
