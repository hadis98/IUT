
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
	.DEF _output_time=R4
	.DEF _output_time_msb=R5
	.DEF _hour=R6
	.DEF _hour_msb=R7
	.DEF _minute=R8
	.DEF _minute_msb=R9
	.DEF _second=R10
	.DEF _second_msb=R11
	.DEF _i=R12
	.DEF _i_msb=R13

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
	JMP  _timer1_ovf_isr
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

_font5x7:
	.DB  0x5,0x7,0x20,0x60,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x5F,0x0,0x0,0x0,0x7
	.DB  0x0,0x7,0x0,0x14,0x7F,0x14,0x7F,0x14
	.DB  0x24,0x2A,0x7F,0x2A,0x12,0x23,0x13,0x8
	.DB  0x64,0x62,0x36,0x49,0x55,0x22,0x50,0x0
	.DB  0x5,0x3,0x0,0x0,0x0,0x1C,0x22,0x41
	.DB  0x0,0x0,0x41,0x22,0x1C,0x0,0x8,0x2A
	.DB  0x1C,0x2A,0x8,0x8,0x8,0x3E,0x8,0x8
	.DB  0x0,0x50,0x30,0x0,0x0,0x8,0x8,0x8
	.DB  0x8,0x8,0x0,0x30,0x30,0x0,0x0,0x20
	.DB  0x10,0x8,0x4,0x2,0x3E,0x51,0x49,0x45
	.DB  0x3E,0x0,0x42,0x7F,0x40,0x0,0x42,0x61
	.DB  0x51,0x49,0x46,0x21,0x41,0x45,0x4B,0x31
	.DB  0x18,0x14,0x12,0x7F,0x10,0x27,0x45,0x45
	.DB  0x45,0x39,0x3C,0x4A,0x49,0x49,0x30,0x1
	.DB  0x71,0x9,0x5,0x3,0x36,0x49,0x49,0x49
	.DB  0x36,0x6,0x49,0x49,0x29,0x1E,0x0,0x36
	.DB  0x36,0x0,0x0,0x0,0x56,0x36,0x0,0x0
	.DB  0x0,0x8,0x14,0x22,0x41,0x14,0x14,0x14
	.DB  0x14,0x14,0x41,0x22,0x14,0x8,0x0,0x2
	.DB  0x1,0x51,0x9,0x6,0x32,0x49,0x79,0x41
	.DB  0x3E,0x7E,0x11,0x11,0x11,0x7E,0x7F,0x49
	.DB  0x49,0x49,0x36,0x3E,0x41,0x41,0x41,0x22
	.DB  0x7F,0x41,0x41,0x22,0x1C,0x7F,0x49,0x49
	.DB  0x49,0x41,0x7F,0x9,0x9,0x1,0x1,0x3E
	.DB  0x41,0x41,0x51,0x32,0x7F,0x8,0x8,0x8
	.DB  0x7F,0x0,0x41,0x7F,0x41,0x0,0x20,0x40
	.DB  0x41,0x3F,0x1,0x7F,0x8,0x14,0x22,0x41
	.DB  0x7F,0x40,0x40,0x40,0x40,0x7F,0x2,0x4
	.DB  0x2,0x7F,0x7F,0x4,0x8,0x10,0x7F,0x3E
	.DB  0x41,0x41,0x41,0x3E,0x7F,0x9,0x9,0x9
	.DB  0x6,0x3E,0x41,0x51,0x21,0x5E,0x7F,0x9
	.DB  0x19,0x29,0x46,0x46,0x49,0x49,0x49,0x31
	.DB  0x1,0x1,0x7F,0x1,0x1,0x3F,0x40,0x40
	.DB  0x40,0x3F,0x1F,0x20,0x40,0x20,0x1F,0x7F
	.DB  0x20,0x18,0x20,0x7F,0x63,0x14,0x8,0x14
	.DB  0x63,0x3,0x4,0x78,0x4,0x3,0x61,0x51
	.DB  0x49,0x45,0x43,0x0,0x0,0x7F,0x41,0x41
	.DB  0x2,0x4,0x8,0x10,0x20,0x41,0x41,0x7F
	.DB  0x0,0x0,0x4,0x2,0x1,0x2,0x4,0x40
	.DB  0x40,0x40,0x40,0x40,0x0,0x1,0x2,0x4
	.DB  0x0,0x20,0x54,0x54,0x54,0x78,0x7F,0x48
	.DB  0x44,0x44,0x38,0x38,0x44,0x44,0x44,0x20
	.DB  0x38,0x44,0x44,0x48,0x7F,0x38,0x54,0x54
	.DB  0x54,0x18,0x8,0x7E,0x9,0x1,0x2,0x8
	.DB  0x14,0x54,0x54,0x3C,0x7F,0x8,0x4,0x4
	.DB  0x78,0x0,0x44,0x7D,0x40,0x0,0x20,0x40
	.DB  0x44,0x3D,0x0,0x0,0x7F,0x10,0x28,0x44
	.DB  0x0,0x41,0x7F,0x40,0x0,0x7C,0x4,0x18
	.DB  0x4,0x78,0x7C,0x8,0x4,0x4,0x78,0x38
	.DB  0x44,0x44,0x44,0x38,0x7C,0x14,0x14,0x14
	.DB  0x8,0x8,0x14,0x14,0x18,0x7C,0x7C,0x8
	.DB  0x4,0x4,0x8,0x48,0x54,0x54,0x54,0x20
	.DB  0x4,0x3F,0x44,0x40,0x20,0x3C,0x40,0x40
	.DB  0x20,0x7C,0x1C,0x20,0x40,0x20,0x1C,0x3C
	.DB  0x40,0x30,0x40,0x3C,0x44,0x28,0x10,0x28
	.DB  0x44,0xC,0x50,0x50,0x50,0x3C,0x44,0x64
	.DB  0x54,0x4C,0x44,0x0,0x8,0x36,0x41,0x0
	.DB  0x0,0x0,0x7F,0x0,0x0,0x0,0x41,0x36
	.DB  0x8,0x0,0x2,0x1,0x2,0x4,0x2,0x7F
	.DB  0x41,0x41,0x41,0x7F
_new_image:
	.DB  0x80,0x0,0x40,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0xC0,0xC0
	.DB  0xC0,0xC0,0xC0,0xC0,0xC0,0xC0,0xC0,0xC0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0xFC,0xFC,0xFC,0xFC
	.DB  0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xC0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0xF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF8
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xF0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x7,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xE0,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x80,0x80,0x80,0x80,0x80,0x80,0x80,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xC0,0xC0,0xC0,0xC0,0xC0,0xC0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x7
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0x1,0x1,0x1,0x1,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1,0x1
	.DB  0x1,0x1,0x1,0x1,0x1,0x1,0x1,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xE0,0xC0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x7F
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xF8,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
_Lab8_Q1_HG:
	.DB  0x7,0x0,0x0,0x0,0xFF,0x0,0x8,0x0
	.DB  0x8,0x0,0x8,0x0,0x8,0x0,0xFF,0x0
	.DB  0x0,0x0,0x7,0x0,0x0,0x0,0x7E,0x0
	.DB  0x42,0x0,0x42,0x0,0x52,0x0,0x52,0x0
	.DB  0x72,0x0,0x0,0x0,0x7,0x0,0x0,0x0
	.DB  0xFF,0x0,0x8,0x0,0x8,0x0,0x8,0x0
	.DB  0x8,0x0,0xFF,0x0,0x0,0x0,0x7,0x0
	.DB  0x0,0x0,0x7E,0x0,0x42,0x0,0x42,0x0
	.DB  0x52,0x0,0x52,0x0,0x72,0x0,0x0,0x0
__glcd_mask:
	.DB  0x0,0x1,0x3,0x7,0xF,0x1F,0x3F,0x7F
	.DB  0xFF
_tbl10_G104:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G104:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  LOW(_0x60003),HIGH(_0x60003),0x5,0x0
	.DB  0x32,0x0,0x28,0x0

_0x60000:
	.DB  0x20,0x20,0x3A,0x20,0x20,0x3A,0x20,0x20
	.DB  0x0,0x25,0x64,0x3A,0x25,0x64,0x3A,0x25
	.DB  0x64,0x20,0x20,0x20,0x0,0x36,0x0,0x33
	.DB  0x0,0x39,0x0,0x31,0x32,0x0
_0x80003:
	.DB  0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80
_0x20A0060:
	.DB  0x1
_0x20A0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x09
	.DW  _0x60003
	.DW  _0x60000*2

	.DW  0x02
	.DW  _0x60019
	.DW  _0x60000*2+7

	.DW  0x02
	.DW  _0x60019+2
	.DW  _0x60000*2+21

	.DW  0x02
	.DW  _0x60019+4
	.DW  _0x60000*2+23

	.DW  0x02
	.DW  _0x60019+6
	.DW  _0x60000*2+25

	.DW  0x03
	.DW  _0x60019+8
	.DW  _0x60000*2+27

	.DW  0x08
	.DW  _R_data
	.DW  _0x80003*2

	.DW  0x01
	.DW  __seed_G105
	.DW  _0x20A0060*2

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
;Automatic Program Generator
;
;Project : lAB8
;Version :
;Date    : 12/23/2022
;Author  : HADIS GHAFOURI
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
;#include "subRoutines.h"
;
;void main(void)
; 0000 001B {

	.CSEG
_main:
; .FSTART _main
; 0000 001C       init_main();
	RCALL _init_main
; 0000 001D 
; 0000 001E       subRoutine2();
	CALL _subRoutine2
; 0000 001F       delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
; 0000 0020       subRoutine3();
	CALL _subRoutine3
; 0000 0021 
; 0000 0022       while (1)
_0x3:
; 0000 0023       {
; 0000 0024             subRoutine1();
	CALL _subRoutine1
; 0000 0025       }
	RJMP _0x3
; 0000 0026 }
_0x6:
	RJMP _0x6
; .FEND
;/****************************************************************************
;Image data created by the LCD Vision V1.05 font & image editor/converter
;(C) Copyright 2011-2013 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Graphic LCD controller: KS0108 128x64 /CS1,/CS2
;Image width: 128 pixels
;Image height: 64 pixels
;Color depth: 1 bits/pixel
;Imported image file name: New image
;
;Exported monochrome image data size:
;1028 bytes for displays organized as horizontal rows of bytes
;1028 bytes for displays organized as rows of vertical bytes.
;****************************************************************************/
;
;flash unsigned char new_image[]=
;{
;/* Image width: 128 pixels */
;0x80, 0x00,
;/* Image height: 64 pixels */
;0x40, 0x00,
;#ifndef _GLCD_DATA_BYTEY_
;/* Image data for monochrome displays organized
;   as horizontal rows of bytes */
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x03, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x07, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFE, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x0F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFC, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x1F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x3F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0x7F, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xF0, 0xFF, 0x00, 0x00, 0x00, 0x00,
;#else
;/* Image data for monochrome displays organized
;   as rows of vertical bytes */
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xC0, 0xC0, 0xC0, 0xC0, 0xC0, 0xC0,
;0xC0, 0xC0, 0xC0, 0xC0, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0xFC, 0xFC, 0xFC, 0xFC, 0xFC, 0xFC, 0xFC, 0xFC,
;0xFC, 0xFC, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x0F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xF8, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xF0, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x07, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xC0, 0xC0, 0xC0,
;0xC0, 0xC0, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x07, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x01,
;0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
;0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
;0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
;0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
;0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
;0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
;0x01, 0x01, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0xC0, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;#endif
;};
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
;
;void init_ports()
; 0002 0004 {

	.CSEG
_init_ports:
; .FSTART _init_ports
; 0002 0005     // Input/Output Ports initialization
; 0002 0006     // Port A initialization
; 0002 0007     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 0008     DDRA = (0 << DDA7) | (0 << DDA6) | (0 << DDA5) | (0 << DDA4) | (0 << DDA3) | (0 << DDA2) | (0 << DDA1) | (0 << DDA0) ...
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0002 0009     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 000A     PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1 ...
	OUT  0x1B,R30
; 0002 000B 
; 0002 000C     // Port B initialization
; 0002 000D     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 000E     DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (0 << DDB3) | (0 << DDB2) | (0 << DDB1) | (0 << DDB0) ...
	OUT  0x17,R30
; 0002 000F     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 0010     PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1 ...
	OUT  0x18,R30
; 0002 0011 
; 0002 0012     // Port C initialization
; 0002 0013     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 0014     DDRC = (0 << DDC7) | (0 << DDC6) | (0 << DDC5) | (0 << DDC4) | (0 << DDC3) | (0 << DDC2) | (0 << DDC1) | (0 << DDC0) ...
	OUT  0x14,R30
; 0002 0015     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 0016     PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1 ...
	OUT  0x15,R30
; 0002 0017 
; 0002 0018     // Port D initialization
; 0002 0019     // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 001A     DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0) ...
	OUT  0x11,R30
; 0002 001B     // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 001C     PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1 ...
	OUT  0x12,R30
; 0002 001D }
	RET
