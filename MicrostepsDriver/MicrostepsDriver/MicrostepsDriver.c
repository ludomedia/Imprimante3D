/*
 * MicrostepsDriver.c
 *
 * Created: 06.06.2013 19:50:59
 * Author: marc
 *
 *
 * -pattiny45 -P\\.\COM4 -b19200 -carduino -C"C:\$(Device)Program Files (x86)\arduino-1.0.4\hardware\tools\avr\etc/avrdude.conf" -v -v -Uflash:w:"$(ProjectDir)Debug\$(ItemFileName).hex":i
 * -p attiny45 -carduino -P\\.\COM4 -b19200 -U lfuse:w:0xE2:m -U hfuse:w:0xdf:m -C"C:\$(Device)Program Files (x86)\arduino-1.0.4\hardware\tools\avr\etc/avrdude.conf" -v -v
 *
 * -pattiny84 -P\\.\COM4 -b19200 -carduino -C"C:\$(Device)Program Files (x86)\arduino-1.0.4\hardware\tools\avr\etc/avrdude.conf" -v -v -Uflash:w:"$(ProjectDir)Debug\$(ItemFileName).hex":i
 * -pattiny84 -P\\.\COM4 -b19200 -carduino -U lfuse:w:0xE2:m -U hfuse:w:0xdf:m -C"C:\$(Device)Program Files (x86)\arduino-1.0.4\hardware\tools\avr\etc/avrdude.conf" -v -v
 *
 */ 

#include <avr/interrupt.h>
#include <avr/pgmspace.h>

const uint8_t sinewave[] PROGMEM = {
	128,131,134,137,140,144,147,150,153,156,159,162,165,168,171,174,
	177,179,182,185,188,191,193,196,199,201,204,206,209,211,213,216,
	218,220,222,224,226,228,230,232,234,235,237,239,240,241,243,244,
	245,246,248,249,250,250,251,252,253,253,254,254,254,255,255,255,
	255,255,255,255,254,254,254,253,253,252,251,250,250,249,248,246,
	245,244,243,241,240,239,237,235,234,232,230,228,226,224,222,220,
	218,216,213,211,209,206,204,201,199,196,193,191,188,185,182,179,
	177,174,171,168,165,162,159,156,153,150,147,144,140,137,134,131,
	128,125,122,119,116,112,109,106,103,100, 97, 94, 91, 88, 85, 82,
	79, 77, 74, 71, 68, 65, 63, 60, 57, 55, 52, 50, 47, 45, 43, 40,
	38, 36, 34, 32, 30, 28, 26, 24, 22, 21, 19, 17, 16, 15, 13, 12,
	11, 10,  8,  7,  6,  6,  5,  4,  3,  3,  2,  2,  2,  1,  1,  1,
	1,  1,  1,  1,  2,  2,  2,  3,  3,  4,  5,  6,  6,  7,  8, 10,
	11, 12, 13, 15, 16, 17, 19, 21, 22, 24, 26, 28, 30, 32, 34, 36,
	38, 40, 43, 45, 47, 50, 52, 55, 57, 60, 63, 65, 68, 71, 74, 77,
	79, 82, 85, 88, 91, 94, 97,100,103,106,109,112,116,119,122,125
};

#define COIL_B_DIR DDRB
#define COIL_A_PORT PORTB
#define COIL_A_PIN_1 PB0
#define COIL_A_PIN_2 PB1

#define COIL_A_DIR DDRA
#define COIL_B_PORT PORTA
#define COIL_B_PIN_1 PA3
#define COIL_B_PIN_2 PA2

#define DIRECTION_PORT PORTA
#define DIRECTION_PIN PA6

#define STOP 0
#define UP 1
#define DOWN 2

unsigned char step_inc = 32;
unsigned char microstep = 0;
unsigned char divisor = 0;

volatile signed char steps = 0;

ISR(TIM0_OVF_vect)
{
	//PORTA ^= (1<<PA0);

	divisor++;
	divisor = divisor & 0x03;
	if(divisor==0) {
		if(steps>0) {
			microstep += step_inc;
			steps--;
		}			
		else if(steps<0) {
			microstep -= step_inc;
			steps++;
		}
		unsigned char i = microstep;
		OCR0A = pgm_read_byte_near(sinewave + i);
		i += 0x40;
		OCR0B = pgm_read_byte_near(sinewave + i);
	}
	COIL_A_PORT &= ~(1<<COIL_A_PIN_1);
	COIL_A_PORT |= (1<<COIL_A_PIN_2);
	COIL_B_PORT &= ~(1<<COIL_B_PIN_1);
	COIL_B_PORT |= (1<<COIL_B_PIN_2);
	
	//PORTA &= ~((1<<PA4)|(1<<PA2));
	//PORTA |= (1<<PA5)|(1<<PA3);
}

ISR(TIM0_COMPA_vect) {
	COIL_A_PORT |= (1<<COIL_A_PIN_1);
	COIL_A_PORT &= ~(1<<COIL_A_PIN_2);	
	//PORTA &= ~(1<<PA5);
	//PORTA |= (1<<PA4);
}

ISR(TIM0_COMPB_vect) {
	COIL_B_PORT |= (1<<COIL_B_PIN_1);
	COIL_B_PORT &= ~(1<<COIL_B_PIN_2);
	//PORTA &= ~(1<<PA3);
	//PORTA |= (1<<PA2);	
}


int main(void)
{
	//init_usart();
	OCR0A	=	0x40;		// PWM 1
	OCR0B	=	0x60;		// PWM 2
	//OCR0C	=	0xFF;
	
	//DDRB = 0xFF; //(1<<DDB5)|(1<<DDB4)|(0<<DDB3)|(0<<DDB2)|(1<<DDB1)|(0<<DDB0);
	//DDRA = 0xFF; //(1<<DDB5)|(1<<DDB4)|(0<<DDB3)|(0<<DDB2)|(1<<DDB1)|(0<<DDB0);
	COIL_A_DIR = (1<<COIL_A_PIN_1) | (1<<COIL_A_PIN_2);
	COIL_B_DIR = (1<<COIL_B_PIN_1) | (1<<COIL_B_PIN_2);

	DDRB &= ~(1<<PB2); // INT0 as entry
	MCUCR |= (1<<ISC01)|(1<<ISC00); // rising edge on INT0
			
	TCCR0A = (1<<COM0A1)|(0<<COM0A0)|(1<<COM0B1)|(0<<COM0B0)|(1<<WGM01)|(1<<WGM00);			// Fast PWM Non inverting mode TOP = 0xFF
	//TCCR0B = (0<<WGM02)|(0<<CS02)|(0<<CS01)|(1<<CS00);										// No prescaling
	TCCR0B = (0<<WGM02)|(0<<CS02)|(1<<CS01)|(0<<CS00);										// 8 prescaling
	TIMSK0 = (1<<TOIE0)|(1<<OCIE0A)|(1<<OCIE0B);											// Enable Timer 0 overflow interrupt
	
	sei();

    while(1) {
		if(GIFR & (1<<INTF0)) { // check if an interrupt request occured on INT0
			GIFR |= (1<<INTF0); // write one to clear the flag
			steps++;
			//if(DIRECTION_PORT & DIRECTION_PIN) steps++;
			//else steps--;
		}
	}
}
