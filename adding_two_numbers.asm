.data

msg1: .asciiz "Sayi Giriniz: "
msg2: .asciiz "Girilen Buyuk Sayi: "
msg3: .asciiz "Girilen iki sayi esittir: "

.text
.globl main

main:

        la $a0, msg1		# terminale mesaji (msg1) bas
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 5	# syscall-5 tamsayi okuma
	syscall
	add $t0,$v0,$zero	# $t1'e sayiyi gecir
	
	
	la $a0, msg1		# terminale mesaji (msg1) bas
	addi $v0, $zero, 4
	syscall
	
	addi $v0, $zero, 5	# syscall-5 tamsayi okuma
	syscall
	add $t1,$v0,$zero	# $t1'e sayiyi gecir
	
	#Sayilari karsilastir
	beq $t0, $t1, esitdurum
	slt $t2, $t0, $t1   #if t0 < t1 , t2=1
	
	beq $t2, $zero, t0buyuk
	beq $t2, 1, t1buyuk
	
	t0buyuk: la $a0, msg2		# terminale mesaji (msg1) bas
	         addi $v0, $zero, 4
	         syscall
		 add $a0,$t0,$zero	# sonucu basmak icin $a0'a al
	         addi $v0,$zero,1	# syscall-1 tamsayi basma
	         syscall
	         j exit
	         
	t1buyuk: la $a0, msg2		# terminale mesaji (msg1) bas
	         addi $v0, $zero, 4
	         syscall
		 add $a0,$t1,$zero	# sonucu basmak icin $a0'a al
	         addi $v0,$zero,1	# syscall-1 tamsayi basma
	         syscall
	         j exit         
	     
	esitdurum: la $a0, msg3		# terminale mesaji (msg1) bas
	           addi $v0, $zero, 4
	           syscall
		   add $a0,$t1,$zero	# sonucu basmak icin $a0'a al
	           addi $v0,$zero,1	# syscall-1 tamsayi basma
	           syscall
	           j exit
	           
	exit: 	addi $v0, $zero, 10	# main programin cikisi
	        syscall	