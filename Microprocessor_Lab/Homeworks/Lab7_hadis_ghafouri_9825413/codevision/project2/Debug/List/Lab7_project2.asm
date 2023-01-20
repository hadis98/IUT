
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
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  _usart_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x0:
	.DB  0x70,0x61,0x72,0x74,0x32,0x20,0x69,0x73
	.DB  0x20,0x72,0x75,0x6E,0x6E,0x69,0x6E,0x67
	.DB  0x21,0x0,0x70,0x61,0x72,0x74,0x32,0x20
	.DB  0x69,0x73,0x20,0x72,0x75,0x6E,0x6E,0x69
	.DB  0x6E,0x67,0x21,0xD,0xA,0x45,0x6E,0x74
	.DB  0x65,0x72,0x20,0x61,0x20,0x63,0x68,0x61
	.DB  0x72,0x61,0x63,0x74,0x65,0x72,0x3A,0x0
	.DB  0x50,0x61,0x72,0x74,0x32,0x20,0x69,0x73
	.DB  0x20,0x65,0x6E,0x64,0x69,0x6E,0x67,0x21
	.DB  0x0,0x70,0x61,0x72,0x74,0x33,0x20,0x69
	.DB  0x73,0x20,0x72,0x75,0x6E,0x6E,0x69,0x6E
	.DB  0x67,0x21,0x0,0x50,0x61,0x72,0x74,0x33
	.DB  0x20,0x69,0x73,0x20,0x72,0x75,0x6E,0x6E
	.DB  0x69,0x6E,0x67,0x21,0x0,0x45,0x6E,0x74
	.DB  0x65,0x72,0x20,0x61,0x20,0x35,0x20,0x64
	.DB  0x69,0x67,0x69,0x74,0x73,0x20,0x6E,0x75
	.DB  0x6D,0x62,0x65,0x72,0x20,0x77,0x69,0x74
	.DB  0x68,0x20,0x74,0x68,0x69,0x73,0x20,0x66
	.DB  0x6F,0x72,0x6D,0x61,0x74,0x3A,0x20,0x28
	.DB  0x6E,0x75,0x6D,0x62,0x65,0x72,0x29,0x0
	.DB  0x25,0x73,0x0
_0x40000:
	.DB  0xD,0xA,0x44,0x61,0x74,0x61,0x20,0x69
	.DB  0x73,0x20,0x61,0x20,0x69,0x6E,0x74,0x65
	.DB  0x67,0x65,0x72,0x20,0x61,0x6E,0x64,0x20
	.DB  0x31,0x30,0x2A,0x25,0x63,0x20,0x3D,0x20
	.DB  0x25,0x64,0xD,0xA,0x0,0x4C,0x43,0x44
	.DB  0x20,0x44,0x65,0x6C,0x65,0x74,0x65,0x64
	.DB  0x21,0x0,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x4D,0x69,0x63,0x72,0x6F,0x20,0x70
	.DB  0x72,0x6F,0x63,0x65,0x73,0x73,0x6F,0x72
	.DB  0x20,0x6C,0x61,0x62,0x20,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A,0x2A
	.DB  0x2A,0x2A,0x2A,0x2A,0x0,0x52,0x78,0x3A
	.DB  0x20,0x45,0x4E,0x44,0x20,0x6F,0x66,0x20
	.DB  0x74,0x68,0x65,0x20,0x70,0x61,0x72,0x74
	.DB  0x0,0xD,0xA,0x52,0x78,0x3A,0x20,0x69
	.DB  0x6E,0x70,0x75,0x74,0x20,0x6C,0x65,0x74
	.DB  0x74,0x65,0x72,0x20,0x69,0x73,0x20,0x25
	.DB  0x63,0xD,0xA,0x0,0x69,0x6E,0x76,0x61
	.DB  0x6C,0x69,0x64,0x20,0x69,0x6E,0x70,0x75
	.DB  0x74,0x21,0x0,0x52,0x78,0x3A,0x46,0x72
	.DB  0x61,0x6D,0x65,0x20,0x6D,0x75,0x73,0x74
	.DB  0x20,0x62,0x65,0x20,0x35,0x20,0x69,0x6E
	.DB  0x74,0x65,0x67,0x65,0x72,0x0,0x52,0x78
	.DB  0x3A,0x20,0x49,0x6E,0x63,0x6F,0x72,0x72
	.DB  0x65,0x63,0x74,0x20,0x66,0x72,0x61,0x6D
	.DB  0x65,0x20,0x73,0x69,0x7A,0x65,0x0,0x52
	.DB  0x78,0x3A,0x20,0x54,0x68,0x65,0x20,0x66
	.DB  0x72,0x61,0x6D,0x65,0x20,0x69,0x73,0x20
	.DB  0x63,0x6F,0x72,0x72,0x65,0x63,0x74,0x0
	.DB  0xD,0xA,0x25,0x73,0xD,0xA,0x0
