EESchema Schematic File Version 2  date 27.06.2013 12:45:07
LIBS:marcha
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
LIBS:optoSwitch-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "27 jun 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L OPTOSWITCH IC1
U 1 1 51BC8DD8
P 3600 2750
F 0 "IC1" H 3412 2926 40  0000 C CNN
F 1 "OPTOSWITCH" H 3724 2566 40  0000 C CNN
F 2 "DIP4F" H 3436 2576 29  0000 C CNN
F 3 "~" H 3600 2750 60  0000 C CNN
	1    3600 2750
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 51BC8DED
P 3000 2400
F 0 "R1" V 3080 2400 40  0000 C CNN
F 1 "220R" V 3007 2401 40  0000 C CNN
F 2 "~" V 2930 2400 30  0000 C CNN
F 3 "~" H 3000 2400 30  0000 C CNN
	1    3000 2400
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 51BC8DFC
P 4200 2400
F 0 "R2" V 4280 2400 40  0000 C CNN
F 1 "4k7" V 4207 2401 40  0000 C CNN
F 2 "~" V 4130 2400 30  0000 C CNN
F 3 "~" H 4200 2400 30  0000 C CNN
	1    4200 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3950 2850 4200 2850
Wire Wire Line
	4200 2850 4200 3150
Wire Wire Line
	4200 3150 3000 3150
Wire Wire Line
	3000 3150 3000 2850
Wire Wire Line
	2400 2850 3250 2850
Wire Wire Line
	3000 2650 3250 2650
$Comp
L CONN_3 K1
U 1 1 51BC8E35
P 1900 2250
F 0 "K1" V 1850 2250 50  0000 C CNN
F 1 "CONN_3" V 1950 2250 40  0000 C CNN
F 2 "" H 1900 2250 60  0000 C CNN
F 3 "" H 1900 2250 60  0000 C CNN
	1    1900 2250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2250 2150 4200 2150
Connection ~ 3000 2150
Wire Wire Line
	3950 2650 4450 2650
Wire Wire Line
	4450 2650 4450 3350
Wire Wire Line
	4450 3350 2600 3350
Wire Wire Line
	2600 3350 2600 2250
Wire Wire Line
	2600 2250 2250 2250
Connection ~ 4200 2650
Wire Wire Line
	2400 2350 2400 2950
Wire Wire Line
	2400 2350 2250 2350
Connection ~ 3000 2850
$Comp
L GND #PWR01
U 1 1 51BC8E8A
P 2400 2950
F 0 "#PWR01" H 2400 2950 30  0001 C CNN
F 1 "GND" H 2400 2880 30  0001 C CNN
F 2 "" H 2400 2950 60  0000 C CNN
F 3 "" H 2400 2950 60  0000 C CNN
	1    2400 2950
	1    0    0    -1  
$EndComp
Connection ~ 2400 2850
$Comp
L +5V #PWR02
U 1 1 51BC8EAB
P 3000 1950
F 0 "#PWR02" H 3000 2040 20  0001 C CNN
F 1 "+5V" H 3000 2040 30  0000 C CNN
F 2 "" H 3000 1950 60  0000 C CNN
F 3 "" H 3000 1950 60  0000 C CNN
	1    3000 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3000 1950 3000 2150
$EndSCHEMATC
