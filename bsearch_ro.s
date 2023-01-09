.text
.globl bsearch_r
bsearch_r:
        addi    sp sp -48
        sw      ra 48(sp)
        sw      fp 44(sp)
        addi    fp sp 48
        bge     a3 a2 L1
        addi    a0 zero -1
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
L1:     sub     t0 a3 a2    #int k = (j - i); 
        srli    t0 t0 1     #int k = ((j - i) / 2);
        add     t0 a2 t0    #int k = i + ((j - i) / 2);
        sw      t0 -16(fp)
        slli    t1 t0 2     # k*4
        add     t1 a0 t1    # base + 4*k
        lw      t1 0(t1)    # loads a[i] into t0
        bne     t1 a1 L2    #if (a[k] == x) {
        lw      t0 -16(fp)  #return k;
        add     a0 zero t0  
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra 		    ##else if (a[k] < x)
L2:     slli    t1 t0 2     # { k*4
        add     t1 a0 t1    # base + 4*k
        lw      t1 0(t1)    # loads a[i] into t0
        bge     t1 a1 L3    # if (a[k] < x) {   a[k] : 2   x : 5
        sw      a3 -44(fp)  #j      1.- respaldo de argumentos   {return bsearch_r(a, x, k + 1, j);}
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
        jr ra                ##else {return bsearch_r(a, x, i, k - 1);
L3:     sw      a3 -44(fp)   #j     1.-respaldo de argumentos
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
    .globl main
main:
        addi    sp sp -80    #frame creation
        sw      ra 80(sp)
        sw      fp 76(sp)
        addi    fp sp 80     #a[10] = {-31, 0, 1, 2, 3, 4, 5, 83, 99, 782};
        addi    t0 fp -52    # computes array's base address
        addi    t1 zero -31  # cd 0
        sw      t1 0(t0)
        addi    t1 zero 0    # cd 1
        sw      t1 4(t0)
        addi    t1 zero 1    # cd 2
        sw      t1 8(t0)
        addi    t1 zero 2    # cd 3
        sw      t1 12(t0)
        addi    t1 zero 3    # cd 4
        sw      t1 16(t0)
        addi    t1 zero 4    # cd 5
        sw      t1 20(t0)
        addi    t1 zero 5    # cd 6
        sw      t1 24(t0)
        addi    t1 zero 83   # cd 7
        sw      t1 28(t0)
        addi    t1 zero 99   # cd 8
        sw      t1 32(t0)
        addi    t1 zero 782  # cd 9
        sw      t1 36(t0)    #int n = sizeof a / sizeof a[0];
        addi    a3 zero 10   #4bytes*10values = 40 bytes / 4bytes*1value = 4 bytes = 10 bytes      
        addi    a1 zero 5    #x = 5;   i = bsearch_r(a, x, 0, n - 1);    
        sw      a3 -56(fp)   #1.- respaldo de argumentos : n
        sw      a1 -60(fp)   # x
        addi    a2 zero 0    # 0 no se respalda.
        addi    a0 fp -52    #computes array's base address   
        addi    a3 a3 -1     #2.- cálculo de argumento
        jal     bsearch_r    #3.- llamada de función
        sw      a0 -64(fp)   #4.- respaldo de resultado / i = a0
        lw      a3 -56(fp)   #5.- recuperación de argumentos
        lw      a1 -60(fp)   
        addi    a0 fp -52    # computes array's base address      
        addi    a0 zero 0    #return 0;   
        lw      ra 80(sp)
        lw      fp 76(sp)
        addi    sp sp 80
        jr ra