.data
	backn: .asciiz "\n" 
.text
.globl main
	addi $s0,$zero,0
	addi $s1,$zero,0
LOOP1:
	addi $t0,$zero,5
	slt $t0,$t0,$s1
	xori $t0,$t0,1
	beq $t0,$zero,L1
	addi $s0,$zero,-1
	L1:
	L1:
