// handleSerialLedCommand -- Controls LED via hardware serial port.
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

//#define RS232
//#define RS485
//#define CH340

#if defined(ARDUINO_ARCH_RENESAS) && ( defined(RS232) || defined(RS485) || defined (CH340) )
#define SerialPort Serial1
#else
#define SerialPort Serial
#endif

void setup() {
	SerialPort.begin(9600);
	while (!SerialPort)
		;
	pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
	if (SerialPort.available())
		handleSerialLedCommand();
}

void handleSerialLedCommand(void) {
	String input = SerialPort.readStringUntil('\n');
	input.trim();

	if (input.equalsIgnoreCase("on")) {
		digitalWrite(LED_BUILTIN, HIGH);
	} else if (input.equalsIgnoreCase("off")) {
		digitalWrite(LED_BUILTIN, LOW);
	} else {
		SerialPort.print("ERROR: Unknown command: ");
		SerialPort.println(input);
	}
}