.data 0x0000				      		
    buf: .word 0x0000
.text 0x0000						
start: 
    lui  $28,0xFFFF			
    ori  $28,$28,0xF000						
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
    addi $t2, $t2, 1
    beq $s0, $t2, case7
case0:
    addi $a0, $0, 0
    lw $v0, 0xC70($28)
    addi $a1, $v0, 0
    addi $a2, $v0, 0
    srl $a1, $a1, 8
    sll $a2, $a2, 24
    srl $a2, $a2, 24
    j led
case1:
    add $a0, $a1, $a2
    j led
case2:
    sub $a0, $a1, $a2
    j led
case3:
    sllv $a0, $a1, $a2
    j led
case4:
    srlv $a0, $a1, $a2
    j led
case5:
    slt $a0, $a2, $a1
    j led
case6:
    and $a0, $a1, $a2
    j led
case7:
    xor $a0, $a1, $a2
    j led
led:
    sw $a0, 0xC60($28)
    j start