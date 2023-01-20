
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  _ext_int1_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x20003:
	.DB  0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
	.DB  0x38,0x39,0x41,0x42,0x43,0x44,0x45,0x46
_0x20004:
	.DB  0x10,0x20,0x40,0x80
_0x20007:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x57,0x65,0x6C,0x63,0x6F,0x6D,0x65,0x20
	.DB  0x74,0x6F,0x20,0x74,0x68,0x65,0x20,0x4D
	.DB  0x69,0x63,0x72,0x6F,0x70,0x72,0x6F,0x63
	.DB  0x65,0x73,0x73,0x6F,0x72,0x20,0x6C,0x61
	.DB  0x62,0x20,0x63,0x6C,0x61,0x73,0x73,0x65
	.DB  0x73,0x20,0x69,0x6E,0x20,0x49,0x73,0x66
	.DB  0x61,0x68,0x61,0x6E,0x20,0x55,0x6E,0x69
	.DB  0x76,0x65,0x72,0x73,0x69,0x74,0x79,0x20
	.DB  0x6F,0x66,0x20,0x54,0x68,0x65,0x63,0x6E
	.DB  0x6F,0x6C,0x6F,0x67,0x79,0x2E,0x20,0x0
_0x20000:
	.DB  0x69,0x6E,0x74,0x65,0x72,0x72,0x75,0x70
	.DB  0x74,0x0,0x67,0x68,0x61,0x66,0x6F,0x75
	.DB  0x72,0x69,0xA,0x39,0x38,0x32,0x35,0x34
	.DB  0x31,0x33,0x0,0x70,0x6F,0x6C,0x6C,0x69
	.DB  0x6E,0x67,0x0,0x53,0x79,0x73,0x74,0x65
	.DB  0x6D,0x20,0x49,0x6E,0x69,0x74,0xA,0x20
	.DB  0x25,0x73,0x3A,0x25,0x63,0x25,0x63,0x25
	.DB  0x73,0x0,0x28,0x30,0x2D,0x35,0x30,0x72
	.DB  0x29,0x0,0x53,0x70,0x65,0x65,0x64,0x0
	.DB  0x28,0x30,0x2D,0x39,0x39,0x73,0x29,0x0
	.DB  0x54,0x69,0x6D,0x65,0x0,0x28,0x30,0x2D
	.DB  0x39,0x39,0x4B,0x67,0x29,0x0,0x57,0x0
	.DB  0x28,0x32,0x30,0x2D,0x38,0x30,0x43,0x29
	.DB  0x0,0x54,0x65,0x6D,0x70,0x0,0x53,0x79
	.DB  0x73,0x74,0x65,0x6D,0x20,0x49,0x6E,0x69
	.DB  0x74,0xA,0x20,0x53,0x70,0x65,0x65,0x64
	.DB  0x3A,0x3F,0x3F,0x28,0x30,0x2D,0x35,0x30
	.DB  0x72,0x29,0x0,0x66,0x75,0x75,0x6B,0x6B
	.DB  0x6B,0x6B,0x0,0x53,0x79,0x73,0x74,0x65
	.DB  0x6D,0x20,0x49,0x6E,0x69,0x74,0xA,0x20
	.DB  0x54,0x69,0x6D,0x65,0x3A,0x3F,0x3F,0x28
	.DB  0x30,0x2D,0x39,0x39,0x73,0x29,0x0,0x53
	.DB  0x79,0x73,0x74,0x65,0x6D,0x20,0x49,0x6E
	.DB  0x69,0x74,0xA,0x20,0x54,0x69,0x6D,0x65
	.DB  0x3A,0x45,0x45,0x28,0x30,0x2D,0x39,0x39
	.DB  0x73,0x29,0x0,0x53,0x79,0x73,0x74,0x65
	.DB  0x6D,0x20,0x49,0x6E,0x69,0x74,0xA,0x20
	.DB  0x57,0x3A,0x3F,0x3F,0x28,0x30,0x2D,0x39
	.DB  0x39,0x4B,0x67,0x29,0x0,0x53,0x79,0x73
	.DB  0x74,0x65,0x6D,0x20,0x49,0x6E,0x69,0x74
	.DB  0xA,0x20,0x57,0x3A,0x45,0x45,0x28,0x30
	.DB  0x2D,0x39,0x39,0x4B,0x67,0x29,0x0,0x53
	.DB  0x79,0x73,0x74,0x65,0x6D,0x20,0x49,0x6E
	.DB  0x69,0x74,0xA,0x20,0x54,0x65,0x6D,0x70
	.DB  0x3A,0x3F,0x3F,0x28,0x32,0x30,0x2D,0x38
	.DB  0x30,0x43,0x29,0x0,0x53,0x79,0x73,0x74
	.DB  0x65,0x6D,0x20,0x49,0x6E,0x69,0x74,0xA
	.DB  0x20,0x54,0x65,0x6D,0x70,0x3A,0x45,0x45
	.DB  0x28,0x32,0x30,0x2D,0x38,0x30,0x43,0x29
	.DB  0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x10
	.DW  _data_key
	.DW  _0x20003*2

	.DW  0x04
	.DW  _row
	.DW  _0x20004*2

	.DW  0x0A
	.DW  _0x20005
	.DW  _0x20000*2

	.DW  0x11
	.DW  _0x20006
	.DW  _0x20000*2+10

	.DW  0x08
	.DW  _0x20023
	.DW  _0x20000*2+27

	.DW  0x08
	.DW  _0x20043
	.DW  _0x20000*2+58

	.DW  0x06
	.DW  _0x20043+8
	.DW  _0x20000*2+66

	.DW  0x08
	.DW  _0x20043+14
	.DW  _0x20000*2+72

	.DW  0x05
	.DW  _0x20043+22
	.DW  _0x20000*2+80

	.DW  0x09
	.DW  _0x20043+27
	.DW  _0x20000*2+85

	.DW  0x02
	.DW  _0x20043+36
	.DW  _0x20000*2+94

	.DW  0x09
	.DW  _0x20043+38
	.DW  _0x20000*2+96

	.DW  0x05
	.DW  _0x20043+47
	.DW  _0x20000*2+105

	.DW  0x1D
	.DW  _0x20047
	.DW  _0x20000*2+110

	.DW  0x08
	.DW  _0x20047+29
	.DW  _0x20000*2+139

	.DW  0x1C
	.DW  _0x20049
	.DW  _0x20000*2+147

	.DW  0x1C
	.DW  _0x20049+28
	.DW  _0x20000*2+175

	.DW  0x1A
	.DW  _0x2004D
	.DW  _0x20000*2+203

	.DW  0x1A
	.DW  _0x2004D+26
	.DW  _0x20000*2+229

	.DW  0x1D
	.DW  _0x20051
	.DW  _0x20000*2+255

	.DW  0x1D
	.DW  _0x20051+29
	.DW  _0x20000*2+284

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;#include <headers.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;void main(void)
; 0000 0004 {

	.CSEG
_main:
; .FSTART _main
; 0000 0005 #asm("cli");
	cli
; 0000 0006     init_configs();
	RCALL _init_configs
; 0000 0007     // q1_show_name();
; 0000 0008     // q2_show_welcome_message();
; 0000 0009     // q3_polling();
; 0000 000A     q5_display_info();
	RCALL _q5_display_info
; 0000 000B // #asm("sei");
; 0000 000C 
; 0000 000D     while (1);
_0x3:
	RJMP _0x3
; 0000 000E }
_0x6:
	RJMP _0x6
