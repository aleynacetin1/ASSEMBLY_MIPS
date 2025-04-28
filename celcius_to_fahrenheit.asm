.data

msg1: .asciiz "Sıcaklık-Celcius olarak giriniz: "
msg2: .asciiz "Sıcaklık-Fahrenheit = "
msg3: .asciiz "\n"

.text
.globl main

main: 

        la $a0, msg1		# terminale mesaji (msg1) bas
	addi $v0, $zero, 4
	syscall
	
	
	addi $v0, $zero, 5	# syscall-5 tamsayi okuma
	syscall
	add $t1,$v0,$zero	# $t1'e sayiyi gecir
	
	
	mul $t0, $t1, 9		# 9 ile carpma
	div $t0, $t0, 5		# 5'e bolme
	addi $t0, $t0, 32	# 32 ile topla
	                        #sonuc $t0'da
	
	la $a0, msg2		# sonucu karakter disizi olarak bas
	addi $v0, $zero, 4      # syscall-4 karakter dizisi basma
	syscall

	
	add $a0,$t0,$zero	# sonucu basmak icin $a0'a gecir
	addi $v0,$zero,1	# syscall-1 tamsayi basma
	syscall
	
	
	la $a0, msg3		# msg3 baslangic adresini alma
	addi $v0, $zero, 4	# yeni satir basilacak
        syscall			# syscall-4 karakter disizi basma

	addi $v0, $zero, 10	# main programin cikisi
	syscall			# syscall-10 cikis (exit)
.
