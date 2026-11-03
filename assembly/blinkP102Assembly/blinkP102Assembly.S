// blinkP102Assembly -- Blinks BUILTIN_LED using assembly and bit-banding.
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

.global setup
.global loop

.equ    PORT_BASE,      0x42800000  // Base address for the port via bit-banding on the Arduino UNO R4 WiFi.
.equ    PIN_LED_WRITE,  0x0408      // Port P102 output register offset
.equ    PIN_LED_MODE,   0x0508      // Port P102 operation mode register offset.

        // Setup port 102 as output.
setup:  ldr r0, =PORT_BASE
        mov r1, #1
        str r1, [r0, #PIN_LED_MODE]
        bx  lr

loop:   push {lr}

        // Turn on port 102 (BUILTIN_LED).
        ldr r0, =PORT_BASE
        mov r1, #1
        str r1, [r0, #PIN_LED_WRITE]

        // Branch to delay routine.
        bl delay1

        // Turn off port 102.
        ldr r0, =PORT_BASE
        mov r1, #0
        str r1, [r0, #PIN_LED_WRITE]

        // Branch to delay routine.
        bl delay1

        // Return to main.
        pop {lr}
        bx  lr

delay1: ldr r2, =0x7FFFFF
delay2: subs r2, r2, #1
        bne delay2              // Branch if not zero.
        bx lr                   // Return to loop.