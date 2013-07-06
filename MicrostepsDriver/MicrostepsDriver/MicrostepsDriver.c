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

#include <avr/delay.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

// 1 A
const unsigned char sinewave[] PROGMEM = {
	0,  3,  5,  8, 11, 13, 16, 19, 21, 24, 26, 29, 32, 34, 37, 39,
	42, 44, 47, 49, 51, 54, 56, 58, 61, 63, 65, 67, 69, 71, 73, 75,
	77, 79, 81, 83, 84, 86, 88, 89, 91, 92, 93, 95, 96, 97, 98, 100,
	101, 102, 103, 103, 104, 105, 106, 106, 107, 107, 108, 108, 108, 109, 109, 109,
	109, 109, 109, 109, 108, 108, 108, 107, 107, 106, 106, 105, 104, 103, 103, 102,
	101, 100, 98, 97, 96, 95, 93, 92, 91, 89, 88, 86, 84, 83, 81, 79,
	77, 75, 73, 71, 69, 67, 65, 63, 61, 58, 56, 54, 51, 49, 47, 44,
	42, 39, 37, 34, 32, 29, 26, 24, 21, 19, 16, 13, 11,  8,  5,  3
};

// 0.5 A
/*
const unsigned char sinewave[] PROGMEM = {
	0,  1,  3,  4,  5,  7,  8,  9, 11, 12, 13, 15, 16, 17, 18, 20,
	21, 22, 23, 24, 26, 27, 28, 29, 30, 31, 32, 34, 35, 36, 37, 38,
	39, 39, 40, 41, 42, 43, 44, 45, 45, 46, 47, 47, 48, 49, 49, 50,
	50, 51, 51, 52, 52, 53, 53, 53, 53, 54, 54, 54, 54, 54, 54, 54,
	54, 54, 54, 54, 54, 54, 54, 54, 53, 53, 53, 53, 52, 52, 51, 51,
	50, 50, 49, 49, 48, 47, 47, 46, 45, 45, 44, 43, 42, 41, 40, 39,
	39, 38, 37, 36, 35, 34, 32, 31, 30, 29, 28, 27, 26, 24, 23, 22,
	21, 20, 18, 17, 16, 15, 13, 12, 11,  9,  8,  7,  5,  4,  3,  1
};
*/
/*
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
*/
#define COIL_B_DIR DDRB
#define COIL_A_PORT PORTB
#define COIL_A_PIN_1 PB0
#define COIL_A_PIN_2 PB1
#define COIL_A_RS PA1
#define COIL_A_RS_ADCMUX 0b000001

#define COIL_A_DIR DDRA
#define COIL_B_PORT PORTA
#define COIL_B_PIN_1 PA3
#define COIL_B_PIN_2 PA2
#define COIL_B_RS PA7
#define COIL_B_RS_ADCMUX 0b000111

#define DIRECTION_PORT PINA
#define DIRECTION_PIN PA6

#define STOP 0
#define UP 1
#define DOWN 2

unsigned char step_inc = 16;
unsigned char microstep = 0;
unsigned char divisor = 0;

/*
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
		//steps++;
		if(DIRECTION_PORT & (1<<DIRECTION_PIN)) steps++;
		else steps--;
	}
}
*/
unsigned char analogRead() {
	ADCSRA |= (1<<ADSC); // Start conversion
	while(ADCSRA & (1<<ADSC)); // Wait end of conversion
	return ADCH;
}

#define COIL_A_FORWARD	COIL_A_PORT &= ~(1<<COIL_A_PIN_1); COIL_A_PORT |=  (1<<COIL_A_PIN_2)
#define COIL_A_OFF		COIL_A_PORT &= ~(1<<COIL_A_PIN_1); COIL_A_PORT &= ~(1<<COIL_A_PIN_2)
#define COIL_A_REVERSE	COIL_A_PORT |=  (1<<COIL_A_PIN_1); COIL_A_PORT &= ~(1<<COIL_A_PIN_2)

