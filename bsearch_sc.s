.text
    .globl bsearch
bsearch:
        addi    sp sp -32     #frame creation
        sw      ra 32(sp)
        sw      fp 28(sp)
        sw      s1 16(sp)
        sw      s2 12(sp)
        sw      s3 8(sp)
        addi    fp sp 32    
        addi    s1 zero 0	# int i = 0
        addi    s2 a1 -1	# j = n - 1;
        j       wh1		# entrada a while (i <= j){
L1:     sub     s3 s2 s1    #int k = (j - i);
        srli    s3 s3 1     #int k = ((j - i) / 2);
        add     s3 s1 s3    #int k = i + ((j - i) / 2);
        slli    t0 s3 2         ##if(a[k] == x){  # k*4
        add     t0 a0 t0    # base + 4*k
        lw      t0 0(t0)    # loads a[i] into t0
        bne     t0 a2 L2    # if (a[k] = x) {
        add     a0 zero s3  #return k;
        lw      ra 32(sp)
        lw      fp 28(sp)
        lw      s1 16(sp)
        lw      s2 12(sp)
        lw      s3 8(sp)
        addi    sp sp 32
        jr ra			##else if (a[k] < x){    
L2:     slli    t0 s3 2     # k*4
        add     t0 a0 t0    # base + 4*k
        lw      t0 0(t0)    # loads a[i] into t0
        bge     t0 a2 L3    # else if (a[k] < x){ 
        addi    s1 s3 1		 #i = k + 1
        j   wh1            
L3:     addi    s2 s3 -1	##else{ j = k - 1;
wh1:    ble     s1 s2 L1  	#condición de while (i <= j){
        addi    a0 zero -1	# return -1
        lw      ra 32(sp)
        lw      fp 28(sp)
        addi    sp sp 32
        jr ra

    .globl bsearch_r
bsearch_r: 		
        addi    sp sp -48	#frame creation
        sw      ra 48(sp)
        sw      fp 44(sp)
        addi    fp sp 48
        bge     a3 a2 L4	##if (j < i) {
        addi    a0 zero -1	#return -1;
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra			#int k = i + ((j - i) / 2);
L4:     sub     t0 a3 a2    #int k = (j - i); 
        srli    t0 t0 1     #int k = ((j - i) / 2);
        add     t0 a2 t0    #int k = i + ((j - i) / 2);
        sw      t0 -16(fp)      ##if(a[k] == x){  
        slli    t1 t0 2     # k*4
        add     t1 a0 t1    # base + 4*k
        lw      t1 0(t1)    # loads a[i] into t0
        bne     t1 a1 L5    #if (a[k] == x) {
        lw      t0 -16(fp)          #return k;
        add     a0 zero t0  
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra			##else if (a[k] < x)
L5:     slli    t1 t0 2     # k*4
        add     t1 a0 t1    # base + 4*k
        lw      t1 0(t1)    # loads a[i] into t0
        bge     t1 a1 L6    # if (a[k] < x) {  
        sw      a3 -44(fp)  ##return bsearch_r(a, x, k + 1, j);
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
        jr ra			##else { #return bsearch_r(a, x, i, k - 1);
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
        
    .globl main
main:  
        addi    sp sp -80        #frame creation
        sw      ra 80(sp)
        sw      fp 76(sp)
        addi    fp sp 80         #a[10] = {-31, 0, 1, 2, 3, 4, 5, 83, 99, 782};
        addi    t0 fp -52       # computes array's base address
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
        sw      t1 36(t0)	#int n = sizeof a / sizeof a[0];
        addi    a1 zero 10 # 4bytes*10values = 40 bytes / 4bytes*1value = 4 bytes = 10 bytes  
        addi    a2 zero 5    #int x = 5;   #int i = bsearch(a, n, x);
        sw      a1 -56(fp)  #respaldo de n
        addi    a0 fp -52   # computes array's base address
        jal     bsearch     #3.- llamada de función
        sw      a0 -64(fp)  #4.- respaldo de resultado  /  i <- a0
        addi    a0 fp -52   # computes array's base address	
        addi    a1 zero 5   #x = 5; i = bsearch_r(a, x, 0, n - 1);    
        lw      a3 -56(fp)  #carga de valorees en posiciones  / a3 n-1 no se respalda
        addi    a2 zero 0   #a2 0 no se respalda 
        addi    a0 fp -52   #computes array's base address   
        addi    a3 a3 -1    #2.- cálculo de argumento
        jal     bsearch_r   #3.- llamada de función
        sw      a0 -64(fp)  #4.- respaldo de resultado / i = a0
        lw      a1 -60(fp)  #5.- recuperación de argumentos
        addi    a0 fp -52   # computes array's base address
        addi    a0 zero 0	#return 0;
        lw      ra 80(sp)
        lw      fp 76(sp)
        addi    sp sp 80
        jr ra
        