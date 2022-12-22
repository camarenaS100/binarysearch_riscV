# This function returns a k or a -1
# frame size : 32 bytes
#               - 16 bytes to back up ra & fp
#               - 16 bytes to back up i, j & k 
#               
# arguments : (a0 : int *a) (a1 : int n) (a2 : int x)   
# i <-> s1,    j <-> s2,     k <-> s3

    .text
    .globl bsearch
bsearch:
    #frame creation
        addi    sp sp -32
        sw      ra 32(sp)
        sw      fp 28(sp)
        sw      s1 16(sp)
        sw      s2 12(sp)
        sw      s3 8(sp)
        addi    fp sp 32    
    # int i = 0
        addi    s1 zero 0
    # j = n - 1;
        addi    s2 a1 -1
    # entrada a while (i <= j){
        j       wh1
L1:     sub     s3 s2 s1    #int k = (j - i);
        addi    t0 zero 2 
        div     s3 s3 t0    #int k = ((j - i) / 2);
        add     s3 s1 s3    #int k = i + ((j - i) / 2);
    ##if(a[k] == x){  
        slli    t0 s3 2     # k*4
        add     t0 a0 t0    # base + 4*k
        lw      t0 0(t0)    # loads a[i] into t0
        bne     t0 a2 L2    # if (a[k] = x) {
    #return k;
        add     a0 zero s3
        lw      ra 32(sp)
        lw      fp 28(sp)
        lw      s1 16(sp)
        lw      s2 12(sp)
        lw      s3 8(sp)
        addi    sp sp 32
        jr ra
    ##else if (a[k] < x){    
L2:     slli    t0 s3 2     # k*4
        add     t0 a0 t0    # base + 4*k
        lw      t0 0(t0)    # loads a[i] into t0
        bge     t0 a2 L3    # else if (a[k] < x){
    #i = k + 1 
        addi    s1 s3 1
        j   wh1             
    ##else{ j = k - 1;
L3:     addi    s2 s3 -1
    #condición de while (i <= j){
wh1:    ble     s1 s2 L1  
    # return -1
        addi    a0 zero -1
        lw      ra 32(sp)
        lw      fp 28(sp)
        addi    sp sp 32
        jr ra

#This function returns to itself, 
# frame size : 32 bytes
#               - 16 bytes to back up ra & fp
#               - 16 bytes to back up a, x, i, j 
#
# arguments : (a0 : int *a),  (a1 : int x),  (a2 : int i),  (a3 : int j)
# k <--> t0
    .globl bsearch_r
bsearch_r:
    #frame creation
        addi    sp sp -48
        sw      ra 48(sp)
        sw      fp 44(sp)
        addi    sp sp 48
    ##if (j < i) {
        bge     a3 a2 L4
    #return -1;
        addi    a0 zero -1
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
    #int k = i + ((j - i) / 2);
L4:     sub     t0 a3 a2    #int k = (j - i);
        addi    t1 zero 2 
        div     t0 t0 t1    #int k = ((j - i) / 2);
        add     t0 a2 t0    #int k = i + ((j - i) / 2);
        sw      t0 -16(fp)
    ##if(a[k] == x){  
        slli    t1 t0 2     # k*4
        add     t1 a0 t1    # base + 4*k
        lw      t1 0(t1)    # loads a[i] into t0
        bne     t1 a1 L5    #if (a[k] == x) {
    #return k;
        lw      t0 -16(fp)
        add     a0 zero t0  
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
    ##else if (a[k] < x)
L5:     slli    t1 t0 2     # k*4
        add     t1 a0 t1    # base + 4*k
        lw      t1 0(t1)    # loads a[i] into t0
        bge     t1 a1 L6    # if (a[k] < x) {   a[k] : 2   x : 5
    #return bsearch_r(a, x, k + 1, j);
        sw      a3 -44(fp)  #j      1.- respaldo de argumentos
        sw      a2 -40(fp)  #i   se respalda, se reescribe (k+1), y se recupera el respaldo
        sw      a1 -36(fp)  #x
        sw      a0 -32(fp)  #a
        lw      a2 -16(fp)  # 2.- cálculo de argumento  a2 <- k
        addi    a2 a2 1     #(i -> k+1) de a2 
        jal     bsearch_r   # 3.- llamada a función,    
        addi    t0 a0 0     # 4.- respaldo de resultado
        lw      a3 -44(fp)  #j     5.-recuperación de argumentos
        lw      a2 -40(fp)  #i
        lw      a1 -36(fp)  #x
        lw      a0 -32(fp)  #a 
        addi    a0 t0 0     #  6.- return value of bsearch_r(a, x, k + 1, j)
        lw      ra 48(sp)   
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
    ##else {
    #return bsearch_r(a, x, i, k - 1);
