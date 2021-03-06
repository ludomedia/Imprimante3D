EESchema Schematic File Version 2  date 14.07.2013 14:52:47
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
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "14 jul 2013"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R2
U 1 1 51E291E6
P 3400 2450
F 0 "R2" V 3480 2450 40  0000 C CNN
F 1 "6k8" V 3407 2451 40  0000 C CNN
F 2 "~" V 3330 2450 30  0000 C CNN
F 3 "~" H 3400 2450 30  0000 C CNN
	1    3400 2450
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 51E291F5
P 3400 2950
F 0 "R1" V 3480 2950 40  0000 C CNN
F 1 "2k2" V 3407 2951 40  0000 C CNN
F 2 "~" V 3330 2950 30  0000 C CNN
F 3 "~" H 3400 2950 30  0000 C CNN
	1    3400 2950
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 51E29226
P 3000 2950
F 0 "C1" H 3000 3050 40  0000 L CNN
F 1 "10u" H 3006 2865 40  0000 L CNN
F 2 "~" H 3038 2800 30  0000 C CNN
F 3 "~" H 3000 2950 60  0000 C CNN
	1    3000 2950
	1    0    0    -1  
$EndComp
$Comp
L RFP30N06LE Q1
U 1 1 51E29BC0
P 2450 2850
F 0 "Q1" H 2450 2702 40  0000 R CNN
F 1 "RFP30N06LE" H 2450 3000 40  0000 R CNN
F 2 "TO220" H 2350 2950 25  0000 C CIN
F 3 "~" H 2450 2850 60  0000 C CNN
	1    2450 2850
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 51E29BD9
P 2000 2900
F 0 "R3" V 2080 2900 40  0000 C CNN
F 1 "10k" V 2007 2901 40  0000 C CNN
F 2 "~" V 1930 2900 30  0000 C CNN
F 3 "~" H 2000 2900 30  0000 C CNN
	1    2000 2900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3000 2750 3000 2700
Wire Wire Line
	1250 3200 4600 3200
Wire Wire Line
	3000 3200 3000 3150
$Comp
L CONN_6 P2
U 1 1 51E29C2B
P 4950 2950
F 0 "P2" V 4900 2950 60  0000 C CNN
F 1 "CONN_6" V 5000 2950 60  0000 C CNN
F 2 "" H 4950 2950 60  0000 C CNN
F 3 "" H 4950 2950 60  0000 C CNN
	1    4950 2950
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P1
U 1 1 51E29C3A
P 900 2950
F 0 "P1" V 850 2950 60  0000 C CNN
F 1 "CONN_6" V 950 2950 60  0000 C CNN
F 2 "" H 900 2950 60  0000 C CNN
F 3 "" H 900 2950 60  0000 C CNN
	1    900  2950
	-1   0    0    1   
$EndComp
Connection ~ 3400 3200
Connection ~ 3000 3200
Connection ~ 3000 2700
Wire Wire Line
	2800 2700 2800 3100
Wire Wire Line
	2800 3100 1250 3100
Wire Wire Line
	1250 1650 1250 2700
$Comp
L +12V #PWR1
U 1 1 51E29E4B
P 1250 1650
F 0 "#PWR1" H 1250 1600 20  0001 C CNN
F 1 "+12V" H 1250 1750 30  0000 C CNN
F 2 "" H 1250 1650 60  0000 C CNN
F 3 "" H 1250 1650 60  0000 C CNN
	1    1250 1650
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR2
U 1 1 51E29E5A
P 1400 1800
F 0 "#PWR2" H 1400 1890 20  0001 C CNN
F 1 "+5V" H 1400 1890 30  0000 C CNN
F 2 "" H 1400 1800 60  0000 C CNN
F 3 "" H 1400 1800 60  0000 C CNN
	1    1400 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 2800 1400 2800
Wire Wire Line
	1400 2800 1400 1800
Wire Wire Line
	2800 2700 3600 2700
Connection ~ 3400 2700
Wire Wire Line
	3400 2200 3400 1800
Wire Wire Line
	3400 1800 1400 1800
Wire Wire Line
	1750 2900 1250 2900
Wire Wire Line
	2550 3050 2550 3200
Connection ~ 2550 3200
Wire Wire Line
	1250 1650 4000 1650
Wire Wire Line
	4000 1650 4000 2900
Wire Wire Line
	4000 2700 4600 2700
Wire Wire Line
	3600 2700 3600 3100
Wire Wire Line
	3600 3100 4600 3100
Wire Wire Line
	2550 2650 2550 1950
Wire Wire Line
	2550 1950 3800 1950
Wire Wire Line
	3800 1950 3800 2800
Wire Wire Line
	3800 2800 4600 2800
Wire Wire Line
	4000 2900 4600 2900
Connection ~ 4000 2700
Wire Wire Line
	4600 3000 4000 3000
Wire Wire Line
	4000 3000 4000 3200
Connection ~ 4000 3200
$EndSCHEMATC
