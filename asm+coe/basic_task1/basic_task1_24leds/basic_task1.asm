.data 0x0000				      		
    buf: .word 0x0000
.text 0x0000						
start: 
    lui  $28,0xFFFF			
    ori  $28,$28,0xF000
    lui  $s2, 0x99
    ori  $s2,$s2,0xFFFF
    addi $s4, $0, 0
    addi $s5, $0, 21845
    lui $s6,0x0001
    ori $s6,$s6,0x0000							
select:			
    lw  $s1, 0xC72($28)
    srl $s0, $s1, 5
    addi $t2, $0, 0
    beq $s0, $t2, case0
    addi $t2, $t2, 1
    beq $s0, $t2, case1
    addi $t2, $t2, 1
    beq $s0, $t2, case2
    addi $t2, $t2, 1
    beq $s0, $t2, case3
    addi $t2, $t2, 1
    beq $s0, $t2, case4
    addi $t2, $t2, 1
    beq $s0, $t2, case5
    addi $t2, $t2, 1
    beq $s0, $t2, case6
case0:
    beq $s4, $0, shiftleft
    bne $s4, $0, shiftright
shiftleft:
    sll  $a0, $s5, 1
    addi $s4, $0,  1
    addi $t0, $0,  0
    j delay
shiftright:
    addi $a0, $s5, 0
    addi $s4, $0,  0
    addi $t0, $0,  0
    j delay
case1:
    lw   $t1,0xC70($28)
    addi $a0, $t1, 0
    addi $v1, $a0, 0
    j led
case2:
    addi $a0, $v1, 0
    addi $a0, $a0, 1
    addi $v1, $a0, 0
    addi $t0, $0,  0
    j delay
case3:
    addi $a0, $v1, 0
    addi $a0, $a0,-1
    addi $v1, $a0, 0
    addi $t0, $0,  0
    j delay
case4:
    addi $a0, $v1, 0
    sll  $a0, $a0, 1
    addi $v1, $a0, 0
    addi $t0, $0,  0
    j delay
case5:
    addi $a0, $v1, 0
    srl  $a0, $a0, 1
    addi $v1, $a0, 0
    addi $t0, $0,  0
    j delay
case6:
    addi $a0, $v1, 0
    sll $a0, $a0, 8
    sra  $a0, $a0, 9
    addi $v1, $a0, 0
    addi $t0, $0,  0
    j delay
delay:
    addi $t0, $t0,1
    beq  $t0, $s2,led
    j delay
led:
    sw $0, 0xC62($28)
    sw $a0, 0xC60($28)
    srl $t4, $a0, 16
    sw $t4, 0xC62($28)
    j select