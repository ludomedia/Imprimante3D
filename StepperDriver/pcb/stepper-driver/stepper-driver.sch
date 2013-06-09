EESchema Schematic File Version 2  date 31.05.2013 22:06:06
LIBS:L298
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:stepper-driver-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "31 may 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L L298D U1
U 1 1 51A8E479
P 5950 3150
F 0 "U1" H 5950 3150 60  0000 C CNN
F 1 "L298D" H 5950 3250 60  0000 C CNN
F 2 "Multiwatt15-V" H 6150 3750 60  0000 C CNN
F 3 "" H 5950 3150 60  0000 C CNN
	1    5950 3150
	1    0    0    -1  
$EndComp
$Comp
L ATTINY84-P IC?
U 1 1 51A8E5DF
P 2550 3250
F 0 "IC?" H 1800 4000 60  0000 C CNN
F 1 "ATTINY84-P" H 3100 2500 60  0000 C CNN
F 2 "DIP14" H 1850 2500 60  0001 C CNN
F 3 "" H 2550 3250 60  0000 C CNN
	1    2550 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 3550 4400 3550
Wire Wire Line
	4400 3550 4400 3250
Wire Wire Line
	4400 3250 5100 3250
Wire Wire Line
	3600 3650 4550 3650
Wire Wire Line
	4550 3650 4550 3550
Wire Wire Line
	4550 3550 5100 3550
Wire Wire Line
	3600 2650 4500 2650
Wire Wire Line
	4500 2650 4500 3050
Wire Wire Line
	4500 3050 5100 3050
Wire Wire Line
	5100 3150 4400 3150
Wire Wire Line
	4400 3150 4400 2750
Wire Wire Line
	4400 2750 3600 2750
Wire Wire Line
	5100 3350 4150 3350
Wire Wire Line
	4150 3350 4150 2850
Wire Wire Line
	4150 2850 3600 2850
Wire Wire Line
	3600 2950 4050 2950
Wire Wire Line
	4050 2950 4050 3450
Wire Wire Line
	4050 3450 5100 3450
Wire Wire Line
	3600 3750 3850 3750
Wire Wire Line
	3850 3750 3850 4600
Wire Wire Line
	3600 3350 3950 3350
Wire Wire Line
	3950 3350 3950 4600
Wire Wire Line
	3600 3250 3950 3250
Wire Wire Line
	3950 3250 3950 2200
Wire Wire Line
	3600 3050 3850 3050
Wire Wire Line
	3850 3050 3850 2200
$EndSCHEMATC
