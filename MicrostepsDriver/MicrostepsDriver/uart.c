/*! This file has been prepared for Doxygen automatic documentation generation.
 * \file uart.h
 * \brief This file implements a half duplex software driven uart.
 *
 * If other operating voltages and/or temperatures than 5 Volts and 25°C
 * are desired, consider calibrating the internal oscillator.
 */

#ifndef __UART_C
#define __UART_C

/*! \fn void bit_delay(void)
 *
 *  \brief  Function to implement a one bit delay.
 *
 *  \return void
 */
void bit_delay(void)
{
	TCCR0B |= ( 1 << CS01 );          	// Divide by 8 prescaler.
	TCNT0 = 0;                    		// Clear counter register.
	while(TCNT0 < _TICKS2WAITONE)
		;
}

/*! \fn void half_bit_delay(void)
 *
 *	\brief  Function to implement a half bit delay.
 *
 *  \return void
 */
void half_bit_delay(void)
{
	TCCR0B |= ( 1 << CS01 );          	// Divide by 8 prescaler.
	TCNT0 = 0;                    		// Clear counter register.
	while(TCNT0 < _TICKS2WAITHALF)
		;
}

/*! \fn void init_usart(void)
 *
 *	\brief  Function to initialize the software UART.
 *
 *  This function will set up pins to transmit and
 *  receive on, and initialize control register of Timer0.
 *
 *  \return void
 */
void init_usart(void)
{
	_DISABLE_TIMER1_OVERFLOW_INTERRUPT();
	state=IDLE;

	//Configure TXD pin
	PORTB |= (1<<_TX_PIN);
	DDRB  |= (1<<_TX_PIN_DDR);
	//Configure RXD pin
	PORTB|=(1<<_RX_PIN);
	DDRB &=~(1<<_RX_PIN_DDR); 
	_ENABLE_TIMER1_OVERFLOW_INTERRUPT();
}

/*! \fn	void send_char(unsigned char value)
 *
 *	\brief  Function to transmit an eight bit unsigned value from TXPIN
 *
 *	This function will transmit an eight bit unsigned value through
 * 	the soft-UART from the microcontroller's TXPIN
 *
 *  \param	value
 *
 *  \return	void
 */
void send_char(unsigned char value)
{
	//Initialize the soft-UART
	init_usart();
	
	int i=0;
	
	if(state==IDLE)
	{
		state = TXING;
		_DISABLE_TIMER1_OVERFLOW_INTERRUPT();
		//start bit (low)
		PORTB &= 0x1f;
		
		bit_delay();

		for(i=0;i<8;i++)
		{
			//if bit is one
			if( (value|0xfe)==0xff )
			{
				//send a high
				PORTB|=0x20;
				bit_delay();
			}
			else	//if bit low
			{
				//send a low
				PORTB&=0x1f;
				bit_delay();
			}
			//shift bits to right by one
			value=value>>1;
		}

		//Stop Bit		
		PORTB|=0x20;
		bit_delay();		

		TCCR0B=0x00;
		TCNT0=0;
	}

	state=IDLE;
	_ENABLE_TIMER1_OVERFLOW_INTERRUPT();
}


/*! \fn	unsigned char recv_char(void) 
 *	\brief  Function to recieve an eight bit unsigned value from RXPIN
 *
 *	This function will recieve an eight bit unsigned value through
 * 	the soft-UART from the microcontroller's RXPIN
 *
 *  \return	unsigned char
 */
unsigned char recv_char(void)
{
	//Initialize the soft-UART
	init_usart();
	
	unsigned char temp=0x00,temp2=0x01;
	
	int i=0;
	
	if(state==IDLE)
	{
		state=RXING;

		//Wait for start bit (low)
		while( (PINB&0x04)==0x04 )
			;
		_DISABLE_TIMER1_OVERFLOW_INTERRUPT();
		half_bit_delay();
		bit_delay();
		for(i=0;i<8;i++)
		{
			//If a high is encountered
			if( (PINB&0x04)==0x04 )
				temp= (temp|temp2);

			temp2=temp2<<1;
			bit_delay();
		}		
	}

	state=IDLE;
	half_bit_delay();		
	TCCR0B=0x00;
	TCNT0=0x00;
	_ENABLE_TIMER1_OVERFLOW_INTERRUPT();
	return temp;
}

#endif
/****************End of SOFT USART implementation *****************************/
/******************************************************************************/
