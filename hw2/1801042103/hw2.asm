#Ozan GECKIN
#1801042103
.data
arr : .space 400
size: .word 0
sum: .word 0
msg: .asciiz "\nPlease enter array size: "
msg1: .asciiz "\nPlease enter array element: "
msg2: .asciiz "\nPlease enter sum number: "
msg3: .asciiz "\nPossible! "
msg4: .asciiz "\n Not possible! "

.text
.globl main
main:
li  $v0, 4
la $a0, msg
syscall 	#printf(msg)

li $v0, 5
syscall		#scanf("%d",size)
move $t1,$v0 
li $t4, 4
mul $t2,$t4,$t1	
sw $t2, size 	#send size to stake at $t2
lw $a1, size	#I pulled size $a1 because I will send it as a parameter to the funct?on.

li $v0, 4
la $a0, msg2
syscall		#printf(msg2)

li $v0, 5
syscall		#scanf("%d",sum)
sw $v0, sum
lw $a2, sum	#I pulled sum $a2 because I will send it as a parameter to the funct?on.

li $v0, 4
la $a0, msg1
syscall 	#prinf(msg1)

jal inputArray	#filling arr until size
lw $a3, arr     #I pulled arr $a3 because I will send it as a parameter to the funct?on.

jal CheckSumPossibility 	#call recursive function.


beq $v1 ,1,possibility 		#if($v1==1) return possibility
beq $v1 ,0,notPossibility	#if($v1==0) return not

				#filling array
inputArray:			#for($t3=0;$3<$a1;$t3++){
beq $t3, $a1, exitInputArray	#scanf("%d",arr[$t3])
li $v0,5			#}
syscall
sw $v0,arr($t3)
add $t3,$t3,4
j inputArray
exitInputArray:
jr $ra

CheckSumPossibility:					
addi $sp, $sp ,-8				
sw $s0, 0($sp)			
sw $ra ,4($sp)

beq $a2,$zero,return1		#if(num==0) return 1;
beq $a1,$zero,return0		#if(size==0)return 0;

sub $t5,$a1,$t4			#$t5=$a1-$t4;
lw $t6,arr($t5)			#$t6=arr[$t5];
blt $a2,$t6,CheckSumPossiliytArgumantControl	#if(arr[size-1]>num return checkSumPossibility(num,arr,size-1);
j CheckSumPossiliytArgumantControl2		#return CheckSumPossibility(num,arr,size-1);
j CheckSumPossiliytArgumantControl		#return CheckSumPossibility(num-arr[size-1],arr,size-1);

CheckSumPossiliytArgumantControl:
sub $a1,$a1,$t4			#size=size-1(4 byte)
j CheckSumPossibility		#return CheckSumPossibility

CheckSumPossiliytArgumantControl2:
sub $t7,$a2,$t6			#int newSum= sum-arr[size-1];
add $a2,$zero,$t7		#num = newSum;
add $a1,$zero,$t5		#size = size-1;
j CheckSumPossibility		#return CheckSumPossibility;

return1:
li $v1,1			#int returnType = 1;
j exitCheckSumPossibility	#return exitCheckSumPossibility;

return0:
li $v1,0			#int returnType = 0;
j exitCheckSumPossibility	#return exitCheckSumPossibility;

exitCheckSumPossibility:
lw $s0 , 0($sp)			
lw $ra , 4($sp)
addi $sp, $sp, 8
jr $ra				#return main

possibility:
li $v0, 4
la $a0, msg3
syscall				#printf(msg3);
li $v0, 10 			
syscall				#exit;

notPossibility:	
li $v0, 4
la $a0, msg4
syscall				#printf(msg4);
li $v0, 10	
syscall				#exit;