_0x2040003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x12
	.DW  _0x3
	.DW  _0x0*2

	.DW  0x26
	.DW  _0x3+18
	.DW  _0x0*2+18

	.DW  0x11
	.DW  _0x3+56
	.DW  _0x0*2+56

	.DW  0x11
	.DW  _0x3+73
	.DW  _0x0*2+56

	.DW  0x12
	.DW  _0x3+90
	.DW  _0x0*2+73

	.DW  0x12
	.DW  _0x3+108
	.DW  _0x0*2+91

	.DW  0x33
	.DW  _0x3+126
	.DW  _0x0*2+109

	.DW  0x0D
	.DW  _0x40017
	.DW  _0x40000*2+37

	.DW  0x0D
	.DW  _0x40017+13
	.DW  _0x40000*2+37

	.DW  0x43
	.DW  _0x40017+26
	.DW  _0x40000*2+50

	.DW  0x14
	.DW  _0x40017+93
	.DW  _0x40000*2+117

	.DW  0x0F
	.DW  _0x40021
	.DW  _0x40000*2+164

	.DW  0x1B
	.DW  _0x40021+15
	.DW  _0x40000*2+179

	.DW  0x1B
	.DW  _0x40021+42
	.DW  _0x40000*2+179

	.DW  0x19
	.DW  _0x40021+69
	.DW  _0x40000*2+206

	.DW  0x19
	.DW  _0x40021+94
	.DW  _0x40000*2+206

	.DW  0x19
	.DW  _0x40021+119
	.DW  _0x40000*2+231

	.DW  0x19
	.DW  _0x40021+144
	.DW  _0x40000*2+231

	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

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
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Project : LAB7-PROJECT2-MICRO_LAB
;Version :
;Date    : 12/26/2022
;Author  : HADIS GHAFOURI 9825413
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include "headers.h"
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
;#include "initial_configs.h"
;#include "subTasks.h"
;
;void main(void)
; 0000 0019 {

	.CSEG
_main:
; .FSTART _main
; 0000 001A    char entered_char;
; 0000 001B    char subTask3_entered_str[10];
; 0000 001C 
; 0000 001D #asm("sei")
	SBIW R28,10
;	entered_char -> R17
;	subTask3_entered_str -> Y+0
	sei
; 0000 001E 
; 0000 001F    init_configs();
	RCALL _init_configs
; 0000 0020 
; 0000 0021    print_message_on_lcd("part2 is running!");
	__POINTW2MN _0x3,0
	CALL _print_message_on_lcd
; 0000 0022    print_on_terminal("part2 is running!\r\nEnter a character:");
	__POINTW2MN _0x3,18
	CALL _print_on_terminal
; 0000 0023 
; 0000 0024    while (1)
_0x4:
; 0000 0025    {
; 0000 0026 
; 0000 0027       entered_char = getchar();
	CALL _getchar
	MOV  R17,R30
; 0000 0028 
; 0000 0029       if (subTask2(entered_char) == -1)
	MOV  R26,R17
	CALL _subTask2
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x7
; 0000 002A       {
; 0000 002B          print_message_on_lcd("Part2 is ending!");
	__POINTW2MN _0x3,56
	CALL _print_message_on_lcd
; 0000 002C          print_on_terminal("Part2 is ending!");
	__POINTW2MN _0x3,73
	CALL _print_on_terminal
; 0000 002D          delay_ms(2000);
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	CALL _delay_ms
; 0000 002E          break;
	RJMP _0x6
; 0000 002F       }
; 0000 0030    }
_0x7:
	RJMP _0x4
_0x6:
; 0000 0031 
; 0000 0032    print_message_on_lcd("part3 is running!");
	__POINTW2MN _0x3,90
	CALL _print_message_on_lcd
; 0000 0033    print_on_terminal("Part3 is running!");
	__POINTW2MN _0x3,108
	CALL _print_on_terminal
; 0000 0034 
; 0000 0035    while (1)
_0x8:
; 0000 0036    {
; 0000 0037       print_on_terminal("Enter a 5 digits number with this format: (number)");
	__POINTW2MN _0x3,126
	CALL _print_on_terminal
; 0000 0038       scanf("%s", subTask3_entered_str);
	__POINTW1FN _0x0,160
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,2
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _scanf
	ADIW R28,6
; 0000 0039       subTask3(subTask3_entered_str);
	MOVW R26,R28
	CALL _subTask3
; 0000 003A    }
	RJMP _0x8
; 0000 003B }
_0xB:
	RJMP _0xB
; .FEND

	.DSEG
_0x3:
	.BYTE 0xB1
;#include "headers.h"
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
;#include "initial_configs.h"
;
;void init_configs()
; 0001 0005 {

	.CSEG
_init_configs:
; .FSTART _init_configs
; 0001 0006     init_PORTS();
	RCALL _init_PORTS
; 0001 0007     init_LCD();
	RCALL _init_LCD
; 0001 0008     init_TIMERS();
	RCALL _init_TIMERS
; 0001 0009     init_INTERRUPTS();
	RCALL _init_INTERRUPTS
; 0001 000A     init_USART();
	RCALL _init_USART
; 0001 000B     init_ANALOG();
	RCALL _init_ANALOG
; 0001 000C     init_ADC();
	RCALL _init_ADC
; 0001 000D     init_SPI();
	RCALL _init_SPI
; 0001 000E     init_TWI();
	RCALL _init_TWI
; 0001 000F }
	RET
; .FEND
;
;void init_PORTS()
; 0001 0012 {
_init_PORTS:
; .FSTART _init_PORTS
; 0001 0013     // Port A initialization
; 0001 0014     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0001 0015     DDRA = (0 << DDA7) | (0 << DDA6) | (0 << DDA5) | (0 << DDA4) | (0 << DDA3) | (0 << DDA2) | (0 << DDA1) | (0 << DDA0) ...
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0001 0016     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 0017     PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1 ...
	OUT  0x1B,R30
; 0001 0018 
; 0001 0019     // Port B initialization
; 0001 001A     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0001 001B     DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (0 << DDB3) | (0 << DDB2) | (0 << DDB1) | (0 << DDB0) ...
	OUT  0x17,R30
; 0001 001C     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 001D     PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1 ...
	OUT  0x18,R30
; 0001 001E 
; 0001 001F     // Port C initialization
; 0001 0020     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0001 0021     DDRC = (0 << DDC7) | (0 << DDC6) | (0 << DDC5) | (0 << DDC4) | (0 << DDC3) | (0 << DDC2) | (0 << DDC1) | (0 << DDC0) ...
	OUT  0x14,R30
; 0001 0022     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 0023     PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1 ...
	OUT  0x15,R30
; 0001 0024 
; 0001 0025     // Port D initialization
; 0001 0026     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0001 0027     DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0) ...
	OUT  0x11,R30
