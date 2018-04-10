.data
    vetor: .word 50,2,3,4,5,6,7,8,19,10
    saidaMax: .asciiz"\nMáximo: "
    saidaMin: .asciiz"\nMínimo: "
    saidaMedia: .asciiz"\nMédia:  "
    espaco_entre_caracteres: .asciiz" "

.text
    la $t0, vetor    
    li $t3, 10        #Tamanho do vetor
    li $t1, 0        #Contador de posicao do vetor
    la $t2, vetor

    lw $s0,0($t0)    #Resultaado maior
    lw $s1,0($t0)    #Resusltado menor

loop:
     beq $t1,$t3,saida
     lw $t4,0($t0)

     move $a0, $t4
     li $v0,1
     syscall

     la $a0,espaco_entre_caracteres
     li $v0,4
     syscall
     
     add $s2, $s2, $t4
     
     lw $t7,0($t2)
     addi $t1,$t1,1
     addi $t0,$t0,4
     addi $t2,$t2,4
     bgt $t4,$s0,novoMaior
     blt $t7,$s1,novoMenor
     j loop
novoMaior:
     move $s0,$t4 #armazena em s0 o novo maior valor
     j loop
novoMenor:
    move $s1,$t7 #armazena em s1 o novo menor valor
    j loop
saida:
    #Imprime o maior numero
    la $a0,saidaMax
    li $v0,4
    syscall

    move $a0, $s0
    li $v0,1
    syscall

    #Imprime o menor numero
    la $a0,saidaMin
    li $v0,4
    syscall

    move $a0, $s1
    li $v0,1
    syscall
    
    #Imprime a media
    la $a0,saidaMedia
    li $v0,4
    syscall
    
    div $s2, $t1 #armazena em lo o valor da dvisão de $s2 por $t1
    mflo $s2 #coloca em s2 o valor de lo
    move $a0, $s2
    li $v0,1
    syscall