#define COIL_B_FORWARD	COIL_B_PORT &= ~(1<<COIL_B_PIN_1); COIL_B_PORT |=  (1<<COIL_B_PIN_2)
#define COIL_B_OFF		COIL_B_PORT &= ~(1<<COIL_B_PIN_1); COIL_B_PORT &= ~(1<<COIL_B_PIN_2)
#define COIL_B_REVERSE	COIL_B_PORT |=  (1<<COIL_B_PIN_1); COIL_B_PORT &= ~(1<<COIL_B_PIN_2)

#define SELECT_ADC_A ADMUX = (1<<REFS1)|(0<<REFS0)|COIL_A_RS_ADCMUX
#define SELECT_ADC_B ADMUX = (1<<REFS1)|(0<<REFS0)|COIL_B_RS_ADCMUX
#define START_CONVERSION ADCSRA |= (1<<ADSC);
#define WAIT_FOR_CONVERSION	while(ADCSRA & (1<<ADSC));

int main(void)
{
	COIL_A_DIR = (1<<COIL_A_PIN_1) | (1<<COIL_A_PIN_2);
	COIL_B_DIR = (1<<COIL_B_PIN_1) | (1<<COIL_B_PIN_2);

	DDRB &= ~(1<<PB2); // INT0 as entry
	MCUCR |= (1<<ISC01)|(1<<ISC00); // rising edge on INT0
			
	ADMUX = (1<<REFS1)|(0<<REFS0)|COIL_A_RS_ADCMUX; // Reference to 1.1V
	ADCSRA = (1<<ADEN)|(0<<ADPS2)|(1<<ADPS1)|(1<<ADPS0); // prescalar 8 (1MHz)
	ADCSRB = (1<<ADLAR); // Left alignement for reading ADCH only 
	DIDR0 = (1<<COIL_A_RS)|(1<<COIL_B_RS); // Reduce power consumption of unneeded digital inputs
	
	int cpt = 0;
	unsigned char dir;
	unsigned char voltage;
	signed char steps = 0;
	
    while(1) {

		/*cpt++;
		if(cpt==25) {
			cpt = 0;
			steps++;
		}
		*/
		
		if(GIFR & (1<<INTF0)) { // check if an interrupt request occured on INT0
			GIFR |= (1<<INTF0); // write one to clear the flag
			if(DIRECTION_PORT & (1<<DIRECTION_PIN)) steps++;
			else steps--;
		}				

		if(steps>0) {
			microstep += step_inc;
			steps--;
		}
		else if(steps<0) {
			microstep -= step_inc;
			steps++;
		}
		unsigned char i = microstep;
		
		SELECT_ADC_A;
		//_delay_us(50);
		START_CONVERSION;
		dir = i & 0x80;
		voltage = pgm_read_byte_near(sinewave + (i & 0x7F));
		WAIT_FOR_CONVERSION;
		if(ADCH<voltage) {
			if(dir) {
				COIL_A_FORWARD;
			}
			else {
				COIL_A_REVERSE;
			}
		}
		else {
			COIL_A_OFF;
		}		

		i += 0x40; // dephasage

		SELECT_ADC_B;
		//_delay_us(50);
		START_CONVERSION;
		dir = i & 0x80;
		voltage = pgm_read_byte_near(sinewave + (i & 0x7F));
		WAIT_FOR_CONVERSION;
		if(ADCH<voltage) {
			if(dir) {
				COIL_B_FORWARD;
			}
			else {
				COIL_B_REVERSE;
			}
		}
		else {
			COIL_B_OFF;
		}

/*				
		for(cpt=0;cpt<50;cpt++) {
			unsigned char v = analogRead();
			if(v<50) {
				COIL_A_FORWARD;
			}		
			else {
				COIL_A_OFF;
			}		
			_delay_us(100);
		}		

		COIL_A_OFF;
		_delay_ms(50);

		//COIL_B_FORWARD;
		//COIL_A_FORWARD;
		//_delay_ms(10);
		//COIL_B_OFF;
		//COIL_A_OFF;
		//_delay_ms(5);
*/
	}
}