; 0001 0028     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0001 0029     PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1 ...
	OUT  0x12,R30
; 0001 002A }
	RET
; .FEND
;
;void init_LCD()
; 0001 002D {
_init_LCD:
; .FSTART _init_LCD
; 0001 002E     // Alphanumeric LCD initialization
; 0001 002F     // Connections are specified in the
; 0001 0030     // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0001 0031     // RS - PORTC Bit 0
; 0001 0032     // RD - PORTC Bit 1
; 0001 0033     // EN - PORTC Bit 2
; 0001 0034     // D4 - PORTC Bit 4
; 0001 0035     // D5 - PORTC Bit 5
; 0001 0036     // D6 - PORTC Bit 6
; 0001 0037     // D7 - PORTC Bit 7
; 0001 0038     // Characters/line: 16
; 0001 0039     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0001 003A }
	RET
; .FEND
;
;void init_TIMERS()
; 0001 003D {
_init_TIMERS:
; .FSTART _init_TIMERS
; 0001 003E     // Timer/Counter 0 initialization
; 0001 003F     // Clock source: System Clock
; 0001 0040     // Clock value: Timer 0 Stopped
; 0001 0041     // Mode: Normal top=0xFF
; 0001 0042     // OC0 output: Disconnected
; 0001 0043     TCCR0 = (0 << WGM00) | (0 << COM01) | (0 << COM00) | (0 << WGM01) | (0 << CS02) | (0 << CS01) | (0 << CS00);
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0001 0044     TCNT0 = 0x00;
	OUT  0x32,R30
; 0001 0045     OCR0 = 0x00;
	OUT  0x3C,R30
; 0001 0046 
; 0001 0047     // Timer/Counter 1 initialization
; 0001 0048     // Clock source: System Clock
; 0001 0049     // Clock value: Timer1 Stopped
; 0001 004A     // Mode: Normal top=0xFFFF
; 0001 004B     // OC1A output: Disconnected
; 0001 004C     // OC1B output: Disconnected
; 0001 004D     // Noise Canceler: Off
; 0001 004E     // Input Capture on Falling Edge
; 0001 004F     // Timer1 Overflow Interrupt: Off
; 0001 0050     // Input Capture Interrupt: Off
; 0001 0051     // Compare A Match Interrupt: Off
; 0001 0052     // Compare B Match Interrupt: Off
; 0001 0053     TCCR1A = (0 << COM1A1) | (0 << COM1A0) | (0 << COM1B1) | (0 << COM1B0) | (0 << WGM11) | (0 << WGM10);
	OUT  0x2F,R30
; 0001 0054     TCCR1B = (0 << ICNC1) | (0 << ICES1) | (0 << WGM13) | (0 << WGM12) | (0 << CS12) | (0 << CS11) | (0 << CS10);
	OUT  0x2E,R30
; 0001 0055     TCNT1H = 0x00;
	OUT  0x2D,R30
; 0001 0056     TCNT1L = 0x00;
	OUT  0x2C,R30
; 0001 0057     ICR1H = 0x00;
	OUT  0x27,R30
; 0001 0058     ICR1L = 0x00;
	OUT  0x26,R30
; 0001 0059     OCR1AH = 0x00;
	OUT  0x2B,R30
; 0001 005A     OCR1AL = 0x00;
	OUT  0x2A,R30
; 0001 005B     OCR1BH = 0x00;
	OUT  0x29,R30
; 0001 005C     OCR1BL = 0x00;
	OUT  0x28,R30
; 0001 005D 
; 0001 005E     // Timer/Counter 2 initialization
; 0001 005F     // Clock source: System Clock
; 0001 0060     // Clock value: Timer2 Stopped
; 0001 0061     // Mode: Normal top=0xFF
; 0001 0062     // OC2 output: Disconnected
; 0001 0063     ASSR = 0 << AS2;
	OUT  0x22,R30
; 0001 0064     TCCR2 = (0 << PWM2) | (0 << COM21) | (0 << COM20) | (0 << CTC2) | (0 << CS22) | (0 << CS21) | (0 << CS20);
	OUT  0x25,R30
; 0001 0065     TCNT2 = 0x00;
	OUT  0x24,R30
; 0001 0066     OCR2 = 0x00;
	OUT  0x23,R30
; 0001 0067 
; 0001 0068     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0001 0069     TIMSK = (0 << OCIE2) | (0 << TOIE2) | (0 << TICIE1) | (0 << OCIE1A) | (0 << OCIE1B) | (0 << TOIE1) | (0 << OCIE0) |  ...
	OUT  0x39,R30
; 0001 006A }
	RET
; .FEND
;
;void init_INTERRUPTS()
; 0001 006D {
_init_INTERRUPTS:
; .FSTART _init_INTERRUPTS
; 0001 006E     // External Interrupt(s) initialization
; 0001 006F     // INT0: Off
; 0001 0070     // INT1: Off
; 0001 0071     // INT2: Off
; 0001 0072     MCUCR = (0 << ISC11) | (0 << ISC10) | (0 << ISC01) | (0 << ISC00);
	LDI  R30,LOW(0)
	OUT  0x35,R30
; 0001 0073     MCUCSR = (0 << ISC2);
	OUT  0x34,R30
; 0001 0074 }
	RET
