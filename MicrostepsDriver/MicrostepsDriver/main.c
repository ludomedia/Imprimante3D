// This file has been prepared for Doxygen automatic documentation generation.
/*! \file main.c
 *
 * 	Atmel Corporation \n
 *
 * 	- File              : main.c	\n
 *
 * 	- Compiler          : IAR EWAVR 4.21a kickstart and AVR-GCC	\n
 *
 * 	- Support mail      : avr@atmel.com	\n
 *
 * 	- Supported devices : ATtiny25, ATtiny 45, ATtiny85 \n
 *
 * 	- AppNote           : Microstepper motor controller \n
 *  
 * 	- Description       : The full implementation is included in this file. \n
 * 
 * 	$Revision: 1.4 $ \n
 * 	$Date: Monday, February 19,2007 UTC $ \n
 */

/*!	\mainpage
 *
 *	\section Intro Introduction
 *	This and related pages contain the documentation for all the
 *	header files, source files, functions, variables, enums, and #defines
 *	related to the project 'Microstepper Motor Controller'.
 *
 *	\section CI Compilation Info
 *	This software was written for the IAR Embedded Workbench 4.21a kickstart
 *	and AVR-GCC compiler.
 *	\n
 */

#include "compiler.h"

/*! \var unsigned char count_down
 *	
 *	\brief Used to count down from an initial value (= speed) to zero. 
 */
unsigned char count_down=1;


/*!	\brief	Timer1 overflow interrupt subroutine  
 *	
 *	This is the the subroutine called when timer1 overflows. Many critical
 *	functions pertaining to the functioning of the code are performed here.
 *	Since this is a time critical interrupt, only few number of statements 
 *	must be executed within the interrupt which is fulfilled with a number 
 *	of if-then-else statements and switch-case constructs. \n\n\n
 *
 *	Case 'H':	Move to home \n
 *		
 *	If currently moving to Home 1, and a low voltage is recieved on PB0
 *	Sends DH1 on UART, sets current command to 'N' (representing No 
 *	Operation). \n
 *	  Else \n
 *	    Moves forward by one minor step					
 *	    If currently moving to Home 2, and a low voltage is recieved on 
 *	    PB3 Sends DH2 on UART, sets current command to 'N' (representing
 *	    No Operation) \n
 *	  Else \n
 *	    Moves forward by one minor step 		
 *	\code
 *	case 'H':	if(((PINB&0x01)==0) && (home==1))
 *				{
 *					curr_command='N';
 *					return;
 *				}
 *				
 *				if(((PINB&0x80)==0) && (home==2))
 *				{
 *					curr_command='N';
 *					return;
 *				}
 *				
 *				OCR1A=_SIN_TABLE(i);
 *				OCR1B=_COS_TABLE(i);
 *				i+=step;
 *				if(i==256)
 *					i=0;
 *				break;
 *	\endcode
 *	\n\n
 *  
 *	Case 'R' & 'F':	Move forward/reverse \n
 *					
 *	As long as there are any revolutions, major steps, or minor steps 
 *	left to move, move forward in the sine table by one step\n
 *	(   step    =   1   for forward		 \n
 *	    step    =   1   for backward   ) \n\n
 *	If not, sends DF/DR and sets the current command to N
 *	\code
 *	case 'R':
 *	case 'F':	if(revolutions>0&&major_step==0)
 *				{
 *					major_step=50;
 *					revolutions--;
 *					//if(revolutions==0)
 *						//rev_flag=1;
 *				}
 *				
 *				if(major_step>0)
 *	 			{		
 *					if(step_started==0)
 *					{
 *						pwmstate = i;
 *						i+=step;
 *						step_started=1;
 *					}
 *					else
 *					{
 * 						if(i==pwmstate)
 *						{
 *							step_started=0;
 *							major_step--;
 *						}
 *						else
 *							i+=step;
 *					}
 *				}
 *				else
 *				{
 *					pwmstate=minor_step;
 *					if(i!=pwmstate)
 *						i+=step;			
 *				}
 *				
 *				if(curr_command=='R')
 *				{					
 *					if(i==256)
 *						i=0;
 *					
 *					OCR1B=_SIN_TABLE(i);
 *					OCR1A=_COS_TABLE(i);								
 *				}
 *				else
 *				{
 *					if(i==256)
 *						i=0;
 *					OCR1A=_SIN_TABLE(i);
 *					OCR1B=_COS_TABLE(i);	
 *				}
 *				
 *			if((major_step==0)&&(i==minor_step)&&(revolutions==0))
 *			{
 *				if(curr_command=='R')
 *				{
 *					reverse_effect();
 *					minor_step=i;
 *				}
 *				curr_command='N';
 *			}
 *			break;
 *	\endcode
 */