; .FEND
;
;void init_timers()
; 0002 0020 {
_init_timers:
; .FSTART _init_timers
; 0002 0021     TCCR1A = (0 << COM1A1) | (0 << COM1A0) | (0 << COM1B1) | (0 << COM1B0) | (0 << WGM11) | (0 << WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0002 0022     TCCR1B = (0 << ICNC1) | (0 << ICES1) | (0 << WGM13) | (0 << WGM12) | (1 << CS12) | (0 << CS11) | (0 << CS10);
	LDI  R30,LOW(4)
	OUT  0x2E,R30
; 0002 0023     TCNT1H = 0x85;
	LDI  R30,LOW(133)
	OUT  0x2D,R30
; 0002 0024     TCNT1L = 0xEE;
	LDI  R30,LOW(238)
	OUT  0x2C,R30
; 0002 0025     ICR1H = 0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0002 0026     ICR1L = 0x00;
	OUT  0x26,R30
; 0002 0027     OCR1AH = 0x00;
	OUT  0x2B,R30
; 0002 0028     OCR1AL = 0x00;
	OUT  0x2A,R30
; 0002 0029     OCR1BH = 0x00;
	OUT  0x29,R30
; 0002 002A     OCR1BL = 0x00;
	OUT  0x28,R30
; 0002 002B 
; 0002 002C     // Timer(s)/Counter(s) Interrupt(s) initialization
; 0002 002D     TIMSK = (0 << OCIE2) | (0 << TOIE2) | (0 << TICIE1) | (0 << OCIE1A) | (0 << OCIE1B) | (1 << TOIE1) | (0 << OCIE0) |  ...
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0002 002E }
	RET
; .FEND
;
;void init_glcd()
; 0002 0031 {
_init_glcd:
; .FSTART _init_glcd
; 0002 0032     // Variable used to store graphic display
; 0002 0033     // controller initialization data
; 0002 0034     GLCDINIT_t glcd_init_data;
; 0002 0035 
; 0002 0036     // Graphic Display Controller initialization
; 0002 0037     // The KS0108 connections are specified in the
; 0002 0038     // Project|Configure|C Compiler|Libraries|Graphic Display menu:
; 0002 0039     // DB0 - PORTC Bit 0
; 0002 003A     // DB1 - PORTC Bit 1
; 0002 003B     // DB2 - PORTC Bit 2
; 0002 003C     // DB3 - PORTC Bit 3
; 0002 003D     // DB4 - PORTC Bit 4
; 0002 003E     // DB5 - PORTC Bit 5
; 0002 003F     // DB6 - PORTC Bit 6
; 0002 0040     // DB7 - PORTC Bit 7
; 0002 0041     // E - PORTD Bit 0
; 0002 0042     // RD /WR - PORTD Bit 1
; 0002 0043     // RS - PORTD Bit 2
; 0002 0044     // /RST - PORTD Bit 3
; 0002 0045     // /CS1 - PORTD Bit 5
; 0002 0046     // /CS2 - PORTD Bit 4
; 0002 0047 
; 0002 0048     // Specify the current font for displaying text
; 0002 0049     glcd_init_data.font = font5x7;
	SBIW R28,6
;	glcd_init_data -> Y+0
	LDI  R30,LOW(_font5x7*2)
	LDI  R31,HIGH(_font5x7*2)
	ST   Y,R30
	STD  Y+1,R31
; 0002 004A     // No function is used for reading
; 0002 004B     // image data from external memory
; 0002 004C     glcd_init_data.readxmem = NULL;
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0002 004D     // No function is used for writing
; 0002 004E     // image data to external memory
; 0002 004F     glcd_init_data.writexmem = NULL;
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0002 0050 
; 0002 0051     glcd_init(&glcd_init_data);
	MOVW R26,R28
	CALL _glcd_init
; 0002 0052 }
	JMP  _0x212000E
; .FEND
;
;void init_main()
; 0002 0055 {
_init_main:
; .FSTART _init_main
; 0002 0056     init_ports();
	RCALL _init_ports
; 0002 0057     init_timers();
	RCALL _init_timers
; 0002 0058     init_glcd();
	RCALL _init_glcd
; 0002 0059 }
	RET
; .FEND
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
;
;char *output_time = "  :  :  ";

	.DSEG
_0x60003:
	.BYTE 0x9
;
;int hour = 5;
;int minute = 50;
;int second = 40;
;
;float get_radian(float degree)
; 0003 000A {

	.CSEG
_get_radian:
; .FSTART _get_radian
; 0003 000B     return degree * (3.14 / 180.0);
	CALL SUBOPT_0x0
;	degree -> Y+0
	__GETD1N 0x3C8EE7A7
	CALL __MULF12
	JMP  _0x2120010
; 0003 000C }
; .FEND
;
;int get_clock_unit_x2(int x1, int amount, char time_unit)
; 0003 000F {
_get_clock_unit_x2:
; .FSTART _get_clock_unit_x2
; 0003 0010     int x2;
; 0003 0011 
; 0003 0012     switch (time_unit)
	CALL SUBOPT_0x1
;	x1 -> Y+5
;	amount -> Y+3
;	time_unit -> Y+2
;	x2 -> R16,R17
; 0003 0013     {
; 0003 0014     case 's': //* second
	BRNE _0x60007
; 0003 0015         x2 = x1 + (27 * sin(get_radian(6 * amount)));
	CALL SUBOPT_0x2
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
; 0003 0016         break;
	RJMP _0x60006
; 0003 0017 
; 0003 0018     case 'm': //* minute
_0x60007:
	CPI  R30,LOW(0x6D)
	LDI  R26,HIGH(0x6D)
	CPC  R31,R26
	BRNE _0x60008
; 0003 0019         x2 = x1 + (23 * sin(get_radian(6 * amount)));
	CALL SUBOPT_0x2
	CALL SUBOPT_0x5
	CALL SUBOPT_0x4
; 0003 001A         break;
	RJMP _0x60006
; 0003 001B 
; 0003 001C     case 'h': //* hour
_0x60008:
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRNE _0x6000A
; 0003 001D         x2 = x1 + (18 * sin(get_radian(30 * amount)));
	CALL SUBOPT_0x6
	CALL _sin
	CALL SUBOPT_0x7
	CALL SUBOPT_0x4
; 0003 001E         break;
; 0003 001F 
; 0003 0020     default:
_0x6000A:
; 0003 0021         break;
; 0003 0022     }
_0x60006:
; 0003 0023 
; 0003 0024     return x2;
	RJMP _0x2120011
; 0003 0025 }
; .FEND
;
;int get_clock_unit_y2(int y1, int amount, char time_unit)
; 0003 0028 {
_get_clock_unit_y2:
; .FSTART _get_clock_unit_y2
; 0003 0029     int y2;
; 0003 002A 
; 0003 002B     switch (time_unit)
	CALL SUBOPT_0x1
;	y1 -> Y+5
;	amount -> Y+3
;	time_unit -> Y+2
;	y2 -> R16,R17
; 0003 002C     {
; 0003 002D     case 's': //* second
	BRNE _0x6000E
; 0003 002E         y2 = y1 - (27 * cos(get_radian(6 * amount)));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x3
	CALL SUBOPT_0x9
; 0003 002F         break;
	RJMP _0x6000D
; 0003 0030 
; 0003 0031     case 'm': //* minute
_0x6000E:
	CPI  R30,LOW(0x6D)
	LDI  R26,HIGH(0x6D)
	CPC  R31,R26
	BRNE _0x6000F
; 0003 0032         y2 = y1 - (23 * cos(get_radian(6 * amount)));
	CALL SUBOPT_0x8
	CALL SUBOPT_0x5
	CALL SUBOPT_0x9
; 0003 0033         break;
	RJMP _0x6000D
; 0003 0034 
; 0003 0035     case 'h': //* hour
_0x6000F:
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRNE _0x60011
; 0003 0036         y2 = y1 - (18 * cos(get_radian(30 * amount)));
	CALL SUBOPT_0x6
	CALL _cos
	CALL SUBOPT_0x7
	CALL SUBOPT_0x9
; 0003 0037         break;
; 0003 0038 
; 0003 0039     default:
_0x60011:
; 0003 003A         break;
; 0003 003B     }
_0x6000D:
; 0003 003C 
; 0003 003D     return y2;
_0x2120011:
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,7
	RET
; 0003 003E }
; .FEND
;
;void draw_clock_lines(int amount, char time_unit)
; 0003 0041 {
_draw_clock_lines:
; .FSTART _draw_clock_lines
; 0003 0042 
; 0003 0043     //* glcd_line(x1,y1,x2,y2);
; 0003 0044     int x1, x2, y1, y2;
; 0003 0045     x1 = 32;
	ST   -Y,R26
	SBIW R28,2
	CALL __SAVELOCR6
;	amount -> Y+9
;	time_unit -> Y+8
;	x1 -> R16,R17
;	x2 -> R18,R19
;	y1 -> R20,R21
;	y2 -> Y+6
	__GETWRN 16,17,32
; 0003 0046     y1 = 31;
	__GETWRN 20,21,31
; 0003 0047 
; 0003 0048     switch (time_unit)
	LDD  R30,Y+8
	LDI  R31,0
; 0003 0049     {
; 0003 004A     case 's': //* second
	CPI  R30,LOW(0x73)
	LDI  R26,HIGH(0x73)
	CPC  R31,R26
	BRNE _0x60015
; 0003 004B         x2 = get_clock_unit_x2(x1, amount, 's');
	CALL SUBOPT_0xA
	LDI  R26,LOW(115)
	CALL SUBOPT_0xB
; 0003 004C         y2 = get_clock_unit_y2(y1, amount, 's');
	LDI  R26,LOW(115)
	CALL SUBOPT_0xC
; 0003 004D         break;
	RJMP _0x60014
; 0003 004E 
; 0003 004F     case 'm': //* minute
_0x60015:
	CPI  R30,LOW(0x6D)
	LDI  R26,HIGH(0x6D)
	CPC  R31,R26
	BRNE _0x60016
; 0003 0050         x2 = get_clock_unit_x2(x1, amount, 'm');
	CALL SUBOPT_0xA
	LDI  R26,LOW(109)
	CALL SUBOPT_0xB
; 0003 0051         y2 = get_clock_unit_y2(y1, amount, 'm');
	LDI  R26,LOW(109)
	CALL SUBOPT_0xC
; 0003 0052         break;
	RJMP _0x60014
; 0003 0053 
; 0003 0054     case 'h': //* hour
_0x60016:
	CPI  R30,LOW(0x68)
	LDI  R26,HIGH(0x68)
	CPC  R31,R26
	BRNE _0x60018
; 0003 0055         x2 = get_clock_unit_x2(x1, amount, 'h');
	CALL SUBOPT_0xA
	LDI  R26,LOW(104)
	CALL SUBOPT_0xB
; 0003 0056         y2 = get_clock_unit_y2(y1, amount, 'h');
	LDI  R26,LOW(104)
	CALL SUBOPT_0xC
; 0003 0057         break;
; 0003 0058 
; 0003 0059     default:
_0x60018:
; 0003 005A         break;
; 0003 005B     }
_0x60014:
; 0003 005C 
; 0003 005D     glcd_line(x1, y1, x2, y2);
	ST   -Y,R16
	ST   -Y,R20
	ST   -Y,R18
	LDD  R26,Y+9
	CALL _glcd_line
; 0003 005E }
	CALL __LOADLOCR6
	ADIW R28,11
	RET
; .FEND
;
;void update_clock()
; 0003 0061 {
_update_clock:
; .FSTART _update_clock
; 0003 0062     glcd_clear();
	CALL _glcd_clear
; 0003 0063     draw_clock_lines(second, 's');
	ST   -Y,R11
	ST   -Y,R10
	LDI  R26,LOW(115)
	RCALL _draw_clock_lines
; 0003 0064     draw_clock_lines(minute, 'm');
	ST   -Y,R9
	ST   -Y,R8
	LDI  R26,LOW(109)
	RCALL _draw_clock_lines
; 0003 0065     draw_clock_lines(hour, 'h');
	ST   -Y,R7
	ST   -Y,R6
	LDI  R26,LOW(104)
	RCALL _draw_clock_lines
; 0003 0066 
; 0003 0067     sprintf(output_time, "%d:%d:%d   ", hour, minute, second);
	ST   -Y,R5
	ST   -Y,R4
	__POINTW1FN _0x60000,9
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R6
	CALL SUBOPT_0xD
	MOVW R30,R8
	CALL SUBOPT_0xD
	MOVW R30,R10
	CALL SUBOPT_0xD
	LDI  R24,12
	CALL _sprintf
	ADIW R28,16
; 0003 0068     glcd_outtextxy(70, 40, output_time);
	LDI  R30,LOW(70)
	ST   -Y,R30
	LDI  R30,LOW(40)
	ST   -Y,R30
	MOVW R26,R4
	CALL SUBOPT_0xE
; 0003 0069 
; 0003 006A     glcd_outtextxy(30, 50, " "); // should be here
	__POINTW2MN _0x60019,0
	CALL SUBOPT_0xE
; 0003 006B     glcd_outtextxy(30, 50, "6");
	__POINTW2MN _0x60019,2
	CALL _glcd_outtextxy
; 0003 006C     glcd_outtextxy(54, 30, "3");
	LDI  R30,LOW(54)
	ST   -Y,R30
	LDI  R30,LOW(30)
	ST   -Y,R30
	__POINTW2MN _0x60019,4
	CALL _glcd_outtextxy
; 0003 006D     glcd_outtextxy(4, 31, "9");
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(31)
	ST   -Y,R30
	__POINTW2MN _0x60019,6
	CALL _glcd_outtextxy
; 0003 006E     glcd_outtextxy(27, 3, "12");
	LDI  R30,LOW(27)
	ST   -Y,R30
	LDI  R30,LOW(3)
	ST   -Y,R30
	__POINTW2MN _0x60019,8
	CALL _glcd_outtextxy
; 0003 006F 
; 0003 0070     glcd_circle(32, 31, 30);
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R30,LOW(31)
	ST   -Y,R30
	LDI  R26,LOW(30)
	CALL _glcd_circle
; 0003 0071     //* 32 = x specifies the horizontal coordinate of the circle's center
; 0003 0072     //* 31 = y specifies the vertical coordinate of the circle's center
; 0003 0073     //* 30 = specifies the circle's radius
; 0003 0074 }
	RET
; .FEND

	.DSEG
_0x60019:
	.BYTE 0xB
;
;interrupt[TIM1_OVF] void timer1_ovf_isr(void)
; 0003 0077 {

	.CSEG
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
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
; 0003 0078     // Reinitialize Timer1 value
; 0003 0079     TCNT1H = 0x85EE >> 8;
	LDI  R30,LOW(133)
	OUT  0x2D,R30
; 0003 007A     TCNT1L = 0x85EE & 0xff;
	LDI  R30,LOW(238)
	OUT  0x2C,R30
; 0003 007B 
; 0003 007C     second++;
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
; 0003 007D     if (second == 60)
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CP   R30,R10
	CPC  R31,R11
	BRNE _0x6001A
; 0003 007E     {
; 0003 007F         second = 0;
	CLR  R10
	CLR  R11
; 0003 0080         minute++;
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
; 0003 0081         if (minute == 60)
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x6001B
; 0003 0082         {
; 0003 0083             minute = 0;
	CLR  R8
	CLR  R9
; 0003 0084             hour++;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
; 0003 0085             if (hour == 12)
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x6001C
; 0003 0086             {
; 0003 0087                 hour = 0;
	CLR  R6
	CLR  R7
; 0003 0088             }
; 0003 0089         }
_0x6001C:
; 0003 008A     }
_0x6001B:
; 0003 008B     update_clock();
_0x6001A:
	RCALL _update_clock
; 0003 008C }
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
;#include "clock.h"
;
;int i, j;
;
;const unsigned short Lab8_Q1_HG[] = {
;    // 32 numbers =>index = [0,31]
;    0x07, 0x00, 0xFF, 0x08, 0x08, 0x08, 0x08, 0xFF, 0x00, // Code for char H
;    0x07, 0x00, 0x7E, 0x42, 0x42, 0x52, 0x52, 0x72, 0x00, // Code for char G
;    0x07, 0x00, 0xFF, 0x08, 0x08, 0x08, 0x08, 0xFF, 0x00, // Code for char H
;    0x07, 0x00, 0x7E, 0x42, 0x42, 0x52, 0x52, 0x72, 0x00, // Code for char G
;};
;
;unsigned char R_data[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};

	.DSEG
;
;int config_portD(int a, int b)
; 0004 0011 {

	.CSEG
_config_portD:
; .FSTART _config_portD
; 0004 0012     if (b - a < 8)
	ST   -Y,R27
	ST   -Y,R26
;	a -> Y+2
;	b -> Y+0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,Y
	LDD  R31,Y+1
	SUB  R30,R26
	SBC  R31,R27
	SBIW R30,8
	BRGE _0x80004
; 0004 0013         return 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x2120010
; 0004 0014     return 1;
_0x80004:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	JMP  _0x2120010
; 0004 0015 }
; .FEND
;
;int config_portA(int index) // PORTA works as Rows in font matrix
; 0004 0018 {
_config_portA:
; .FSTART _config_portA
; 0004 0019     //(j - i) % 8 = 0 1 2 3 4 5 6 7 => row { Decimal: 1 2 4 8 16 32 64 128 # Hex: 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x ...
; 0004 001A     return R_data[index];
	ST   -Y,R27
	ST   -Y,R26
;	index -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	SUBI R30,LOW(-_R_data)
	SBCI R31,HIGH(-_R_data)
	LD   R30,Z
	LDI  R31,0
	JMP  _0x212000C
; 0004 001B }
; .FEND
;
;void subRoutine1()
; 0004 001E {
_subRoutine1:
; .FSTART _subRoutine1
; 0004 001F 
; 0004 0020     for (i = 0; i < 16; i++)
	CLR  R12
	CLR  R13
_0x80006:
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CP   R12,R30
	CPC  R13,R31
	BRLT PC+2
	RJMP _0x80007
; 0004 0021     {
; 0004 0022         for (j = i; j < i + 16; j++)
	__PUTWMRN _j,0,12,13
_0x80009:
	MOVW R30,R12
	ADIW R30,16
	LDS  R26,_j
	LDS  R27,_j+1
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x8000A
; 0004 0023         {
; 0004 0024             PORTD.7 = config_portD(i, j);
	ST   -Y,R13
	ST   -Y,R12
	RCALL _config_portD
	CPI  R30,0
	BRNE _0x8000B
	CBI  0x12,7
	RJMP _0x8000C
_0x8000B:
	SBI  0x12,7
_0x8000C:
; 0004 0025             PORTA = config_portA((j - i) % 8);
	LDS  R30,_j
	LDS  R31,_j+1
	SUB  R30,R12
	SBC  R31,R13
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	CALL __MANDW12
	MOVW R26,R30
	RCALL _config_portA
	OUT  0x1B,R30
; 0004 0026             PORTB = Lab8_Q1_HG[j]; // Columns in font matrix
	LDS  R30,_j
	LDS  R31,_j+1
	LDI  R26,LOW(_Lab8_Q1_HG*2)
	LDI  R27,HIGH(_Lab8_Q1_HG*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LPM  R0,Z
	OUT  0x18,R0
; 0004 0027             delay_ms(3);
	LDI  R26,LOW(3)
	LDI  R27,0
	CALL _delay_ms
; 0004 0028         }
	LDI  R26,LOW(_j)
	LDI  R27,HIGH(_j)
	CALL SUBOPT_0xF
	RJMP _0x80009
_0x8000A:
; 0004 0029         delay_ms(7);
	LDI  R26,LOW(7)
	LDI  R27,0
	CALL _delay_ms
; 0004 002A     }
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
	RJMP _0x80006
_0x80007:
; 0004 002B }
	RET
; .FEND
;
;void subRoutine2()
; 0004 002E {
_subRoutine2:
; .FSTART _subRoutine2
; 0004 002F     glcd_putimagef(0, 0, new_image, GLCD_PUTCOPY);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(_new_image*2)
	LDI  R31,HIGH(_new_image*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _glcd_putimagef
; 0004 0030 }
	RET
; .FEND
;
;void subRoutine3()
; 0004 0033 {
_subRoutine3:
; .FSTART _subRoutine3
; 0004 0034     // _timer_init_();
; 0004 0035 #asm("sei");
	sei
; 0004 0036     update_clock();
	RCALL _update_clock
; 0004 0037 }
	RET
; .FEND

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	CALL SUBOPT_0x0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL __GETD1S0
	JMP  _0x2120010
__floor1:
    brtc __floor0
	CALL __GETD1S0
	__GETD2N 0x3F800000
	CALL __SUBF12
	RJMP _0x2120010
; .FEND
_sin:
; .FSTART _sin
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	LDI  R17,0
	CALL SUBOPT_0x10
	__GETD1N 0x3E22F983
	CALL __MULF12
	CALL SUBOPT_0x11
	RCALL _floor
	CALL SUBOPT_0x10
	CALL __SWAPD12
	CALL __SUBF12
	CALL SUBOPT_0x11
	__GETD1N 0x3F000000
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2000017
	CALL SUBOPT_0x12
	__GETD2N 0x3F000000
	CALL SUBOPT_0x13
	LDI  R17,LOW(1)
_0x2000017:
	CALL SUBOPT_0x10
	__GETD1N 0x3E800000
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2000018
	CALL SUBOPT_0x10
	__GETD1N 0x3F000000
	CALL SUBOPT_0x13
_0x2000018:
	CPI  R17,0
	BREQ _0x2000019
	CALL SUBOPT_0x12
	CALL __ANEGF1
	__PUTD1S 5
_0x2000019:
	CALL SUBOPT_0x12
	CALL SUBOPT_0x10
	CALL __MULF12
	__PUTD1S 1
	__GETD2N 0x4226C4B1
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x422DE51D
	CALL __SWAPD12
	CALL __SUBF12
	CALL SUBOPT_0x14
	__GETD2N 0x4104534C
	CALL __ADDF12
	CALL SUBOPT_0x10
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD1S 1
	__GETD2N 0x3FDEED11
	CALL __ADDF12
	CALL SUBOPT_0x14
	__GETD2N 0x3FA87B5E
	CALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	LDD  R17,Y+0
	JMP  _0x2120009
; .FEND
_cos:
; .FSTART _cos
	CALL SUBOPT_0x0
	__GETD1N 0x3FC90FDB
	CALL __SUBF12
	MOVW R26,R30
	MOVW R24,R22
	RCALL _sin
	RJMP _0x2120010
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
_ks0108_enable_G101:
; .FSTART _ks0108_enable_G101
	nop
	SBI  0x12,0
	nop
	RET
; .FEND
_ks0108_disable_G101:
; .FSTART _ks0108_disable_G101
	CBI  0x12,0
	SBI  0x12,5
	SBI  0x12,4
	RET
; .FEND
_ks0108_rdbus_G101:
; .FSTART _ks0108_rdbus_G101
	ST   -Y,R17
	RCALL _ks0108_enable_G101
	IN   R17,19
	CBI  0x12,0
	MOV  R30,R17
	LD   R17,Y+
	RET
; .FEND
_ks0108_busy_G101:
; .FSTART _ks0108_busy_G101
	ST   -Y,R26
	ST   -Y,R17
	LDI  R30,LOW(0)
	OUT  0x14,R30
	SBI  0x12,1
	CBI  0x12,2
	LDD  R26,Y+1
	LDI  R30,LOW(2)
	SUB  R30,R26
	MOV  R17,R30
	SBRS R17,0
	RJMP _0x2020003
	SBI  0x12,5
	RJMP _0x2020004
_0x2020003:
	CBI  0x12,5
_0x2020004:
	SBRS R17,1
	RJMP _0x2020005
	SBI  0x12,4
	RJMP _0x2020006
_0x2020005:
	CBI  0x12,4
_0x2020006:
_0x2020007:
	RCALL _ks0108_rdbus_G101
	ANDI R30,LOW(0x80)
	BRNE _0x2020007
	LDD  R17,Y+0
	RJMP _0x212000C
; .FEND
_ks0108_wrcmd_G101:
; .FSTART _ks0108_wrcmd_G101
	ST   -Y,R26
	LDD  R26,Y+1
	RCALL _ks0108_busy_G101
	CALL SUBOPT_0x15
	RJMP _0x212000C
; .FEND
_ks0108_setloc_G101:
; .FSTART _ks0108_setloc_G101
	__GETB1MN _ks0108_coord_G101,1
	ST   -Y,R30
	LDS  R30,_ks0108_coord_G101
	ANDI R30,LOW(0x3F)
	ORI  R30,0x40
	MOV  R26,R30
	RCALL _ks0108_wrcmd_G101
	__GETB1MN _ks0108_coord_G101,1
	ST   -Y,R30
	__GETB1MN _ks0108_coord_G101,2
	ORI  R30,LOW(0xB8)
	MOV  R26,R30
	RCALL _ks0108_wrcmd_G101
	RET
; .FEND
_ks0108_gotoxp_G101:
; .FSTART _ks0108_gotoxp_G101
	ST   -Y,R26
	LDD  R30,Y+1
	STS  _ks0108_coord_G101,R30
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	__PUTB1MN _ks0108_coord_G101,1
	LD   R30,Y
	__PUTB1MN _ks0108_coord_G101,2
	RCALL _ks0108_setloc_G101
	RJMP _0x212000C
; .FEND
_ks0108_nextx_G101:
; .FSTART _ks0108_nextx_G101
	LDS  R26,_ks0108_coord_G101
	SUBI R26,-LOW(1)
	STS  _ks0108_coord_G101,R26
	CPI  R26,LOW(0x80)
	BRLO _0x202000A
	LDI  R30,LOW(0)
	STS  _ks0108_coord_G101,R30
_0x202000A:
	LDS  R30,_ks0108_coord_G101
	ANDI R30,LOW(0x3F)
	BRNE _0x202000B
	LDS  R30,_ks0108_coord_G101
	ST   -Y,R30
	__GETB2MN _ks0108_coord_G101,2
	RCALL _ks0108_gotoxp_G101
_0x202000B:
	RET
; .FEND
_ks0108_wrdata_G101:
; .FSTART _ks0108_wrdata_G101
	ST   -Y,R26
	__GETB2MN _ks0108_coord_G101,1
	RCALL _ks0108_busy_G101
	SBI  0x12,2
	CALL SUBOPT_0x15
	ADIW R28,1
	RET
; .FEND
_ks0108_rddata_G101:
; .FSTART _ks0108_rddata_G101
	__GETB2MN _ks0108_coord_G101,1
	RCALL _ks0108_busy_G101
	LDI  R30,LOW(0)
	OUT  0x14,R30
	SBI  0x12,1
	SBI  0x12,2
	RCALL _ks0108_rdbus_G101
	RET
; .FEND
_ks0108_rdbyte_G101:
; .FSTART _ks0108_rdbyte_G101
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	CALL SUBOPT_0x16
	RCALL _ks0108_rddata_G101
	RCALL _ks0108_setloc_G101
	RCALL _ks0108_rddata_G101
	RJMP _0x212000C
; .FEND
_glcd_init:
; .FSTART _glcd_init
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	SBI  0x11,0
	SBI  0x11,1
	SBI  0x11,2
	SBI  0x11,3
	SBI  0x12,3
	SBI  0x11,5
	SBI  0x11,4
	RCALL _ks0108_disable_G101
	CBI  0x12,3
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x12,3
	LDI  R17,LOW(0)
_0x202000C:
	CPI  R17,2
	BRSH _0x202000E
	ST   -Y,R17
	LDI  R26,LOW(63)
	RCALL _ks0108_wrcmd_G101
	ST   -Y,R17
	INC  R17
	LDI  R26,LOW(192)
	RCALL _ks0108_wrcmd_G101
	RJMP _0x202000C
_0x202000E:
	LDI  R30,LOW(1)
	STS  _glcd_state,R30
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	SBIW R30,0
	BREQ _0x202000F
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL __GETW1P
	__PUTW1MN _glcd_state,4
	ADIW R26,2
	CALL __GETW1P
	__PUTW1MN _glcd_state,25
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,4
	CALL __GETW1P
	RJMP _0x20200AC
_0x202000F:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _glcd_state,4
	__PUTW1MN _glcd_state,25
_0x20200AC:
	__PUTW1MN _glcd_state,27
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,6
	__PUTB1MN _glcd_state,7
	__PUTB1MN _glcd_state,8
	LDI  R30,LOW(255)
	__PUTB1MN _glcd_state,9
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,16
	__POINTW1MN _glcd_state,17
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDI  R26,LOW(8)
	LDI  R27,0
	CALL _memset
	RCALL _glcd_clear
	LDI  R30,LOW(1)
	RJMP _0x212000B
; .FEND
_glcd_clear:
; .FSTART _glcd_clear
	CALL __SAVELOCR4
	LDI  R16,0
	LDI  R19,0
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x2020015
	LDI  R16,LOW(255)
_0x2020015:
_0x2020016:
	CPI  R19,8
	BRSH _0x2020018
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R19
	SUBI R19,-1
	RCALL _ks0108_gotoxp_G101
	LDI  R17,LOW(0)
_0x2020019:
	MOV  R26,R17
	SUBI R17,-1
	CPI  R26,LOW(0x80)
	BRSH _0x202001B
	MOV  R26,R16
	CALL SUBOPT_0x17
	RJMP _0x2020019
_0x202001B:
	RJMP _0x2020016
_0x2020018:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _ks0108_gotoxp_G101
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _glcd_moveto
	CALL __LOADLOCR4
_0x2120010:
	ADIW R28,4
	RET
; .FEND
_glcd_putpixel:
; .FSTART _glcd_putpixel
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x80)
	BRSH _0x202001D
	LDD  R26,Y+3
	CPI  R26,LOW(0x40)
	BRLO _0x202001C
_0x202001D:
	RJMP _0x212000F
_0x202001C:
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+4
	RCALL _ks0108_rdbyte_G101
	MOV  R17,R30
	RCALL _ks0108_setloc_G101
	LDD  R30,Y+3
	ANDI R30,LOW(0x7)
	LDI  R26,LOW(1)
	CALL __LSLB12
	MOV  R16,R30
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x202001F
	OR   R17,R16
	RJMP _0x2020020
_0x202001F:
	MOV  R30,R16
	COM  R30
	AND  R17,R30
_0x2020020:
	MOV  R26,R17
	RCALL _ks0108_wrdata_G101
_0x212000F:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
_glcd_getpixel:
; .FSTART _glcd_getpixel
	ST   -Y,R26
	LDD  R26,Y+1
	CPI  R26,LOW(0x80)
	BRSH _0x2020022
	LD   R26,Y
	CPI  R26,LOW(0x40)
	BRLO _0x2020021
_0x2020022:
	LDI  R30,LOW(0)
	RJMP _0x212000C
_0x2020021:
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _ks0108_rdbyte_G101
	MOV  R1,R30
	LD   R30,Y
	ANDI R30,LOW(0x7)
	LDI  R26,LOW(1)
	CALL __LSLB12
	AND  R30,R1
	BREQ _0x2020024
	LDI  R30,LOW(1)
	RJMP _0x2020025
_0x2020024:
	LDI  R30,LOW(0)
_0x2020025:
	RJMP _0x212000C
; .FEND
_ks0108_wrmasked_G101:
; .FSTART _ks0108_wrmasked_G101
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+5
	ST   -Y,R30
	LDD  R26,Y+5
	RCALL _ks0108_rdbyte_G101
	MOV  R17,R30
	RCALL _ks0108_setloc_G101
	LDD  R30,Y+1
	CPI  R30,LOW(0x7)
	BREQ _0x202002B
	CPI  R30,LOW(0x8)
	BRNE _0x202002C
_0x202002B:
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R26,Y+2
	CALL _glcd_mappixcolor1bit
	STD  Y+3,R30
	RJMP _0x202002D
_0x202002C:
	CPI  R30,LOW(0x3)
	BRNE _0x202002F
	LDD  R30,Y+3
	COM  R30
	STD  Y+3,R30
	RJMP _0x2020030
_0x202002F:
	CPI  R30,0
	BRNE _0x2020031
_0x2020030:
_0x202002D:
	LDD  R30,Y+2
	COM  R30
	AND  R17,R30
	RJMP _0x2020032
_0x2020031:
	CPI  R30,LOW(0x2)
	BRNE _0x2020033
_0x2020032:
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	OR   R17,R30
	RJMP _0x2020029
_0x2020033:
	CPI  R30,LOW(0x1)
	BRNE _0x2020034
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	EOR  R17,R30
	RJMP _0x2020029
_0x2020034:
	CPI  R30,LOW(0x4)
	BRNE _0x2020029
	LDD  R30,Y+2
	COM  R30
	LDD  R26,Y+3
	OR   R30,R26
	AND  R17,R30
_0x2020029:
	MOV  R26,R17
	CALL SUBOPT_0x17
	LDD  R17,Y+0
_0x212000E:
	ADIW R28,6
	RET
; .FEND
_glcd_block:
; .FSTART _glcd_block
	ST   -Y,R26
	SBIW R28,3
	CALL __SAVELOCR6
	LDD  R26,Y+16
	CPI  R26,LOW(0x80)
	BRSH _0x2020037
	LDD  R26,Y+15
	CPI  R26,LOW(0x40)
	BRSH _0x2020037
	LDD  R26,Y+14
	CPI  R26,LOW(0x0)
	BREQ _0x2020037
	LDD  R26,Y+13
	CPI  R26,LOW(0x0)
	BRNE _0x2020036
_0x2020037:
	RJMP _0x212000D
_0x2020036:
	LDD  R30,Y+14
	STD  Y+8,R30
	LDD  R26,Y+16
	CLR  R27
	LDD  R30,Y+14
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CPI  R26,LOW(0x81)
	LDI  R30,HIGH(0x81)
	CPC  R27,R30
	BRLO _0x2020039
	LDD  R26,Y+16
	LDI  R30,LOW(128)
	SUB  R30,R26
	STD  Y+14,R30
_0x2020039:
	LDD  R18,Y+13
	LDD  R26,Y+15
	CLR  R27
	LDD  R30,Y+13
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CPI  R26,LOW(0x41)
	LDI  R30,HIGH(0x41)
	CPC  R27,R30
	BRLO _0x202003A
	LDD  R26,Y+15
	LDI  R30,LOW(64)
	SUB  R30,R26
	STD  Y+13,R30
_0x202003A:
	LDD  R26,Y+9
	CPI  R26,LOW(0x6)
	BREQ PC+2
	RJMP _0x202003B
	LDD  R30,Y+12
	CPI  R30,LOW(0x1)
	BRNE _0x202003F
	RJMP _0x212000D
_0x202003F:
	CPI  R30,LOW(0x3)
	BRNE _0x2020042
	__GETW1MN _glcd_state,27
	SBIW R30,0
	BRNE _0x2020041
	RJMP _0x212000D
_0x2020041:
_0x2020042:
	LDD  R16,Y+8
	LDD  R30,Y+13
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R19,R30
	MOV  R30,R18
	ANDI R30,LOW(0x7)
	BRNE _0x2020044
	LDD  R26,Y+13
	CP   R18,R26
	BREQ _0x2020043
_0x2020044:
	MOV  R26,R16
	CLR  R27
	MOV  R30,R19
	LDI  R31,0
	CALL __MULW12U
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CALL SUBOPT_0x18
	LSR  R18
	LSR  R18
	LSR  R18
	MOV  R21,R19
_0x2020046:
	PUSH R21
	SUBI R21,-1
	MOV  R30,R18
	POP  R26
	CP   R30,R26
	BRLO _0x2020048
	MOV  R17,R16
_0x2020049:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x202004B
	CALL SUBOPT_0x19
	RJMP _0x2020049
_0x202004B:
	RJMP _0x2020046
_0x2020048:
_0x2020043:
	LDD  R26,Y+14
	CP   R16,R26
	BREQ _0x202004C
	LDD  R30,Y+14
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R31,0
	CALL SUBOPT_0x18
	LDD  R30,Y+13
	ANDI R30,LOW(0x7)
	BREQ _0x202004D
	SUBI R19,-LOW(1)
_0x202004D:
	LDI  R18,LOW(0)
_0x202004E:
	PUSH R18
	SUBI R18,-1
	MOV  R30,R19
	POP  R26
	CP   R26,R30
	BRSH _0x2020050
	LDD  R17,Y+14
_0x2020051:
	PUSH R17
	SUBI R17,-1
	MOV  R30,R16
	POP  R26
	CP   R26,R30
	BRSH _0x2020053
	CALL SUBOPT_0x19
	RJMP _0x2020051
_0x2020053:
	LDD  R30,Y+14
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL SUBOPT_0x18
	RJMP _0x202004E
_0x2020050:
_0x202004C:
_0x202003B:
	LDD  R30,Y+15
	ANDI R30,LOW(0x7)
	MOV  R19,R30
_0x2020054:
	LDD  R30,Y+13
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2020056
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(0)
	LDD  R16,Y+16
	CPI  R19,0
	BREQ PC+2
	RJMP _0x2020057
	LDD  R26,Y+13
	CPI  R26,LOW(0x8)
	BRSH PC+2
	RJMP _0x2020058
	LDD  R30,Y+9
	CPI  R30,0
	BREQ _0x202005D
	CPI  R30,LOW(0x3)
	BRNE _0x202005E
_0x202005D:
	RJMP _0x202005F
_0x202005E:
	CPI  R30,LOW(0x7)
	BRNE _0x2020060
_0x202005F:
	RJMP _0x2020061
_0x2020060:
	CPI  R30,LOW(0x8)
	BRNE _0x2020062
_0x2020061:
	RJMP _0x2020063
_0x2020062:
	CPI  R30,LOW(0x6)
	BRNE _0x2020064
_0x2020063:
	RJMP _0x2020065
_0x2020064:
	CPI  R30,LOW(0x9)
	BRNE _0x2020066
_0x2020065:
	RJMP _0x2020067
_0x2020066:
	CPI  R30,LOW(0xA)
	BRNE _0x202005B
_0x2020067:
	ST   -Y,R16
	LDD  R30,Y+16
	CALL SUBOPT_0x16
_0x202005B:
_0x2020069:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x202006B
	LDD  R26,Y+9
	CPI  R26,LOW(0x6)
	BRNE _0x202006C
	RCALL _ks0108_rddata_G101
	RCALL _ks0108_setloc_G101
	CALL SUBOPT_0x1A
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ks0108_rddata_G101
	MOV  R26,R30
	CALL _glcd_writemem
	RCALL _ks0108_nextx_G101
	RJMP _0x202006D
_0x202006C:
	LDD  R30,Y+9
	CPI  R30,LOW(0x9)
	BRNE _0x2020071
	LDI  R21,LOW(0)
	RJMP _0x2020072
_0x2020071:
	CPI  R30,LOW(0xA)
	BRNE _0x2020070
	LDI  R21,LOW(255)
	RJMP _0x2020072
_0x2020070:
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1B
	MOV  R21,R30
	LDD  R30,Y+9
	CPI  R30,LOW(0x7)
	BREQ _0x2020079
	CPI  R30,LOW(0x8)
	BRNE _0x202007A
_0x2020079:
_0x2020072:
	CALL SUBOPT_0x1C
	MOV  R21,R30
	RJMP _0x202007B
_0x202007A:
	CPI  R30,LOW(0x3)
	BRNE _0x202007D
	COM  R21
	RJMP _0x202007E
_0x202007D:
	CPI  R30,0
	BRNE _0x2020080
_0x202007E:
_0x202007B:
	MOV  R26,R21
	CALL SUBOPT_0x17
	RJMP _0x2020077
_0x2020080:
	CALL SUBOPT_0x1D
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G101
_0x2020077:
_0x202006D:
	RJMP _0x2020069
_0x202006B:
	LDD  R30,Y+15
	SUBI R30,-LOW(8)
	STD  Y+15,R30
	LDD  R30,Y+13
	SUBI R30,LOW(8)
	STD  Y+13,R30
	RJMP _0x2020081
_0x2020058:
	LDD  R21,Y+13
	LDI  R18,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+13,R30
	RJMP _0x2020082
_0x2020057:
	MOV  R30,R19
	LDD  R26,Y+13
	ADD  R26,R30
	CPI  R26,LOW(0x9)
	BRSH _0x2020083
	LDD  R18,Y+13
	LDI  R30,LOW(0)
	STD  Y+13,R30
	RJMP _0x2020084
_0x2020083:
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R18,R30
_0x2020084:
	ST   -Y,R19
	MOV  R26,R18
	CALL _glcd_getmask
	MOV  R20,R30
	LDD  R30,Y+9
	CPI  R30,LOW(0x6)
	BRNE _0x2020088
_0x2020089:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x202008B
	CALL SUBOPT_0x1E
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSRB12
	CALL SUBOPT_0x1F
	MOV  R30,R19
	MOV  R26,R20
	CALL __LSRB12
	COM  R30
	AND  R30,R1
	OR   R21,R30
	CALL SUBOPT_0x1A
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R21
	CALL _glcd_writemem
	RJMP _0x2020089
_0x202008B:
	RJMP _0x2020087
_0x2020088:
	CPI  R30,LOW(0x9)
	BRNE _0x202008C
	LDI  R21,LOW(0)
	RJMP _0x202008D
_0x202008C:
	CPI  R30,LOW(0xA)
	BRNE _0x2020093
	LDI  R21,LOW(255)
_0x202008D:
	CALL SUBOPT_0x1C
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSLB12
	MOV  R21,R30
_0x2020090:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x2020092
	CALL SUBOPT_0x1D
	ST   -Y,R20
	LDI  R26,LOW(0)
	RCALL _ks0108_wrmasked_G101
	RJMP _0x2020090
_0x2020092:
	RJMP _0x2020087
_0x2020093:
_0x2020094:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x2020096
	CALL SUBOPT_0x20
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSLB12
	ST   -Y,R30
	ST   -Y,R20
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G101
	RJMP _0x2020094
_0x2020096:
_0x2020087:
	LDD  R30,Y+13
	CPI  R30,0
	BRNE _0x2020097
	RJMP _0x2020056
_0x2020097:
	LDD  R26,Y+13
	CPI  R26,LOW(0x8)
	BRSH _0x2020098
	LDD  R30,Y+13
	SUB  R30,R18
	MOV  R21,R30
	LDI  R30,LOW(0)
	RJMP _0x20200AD
_0x2020098:
	MOV  R21,R19
	LDD  R30,Y+13
	SUBI R30,LOW(8)
_0x20200AD:
	STD  Y+13,R30
	LDI  R17,LOW(0)
	LDD  R30,Y+15
	SUBI R30,-LOW(8)
	STD  Y+15,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R18,R30
	LDD  R16,Y+16
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x2020082:
	MOV  R30,R21
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R20,Z
	LDD  R30,Y+9
	CPI  R30,LOW(0x6)
	BRNE _0x202009D
_0x202009E:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20200A0
	CALL SUBOPT_0x1E
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSLB12
	CALL SUBOPT_0x1F
	MOV  R30,R18
	MOV  R26,R20
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	OR   R21,R30
	CALL SUBOPT_0x1A
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R21
	CALL _glcd_writemem
	RJMP _0x202009E
_0x20200A0:
	RJMP _0x202009C
_0x202009D:
	CPI  R30,LOW(0x9)
	BRNE _0x20200A1
	LDI  R21,LOW(0)
	RJMP _0x20200A2
_0x20200A1:
	CPI  R30,LOW(0xA)
	BRNE _0x20200A8
	LDI  R21,LOW(255)
_0x20200A2:
	CALL SUBOPT_0x1C
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	MOV  R21,R30
_0x20200A5:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20200A7
	CALL SUBOPT_0x1D
	ST   -Y,R20
	LDI  R26,LOW(0)
	RCALL _ks0108_wrmasked_G101
	RJMP _0x20200A5
_0x20200A7:
	RJMP _0x202009C
_0x20200A8:
_0x20200A9:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20200AB
	CALL SUBOPT_0x20
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	ST   -Y,R30
	ST   -Y,R20
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G101
	RJMP _0x20200A9
_0x20200AB:
_0x202009C:
_0x2020081:
	LDD  R30,Y+8
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2020054
_0x2020056:
_0x212000D:
	CALL __LOADLOCR6
	ADIW R28,17
	RET
; .FEND

	.CSEG
_glcd_clipx:
; .FSTART _glcd_clipx
	CALL SUBOPT_0x21
	BRLT _0x2040003
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x212000C
_0x2040003:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRLT _0x2040004
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	RJMP _0x212000C
_0x2040004:
	LD   R30,Y
	LDD  R31,Y+1
	RJMP _0x212000C
; .FEND
_glcd_clipy:
; .FSTART _glcd_clipy
	CALL SUBOPT_0x21
	BRLT _0x2040005
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x212000C
_0x2040005:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRLT _0x2040006
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	RJMP _0x212000C
_0x2040006:
	LD   R30,Y
	LDD  R31,Y+1
	RJMP _0x212000C
; .FEND
_glcd_setpixel:
; .FSTART _glcd_setpixel
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	LDS  R26,_glcd_state
	RCALL _glcd_putpixel
_0x212000C:
	ADIW R28,2
	RET
; .FEND
_glcd_imagesize:
; .FSTART _glcd_imagesize
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+2
	CPI  R26,LOW(0x80)
	BRSH _0x2040008
	LDD  R26,Y+1
	CPI  R26,LOW(0x40)
	BRLO _0x2040007
_0x2040008:
	__GETD1N 0x0
	RJMP _0x212000B
_0x2040007:
	LDD  R30,Y+1
	ANDI R30,LOW(0x7)
	MOV  R17,R30
	LDD  R30,Y+1
	LSR  R30
	LSR  R30
	LSR  R30
	STD  Y+1,R30
	CPI  R17,0
	BREQ _0x204000A
	SUBI R30,-LOW(1)
	STD  Y+1,R30
_0x204000A:
	LDD  R26,Y+2
	CLR  R27
	CLR  R24
	CLR  R25
	LDD  R30,Y+1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __MULD12U
	__ADDD1N 4
_0x212000B:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_glcd_getcharw_G102:
; .FSTART _glcd_getcharw_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,3
	CALL SUBOPT_0x22
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x204000B
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x212000A
_0x204000B:
	CALL SUBOPT_0x23
	STD  Y+7,R0
	CALL SUBOPT_0x23
	STD  Y+6,R0
	CALL SUBOPT_0x23
	STD  Y+8,R0
	LDD  R30,Y+11
	LDD  R26,Y+8
	CP   R30,R26
	BRSH _0x204000C
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x212000A
_0x204000C:
	MOVW R30,R16
	__ADDWRN 16,17,1
	LPM  R21,Z
	LDD  R26,Y+8
	CLR  R27
	CLR  R30
	ADD  R26,R21
	ADC  R27,R30
	LDD  R30,Y+11
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO _0x204000D
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x212000A
_0x204000D:
	LDD  R30,Y+6
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R20,R30
	LDD  R30,Y+6
	ANDI R30,LOW(0x7)
	BREQ _0x204000E
	SUBI R20,-LOW(1)
_0x204000E:
	LDD  R30,Y+7
	CPI  R30,0
	BREQ _0x204000F
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ST   X,R30
	LDD  R26,Y+8
	LDD  R30,Y+11
	SUB  R30,R26
	LDI  R31,0
	MOVW R26,R30
	LDD  R30,Y+7
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R20
	LDI  R31,0
	CALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	RJMP _0x212000A
_0x204000F:
	MOVW R18,R16
	MOV  R30,R21
	LDI  R31,0
	__ADDWRR 16,17,30,31
_0x2040010:
	LDD  R26,Y+8
	SUBI R26,-LOW(1)
	STD  Y+8,R26
	SUBI R26,LOW(1)
	LDD  R30,Y+11
	CP   R26,R30
	BRSH _0x2040012
	MOVW R30,R18
	__ADDWRN 18,19,1
	LPM  R26,Z
	LDI  R27,0
	MOV  R30,R20
	LDI  R31,0
	CALL __MULW12U
	__ADDWRR 16,17,30,31
	RJMP _0x2040010
_0x2040012:
	MOVW R30,R18
	LPM  R30,Z
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ST   X,R30
	MOVW R30,R16
_0x212000A:
	CALL __LOADLOCR6
	ADIW R28,12
	RET
; .FEND
_glcd_new_line_G102:
; .FSTART _glcd_new_line_G102
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,2
	__GETB2MN _glcd_state,3
	CLR  R27
	CALL SUBOPT_0x24
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	__GETB1MN _glcd_state,7
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	RCALL _glcd_clipy
	__PUTB1MN _glcd_state,3
	RET
; .FEND
_glcd_putchar:
; .FSTART _glcd_putchar
	ST   -Y,R26
	SBIW R28,1
	CALL SUBOPT_0x22
	SBIW R30,0
	BRNE PC+2
	RJMP _0x204001F
	LDD  R26,Y+7
	CPI  R26,LOW(0xA)
	BRNE _0x2040020
	RJMP _0x2040021
_0x2040020:
	LDD  R30,Y+7
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,7
	RCALL _glcd_getcharw_G102
	MOVW R20,R30
	SBIW R30,0
	BRNE _0x2040022
	CALL __LOADLOCR6
	RJMP _0x2120006
_0x2040022:
	__GETB1MN _glcd_state,6
	LDD  R26,Y+6
	ADD  R30,R26
	MOV  R19,R30
	__GETB2MN _glcd_state,2
	CLR  R27
	CALL SUBOPT_0x25
	__CPWRN 16,17,129
	BRLO _0x2040023
	MOV  R16,R19
	CLR  R17
	RCALL _glcd_new_line_G102
_0x2040023:
	__GETB1MN _glcd_state,2
	ST   -Y,R30
	__GETB1MN _glcd_state,3
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	CALL SUBOPT_0x24
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	ST   -Y,R21
	ST   -Y,R20
	LDI  R26,LOW(7)
	RCALL _glcd_block
	__GETB1MN _glcd_state,2
	LDD  R26,Y+6
	ADD  R30,R26
	ST   -Y,R30
	__GETB1MN _glcd_state,3
	ST   -Y,R30
	__GETB1MN _glcd_state,6
	ST   -Y,R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x26
	__GETB1MN _glcd_state,2
	ST   -Y,R30
	__GETB2MN _glcd_state,3
	CALL SUBOPT_0x24
	ADD  R30,R26
	ST   -Y,R30
	ST   -Y,R19
	__GETB1MN _glcd_state,7
	CALL SUBOPT_0x26
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x2040024
_0x2040021:
	RCALL _glcd_new_line_G102
	CALL __LOADLOCR6
	RJMP _0x2120006
_0x2040024:
_0x204001F:
	__PUTBMRN _glcd_state,2,16
	CALL __LOADLOCR6
	RJMP _0x2120006
; .FEND
_glcd_outtextxy:
; .FSTART _glcd_outtextxy
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+4
	RCALL _glcd_moveto
_0x2040025:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2040027
	MOV  R26,R17
	RCALL _glcd_putchar
	RJMP _0x2040025
_0x2040027:
	LDD  R17,Y+0
	JMP  _0x2120003
; .FEND
_glcd_putimagef:
; .FSTART _glcd_putimagef
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+4
	CPI  R26,LOW(0x5)
	BRSH _0x2040038
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LPM  R16,Z+
	CALL SUBOPT_0x27
	LPM  R17,Z+
	CALL SUBOPT_0x27
	LPM  R18,Z+
	CALL SUBOPT_0x27
	LPM  R19,Z+
	STD  Y+5,R30
	STD  Y+5+1,R31
	LDD  R30,Y+8
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	ST   -Y,R16
	ST   -Y,R18
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+11
	RCALL _glcd_block
	ST   -Y,R16
	MOV  R26,R18
	RCALL _glcd_imagesize
	RJMP _0x2120008
_0x2040038:
	__GETD1N 0x0
_0x2120008:
	CALL __LOADLOCR4
_0x2120009:
	ADIW R28,9
	RET
; .FEND
_glcd_putpixelm_G102:
; .FSTART _glcd_putpixelm_G102
	ST   -Y,R26
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R30,Y+2
	ST   -Y,R30
	__GETB1MN _glcd_state,9
	LDD  R26,Y+2
	AND  R30,R26
	BREQ _0x204003E
	LDS  R30,_glcd_state
	RJMP _0x204003F
_0x204003E:
	__GETB1MN _glcd_state,1
_0x204003F:
	MOV  R26,R30
	RCALL _glcd_putpixel
	LD   R30,Y
	LSL  R30
	ST   Y,R30
	CPI  R30,0
	BRNE _0x2040041
	LDI  R30,LOW(1)
	ST   Y,R30
_0x2040041:
	LD   R30,Y
	JMP  _0x2120001
; .FEND
_glcd_moveto:
; .FSTART _glcd_moveto
	ST   -Y,R26
	LDD  R26,Y+1
	CLR  R27
	RCALL _glcd_clipx
	__PUTB1MN _glcd_state,2
	LD   R26,Y
	CLR  R27
	RCALL _glcd_clipy
	__PUTB1MN _glcd_state,3
	JMP  _0x2120002
; .FEND
_glcd_line:
; .FSTART _glcd_line
	ST   -Y,R26
	SBIW R28,11
	CALL __SAVELOCR6
	LDD  R26,Y+20
	CLR  R27
	RCALL _glcd_clipx
	STD  Y+20,R30
	LDD  R26,Y+18
	CLR  R27
	RCALL _glcd_clipx
	STD  Y+18,R30
	LDD  R26,Y+19
	CLR  R27
	RCALL _glcd_clipy
	STD  Y+19,R30
	LDD  R26,Y+17
	CLR  R27
	RCALL _glcd_clipy
	STD  Y+17,R30
	LDD  R30,Y+18
	__PUTB1MN _glcd_state,2
	LDD  R30,Y+17
	__PUTB1MN _glcd_state,3
	LDI  R30,LOW(1)
	STD  Y+8,R30
	LDD  R30,Y+17
	LDD  R26,Y+19
	CP   R30,R26
	BRNE _0x2040042
	LDD  R17,Y+20
	LDD  R26,Y+18
	CP   R17,R26
	BRNE _0x2040043
	ST   -Y,R17
	LDD  R30,Y+20
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _glcd_putpixelm_G102
	RJMP _0x2120007
_0x2040043:
	LDD  R26,Y+18
	CP   R17,R26
	BRSH _0x2040044
	LDD  R30,Y+18
	SUB  R30,R17
	MOV  R16,R30
	__GETWRN 20,21,1
	RJMP _0x2040045
_0x2040044:
	LDD  R26,Y+18
	MOV  R30,R17
	SUB  R30,R26
	MOV  R16,R30
	__GETWRN 20,21,-1
_0x2040045:
_0x2040047:
	LDD  R19,Y+19
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2040049:
	CALL SUBOPT_0x28
	BRSH _0x204004B
	ST   -Y,R17
	ST   -Y,R19
	INC  R19
	LDD  R26,Y+10
	RCALL _glcd_putpixelm_G102
	STD  Y+7,R30
	RJMP _0x2040049
_0x204004B:
	LDD  R30,Y+7
	STD  Y+8,R30
	ADD  R17,R20
	MOV  R30,R16
	SUBI R16,1
	CPI  R30,0
	BRNE _0x2040047
	RJMP _0x204004C
_0x2040042:
	LDD  R30,Y+18
	LDD  R26,Y+20
	CP   R30,R26
	BRNE _0x204004D
	LDD  R19,Y+19
	LDD  R26,Y+17
	CP   R19,R26
	BRSH _0x204004E
	LDD  R30,Y+17
	SUB  R30,R19
	MOV  R18,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x204011B
_0x204004E:
	LDD  R26,Y+17
	MOV  R30,R19
	SUB  R30,R26
	MOV  R18,R30
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
_0x204011B:
	STD  Y+13,R30
	STD  Y+13+1,R31
_0x2040051:
	LDD  R17,Y+20
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2040053:
	CALL SUBOPT_0x28
	BRSH _0x2040055
	ST   -Y,R17
	INC  R17
	CALL SUBOPT_0x29
	STD  Y+7,R30
	RJMP _0x2040053
_0x2040055:
	LDD  R30,Y+7
	STD  Y+8,R30
	LDD  R30,Y+13
	ADD  R19,R30
	MOV  R30,R18
	SUBI R18,1
	CPI  R30,0
	BRNE _0x2040051
	RJMP _0x2040056
_0x204004D:
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2040057:
	CALL SUBOPT_0x28
	BRLO PC+2
	RJMP _0x2040059
	LDD  R17,Y+20
	LDD  R19,Y+19
	LDI  R30,LOW(1)
	MOV  R18,R30
	MOV  R16,R30
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+20
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
	TST  R21
	BRPL _0x204005A
	LDI  R16,LOW(255)
	MOVW R30,R20
	CALL __ANEGW1
	MOVW R20,R30
_0x204005A:
	MOVW R30,R20
	LSL  R30
	ROL  R31
	STD  Y+15,R30
	STD  Y+15+1,R31
	LDD  R26,Y+17
	CLR  R27
	LDD  R30,Y+19
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	STD  Y+13,R26
	STD  Y+13+1,R27
	LDD  R26,Y+14
	TST  R26
	BRPL _0x204005B
	LDI  R18,LOW(255)
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	CALL __ANEGW1
	STD  Y+13,R30
	STD  Y+13+1,R31
_0x204005B:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	LSL  R30
	ROL  R31
	STD  Y+11,R30
	STD  Y+11+1,R31
	ST   -Y,R17
	ST   -Y,R19
	LDI  R26,LOW(1)
	RCALL _glcd_putpixelm_G102
	STD  Y+8,R30
	LDI  R30,LOW(0)
	STD  Y+9,R30
	STD  Y+9+1,R30
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	CP   R20,R26
	CPC  R21,R27
	BRLT _0x204005C
_0x204005E:
	ADD  R17,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CALL SUBOPT_0x2A
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R20,R26
	CPC  R21,R27
	BRGE _0x2040060
	ADD  R19,R18
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	CALL SUBOPT_0x2B
_0x2040060:
	ST   -Y,R17
	CALL SUBOPT_0x29
	STD  Y+8,R30
	LDD  R30,Y+18
	CP   R30,R17
	BRNE _0x204005E
	RJMP _0x2040061
_0x204005C:
_0x2040063:
	ADD  R19,R18
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	CALL SUBOPT_0x2A
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x2040065
	ADD  R17,R16
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL SUBOPT_0x2B
_0x2040065:
	ST   -Y,R17
	CALL SUBOPT_0x29
	STD  Y+8,R30
	LDD  R30,Y+17
	CP   R30,R19
	BRNE _0x2040063
_0x2040061:
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	LDD  R30,Y+17
	SUBI R30,-LOW(1)
	STD  Y+17,R30
	RJMP _0x2040057
_0x2040059:
_0x2040056:
_0x204004C:
_0x2120007:
	CALL __LOADLOCR6
	ADIW R28,21
	RET
; .FEND
_glcd_plot8_G102:
; .FSTART _glcd_plot8_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,3
	CALL __SAVELOCR6
	LDD  R30,Y+13
	STD  Y+8,R30
	__GETB1MN _glcd_state,8
	STD  Y+7,R30
	LDS  R30,_glcd_state
	STD  Y+6,R30
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+15
	CALL SUBOPT_0x25
	LDD  R26,Y+17
	CLR  R27
	LDD  R30,Y+16
	CALL SUBOPT_0x2C
	LDD  R30,Y+16
	CALL SUBOPT_0x2D
	BREQ _0x2040073
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x2040075
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDI  R30,LOW(90)
	LDI  R31,HIGH(90)
	CALL SUBOPT_0x2E
	BRLT _0x2040077
	CALL SUBOPT_0x2F
	BRGE _0x2040078
_0x2040077:
	RJMP _0x2040076
_0x2040078:
_0x2040073:
	TST  R19
	BRMI _0x2040079
	CALL SUBOPT_0x30
_0x2040079:
	LDD  R26,Y+7
	CPI  R26,LOW(0x2)
	BRLO _0x204007B
	__CPWRN 18,19,2
	BRGE _0x204007C
_0x204007B:
	RJMP _0x204007A
_0x204007C:
	CALL SUBOPT_0x31
	BRNE _0x204007D
	ST   -Y,R16
	MOV  R26,R18
	SUBI R26,LOW(1)
	RCALL _glcd_setpixel
_0x204007D:
_0x204007A:
_0x2040076:
_0x2040075:
	LDD  R30,Y+8
	ANDI R30,LOW(0x88)
	CPI  R30,LOW(0x88)
	BREQ _0x204007F
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x2040081
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUBI R26,LOW(-270)
	SBCI R27,HIGH(-270)
	CALL SUBOPT_0x32
	BRLT _0x2040083
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUBI R26,LOW(-270)
	SBCI R27,HIGH(-270)
	CALL SUBOPT_0x33
	BRGE _0x2040084
_0x2040083:
	RJMP _0x2040082
_0x2040084:
_0x204007F:
	CALL SUBOPT_0x34
	BRLO _0x2040085
	CALL SUBOPT_0x35
	BRNE _0x2040086
	ST   -Y,R16
	MOV  R26,R20
	SUBI R26,-LOW(1)
	RCALL _glcd_setpixel
_0x2040086:
_0x2040085:
_0x2040082:
_0x2040081:
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+15
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R16,R26
	TST  R17
	BRPL PC+2
	RJMP _0x2040087
	LDD  R30,Y+8
	ANDI R30,LOW(0x82)
	CPI  R30,LOW(0x82)
	BREQ _0x2040089
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x204008B
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUBI R26,LOW(-90)
	SBCI R27,HIGH(-90)
	CALL SUBOPT_0x32
	BRLT _0x204008D
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUBI R26,LOW(-90)
	SBCI R27,HIGH(-90)
	CALL SUBOPT_0x33
	BRGE _0x204008E
_0x204008D:
	RJMP _0x204008C
_0x204008E:
_0x2040089:
	TST  R19
	BRMI _0x204008F
	CALL SUBOPT_0x30
_0x204008F:
	LDD  R26,Y+7
	CPI  R26,LOW(0x2)
	BRLO _0x2040091
	__CPWRN 18,19,2
	BRGE _0x2040092
_0x2040091:
	RJMP _0x2040090
_0x2040092:
	CALL SUBOPT_0x31
	BRNE _0x2040093
	ST   -Y,R16
	MOV  R26,R18
	SUBI R26,LOW(1)
	RCALL _glcd_setpixel
_0x2040093:
_0x2040090:
_0x204008C:
_0x204008B:
	LDD  R30,Y+8
	ANDI R30,LOW(0x84)
	CPI  R30,LOW(0x84)
	BREQ _0x2040095
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x2040097
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDI  R30,LOW(270)
	LDI  R31,HIGH(270)
	CALL SUBOPT_0x2E
	BRLT _0x2040099
	CALL SUBOPT_0x2F
	BRGE _0x204009A
_0x2040099:
	RJMP _0x2040098
_0x204009A:
_0x2040095:
	CALL SUBOPT_0x34
	BRLO _0x204009B
	CALL SUBOPT_0x35
	BRNE _0x204009C
	ST   -Y,R16
	MOV  R26,R20
	SUBI R26,-LOW(1)
	RCALL _glcd_setpixel
_0x204009C:
_0x204009B:
_0x2040098:
_0x2040097:
_0x2040087:
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+16
	CALL SUBOPT_0x25
	LDD  R26,Y+17
	CLR  R27
	LDD  R30,Y+15
	CALL SUBOPT_0x2C
	LDD  R30,Y+15
	CALL SUBOPT_0x2D
	BREQ _0x204009E
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x20400A0
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x20400A2
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x20400A3
_0x20400A2:
	RJMP _0x20400A1
_0x20400A3:
_0x204009E:
	TST  R19
	BRMI _0x20400A4
	CALL SUBOPT_0x30
	LDD  R26,Y+7
	CPI  R26,LOW(0x2)
	BRLO _0x20400A5
	MOV  R30,R16
	SUBI R30,-LOW(2)
	CALL SUBOPT_0x36
	BRNE _0x20400A6
	MOV  R30,R16
	SUBI R30,-LOW(1)
	ST   -Y,R30
	MOV  R26,R18
	RCALL _glcd_setpixel
_0x20400A6:
_0x20400A5:
_0x20400A4:
_0x20400A1:
_0x20400A0:
	LDD  R30,Y+8
	ANDI R30,LOW(0x88)
	CPI  R30,LOW(0x88)
	BREQ _0x20400A8
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x20400AA
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDI  R30,LOW(360)
	LDI  R31,HIGH(360)
	CALL SUBOPT_0x2E
	BRLT _0x20400AC
	CALL SUBOPT_0x2F
	BRGE _0x20400AD
_0x20400AC:
	RJMP _0x20400AB
_0x20400AD:
_0x20400A8:
	CALL SUBOPT_0x34
	BRLO _0x20400AE
	MOV  R30,R16
	SUBI R30,-LOW(2)
	CALL SUBOPT_0x37
	BRNE _0x20400AF
	MOV  R30,R16
	SUBI R30,-LOW(1)
	ST   -Y,R30
	MOV  R26,R20
	RCALL _glcd_setpixel
_0x20400AF:
_0x20400AE:
_0x20400AB:
_0x20400AA:
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+16
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R16,R26
	TST  R17
	BRPL PC+2
	RJMP _0x20400B0
	LDD  R30,Y+8
	ANDI R30,LOW(0x82)
	CPI  R30,LOW(0x82)
	BREQ _0x20400B2
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x20400B4
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDI  R30,LOW(180)
	LDI  R31,HIGH(180)
	CALL SUBOPT_0x2E
	BRLT _0x20400B6
	CALL SUBOPT_0x2F
	BRGE _0x20400B7
_0x20400B6:
	RJMP _0x20400B5
_0x20400B7:
_0x20400B2:
	TST  R19
	BRMI _0x20400B8
	CALL SUBOPT_0x30
	LDD  R26,Y+7
	CPI  R26,LOW(0x2)
	BRLO _0x20400BA
	__CPWRN 16,17,2
	BRGE _0x20400BB
_0x20400BA:
	RJMP _0x20400B9
_0x20400BB:
	MOV  R30,R16
	SUBI R30,LOW(2)
	CALL SUBOPT_0x36
	BRNE _0x20400BC
	MOV  R30,R16
	SUBI R30,LOW(1)
	ST   -Y,R30
	MOV  R26,R18
	RCALL _glcd_setpixel
_0x20400BC:
_0x20400B9:
_0x20400B8:
_0x20400B5:
_0x20400B4:
	LDD  R30,Y+8
	ANDI R30,LOW(0x84)
	CPI  R30,LOW(0x84)
	BREQ _0x20400BE
	LDD  R30,Y+8
	ANDI R30,LOW(0x80)
	BRNE _0x20400C0
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUBI R26,LOW(-180)
	SBCI R27,HIGH(-180)
	CALL SUBOPT_0x32
	BRLT _0x20400C2
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	SUBI R26,LOW(-180)
	SBCI R27,HIGH(-180)
	CALL SUBOPT_0x33
	BRGE _0x20400C3
_0x20400C2:
	RJMP _0x20400C1
_0x20400C3:
_0x20400BE:
	CALL SUBOPT_0x34
	BRLO _0x20400C5
	__CPWRN 16,17,2
	BRGE _0x20400C6
_0x20400C5:
	RJMP _0x20400C4
_0x20400C6:
	MOV  R30,R16
	SUBI R30,LOW(2)
	CALL SUBOPT_0x37
	BRNE _0x20400C7
	MOV  R30,R16
	SUBI R30,LOW(1)
	ST   -Y,R30
	MOV  R26,R20
	RCALL _glcd_setpixel
_0x20400C7:
_0x20400C4:
_0x20400C1:
_0x20400C0:
_0x20400B0:
	CALL __LOADLOCR6
	ADIW R28,19
	RET
; .FEND
_glcd_line2_G102:
; .FSTART _glcd_line2_G102
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+7
	CLR  R27
	LDD  R30,Y+5
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	RCALL _glcd_clipx
	MOV  R17,R30
	LDD  R26,Y+7
	CLR  R27
	LDD  R30,Y+5
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	RCALL _glcd_clipx
	MOV  R16,R30
	LDD  R26,Y+6
	CLR  R27
	LDD  R30,Y+4
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	RCALL _glcd_clipy
	MOV  R19,R30
	LDD  R26,Y+6
	CLR  R27
	LDD  R30,Y+4
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	RCALL _glcd_clipy
	MOV  R18,R30
	ST   -Y,R17
	ST   -Y,R19
	ST   -Y,R16
	MOV  R26,R19
	RCALL _glcd_line
	ST   -Y,R17
	ST   -Y,R18
	ST   -Y,R16
	MOV  R26,R18
	RCALL _glcd_line
	CALL __LOADLOCR4
_0x2120006:
	ADIW R28,8
	RET
; .FEND
_glcd_quadrant_G102:
; .FSTART _glcd_quadrant_G102
	ST   -Y,R26
	CALL __SAVELOCR6
	LDD  R26,Y+9
	CPI  R26,LOW(0x80)
	BRSH _0x20400C9
	LDD  R26,Y+8
	CPI  R26,LOW(0x40)
	BRLO _0x20400C8
_0x20400C9:
	RJMP _0x2120005
_0x20400C8:
	__GETBRMN 21,_glcd_state,8
_0x20400CB:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20400CD
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20400CE
	RJMP _0x2120005
_0x20400CE:
	LDD  R30,Y+7
	SUBI R30,LOW(1)
	STD  Y+7,R30
	SUBI R30,-LOW(1)
	MOV  R16,R30
	LDI  R31,0
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R30,R26
	CALL __LSLW2
	CALL __ASRW2
	MOVW R18,R30
	LDI  R17,LOW(0)
_0x20400D0:
	LDD  R26,Y+6
	CPI  R26,LOW(0x40)
	BRNE _0x20400D2
	CALL SUBOPT_0x38
	ST   -Y,R17
	MOV  R26,R16
	RCALL _glcd_line2_G102
	CALL SUBOPT_0x38
	ST   -Y,R16
	MOV  R26,R17
	RCALL _glcd_line2_G102
	RJMP _0x20400D3
_0x20400D2:
	CALL SUBOPT_0x38
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+10
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _glcd_plot8_G102
_0x20400D3:
	SUBI R17,-1
	TST  R19
	BRPL _0x20400D4
	MOV  R30,R17
	LDI  R31,0
	RJMP _0x204011C
_0x20400D4:
	SUBI R16,1
	MOV  R26,R17
	CLR  R27
	MOV  R30,R16
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R30,R26
_0x204011C:
	LSL  R30
	ROL  R31
	ADIW R30,1
	__ADDWRR 18,19,30,31
	CP   R16,R17
	BRSH _0x20400D0
	RJMP _0x20400CB
_0x20400CD:
_0x2120005:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
_glcd_circle:
; .FSTART _glcd_circle
	ST   -Y,R26
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R30,Y+2
	ST   -Y,R30
	LDI  R26,LOW(143)
	RCALL _glcd_quadrant_G102
	JMP  _0x2120001
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
_put_buff_G104:
; .FSTART _put_buff_G104
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2080010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2080012
	__CPWRN 16,17,2
	BRLO _0x2080013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2080012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL SUBOPT_0xF
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2080013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2080014
	CALL SUBOPT_0xF
_0x2080014:
	RJMP _0x2080015
_0x2080010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2080015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x2120003
; .FEND
__print_G104:
; .FSTART __print_G104
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
_0x2080016:
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
	RJMP _0x2080018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x208001C
	CPI  R18,37
	BRNE _0x208001D
	LDI  R17,LOW(1)
	RJMP _0x208001E
_0x208001D:
	CALL SUBOPT_0x39
_0x208001E:
	RJMP _0x208001B
_0x208001C:
	CPI  R30,LOW(0x1)
	BRNE _0x208001F
	CPI  R18,37
	BRNE _0x2080020
	CALL SUBOPT_0x39
	RJMP _0x20800CC
_0x2080020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2080021
	LDI  R16,LOW(1)
	RJMP _0x208001B
_0x2080021:
	CPI  R18,43
	BRNE _0x2080022
	LDI  R20,LOW(43)
	RJMP _0x208001B
_0x2080022:
	CPI  R18,32
	BRNE _0x2080023
	LDI  R20,LOW(32)
	RJMP _0x208001B
_0x2080023:
	RJMP _0x2080024
_0x208001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2080025
_0x2080024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2080026
	ORI  R16,LOW(128)
	RJMP _0x208001B
_0x2080026:
	RJMP _0x2080027
_0x2080025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x208001B
_0x2080027:
	CPI  R18,48
	BRLO _0x208002A
	CPI  R18,58
	BRLO _0x208002B
_0x208002A:
	RJMP _0x2080029
_0x208002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x208001B
_0x2080029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x208002F
	CALL SUBOPT_0x3A
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x3B
	RJMP _0x2080030
_0x208002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2080032
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3C
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2080033
_0x2080032:
	CPI  R30,LOW(0x70)
	BRNE _0x2080035
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3C
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2080033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2080036
_0x2080035:
	CPI  R30,LOW(0x64)
	BREQ _0x2080039
	CPI  R30,LOW(0x69)
	BRNE _0x208003A
_0x2080039:
	ORI  R16,LOW(4)
	RJMP _0x208003B
_0x208003A:
	CPI  R30,LOW(0x75)
	BRNE _0x208003C
_0x208003B:
	LDI  R30,LOW(_tbl10_G104*2)
	LDI  R31,HIGH(_tbl10_G104*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x208003D
_0x208003C:
	CPI  R30,LOW(0x58)
	BRNE _0x208003F
	ORI  R16,LOW(8)
	RJMP _0x2080040
_0x208003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2080071
_0x2080040:
	LDI  R30,LOW(_tbl16_G104*2)
	LDI  R31,HIGH(_tbl16_G104*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x208003D:
	SBRS R16,2
	RJMP _0x2080042
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3D
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2080043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2080043:
	CPI  R20,0
	BREQ _0x2080044
	SUBI R17,-LOW(1)
	RJMP _0x2080045
_0x2080044:
	ANDI R16,LOW(251)
_0x2080045:
	RJMP _0x2080046
_0x2080042:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3D
_0x2080046:
_0x2080036:
	SBRC R16,0
	RJMP _0x2080047
_0x2080048:
	CP   R17,R21
	BRSH _0x208004A
	SBRS R16,7
	RJMP _0x208004B
	SBRS R16,2
	RJMP _0x208004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x208004D
_0x208004C:
	LDI  R18,LOW(48)
_0x208004D:
	RJMP _0x208004E
_0x208004B:
	LDI  R18,LOW(32)
_0x208004E:
	CALL SUBOPT_0x39
	SUBI R21,LOW(1)
	RJMP _0x2080048
_0x208004A:
_0x2080047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x208004F
_0x2080050:
	CPI  R19,0
	BREQ _0x2080052
	SBRS R16,3
	RJMP _0x2080053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2080054
_0x2080053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2080054:
	CALL SUBOPT_0x39
	CPI  R21,0
	BREQ _0x2080055
	SUBI R21,LOW(1)
_0x2080055:
	SUBI R19,LOW(1)
	RJMP _0x2080050
_0x2080052:
	RJMP _0x2080056
_0x208004F:
_0x2080058:
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
_0x208005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x208005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x208005A
_0x208005C:
	CPI  R18,58
	BRLO _0x208005D
	SBRS R16,3
	RJMP _0x208005E
	SUBI R18,-LOW(7)
	RJMP _0x208005F
_0x208005E:
	SUBI R18,-LOW(39)
_0x208005F:
_0x208005D:
	SBRC R16,4
	RJMP _0x2080061
	CPI  R18,49
	BRSH _0x2080063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2080062
_0x2080063:
	RJMP _0x20800CD
_0x2080062:
	CP   R21,R19
	BRLO _0x2080067
	SBRS R16,0
	RJMP _0x2080068
_0x2080067:
	RJMP _0x2080066
_0x2080068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2080069
	LDI  R18,LOW(48)
_0x20800CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x208006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x3B
	CPI  R21,0
	BREQ _0x208006B
	SUBI R21,LOW(1)
_0x208006B:
_0x208006A:
_0x2080069:
_0x2080061:
	CALL SUBOPT_0x39
	CPI  R21,0
	BREQ _0x208006C
	SUBI R21,LOW(1)
_0x208006C:
_0x2080066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2080059
	RJMP _0x2080058
_0x2080059:
_0x2080056:
	SBRS R16,0
	RJMP _0x208006D
_0x208006E:
	CPI  R21,0
	BREQ _0x2080070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x3B
	RJMP _0x208006E
_0x2080070:
_0x208006D:
_0x2080071:
_0x2080030:
_0x20800CC:
	LDI  R17,LOW(0)
_0x208001B:
	RJMP _0x2080016
_0x2080018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x3E
	SBIW R30,0
	BRNE _0x2080072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2120004
_0x2080072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x3E
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G104)
	LDI  R31,HIGH(_put_buff_G104)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G104
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2120004:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
_0x2120003:
	ADIW R28,5
	RET
; .FEND
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

	.CSEG
_glcd_getmask:
; .FSTART _glcd_getmask
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R26,Z
	LDD  R30,Y+1
	CALL __LSLB12
_0x2120002:
	ADIW R28,2
	RET
; .FEND
_glcd_mappixcolor1bit:
; .FSTART _glcd_mappixcolor1bit
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	CPI  R30,LOW(0x7)
	BREQ _0x20E0007
	CPI  R30,LOW(0xA)
	BRNE _0x20E0008
_0x20E0007:
	LDS  R17,_glcd_state
	RJMP _0x20E0009
_0x20E0008:
	CPI  R30,LOW(0x9)
	BRNE _0x20E000B
	__GETBRMN 17,_glcd_state,1
	RJMP _0x20E0009
_0x20E000B:
	CPI  R30,LOW(0x8)
	BRNE _0x20E0005
	__GETBRMN 17,_glcd_state,16
_0x20E0009:
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x20E000E
	CPI  R17,0
	BREQ _0x20E000F
	LDI  R30,LOW(255)
	LDD  R17,Y+0
	RJMP _0x2120001
_0x20E000F:
	LDD  R30,Y+2
	COM  R30
	LDD  R17,Y+0
	RJMP _0x2120001
_0x20E000E:
	CPI  R17,0
	BRNE _0x20E0011
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x2120001
_0x20E0011:
_0x20E0005:
	LDD  R30,Y+2
	LDD  R17,Y+0
	RJMP _0x2120001
; .FEND
_glcd_readmem:
; .FSTART _glcd_readmem
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	CPI  R30,LOW(0x1)
	BRNE _0x20E0015
	LD   R30,Y
	LDD  R31,Y+1
	LPM  R30,Z
	RJMP _0x2120001
_0x20E0015:
	CPI  R30,LOW(0x2)
	BRNE _0x20E0016
	LD   R26,Y
	LDD  R27,Y+1
	CALL __EEPROMRDB
	RJMP _0x2120001
_0x20E0016:
	CPI  R30,LOW(0x3)
	BRNE _0x20E0018
	LD   R26,Y
	LDD  R27,Y+1
	__CALL1MN _glcd_state,25
	RJMP _0x2120001
_0x20E0018:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
_0x2120001:
	ADIW R28,3
	RET
; .FEND
_glcd_writemem:
; .FSTART _glcd_writemem
	ST   -Y,R26
	LDD  R30,Y+3
	CPI  R30,0
	BRNE _0x20E001C
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ST   X,R30
	RJMP _0x20E001B
_0x20E001C:
	CPI  R30,LOW(0x2)
	BRNE _0x20E001D
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL __EEPROMWRB
	RJMP _0x20E001B
_0x20E001D:
	CPI  R30,LOW(0x3)
	BRNE _0x20E001B
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+2
	__CALL1MN _glcd_state,27
_0x20E001B:
	ADIW R28,4
	RET
; .FEND

	.CSEG

	.DSEG
_glcd_state:
	.BYTE 0x1D
_j:
	.BYTE 0x2
_R_data:
	.BYTE 0x8
_ks0108_coord_G101:
	.BYTE 0x3
__seed_G105:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	CALL __PUTPARD2
	CALL __GETD2S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+2
	LDI  R31,0
	CPI  R30,LOW(0x73)
	LDI  R26,HIGH(0x73)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x2:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LDI  R26,LOW(6)
	LDI  R27,HIGH(6)
	CALL __MULW12
	CALL __CWD1
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL _get_radian
	MOVW R26,R30
	MOVW R24,R22
	JMP  _sin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	__GETD2N 0x41D80000
	CALL __MULF12
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CALL __CWD2
	CALL __CDF2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	CALL __ADDF12
	CALL __CFD1
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5:
	__GETD2N 0x41B80000
	CALL __MULF12
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CALL __CWD2
	CALL __CDF2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x6:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LDI  R26,LOW(30)
	LDI  R27,HIGH(30)
	CALL __MULW12
	CALL __CWD1
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL _get_radian
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x7:
	__GETD2N 0x41900000
	CALL __MULF12
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CALL __CWD2
	CALL __CDF2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LDI  R26,LOW(6)
	LDI  R27,HIGH(6)
	CALL __MULW12
	CALL __CWD1
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL _get_radian
	MOVW R26,R30
	MOVW R24,R22
	JMP  _cos

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x9:
	CALL __SWAPD12
	CALL __SUBF12
	CALL __CFD1
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA:
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xB:
	CALL _get_clock_unit_x2
	MOVW R18,R30
	ST   -Y,R21
	ST   -Y,R20
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	CALL _get_clock_unit_y2
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	CALL __CWD1
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	CALL _glcd_outtextxy
	LDI  R30,LOW(30)
	ST   -Y,R30
	LDI  R30,LOW(50)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x10:
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	__PUTD1S 5
	RJMP SUBOPT_0x10

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	__GETD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	CALL __SUBF12
	__PUTD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	__GETD2S 1
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x15:
	CBI  0x12,1
	LDI  R30,LOW(255)
	OUT  0x14,R30
	LD   R30,Y
	OUT  0x15,R30
	CALL _ks0108_enable_G101
	JMP  _ks0108_disable_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R26,R30
	JMP  _ks0108_gotoxp_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	CALL _ks0108_wrdata_G101
	JMP  _ks0108_nextx_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x19:
	LDD  R30,Y+12
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _glcd_writemem

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1A:
	LDD  R30,Y+12
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1B:
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	JMP  _glcd_readmem

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	ST   -Y,R21
	LDD  R26,Y+10
	JMP  _glcd_mappixcolor1bit

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	ST   -Y,R16
	INC  R16
	LDD  R30,Y+16
	ST   -Y,R30
	ST   -Y,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	ST   -Y,R16
	INC  R16
	LDD  R26,Y+16
	CALL _ks0108_rdbyte_G101
	AND  R30,R20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1F:
	MOV  R21,R30
	LDD  R30,Y+12
	ST   -Y,R30
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CLR  R24
	CLR  R25
	CALL _glcd_readmem
	MOV  R1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x20:
	ST   -Y,R16
	INC  R16
	LDD  R30,Y+16
	ST   -Y,R30
	LDD  R30,Y+14
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ADIW R30,1
	STD  Y+9,R30
	STD  Y+9+1,R31
	SBIW R30,1
	RJMP SUBOPT_0x1B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	CALL __SAVELOCR6
	__GETW1MN _glcd_state,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	MOVW R30,R16
	__ADDWRN 16,17,1
	LPM  R0,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x24:
	__GETW1MN _glcd_state,4
	ADIW R30,1
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x26:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(9)
	JMP  _glcd_block

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x27:
	STD  Y+5,R30
	STD  Y+5+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x28:
	LDD  R26,Y+6
	SUBI R26,-LOW(1)
	STD  Y+6,R26
	SUBI R26,LOW(1)
	__GETB1MN _glcd_state,8
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	ST   -Y,R19
	LDD  R26,Y+10
	JMP  _glcd_putpixelm_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+9,R30
	STD  Y+9+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+9,R30
	STD  Y+9+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
	LDD  R26,Y+17
	CLR  R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2D:
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R20,R30
	LDD  R30,Y+8
	ANDI R30,LOW(0x81)
	CPI  R30,LOW(0x81)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x2E:
	SUB  R30,R26
	SBC  R31,R27
	MOVW R0,R30
	MOVW R26,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2F:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CP   R30,R0
	CPC  R31,R1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x30:
	ST   -Y,R16
	MOV  R26,R18
	JMP  _glcd_setpixel

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x31:
	ST   -Y,R16
	MOV  R26,R18
	SUBI R26,LOW(2)
	CALL _glcd_getpixel
	MOV  R26,R30
	LDD  R30,Y+6
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x33:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x34:
	ST   -Y,R16
	MOV  R26,R20
	CALL _glcd_setpixel
	LDD  R26,Y+7
	CPI  R26,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x35:
	ST   -Y,R16
	MOV  R26,R20
	SUBI R26,-LOW(2)
	CALL _glcd_getpixel
	MOV  R26,R30
	LDD  R30,Y+6
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x36:
	ST   -Y,R30
	MOV  R26,R18
	CALL _glcd_getpixel
	MOV  R26,R30
	LDD  R30,Y+6
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x37:
	ST   -Y,R30
	MOV  R26,R20
	CALL _glcd_getpixel
	MOV  R26,R30
	LDD  R30,Y+6
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x38:
	LDD  R30,Y+9
	ST   -Y,R30
	LDD  R30,Y+9
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x39:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3A:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3B:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3C:
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
SUBOPT_0x3D:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3E:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
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

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

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

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
	RET

__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRW2:
	ASR  R31
	ROR  R30
	ASR  R31
	ROR  R30
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
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

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
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

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__CDF2U:
	SET
	RJMP __CDF2U0
__CDF2:
	CLT
__CDF2U0:
	RCALL __SWAPD12
	RCALL __CDF1U0

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
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
