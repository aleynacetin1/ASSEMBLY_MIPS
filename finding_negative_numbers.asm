.data
DIZI:       .word 2, 0, -4, 16, 0, 1, -8, -10, 0, 2, -3, 11
YENI_DIZI:  .space 48          # 12 adet word = 48 byte
msg2:    .asciiz "   "

.text
.globl main

main:
    la $t0, DIZI              # $t0 = DIZI dizisinin başlangıç adresi
    la $t1, YENI_DIZI         # $t1 = YENI_DIZI'nin başlangıç adresi
    addi $t2, $zero, 12       # sayaç = 12 (eleman sayısı)

loop:
    beq $t2, $zero, done      # sayaç 0 ise çık
    lw $t3, 0($t0)            # $t3 = DIZI[i]

    # $t3 < 0 ? kontrolü (slt $t4, $t3, $zero)
    # Eğer $t3 < 0 ise $t4 = 1 olacak
    slt $t4, $t3, $zero       
    beq $t4, $zero, skip      # $t3 < 0 değilse skip et

    # $t3 < 0 ise YENI_DIZI'ye yaz
    sw $t3, 0($t1)
    addi $t1, $t1, 4          # YENI_DIZI işaretçisini ilerlet

skip:
    addi $t0, $t0, 4          # DIZI işaretçisini ilerlet
    addi $t5, $zero, -1       
    add $t2, $t2, $t5         # sayaç azalt
    j loop

done:
    # YENI_DIZI'yi yazdır
    la $t1, YENI_DIZI         # Yazdırmak için tekrar başa dön
    addi $t2, $zero, 12       # max 12 eleman kontrolü

print_loop:
    beq $t2, $zero, exit
    lw $a0, 0($t1)
    
    # 0 mı kontrolü, 0 ise yazma
    beq $a0, $zero, next_print

    addi $v0, $zero, 1        # print_int
    syscall

    addi $v0, $zero, 4        # print_newline
    la $a0, msg2
    syscall

next_print:
    addi $t1, $t1, 4
    addi $t5, $zero, -1
    add $t2, $t2, $t5
    j print_loop

exit:
    addi $v0, $zero, 10       # exit
    syscall