#ifdef _IAR_C
#pragma vector	=	TIM1_OVF_vect
#endif
_TIMER1_OVERFLOW_INTERRUPT()
{
	count_down--;
	if(count_down<1)
		count_down=(1<<(speed-'1'));
	
	if(count_down==1)
	{
		switch(curr_command)
		{
			case 'H':	if(((PINB&0x01)==0) && (home==1))
						{
							curr_command='N';
							return;
						}
						
						if(((PINB&0x08)==0) && (home==2))
						{
							curr_command='N';
							return;
						}
						
						OCR1A=_SIN_TABLE(i);
						OCR1B=_COS_TABLE(i);
						i+=step;
						if(i==256)
							i=0;
						break;
			case 'R':
			case 'F':	if(revolutions>0&&major_step==0)
						{
							major_step=50;
							revolutions--;
						}
						
						if(major_step>0)
						{		
							if(step_started==0)
							{
								pwmstate = i;
								i+=step;
								step_started=1;
							}
							else
							{
								if(i==pwmstate)
								{
									step_started=0;
									major_step--;
								}
								else
									i+=step;
							}
						}
						else
						{
							pwmstate=minor_step;
							if(i!=pwmstate)
								i+=step;			
						}
						
						if(curr_command=='R')
						{					
							if(i==256)
								i=0;
							
							OCR1B=_SIN_TABLE(i);
							OCR1A=_COS_TABLE(i);					
						}
						else
						{
							if(i==256)
								i=0;
							OCR1A=_SIN_TABLE(i);
							OCR1B=_COS_TABLE(i);	
						}
						
					if((major_step==0)&&(i==minor_step)&&(revolutions==0))
					{
						if(curr_command=='R')
						{
							reverse_effect();
							minor_step=i;
						}
						curr_command='N';
					}
					break;
		/*!	\code
		 *	default:
		 *			OCR1A=_SIN_TABLE(i);
		 *			OCR1B=_COS_TABLE(i);
		 *	\endcode
		 *
		 *	\brief	Case default:	
		 *		
		 *	Mostly invoked in case the current command is N (No Operation)
		 *	Doesn't move either forward or backward in the sine table
		 *	Maintains the current PWM values indefinitely
		 */
			default:
					OCR1A=_SIN_TABLE(i);
					OCR1B=_COS_TABLE(i);
		}	
	}
}

/*!	\var unsigned char r1
 *	\brief This determines which action will be performed
 */	
unsigned char r1=0;

/*!	\fn int main(void)
 *	\brief The main function
 *
 *	1. Configures hardware PWM on PB1 and PB5 \n
 *	2. Configures PB0 and PB3 to allow external interrupts to occur. \n
 *	3. Enables all interrupts \n
 *	4. Enters an infinite loop, waiting for a valid command from UART: \n\n
 *	   A  :  Abort					\n
 *	   F  :  Move Forward			\n
 *	   R  :  Move reverse			\n
 *	   H  :  Move to home position	\n
 *	   S  :  Status					\n
 *	   V  :  Set velocity			\n\n
 *	On receiving a valid command, the corresponding function is	
 *	called for further processing.	\n\n
 *	NOTE: If a character other than the valid ones is received,
 *	 a E is sent, representing error.
 *
 *	\return int
 */
int main(void)
{
	_RESET_PORT();
	
	init_usart();
	
	_CONFIGURE_PWM1_CHANNEL();
	_CONFIGURE_PWM2_CHANNEL();
	_CONFIGURE_PWM_BASE_FREQ();
	
	_CONFIGURE_I_O_PINS();	
	_SET_INTERNAL_PULLUPS();
	
	_ENABLE_PWM1_CHANNEL();
	_ENABLE_PWM2_CHANNEL();
	
	_ENABLE_PLL();
	_DELAY_1000_CYCLES();
	_WAIT_TILL_PLL_LOCKED();
	_ENABLE_PLL_CLOCK_SOURCE();
	
	_ENABLE_TIMER1_OVERFLOW_INTERRUPT();
	_ENABLE_GLOBAL_INTERRUPTS();	
	_SET_TIMER1_FREQUENCY(1);
	
    while (1)
	{
		r1=recv_char();
		switch(r1)
		{
			case 'A':	abort();			
						break;
			case 'F':	forward();
						send_char('D');
						send_char('F');
						break;
			case 'R':	reverse();
						send_char('D');
						send_char('R');		
						break;
			case 'H':	to_home();
						send_char('D');
						send_char('H');
						send_char(home+'0');
						break;
			case 'S':	status();
						break;
			case 'V':	velocity();
						break;
			default:	{
							send_char('E');								
							break;
						}										
		}	
	}
	return 0;
}