; .FEND
;
;
;
;
;
;
;
;
;
;#include <headers.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;char data_key[]={
;'0','1','2','3',
;'4','5','6','7',
;'8','9','A','B',
;'C','D','E','F'};

	.DSEG
;
;char row[] = { 0x10,0x20,0x40,0x80 };
;
;interrupt [EXT_INT1] void ext_int1_isr(void)
; 0001 000B {

	.CSEG
_ext_int1_isr:
; .FSTART _ext_int1_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0001 000C    char key;
; 0001 000D    PORTC=~PORTC;
	ST   -Y,R17
;	key -> R17
	IN   R30,0x15
	COM  R30
	OUT  0x15,R30
; 0001 000E    key = get_entered_key();
	CALL SUBOPT_0x0
; 0001 000F    lcd_gotoxy(0,0);
; 0001 0010    lcd_putchar(get_entered_data(key));
	RCALL _get_entered_data
	MOV  R26,R30
	RCALL _lcd_putchar
; 0001 0011    lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _lcd_gotoxy
; 0001 0012    lcd_puts("interrupt");
	__POINTW2MN _0x20005,0
	RCALL _lcd_puts
; 0001 0013 }
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND

	.DSEG
_0x20005:
	.BYTE 0xA
;
;void init_configs(){
; 0001 0015 void init_configs(){

	.CSEG
_init_configs:
; .FSTART _init_configs
; 0001 0016 DDRA=0xff;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0001 0017 DDRB=0xf0;
	LDI  R30,LOW(240)
	OUT  0x17,R30
; 0001 0018 DDRC=0xff;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0001 0019 DDRD=0x00;
	LDI  R30,LOW(0)
	OUT  0x11,R30
; 0001 001A PORTA=0x00;
	OUT  0x1B,R30
; 0001 001B PORTB=0xf0;
	LDI  R30,LOW(240)
	OUT  0x18,R30
; 0001 001C PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0001 001D PORTC=0x00;
	OUT  0x15,R30
; 0001 001E 
; 0001 001F GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x80
	OUT  0x3B,R30
; 0001 0020 MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(12)
	OUT  0x35,R30
; 0001 0021 MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0001 0022 GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(128)
	OUT  0x3A,R30
; 0001 0023 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0001 0024 }
	RET
; .FEND
;
;void q1_show_name(){
; 0001 0026 void q1_show_name(){
; 0001 0027     lcd_puts("ghafouri\n9825413");
; 0001 0028     delay_ms(2000);
; 0001 0029     lcd_clear();
; 0001 002A }

	.DSEG
_0x20006:
	.BYTE 0x11
;
;void q2_show_welcome_message(){
; 0001 002C void q2_show_welcome_message(){

	.CSEG
; 0001 002D     char i =0;
; 0001 002E     char welcome_message[]="Welcome to the Microprocessor lab classes in Isfahan University of Thecnology. ";
; 0001 002F     char display_message[16]="";
; 0001 0030     lcd_clear();
;	i -> R17
;	welcome_message -> Y+17
;	display_message -> Y+1
; 0001 0031 
; 0001 0032     for(i=0;i<strlen(welcome_message);i++){
; 0001 0033         strncpy(display_message,welcome_message+i,15);
; 0001 0034         lcd_gotoxy(0,1);
; 0001 0035         lcd_puts(display_message);
; 0001 0036         delay_ms(200);
; 0001 0037     }
; 0001 0038 }
;
;char get_entered_key(){
; 0001 003A char get_entered_key(){
_get_entered_key:
; .FSTART _get_entered_key
; 0001 003B char key =100;
; 0001 003C char c,r;
; 0001 003D for(r=0;r<4;r++){
	CALL __SAVELOCR4
;	key -> R17
;	c -> R16
;	r -> R19
	LDI  R17,100
	LDI  R19,LOW(0)
_0x2000C:
	CPI  R19,4
	BRSH _0x2000D
; 0001 003E PORTB = row[r];
	MOV  R30,R19
	LDI  R31,0
	SUBI R30,LOW(-_row)
	SBCI R31,HIGH(-_row)
	LD   R30,Z
	OUT  0x18,R30
; 0001 003F c=20;
	LDI  R16,LOW(20)
; 0001 0040 delay_ms(10);
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0001 0041 if (PINB.0==1) c=0;
	SBIC 0x16,0
	LDI  R16,LOW(0)
; 0001 0042 if (PINB.1==1) c=1;
	SBIC 0x16,1
	LDI  R16,LOW(1)
; 0001 0043 if (PINB.2==1) c=2;
	SBIC 0x16,2
	LDI  R16,LOW(2)
; 0001 0044 if (PINB.3==1) c=3;
	SBIC 0x16,3
	LDI  R16,LOW(3)
; 0001 0045 
; 0001 0046  if (c!=20){
	CPI  R16,20
	BREQ _0x20012
; 0001 0047  key=(r*4)+c;
	MOV  R30,R19
	LSL  R30
	LSL  R30
	ADD  R30,R16
	MOV  R17,R30
; 0001 0048    PORTB=0xf0;
	LDI  R30,LOW(240)
	OUT  0x18,R30
; 0001 0049   while (PINB.0==1) {}
_0x20013:
	SBIC 0x16,0
	RJMP _0x20013
; 0001 004A   while (PINB.1==1) {}
_0x20016:
	SBIC 0x16,1
	RJMP _0x20016
; 0001 004B   while (PINB.2==1) {}
_0x20019:
	SBIC 0x16,2
	RJMP _0x20019
; 0001 004C   while (PINB.3==1) {}
_0x2001C:
	SBIC 0x16,3
	RJMP _0x2001C
; 0001 004D   return key;
	MOV  R30,R17
	RJMP _0x2080002
; 0001 004E   }
; 0001 004F   }
_0x20012:
	SUBI R19,-1
	RJMP _0x2000C
_0x2000D:
; 0001 0050   PORTB = 0xf0;
	LDI  R30,LOW(240)
	OUT  0x18,R30
; 0001 0051   return key;
	MOV  R30,R17
	RJMP _0x2080002
; 0001 0052 }
; .FEND
;
;char get_entered_data(char entered_key){
; 0001 0054 char get_entered_data(char entered_key){
_get_entered_data:
; .FSTART _get_entered_data
; 0001 0055     return data_key[entered_key];
	ST   -Y,R26
;	entered_key -> Y+0
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-_data_key)
	SBCI R31,HIGH(-_data_key)
	LD   R30,Z
	RJMP _0x2080001
; 0001 0056 }
; .FEND
;
;void q3_polling(){
; 0001 0058 void q3_polling(){
; 0001 0059 
; 0001 005A     char i,key;
; 0001 005B    #asm("cli");
;	i -> R17
;	key -> R16
; 0001 005C     for(i=0;i<100;i++){
; 0001 005D      if(PINB !=0XF0){
; 0001 005E         lcd_gotoxy(0,0);
; 0001 005F         key = get_entered_key();
; 0001 0060         lcd_putchar(get_entered_data(key));
; 0001 0061         lcd_gotoxy(0,1);
; 0001 0062         lcd_puts("polling");
; 0001 0063 
; 0001 0064      }
; 0001 0065       delay_ms(100);
; 0001 0066     }
; 0001 0067      delay_ms(2000);
; 0001 0068 
; 0001 0069 }

	.DSEG
_0x20023:
	.BYTE 0x8
;
;
;int part5_keyscan(int ch, int loc, int func)
; 0001 006D {

	.CSEG
; 0001 006E     char str[40], num, str_func[20], str_func1[20],r,c,key;
; 0001 006F     if(ch == -1)
;	ch -> Y+88
;	loc -> Y+86
;	func -> Y+84
;	str -> Y+44
;	num -> R17
;	str_func -> Y+24
;	str_func1 -> Y+4
;	r -> R16
;	c -> R19
;	key -> R18
; 0001 0070         num = '?';
; 0001 0071     else
; 0001 0072         num = data_key[ch];
; 0001 0073 
; 0001 0074 
; 0001 0075 
; 0001 0076     DDRB = 0xF0;
; 0001 0077     while(1){
; 0001 0078     r=0;
; 0001 0079     for (r=0;r<4;r++)
; 0001 007A     {
; 0001 007B         PORTB=row[r];
; 0001 007C         c=20;
; 0001 007D         delay_ms(10);
; 0001 007E         if (PINB.0==1) c=0;
; 0001 007F         if (PINB.1==1) c=1;
; 0001 0080         if (PINB.2==1) c=2;
; 0001 0081         if (PINB.3==1) c=3;
; 0001 0082 
; 0001 0083         if (!(c==20)){
; 0001 0084             lcd_clear();
; 0001 0085             key=(r*4)+c;
; 0001 0086             PORTB=0xf0;
; 0001 0087             while (PINB.0==1) {}
; 0001 0088             while (PINB.1==1) {}
; 0001 0089             while (PINB.2==1) {}
; 0001 008A             while (PINB.3==1) {}
; 0001 008B             if(loc == 0)
; 0001 008C             {
; 0001 008D                 lcd_clear();
; 0001 008E                 sprintf(str, "System Init\n %s:%c%c%s", str_func1, data_key[key], num, str_func);
; 0001 008F                 lcd_puts(str);
; 0001 0090                 //delay_ms(1000);
; 0001 0091             }
; 0001 0092             if(loc == 1)
; 0001 0093             {
; 0001 0094                 lcd_clear();
; 0001 0095                 sprintf(str, "System Init\n %s:%c%c%s", str_func1, num, data_key[key], str_func);
; 0001 0096                 lcd_puts(str);
; 0001 0097                 //delay_ms(1000);
; 0001 0098             }
; 0001 0099             return key;
; 0001 009A         }
; 0001 009B         PORTB=0xf0;
; 0001 009C     }
; 0001 009D     }
; 0001 009E }
;
;void print_func_details(char function_type, char first_digit,char second_digit)
; 0001 00A1 {
; 0001 00A2     char display_message[40], func_valid_range[20], func_type[20];
; 0001 00A3     switch (function_type)
;	function_type -> Y+82
;	first_digit -> Y+81
;	second_digit -> Y+80
;	display_message -> Y+40
;	func_valid_range -> Y+20
;	func_type -> Y+0
; 0001 00A4     {
; 0001 00A5     case 0:
; 0001 00A6         strcpy(func_valid_range, "(0-50r)");
; 0001 00A7         strcpy(func_type, "Speed");
; 0001 00A8         break;
; 0001 00A9     case 1:
; 0001 00AA         strcpy(func_valid_range, "(0-99s)");
; 0001 00AB         strcpy(func_type, "Time");
; 0001 00AC         break;
; 0001 00AD     case 2:
; 0001 00AE         strcpy(func_valid_range, "(0-99Kg)");
; 0001 00AF         strcpy(func_type, "W");
; 0001 00B0         break;
; 0001 00B1 
; 0001 00B2     case 3:
; 0001 00B3         strcpy(func_valid_range, "(20-80C)");
; 0001 00B4         strcpy(func_type, "Temp");
; 0001 00B5         break;
; 0001 00B6     }
; 0001 00B7 
; 0001 00B8     lcd_clear();
; 0001 00B9     sprintf(display_message, "System Init\n %s:%c%c%s", func_valid_range, first_digit, second_digit, func_type);
; 0001 00BA     lcd_puts(display_message);
; 0001 00BB }

	.DSEG
_0x20043:
	.BYTE 0x34
;
;void q5_display_info()
; 0001 00BE {

	.CSEG
_q5_display_info:
; .FSTART _q5_display_info
; 0001 00BF     speed();
	RCALL _speed
; 0001 00C0     //time();
; 0001 00C1     // weight();
; 0001 00C2     // temp();
; 0001 00C3     // lcd_clear();
; 0001 00C4     // lcd_puts("System Init Done\n\tThanks");
; 0001 00C5     // delay_ms(300);
; 0001 00C6     // lcd_clear();
; 0001 00C7 }
	RET
; .FEND
;
;
;void speed()
; 0001 00CB {
_speed:
; .FSTART _speed
; 0001 00CC     char speed_first_digit, speed_second_digit, speed_total_num;
; 0001 00CD     char unrecognized_num;
; 0001 00CE     unrecognized_num = '?';
	CALL __SAVELOCR4
;	speed_first_digit -> R17
;	speed_second_digit -> R16
;	speed_total_num -> R19
;	unrecognized_num -> R18
	LDI  R18,LOW(63)
; 0001 00CF     lcd_clear();
	RCALL _lcd_clear
; 0001 00D0     lcd_puts("System Init\n Speed:??(0-50r)");
	__POINTW2MN _0x20047,0
	RCALL _lcd_puts
; 0001 00D1     //speed1 = part5_keyscan(-1, 0, 0);
; 0001 00D2     if (PORTB != 0XF0)
	IN   R30,0x18
	CPI  R30,LOW(0xF0)
	BREQ _0x20048
; 0001 00D3     {
; 0001 00D4         lcd_clear();
	RCALL _lcd_clear
; 0001 00D5         lcd_puts("fuukkkk");
	__POINTW2MN _0x20047,29
	RCALL _lcd_puts
; 0001 00D6         speed_first_digit = get_entered_key();
	CALL SUBOPT_0x0
; 0001 00D7         lcd_gotoxy(0, 0);
; 0001 00D8         lcd_putchar(speed_first_digit);
	RCALL _lcd_putchar
; 0001 00D9     }
; 0001 00DA 
; 0001 00DB     // print_func_details(0, speed_first_digit, unrecognized_num);
; 0001 00DC     //speed_second_digit = get_entered_key();
; 0001 00DD     //print_func_details(0, speed_first_digit, speed_second_digit);
; 0001 00DE     // speed_total_num = speed_first_digit*10 + speed_second_digit;
; 0001 00DF     // lcd_puts(speed_total_num);
; 0001 00E0     // while (speed_total_num > 50)
; 0001 00E1     // {
; 0001 00E2     //     lcd_clear();
; 0001 00E3     //     lcd_puts("System Init\n Speed:EE(0-50r)");
; 0001 00E4     //     speed_first_digit = get_entered_key();
; 0001 00E5     //     print_func_details(0, speed_first_digit, unrecognized_num);
; 0001 00E6     //     speed_second_digit = get_entered_key();
; 0001 00E7     //     print_func_details(0, speed_first_digit, speed_second_digit);
; 0001 00E8     //     speed_total_num = speed_first_digit * 10 + speed_second_digit;
; 0001 00E9     // }
; 0001 00EA     // delay_ms(100);
; 0001 00EB }
_0x20048:
_0x2080002:
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND

	.DSEG
_0x20047:
	.BYTE 0x25
;
;
;void time()
; 0001 00EF {

	.CSEG
; 0001 00F0     int time, time1;
; 0001 00F1     lcd_clear();
;	time -> R16,R17
;	time1 -> R18,R19
; 0001 00F2     lcd_puts("System Init\n Time:??(0-99s)");
; 0001 00F3     time1 = part5_keyscan(-1, 0, 1);
; 0001 00F4     time = time1 * 10;
; 0001 00F5     time += part5_keyscan(time1, 1, 1);
; 0001 00F6     while(time > 99)
; 0001 00F7     {
; 0001 00F8         lcd_clear();
; 0001 00F9         lcd_puts("System Init\n Time:EE(0-99s)");
; 0001 00FA         time1 = part5_keyscan(-1, 0, 1);
; 0001 00FB         time = time1 * 10;
; 0001 00FC         time += part5_keyscan(time1, 1, 1);
; 0001 00FD     }
; 0001 00FE     delay_ms(100);
; 0001 00FF }

	.DSEG
_0x20049:
	.BYTE 0x38
;
;
;
;void weight()
; 0001 0104 {

	.CSEG
; 0001 0105     int w, w1;
; 0001 0106     lcd_clear();
;	w -> R16,R17
;	w1 -> R18,R19
; 0001 0107     lcd_puts("System Init\n W:??(0-99Kg)");
; 0001 0108     w1 = part5_keyscan(-1, 0, 2);
; 0001 0109     w = w1 * 10;
; 0001 010A     w += part5_keyscan(w1, 1, 2);
; 0001 010B     while(w > 99)
; 0001 010C     {
; 0001 010D         lcd_clear();
; 0001 010E         lcd_puts("System Init\n W:EE(0-99Kg)");
; 0001 010F         w1 = part5_keyscan(-1, 0, 2);
; 0001 0110         w = w1 * 10;
; 0001 0111         w += part5_keyscan(w1, 1, 2);
; 0001 0112     }
; 0001 0113     delay_ms(100);
; 0001 0114 }

	.DSEG
_0x2004D:
	.BYTE 0x34
;
;
;void temp()
; 0001 0118 {

	.CSEG
; 0001 0119     int temp, temp1;
; 0001 011A     lcd_clear();
;	temp -> R16,R17
;	temp1 -> R18,R19
; 0001 011B     lcd_puts("System Init\n Temp:??(20-80C)");
; 0001 011C     temp1 = part5_keyscan(-1, 0, 3);
; 0001 011D     temp = temp1 * 10;
; 0001 011E     temp += part5_keyscan(temp1, 1, 3);
; 0001 011F     while(temp > 80 || temp < 20)
; 0001 0120     {
; 0001 0121         lcd_clear();
; 0001 0122         lcd_puts("System Init\n Temp:EE(20-80C)");
; 0001 0123         temp1 = part5_keyscan(-1, 0, 3);
; 0001 0124         temp = temp1 * 10;
; 0001 0125         temp += part5_keyscan(temp1, 1, 3);
; 0001 0126     }
; 0001 0127     delay_ms(100);
; 0001 0128 }

	.DSEG
_0x20051:
	.BYTE 0x3A
;
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2080001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x1
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x1
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R5,R7
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x2080001
_0x2000007:
_0x2000004:
	INC  R5
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x2080001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x2
	CALL SUBOPT_0x2
	CALL SUBOPT_0x2
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_data_key:
	.BYTE 0x10
_row:
	.BYTE 0x4
__base_y_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x0:
	CALL _get_entered_key
	MOV  R17,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	MOV  R26,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