L6:     sw      a3 -44(fp)   #j     1.-respaldo de argumentos
        sw      a2 -40(fp)   #i
        sw      a1 -36(fp)   #x
        sw      a0 -32(fp)   #a 
        lw      a3 -16(fp)   # 2.- cálculo de argumento  a3 <- k
        addi    a3 a3 -1     #(i -> k-1) de a3
        jal     bsearch_r    # 3.- llamada a función
        addi    t0 a0 0      # 4.- respaldo de resultado
        lw      a3 -44(fp)   #j     5.-recuperación de argumentos
        lw      a2 -40(fp)   #i
        lw      a1 -36(fp)   #x
        lw      a0 -32(fp)   #a 
        addi    a0 t0 0      #  6.- return value of bsearch_r(a, x, i, k - 1)
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra

#main function 
# frame size : 80 bytes
#               - 16 bytes to back up ra & fp
#               - 64 bytes to back up a, n, x & i 
#
#  Because the program is made for a one cycle processor with 
#  no peripheral output, functions of stdio.h, printf and sizeof were changed
#  to make the program work in said processor. 
#   
#   Thus : printf("%d is at index %d.\n", x, i); : stores x in variable num, and i in index
#   and :  printf("%d is not found.\n", x); : stores x in variable num
#
#   arguments : 
#   (a0 - a), (a1 - n), (a2 - x), (a3 - i)


    .globl main
main:
    #frame creation
        addi    sp sp -80
        sw      ra 80(sp)
        sw      fp 76(sp)
        addi    fp sp 80
    #a[10] = {-31, 0, 1, 2, 2, 4, 65, 83, 99, 782};
        addi    t0 fp -52       # computes array's base address
        addi    t1 zero -31
        sw      t1 0(t0)
        addi    t1 zero 0
        sw      t1 4(t0)
        addi    t1 zero 1
        sw      t1 8(t0)
        addi    t1 zero 2
        sw      t1 12(t0)
        addi    t1 zero 2
        sw      t1 16(t0)
        addi    t1 zero 4
        sw      t1 20(t0)
        addi    t1 zero 65
        sw      t1 24(t0)
        addi    t1 zero 83
        sw      t1 28(t0)
        addi    t1 zero 99
        sw      t1 32(t0)
        addi    t1 zero 782
        sw      t1 36(t0)
    #int n = sizeof a / sizeof a[0];
        addi    a1 zero 10 # 4bytes*10values = 40 bytes / 4bytes*1value = 4 bytes = 10 bytes 
    #int x = 2;    
        addi    a2 zero 2
    #int i = bsearch(a, n, x);
        addi    a0 fp -52   # computes array's base address
        sw      a2 -60(fp)  #1.- respaldo de argumentos
        sw      a1 -56(fp)
        sw      a0 -52(fp)  
        jal     bsearch     #3.- llamada de función
        sw      a0 -64(fp)  #4.- respaldo de resultado  /  i <- a0
        lw      a2 -60(fp)  #5.- recuperación de argumentos
        lw      a1 -56(fp) 
        lw      a0 -52(fp)
    ##if (i >= 0)    
        lw      t1 -64(fp)
        addi    t2 zero 0
        blt     t1 t2 L7
    #printf("%d is at index %d.\n", x, i);     
        add     t2 zero a2     
        sw      t2 -72(fp) # x, num 
        lw      t3 -64(fp)
        sw      t3 -76(fp) # i, index
        j       L8
    ##else { printf("%d is not found.\n", x);   }
L7:     addi    t2 zero 0
        sw      t2 -72(fp)
    #x = 5;
L8:     addi    a1 zero 5   
    #i = bsearch_r(a, x, 0, n - 1);    
        lw      a3 -56(fp)  #carga de valorees en posiciones  / a3 n-1 no se respalda
        addi    a2 zero 0   #a2 0 no se respalda
        sw      a1 -60(fp)  #x sí se respalda
        sw      a0 -52(fp)  #a idealmente no se respalda porque no ha cambiado
        lw      a0 -52(fp)   
        addi    a3 a3 -1    #2.- cálculo de argumento
        jal     bsearch_r   #3.- llamada de función
        sw      a0 -64(fp)  #4.- respaldo de resultado / i = a0
        lw      a1 -60(fp)  #5.- recuperación de argumentos
        lw      a0 -52(fp)
     ##if (i >= 0)    
        lw      t1 -64(fp)
        addi    t2 zero 0
        blt     t1 t2 L9
    #printf("%d is at index %d.\n", x, i);     
        addi    t2 a1 0      
        sw      t2 -72(fp) # x -> num 
        lw      t3 -64(fp)
        sw      t3 -76(fp) # i -> index
        j       L10
    ##else { printf("%d is not found.\n", x);   }
L9:     addi    t2 zero 0
        sw      t2 -72(fp)  # x -> num
    #return 0;
L10:    addi    a0 zero 0
        lw      ra 80(sp)
        lw      fp 76(sp)
        addi    sp sp 80
        jr ra
        