; .FEND
;
;void init_USART()
; 0001 0077 {
_init_USART:
; .FSTART _init_USART
; 0001 0078     // USART initialization
; 0001 0079     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0001 007A     // USART Receiver: On
; 0001 007B     // USART Transmitter: On
; 0001 007C     // USART Mode: Asynchronous
; 0001 007D     // USART Baud Rate: 9600
; 0001 007E     UCSRA = (0 << RXC) | (0 << TXC) | (0 << UDRE) | (0 << FE) | (0 << DOR) | (0 << UPE) | (0 << U2X) | (0 << MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0001 007F     UCSRB = (1 << RXCIE) | (1 << TXCIE) | (0 << UDRIE) | (1 << RXEN) | (1 << TXEN) | (0 << UCSZ2) | (0 << RXB8) | (0 <<  ...
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0001 0080     UCSRC = (1 << URSEL) | (0 << UMSEL) | (0 << UPM1) | (0 << UPM0) | (0 << USBS) | (1 << UCSZ1) | (1 << UCSZ0) | (0 <<  ...
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0001 0081     UBRRH = 0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0001 0082     UBRRL = 0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0001 0083 }
	RET
; .FEND
;
;void init_ANALOG()
; 0001 0086 {
_init_ANALOG:
; .FSTART _init_ANALOG
; 0001 0087     // Analog Comparator initialization
; 0001 0088     // Analog Comparator: Off
; 0001 0089     // The Analog Comparator's positive input is
; 0001 008A     // connected to the AIN0 pin
; 0001 008B     // The Analog Comparator's negative input is
; 0001 008C     // connected to the AIN1 pin
; 0001 008D     ACSR = (1 << ACD) | (0 << ACBG) | (0 << ACO) | (0 << ACI) | (0 << ACIE) | (0 << ACIC) | (0 << ACIS1) | (0 << ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0001 008E     SFIOR = (0 << ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0001 008F }
	RET
; .FEND
;
;void init_ADC()
; 0001 0092 {
_init_ADC:
; .FSTART _init_ADC
; 0001 0093     // ADC initialization
; 0001 0094     // ADC disabled
; 0001 0095     ADCSRA = (0 << ADEN) | (0 << ADSC) | (0 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (0 << ADPS1) | (0 <<  ...
	LDI  R30,LOW(0)
	OUT  0x6,R30
; 0001 0096 }
	RET
; .FEND
;
;void init_SPI()
; 0001 0099 {
_init_SPI:
; .FSTART _init_SPI
; 0001 009A     // SPI initialization
; 0001 009B     // SPI disabled
; 0001 009C     SPCR = (0 << SPIE) | (0 << SPE) | (0 << DORD) | (0 << MSTR) | (0 << CPOL) | (0 << CPHA) | (0 << SPR1) | (0 << SPR0);
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0001 009D }
	RET
; .FEND
;
;void init_TWI()
; 0001 00A0 {
_init_TWI:
; .FSTART _init_TWI
; 0001 00A1     // TWI initialization
; 0001 00A2     // TWI disabled
; 0001 00A3     TWCR = (0 << TWEA) | (0 << TWSTA) | (0 << TWSTO) | (0 << TWEN) | (0 << TWIE);
	LDI  R30,LOW(0)
	OUT  0x36,R30
; 0001 00A4 }
	RET
; .FEND
;#include "subTasks.h"
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
;char rx_buffer[RX_BUFFER_SIZE];
;bit rx_buffer_overflow;
;unsigned char rx_wr_index = 0, rx_rd_index = 0;
;unsigned char rx_counter = 0;
;char tx_buffer[TX_BUFFER_SIZE];
;unsigned char tx_wr_index = 0, tx_rd_index = 0;
;unsigned char tx_counter = 0;
;
;// USART Receiver interrupt service routine
;interrupt[USART_RXC] void usart_rx_isr(void)
; 0002 000D {

	.CSEG
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0002 000E     char status, data;
; 0002 000F     status = UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0002 0010     data = UDR;
	IN   R16,12
; 0002 0011     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN)) == 0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x40003
; 0002 0012     {
; 0002 0013         rx_buffer[rx_wr_index++] = data;
	LDS  R30,_rx_wr_index
	SUBI R30,-LOW(1)
	STS  _rx_wr_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0002 0014 #if RX_BUFFER_SIZE == 256
; 0002 0015         // special case for receiver buffer size=256
; 0002 0016         if (++rx_counter == 0)
; 0002 0017             rx_buffer_overflow = 1;
; 0002 0018 #else
; 0002 0019         if (rx_wr_index == RX_BUFFER_SIZE)
	LDS  R26,_rx_wr_index
	CPI  R26,LOW(0x8)
	BRNE _0x40004
; 0002 001A             rx_wr_index = 0;
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
; 0002 001B         if (++rx_counter == RX_BUFFER_SIZE)
_0x40004:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x8)
	BRNE _0x40005
; 0002 001C         {
; 0002 001D             rx_counter = 0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
; 0002 001E             rx_buffer_overflow = 1;
	SET
	BLD  R2,0
; 0002 001F         }
; 0002 0020 #endif
; 0002 0021     }
_0x40005:
; 0002 0022 }
_0x40003:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x40030
; .FEND
;
;// USART Transmitter interrupt service routine
;interrupt[USART_TXC] void usart_tx_isr(void)
; 0002 0026 {
_usart_tx_isr:
; .FSTART _usart_tx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0002 0027     if (tx_counter)
	LDS  R30,_tx_counter
	CPI  R30,0
	BREQ _0x40006
; 0002 0028     {
; 0002 0029         --tx_counter;
	SUBI R30,LOW(1)
	STS  _tx_counter,R30
; 0002 002A         UDR = tx_buffer[tx_rd_index++];
	LDS  R30,_tx_rd_index
	SUBI R30,-LOW(1)
	STS  _tx_rd_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	OUT  0xC,R30
; 0002 002B #if TX_BUFFER_SIZE != 256
; 0002 002C         if (tx_rd_index == TX_BUFFER_SIZE)
	LDS  R26,_tx_rd_index
	CPI  R26,LOW(0x8)
	BRNE _0x40007
; 0002 002D             tx_rd_index = 0;
	LDI  R30,LOW(0)
	STS  _tx_rd_index,R30
; 0002 002E #endif
; 0002 002F     }
_0x40007:
; 0002 0030 }
_0x40006:
_0x40030:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used +
;char getchar(void)
; 0002 0037 {
_getchar:
; .FSTART _getchar
; 0002 0038     char data;
; 0002 0039     while (rx_counter == 0)
	ST   -Y,R17
;	data -> R17
_0x40008:
	LDS  R30,_rx_counter
	CPI  R30,0
	BREQ _0x40008
; 0002 003A         ;
; 0002 003B     data = rx_buffer[rx_rd_index++];
	LDS  R30,_rx_rd_index
	SUBI R30,-LOW(1)
	STS  _rx_rd_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	LD   R17,Z
; 0002 003C #if RX_BUFFER_SIZE != 256
; 0002 003D     if (rx_rd_index == RX_BUFFER_SIZE)
	LDS  R26,_rx_rd_index
	CPI  R26,LOW(0x8)
	BRNE _0x4000B
; 0002 003E         rx_rd_index = 0;
	LDI  R30,LOW(0)
	STS  _rx_rd_index,R30
; 0002 003F #endif
; 0002 0040 #asm("cli")
_0x4000B:
	cli
; 0002 0041     --rx_counter;
	LDS  R30,_rx_counter
	SUBI R30,LOW(1)
	STS  _rx_counter,R30
; 0002 0042 #asm("sei")
	sei
; 0002 0043     return data;
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0002 0044 }
; .FEND
;#pragma used -
;#endif
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Write a character to the USART Transmitter buffer
;#define _ALTERNATE_PUTCHAR_
;#pragma used +
;void putchar(char c)
; 0002 004D {
_putchar:
; .FSTART _putchar
; 0002 004E     while (tx_counter == TX_BUFFER_SIZE)
	ST   -Y,R26
;	c -> Y+0
_0x4000C:
	LDS  R26,_tx_counter
	CPI  R26,LOW(0x8)
	BREQ _0x4000C
; 0002 004F         ;
; 0002 0050 #asm("cli")
	cli
; 0002 0051     if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY) == 0))
	LDS  R30,_tx_counter
	CPI  R30,0
	BRNE _0x40010
	SBIC 0xB,5
	RJMP _0x4000F
_0x40010:
; 0002 0052     {
; 0002 0053         tx_buffer[tx_wr_index++] = c;
	LDS  R30,_tx_wr_index
	SUBI R30,-LOW(1)
	STS  _tx_wr_index,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R26,Y
	STD  Z+0,R26
; 0002 0054 #if TX_BUFFER_SIZE != 256
; 0002 0055         if (tx_wr_index == TX_BUFFER_SIZE)
	LDS  R26,_tx_wr_index
	CPI  R26,LOW(0x8)
	BRNE _0x40012
; 0002 0056             tx_wr_index = 0;
	LDI  R30,LOW(0)
	STS  _tx_wr_index,R30
; 0002 0057 #endif
; 0002 0058         ++tx_counter;
_0x40012:
	LDS  R30,_tx_counter
	SUBI R30,-LOW(1)
	STS  _tx_counter,R30
; 0002 0059     }
; 0002 005A     else
	RJMP _0x40013
_0x4000F:
; 0002 005B         UDR = c;
	LD   R30,Y
	OUT  0xC,R30
; 0002 005C #asm("sei")
_0x40013:
	sei
; 0002 005D }
	JMP  _0x2080001
; .FEND
;#pragma used -
;#endif
;
;int subTask2(char entered_character)
; 0002 0062 {
_subTask2:
; .FSTART _subTask2
; 0002 0063     int integer_char;
; 0002 0064     if (is_digit_valid(entered_character))
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	entered_character -> Y+2
;	integer_char -> R16,R17
	LDD  R26,Y+2
	RCALL _is_digit_valid
	CPI  R30,0
	BREQ _0x40014
; 0002 0065     {
; 0002 0066         integer_char = (int)(entered_character)-48;
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,48
	MOVW R16,R30
; 0002 0067         printf("\r\nData is a integer and 10*%c = %d\r\n", entered_character, integer_char * 10);
	__POINTW1FN _0x40000,0
	CALL SUBOPT_0x0
	MOVW R30,R16
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,8
	RCALL _printf
	ADIW R28,10
; 0002 0068     }
; 0002 0069     else if (entered_character == 'D')
	RJMP _0x40015
_0x40014:
	LDD  R26,Y+2
	CPI  R26,LOW(0x44)
	BRNE _0x40016
; 0002 006A     {
; 0002 006B         print_message_on_lcd("LCD Deleted!");
	__POINTW2MN _0x40017,0
	RCALL _print_message_on_lcd
; 0002 006C         print_on_terminal("LCD Deleted!");
	__POINTW2MN _0x40017,13
	RCALL _print_on_terminal
; 0002 006D     }
; 0002 006E     else if (entered_character == 'H')
	RJMP _0x40018
_0x40016:
	LDD  R26,Y+2
	CPI  R26,LOW(0x48)
	BRNE _0x40019
; 0002 006F     {
; 0002 0070         print_on_terminal("***********************Micro processor lab ***********************");
	__POINTW2MN _0x40017,26
	RCALL _print_on_terminal
; 0002 0071     }
; 0002 0072     else if (entered_character == 'E')
	RJMP _0x4001A
_0x40019:
	LDD  R26,Y+2
	CPI  R26,LOW(0x45)
	BRNE _0x4001B
; 0002 0073     {
; 0002 0074         print_on_terminal("Rx: END of the part");
	__POINTW2MN _0x40017,93
	RCALL _print_on_terminal
; 0002 0075         return -1; // end
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2080002
; 0002 0076     }
; 0002 0077     else
_0x4001B:
; 0002 0078     {
; 0002 0079         printf("\r\nRx: input letter is %c\r\n", entered_character);
	__POINTW1FN _0x40000,137
	CALL SUBOPT_0x0
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
; 0002 007A     }
_0x4001A:
_0x40018:
_0x40015:
; 0002 007B     return 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2080002
; 0002 007C }
; .FEND

	.DSEG
_0x40017:
	.BYTE 0x71
;
;bool is_digit_valid(char entered_char)
; 0002 007F {

	.CSEG
_is_digit_valid:
; .FSTART _is_digit_valid
; 0002 0080     int integer_char;
; 0002 0081     integer_char = (int)(entered_char)-48;
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	entered_char -> Y+2
;	integer_char -> R16,R17
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,48
	MOVW R16,R30
; 0002 0082 
; 0002 0083     if (integer_char >= 0 && integer_char <= 9)
	TST  R17
	BRMI _0x4001E
	__CPWRN 16,17,10
	BRLT _0x4001F
_0x4001E:
	RJMP _0x4001D
_0x4001F:
; 0002 0084     {
; 0002 0085         return true;
	LDI  R30,LOW(1)
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2080002
; 0002 0086     }
; 0002 0087     return false;
_0x4001D:
	LDI  R30,LOW(0)
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2080002
; 0002 0088 }
; .FEND
;
;void subTask3(char *entered_frame)
; 0002 008B {
_subTask3:
; .FSTART _subTask3
; 0002 008C 
; 0002 008D     char number[10];
; 0002 008E     int frame_length;
; 0002 008F     int i = 0, j = 0;
; 0002 0090 
; 0002 0091     if (!is_parentheses_valid(entered_frame))
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR6
;	*entered_frame -> Y+16
;	number -> Y+6
;	frame_length -> R16,R17
;	i -> R18,R19
;	j -> R20,R21
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	RCALL _is_parentheses_valid
	CPI  R30,0
	BRNE _0x40020
; 0002 0092     {
; 0002 0093         print_on_terminal("invalid input!");
	__POINTW2MN _0x40021,0
	RCALL _print_on_terminal
; 0002 0094         return;
	RJMP _0x2080007
; 0002 0095     }
; 0002 0096 
; 0002 0097     frame_length = strlen(entered_frame);
_0x40020:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL _strlen
	MOVW R16,R30
; 0002 0098 
; 0002 0099     for (i = 1; i < frame_length - 1; i++, j++)
	__GETWRN 18,19,1
_0x40023:
	MOVW R30,R16
	SBIW R30,1
	CP   R18,R30
	CPC  R19,R31
	BRGE _0x40024
; 0002 009A     {
; 0002 009B         number[j] = entered_frame[i];
	MOVW R30,R20
	MOVW R26,R28
	ADIW R26,6
	ADD  R30,R26
	ADC  R31,R27
	MOVW R0,R30
	MOVW R30,R18
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
; 0002 009C     }
	__ADDWRN 18,19,1
	__ADDWRN 20,21,1
	RJMP _0x40023
_0x40024:
; 0002 009D 
; 0002 009E     if (has_letter(number))
	MOVW R26,R28
	ADIW R26,6
	RCALL _has_letter
	CPI  R30,0
	BREQ _0x40025
; 0002 009F     {
; 0002 00A0         print_message_on_lcd("Rx:Frame must be 5 integer");
	__POINTW2MN _0x40021,15
	RCALL _print_message_on_lcd
; 0002 00A1         print_on_terminal("Rx:Frame must be 5 integer");
	__POINTW2MN _0x40021,42
	RJMP _0x4002F
; 0002 00A2     }
; 0002 00A3     else
_0x40025:
; 0002 00A4     {
; 0002 00A5         if (strlen(number) != 5)
	MOVW R26,R28
	ADIW R26,6
	CALL _strlen
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BREQ _0x40027
; 0002 00A6         {
; 0002 00A7             print_message_on_lcd("Rx: Incorrect frame size");
	__POINTW2MN _0x40021,69
	RCALL _print_message_on_lcd
; 0002 00A8             print_on_terminal("Rx: Incorrect frame size");
	__POINTW2MN _0x40021,94
	RJMP _0x4002F
; 0002 00A9         }
; 0002 00AA         else
_0x40027:
; 0002 00AB         {
; 0002 00AC             print_message_on_lcd("Rx: The frame is correct");
	__POINTW2MN _0x40021,119
	RCALL _print_message_on_lcd
; 0002 00AD             print_on_terminal("Rx: The frame is correct");
	__POINTW2MN _0x40021,144
_0x4002F:
	RCALL _print_on_terminal
; 0002 00AE         }
; 0002 00AF     }
; 0002 00B0 }
_0x2080007:
	CALL __LOADLOCR6
	ADIW R28,18
	RET
; .FEND

	.DSEG
_0x40021:
	.BYTE 0xA9
;
;bool is_parentheses_valid(char *entered_frame)
; 0002 00B3 {

	.CSEG
_is_parentheses_valid:
; .FSTART _is_parentheses_valid
; 0002 00B4     int last_index = strlen(entered_frame) - 1;
; 0002 00B5     return entered_frame[0] == '(' && entered_frame[last_index] == ')';
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	*entered_frame -> Y+2
;	last_index -> R16,R17
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL _strlen
	SBIW R30,1
	MOVW R16,R30
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R26,X
	CPI  R26,LOW(0x28)
	BRNE _0x40029
	CALL SUBOPT_0x1
	CPI  R26,LOW(0x29)
	BRNE _0x40029
	LDI  R30,1
	RJMP _0x4002A
_0x40029:
	LDI  R30,0
_0x4002A:
	RJMP _0x2080006
; 0002 00B6 }
; .FEND
;
;bool has_letter(char entered_number[])
; 0002 00B9 {
_has_letter:
; .FSTART _has_letter
; 0002 00BA     int i = 0;
; 0002 00BB     for (i = 0; i < strlen(entered_number); i++)
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	entered_number -> Y+2
;	i -> R16,R17
	__GETWRN 16,17,0
	__GETWRN 16,17,0
_0x4002C:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL _strlen
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x4002D
; 0002 00BC     {
; 0002 00BD         if (isalpha(entered_number[i]))
	CALL SUBOPT_0x1
	CALL _isalpha
	CPI  R30,0
	BREQ _0x4002E
; 0002 00BE         {
; 0002 00BF             return true;
	LDI  R30,LOW(1)
	RJMP _0x2080006
; 0002 00C0         }
; 0002 00C1     }
_0x4002E:
	__ADDWRN 16,17,1
	RJMP _0x4002C
_0x4002D:
; 0002 00C2 
; 0002 00C3     return false;
	LDI  R30,LOW(0)
_0x2080006:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
; 0002 00C4 }
; .FEND
;
;void print_message_on_lcd(char *message)
; 0002 00C7 {
_print_message_on_lcd:
; .FSTART _print_message_on_lcd
; 0002 00C8     lcd_clear();
	ST   -Y,R27
	ST   -Y,R26
;	*message -> Y+0
	CALL _lcd_clear
; 0002 00C9     lcd_gotoxy(0, 0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
; 0002 00CA     lcd_puts(message);
	LD   R26,Y
	LDD  R27,Y+1
	CALL _lcd_puts
; 0002 00CB }
	JMP  _0x2080003
; .FEND
;
;void print_on_terminal(char *message)
; 0002 00CE {
_print_on_terminal:
; .FSTART _print_on_terminal
; 0002 00CF     printf("\r\n%s\r\n", message);
	ST   -Y,R27
	ST   -Y,R26
;	*message -> Y+0
	__POINTW1FN _0x40000,256
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
; 0002 00D0 }
	JMP  _0x2080003
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
_put_usart_G100:
; .FSTART _put_usart_G100
	ST   -Y,R27
	ST   -Y,R26
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	JMP  _0x2080002
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	CALL SUBOPT_0x2
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0x2
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	CALL SUBOPT_0x3
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x4
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0x3
	CALL SUBOPT_0x5
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0x3
	CALL SUBOPT_0x5
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	CALL SUBOPT_0x3
	CALL SUBOPT_0x6
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	CALL SUBOPT_0x3
	CALL SUBOPT_0x6
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	CALL SUBOPT_0x2
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	CALL SUBOPT_0x2
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x4
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0x2
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x4
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_printf:
; .FSTART _printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	CALL SUBOPT_0x7
	LDI  R30,LOW(_put_usart_G100)
	LDI  R31,HIGH(_put_usart_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G100
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND
_get_usart_G100:
; .FSTART _get_usart_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000078
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x2000079
_0x2000078:
	CALL _getchar
	MOV  R17,R30
_0x2000079:
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,5
	RET
; .FEND
__scanf_G100:
; .FSTART __scanf_G100
	PUSH R15
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR6
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STD  Y+8,R30
	STD  Y+8+1,R31
	MOV  R20,R30
_0x200007F:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000081
	CALL SUBOPT_0x8
	BREQ _0x2000082
_0x2000083:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x9
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x2000086
	CALL SUBOPT_0x8
	BRNE _0x2000087
_0x2000086:
	RJMP _0x2000085
_0x2000087:
	CALL SUBOPT_0xA
	BRGE _0x2000088
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x2000088:
	RJMP _0x2000083
_0x2000085:
	MOV  R20,R19
	RJMP _0x2000089
_0x2000082:
	CPI  R19,37
	BREQ PC+2
	RJMP _0x200008A
	LDI  R21,LOW(0)
_0x200008B:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LPM  R19,Z+
	STD  Y+16,R30
	STD  Y+16+1,R31
	CPI  R19,48
	BRLO _0x200008F
	CPI  R19,58
	BRLO _0x200008E
_0x200008F:
	RJMP _0x200008D
_0x200008E:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200008B
_0x200008D:
	CPI  R19,0
	BRNE _0x2000091
	RJMP _0x2000081
_0x2000091:
_0x2000092:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x9
	POP  R20
	MOV  R18,R30
	MOV  R26,R30
	CALL _isspace
	CPI  R30,0
	BREQ _0x2000094
	CALL SUBOPT_0xA
	BRGE _0x2000095
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x2000095:
	RJMP _0x2000092
_0x2000094:
	CPI  R18,0
	BRNE _0x2000096
	RJMP _0x2000097
_0x2000096:
	MOV  R20,R18
	CPI  R21,0
	BRNE _0x2000098
	LDI  R21,LOW(255)
_0x2000098:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x200009C
	CALL SUBOPT_0xB
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x9
	POP  R20
	MOVW R26,R16
	ST   X,R30
	CALL SUBOPT_0xA
	BRGE _0x200009D
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x200009D:
	RJMP _0x200009B
_0x200009C:
	CPI  R30,LOW(0x73)
	BRNE _0x20000A6
	CALL SUBOPT_0xB
_0x200009F:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BREQ _0x20000A1
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x9
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x20000A3
	CALL SUBOPT_0x8
	BREQ _0x20000A2
_0x20000A3:
	CALL SUBOPT_0xA
	BRGE _0x20000A5
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x20000A5:
	RJMP _0x20000A1
_0x20000A2:
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	MOV  R30,R19
	POP  R26
	POP  R27
	ST   X,R30
	RJMP _0x200009F
_0x20000A1:
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x200009B
_0x20000A6:
	SET
	BLD  R15,1
	CLT
	BLD  R15,2
	MOV  R30,R19
	CPI  R30,LOW(0x64)
	BREQ _0x20000AB
	CPI  R30,LOW(0x69)
	BRNE _0x20000AC
_0x20000AB:
	CLT
	BLD  R15,1
	RJMP _0x20000AD
_0x20000AC:
	CPI  R30,LOW(0x75)
	BRNE _0x20000AE
_0x20000AD:
	LDI  R18,LOW(10)
	RJMP _0x20000A9
_0x20000AE:
	CPI  R30,LOW(0x78)
	BRNE _0x20000AF
	LDI  R18,LOW(16)
	RJMP _0x20000A9
_0x20000AF:
	CPI  R30,LOW(0x25)
	BRNE _0x20000B2
	RJMP _0x20000B1
_0x20000B2:
	RJMP _0x2080005
_0x20000A9:
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
	SET
	BLD  R15,0
_0x20000B3:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20000B5
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x9
	POP  R20
	MOV  R19,R30
	CPI  R30,LOW(0x21)
	BRSH _0x20000B6
	CALL SUBOPT_0xA
	BRGE _0x20000B7
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x20000B7:
	RJMP _0x20000B8
_0x20000B6:
	SBRC R15,1
	RJMP _0x20000B9
	SET
	BLD  R15,1
	CPI  R19,45
	BRNE _0x20000BA
	BLD  R15,2
	RJMP _0x20000B3
_0x20000BA:
	CPI  R19,43
	BREQ _0x20000B3
_0x20000B9:
	CPI  R18,16
	BRNE _0x20000BC
	MOV  R26,R19
	CALL _isxdigit
	CPI  R30,0
	BREQ _0x20000B8
	RJMP _0x20000BE
_0x20000BC:
	MOV  R26,R19
	CALL _isdigit
	CPI  R30,0
	BRNE _0x20000BF
_0x20000B8:
	SBRC R15,0
	RJMP _0x20000C1
	MOV  R20,R19
	RJMP _0x20000B5
_0x20000BF:
_0x20000BE:
	CPI  R19,97
	BRLO _0x20000C2
	SUBI R19,LOW(87)
	RJMP _0x20000C3
_0x20000C2:
	CPI  R19,65
	BRLO _0x20000C4
	SUBI R19,LOW(55)
	RJMP _0x20000C5
_0x20000C4:
	SUBI R19,LOW(48)
_0x20000C5:
_0x20000C3:
	MOV  R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R19
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	CLT
	BLD  R15,0
	RJMP _0x20000B3
_0x20000B5:
	CALL SUBOPT_0xB
	SBRS R15,2
	RJMP _0x20000C6
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __ANEGW1
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x20000C6:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	MOVW R26,R16
	ST   X+,R30
	ST   X,R31
_0x200009B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RJMP _0x20000C7
_0x200008A:
_0x20000B1:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	CALL SUBOPT_0x9
	POP  R20
	CP   R30,R19
	BREQ _0x20000C8
	CALL SUBOPT_0xA
	BRGE _0x20000C9
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x20000C9:
_0x2000097:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BRNE _0x20000CA
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080004
_0x20000CA:
	RJMP _0x2000081
_0x20000C8:
_0x20000C7:
_0x2000089:
	RJMP _0x200007F
_0x2000081:
_0x20000C1:
_0x2080005:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
_0x2080004:
	CALL __LOADLOCR6
	ADIW R28,18
	POP  R15
	RET
; .FEND
_scanf:
; .FSTART _scanf
	PUSH R15
	MOV  R15,R24
	SBIW R28,3
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,1
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+3,R30
	STD  Y+3+1,R30
	MOVW R26,R28
	ADIW R26,5
	CALL SUBOPT_0x7
	LDI  R30,LOW(_get_usart_G100)
	LDI  R31,HIGH(_get_usart_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __scanf_G100
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	POP  R15
	RET
; .FEND

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
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

	.DSEG

	.CSEG
__lcd_write_nibble_G102:
; .FSTART __lcd_write_nibble_G102
	ST   -Y,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 13
	SBI  0x15,2
	__DELAY_USB 13
	CBI  0x15,2
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 133
	RJMP _0x2080001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
_0x2080003:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xC
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xC
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
	BREQ _0x2040005
	CP   R5,R7
	BRLO _0x2040004
_0x2040005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2040007
	RJMP _0x2080001
_0x2040007:
_0x2040004:
	INC  R5
	SBI  0x15,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x15,0
	RJMP _0x2080001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2040008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x204000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2040008
_0x204000A:
	LDD  R17,Y+0
_0x2080002:
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G102,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G102,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G102
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

	.CSEG
_isalpha:
; .FSTART _isalpha
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,'A'
    brlo isalpha0
    cpi  r31,'Z'+1
    brlo isalpha1
    cpi  r31,'a'
    brlo isalpha0
    cpi  r31,'z'+1
    brlo isalpha1
isalpha0:
    clr  r30
isalpha1:
    ret
; .FEND
_isdigit:
; .FSTART _isdigit
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,'0'
    brlo isdigit0
    cpi  r31,'9'+1
    brlo isdigit1
isdigit0:
    clr  r30
isdigit1:
    ret
; .FEND
_isspace:
; .FSTART _isspace
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,' '
    breq isspace1
    cpi  r31,9
    brlo isspace0
    cpi  r31,13+1
    brlo isspace1
isspace0:
    clr  r30
isspace1:
    ret
; .FEND
_isxdigit:
; .FSTART _isxdigit
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    subi r31,0x30
    brcs isxdigit0
    cpi  r31,10
    brcs isxdigit1
    andi r31,0x5f
    subi r31,7
    cpi  r31,10
    brcs isxdigit0
    cpi  r31,16
    brcs isxdigit1
isxdigit0:
    clr  r30
isxdigit1:
    ret
; .FEND

	.DSEG
_rx_buffer:
	.BYTE 0x8
_rx_wr_index:
	.BYTE 0x1
_rx_rd_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
_tx_buffer:
	.BYTE 0x8
_tx_wr_index:
	.BYTE 0x1
_tx_rd_index:
	.BYTE 0x1
_tx_counter:
	.BYTE 0x1
__base_y_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	MOVW R30,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x2:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	MOV  R26,R19
	CALL _isspace
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x9:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA:
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LD   R26,X
	CPI  R26,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xB:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	SBIW R30,4
	STD  Y+14,R30
	STD  Y+14+1,R31
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	ADIW R26,4
	LD   R16,X+
	LD   R17,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G102
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

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
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
