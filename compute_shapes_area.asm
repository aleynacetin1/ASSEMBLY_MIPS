.data

msg1: .asciiz "Küp için 1, küre için 2, silindir için 3'e basınız: "
msg2: .asciiz "Yanlış bir numara girdiniz, tekrar deneyin.\n"
msg3: .asciiz "Küpün alanı: "
msg4: .asciiz "Kürenin alanı: "
msg5: .asciiz "Silindirin alanı: "
msg6: .asciiz "Küpün kenar uzunluğu: "
msg7: .asciiz "Kürenin yarıçapı: "
msg8: .asciiz "Silindirin yarıçapı: "
msg9: .asciiz "Silindirin yüksekliği: "

AlanDizisi: .space 400

.text
.globl main

main:
    addi $t6, $zero, 0         # işlem sayacı = 0
    la   $t9, AlanDizisi       # AlanDizisinin başlangıcı

loop:
    slti $t0, $t6, 3           # $t0 = ($t6 < 3) ? 1 : 0
    beq  $t0, $zero, exit      # 3 işlem yapıldıysa çık

    # Menü yazdır
    la   $a0, msg1lk
    addi $v0, $zero, 4
    syscall

    # Seçim al
    addi $v0, $zero, 5
    syscall
    add  $t0, $v0, $zero       # Kullanıcının seçimi $t0'da

    # Şekil seçimine göre yönlendir
    addi $t1, $zero, 1
    beq  $t0, $t1, kupun_alani

    addi $t1, $zero, 2
    beq  $t0, $t1, kurenin_alani

    addi $t1, $zero, 3
    beq  $t0, $t1, silindirin_alani

    # Yanlış seçim
    la   $a0, msg2
    addi $v0, $zero, 4
    syscall
    j loop

kupun_alani:
    addi $t6, $t6, 1           # işlem sayısını artır

    # Kenar uzunluğu al
    la   $a0, msg6
    addi $v0, $zero, 4
    syscall

    addi $v0, $zero, 5
    syscall
    add  $t1, $v0, $zero       # kenar uzunluğu $t1

    # Alan = 6 * (kenar^2)
    mul  $t2, $t1, $t1
    mul  $t2, $t2, 6

    # Alanı diziye kaydet
    sw   $t2, 0($t9)

    # Alanı yazdır
    la   $a0, msg3
    addi $v0, $zero, 4
    syscall

    add  $a0, $t2, $zero
    addi $v0, $zero, 1
    syscall

    addi $t9, $t9, 4           # Alan dizisinde ilerle
    j loop

kurenin_alani:
    addi $t6, $t6, 1

    # Yarıçap al
    la   $a0, msg7
    addi $v0, $zero, 4
    syscall

    addi $v0, $zero, 5
    syscall
    add  $t1, $v0, $zero

    # Alan = 4 * pi * r^2 (pi ≈ 314/100)
    addi $s4, $zero, 314       # s4 = 314 (pi'nin 100 katı)

    mul  $t2, $t1, $t1         # r^2
    mul  $t2, $t2, $s4         # 314 * r^2
    div  $t2, $t2, 100         # /100
    mul  $t2, $t2, 4           # 4*(pi*r^2)

    sw   $t2, 0($t9)

    la   $a0, msg4
    addi $v0, $zero, 4
    syscall

    add  $a0, $t2, $zero
    addi $v0, $zero, 1
    syscall

    addi $t9, $t9, 4
    j loop

silindirin_alani:
    addi $t6, $t6, 1

    # Yarıçap al
    la   $a0, msg8
    addi $v0, $zero, 4
    syscall

    addi $v0, $zero, 5
    syscall
    add  $t1, $v0, $zero

    # Yükseklik al
    la   $a0, msg9
    addi $v0, $zero, 4
    syscall

    addi $v0, $zero, 5
    syscall
    add  $t2, $v0, $zero

    addi $s4, $zero, 314       # pi = 314/100

    # 2*pi*r*h
    mul  $t3, $s4, 2
    mul  $t3, $t3, $t1
    mul  $t3, $t3, $t2
    div  $t3, $t3, 100

    # 2*pi*r^2
    mul  $t4, $t1, $t1
    mul  $t4, $t4, 2
    mul  $t4, $t4, $s4
    div  $t4, $t4, 100

    # Toplam alan
    add  $t5, $t3, $t4

    sw   $t5, 0($t9)

    la   $a0, msg5
    addi $v0, $zero, 4
    syscall

    add  $a0, $t5, $zero
    addi $v0, $zero, 1
    syscall

    addi $t9, $t9, 4
    j loop

exit:
    addi $v0, $zero, 10
    syscall
