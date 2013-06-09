/*! This file has been prepared for Doxygen automatic documentation generation.
 * \file uart.h
 * \brief This file implements a half duplex software driven uart.
 *
 * If other operating voltages and/or temperatures than 5 Volts and 25°C
 * are desired, consider calibrating the internal oscillator.
 */

#ifndef __UART_H
#define __UART_H

/*! \brief Baud Rate.
 *
 *  This is the baudrate at which the software UART will operate.
 *	Please choose one, and comment the others.
 */ 
#define _BR_9600				//!< Desired baudrate...choose one, comment the others.
//#define _BR_19200			//!< Desired baudrate...choose one, comment the others.
//#define _BR_38400			//!< Desired baudrate...choose one, comment the others.

//This section chooses the correct timer values for the chosen baudrate.
#ifdef  _BR_9600
    #define _TICKS2COUNT			100 //!< Ticks between two bits.
    #define _TICKS2WAITONE			100 //!< Wait one bit period.
    #define _TICKS2WAITHALF			50  //!< Wait half bit period.
#endif
#ifdef  _BR_19200
    #define _TICKS2COUNT			50 //!< Ticks between two bits.
    #define _TICKS2WAITONE			50 //!< Wait one bit period.
    #define _TICKS2WAITHALF			25 //!< Wait half bit period.
#endif
#ifdef  _BR_38400
    #define TICKS2COUNT				24 //!< Ticks between two bits.
    #define TICKS2WAITONE			24 //!< Wait one bit period.
    #define TICKS2WAITHALF			12 //!< Wait one and a half bit period.
#endif

/*!	\def _SYS_FREQ 
 *	\brief System clock frequency.
 *  This is the system clock frequency in MHz. 
 */
#define _SYS_FREQ	8

/*!	\def _TX_PIN
 *	\brief The pin which is to be configured as the soft-uART TXD(transmit) pin
 */
#define _TX_PIN		PB5

#define _TX_PIN_DDR	DDB5

/*!	\def _RX_PIN
 *	\brief The pin which is to be configured as the soft-uART RXD(receive) pin
 */
#define _RX_PIN PB2

#define _RX_PIN_DDR	DDB2

/*! \brief  Type defined enumeration holding software UART's state.
 *
 */
typedef enum 
{
	IDLE,					//!< Idle state, both transmit and receive possible.
	TXING,             		//!< Transmitting byte.
	RXING                   //!< Receiving byte.
}uartstate_t;

static volatile uartstate_t state;     //!< Holds the state of the UART.

/*! \fn void init_usart(void);
 *	\brief  Function to initialize the software UART.
 *
 *  This function will set up pins to transmit and
 *  receive on, and initialize control register of Timer0.
 *
 *  \return void
 */
void init_usart(void);

/*! \fn	void send_char(unsigned char value)
 *	\brief  Function to transmit an eight bit unsigned value from TXPIN
 *
 *	This function will transmit an eight bit unsigned value through
 * 	the soft-UART from the microcontroller's TXPIN
 *
 *  \param	unsigned char value
 *
 *  \return	void
 */
void send_char(unsigned char value);

/*! \fn	unsigned char recv_char(void) 
 *	\brief  Function to recieve an eight bit unsigned value from RXPIN
 *
 *	This function will recieve an eight bit unsigned value through
 * 	the soft-UART from the microcontroller's RXPIN
 *
 *  \return	unsigned char
 */
unsigned char recv_char(void);

#endif

/****************End of SOFT USART implementation *****************************/
/******************************************************************************/
