    .text
    .globl bsearch
bsearch:
        addi    sp sp -32
        sw      ra 32(sp)
        sw      fp 28(sp)
        sw      s1 16(sp)
        sw      s2 12(sp)
        sw      s3 8(sp)
        addi    fp sp 32    
        addi    s1 zero 0
        addi    s2 a1 -1
        j       wh1
L1:     sub     s3 s2 s1    
        addi    t0 zero 2 
        div     s3 s3 t0    
        add     s3 s1 s3    
        slli    t0 s3 2     
        add     t0 a0 t0    
        lw      t0 0(t0)    
        bne     t0 a2 L2    
        add     a0 zero s3
        lw      ra 32(sp)
        lw      fp 28(sp)
        lw      s1 16(sp)
        lw      s2 12(sp)
        lw      s3 8(sp)
        addi    sp sp 32
        jr ra
L2:     slli    t0 s3 2     
        add     t0 a0 t0    
        lw      t0 0(t0)    
        bge     t0 a2 L3    
        addi    s1 s3 1
        j   wh1             
L3:     addi    s2 s3 -1
wh1:    ble     s1 s2 L1  
        addi    a0 zero -1
        lw      ra 32(sp)
        lw      fp 28(sp)
        addi    sp sp 32
        jr ra

    .globl bsearch_r
bsearch_r:
        addi    sp sp -48
        sw      ra 48(sp)
        sw      fp 44(sp)
        addi    sp sp 48
        bge     a3 a2 L4
        addi    a0 zero -1
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
L4:     sub     t0 a3 a2    
        addi    t1 zero 2 
        div     t0 t0 t1    
        add     t0 a2 t0    
        sw      t0 -16(fp)
        slli    t1 t0 2     
        add     t1 a0 t1    
        lw      t1 0(t1)    
        bne     t1 a1 L5    
        lw      t0 -16(fp)
        add     a0 zero t0  
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
L5:     slli    t1 t0 2     
        add     t1 a0 t1    
        lw      t1 0(t1)    
        bge     t1 a1 L6    
        sw      a3 -44(fp)  
        sw      a2 -40(fp)  
        sw      a1 -36(fp)  
        sw      a0 -32(fp)  
        lw      a2 -16(fp)  
        addi    a2 a2 1     
        jal     bsearch_r       
        addi    t0 a0 0     
        lw      a3 -44(fp)  
        lw      a2 -40(fp)  
        lw      a1 -36(fp)  
        lw      a0 -32(fp)  
        addi    a0 t0 0     
        lw      ra 48(sp)   
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra
L6:     sw      a3 -44(fp)   
        sw      a2 -40(fp)   
        sw      a1 -36(fp)   
        sw      a0 -32(fp)   
        lw      a3 -16(fp)   
        addi    a3 a3 -1     
        jal     bsearch_r    
        addi    t0 a0 0      
        lw      a3 -44(fp)   
        lw      a2 -40(fp)   
        lw      a1 -36(fp)   
        lw      a0 -32(fp)   
        addi    a0 t0 0      
        lw      ra 48(sp)
        lw      fp 44(sp)
        addi    sp sp 48
        jr ra

    .globl main
main:
        addi    sp sp -80
        sw      ra 80(sp)
        sw      fp 76(sp)
        addi    fp sp 80
        addi    t0 fp -52       
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
        addi    a1 zero 10  
        addi    a2 zero 2
        addi    a0 fp -52   
        sw      a2 -60(fp)  
        sw      a1 -56(fp)
        sw      a0 -52(fp)  
        jal     bsearch    
        sw      a0 -64(fp)  
        lw      a2 -60(fp)  
        lw      a1 -56(fp) 
        lw      a0 -52(fp)    
        lw      t1 -64(fp)
        addi    t2 zero 0
        blt     t1 t2 L7   
        add     t2 zero a2     
        sw      t2 -72(fp)  
        lw      t3 -64(fp)
        sw      t3 -76(fp) 
        j       L8
L7:     addi    t2 zero 0
        sw      t2 -72(fp)
L8:     addi    a1 zero 5   
        lw      a3 -56(fp)  
        addi    a2 zero 0   
        sw      a1 -60(fp)  
        sw      a0 -52(fp)  
        lw      a0 -52(fp)   
        addi    a3 a3 -1    
        jal     bsearch_r   
        sw      a0 -64(fp)  
        lw      a1 -60(fp)  
        lw      a0 -52(fp)
        lw      t1 -64(fp)
        addi    t2 zero 0
        blt     t1 t2 L9     
        addi    t2 a1 0      
        sw      t2 -72(fp) 
        lw      t3 -64(fp)
        sw      t3 -76(fp) 
        j       L10
L9:     addi    t2 zero 0
        sw      t2 -72(fp) 
L10:    addi    a0 zero 0
        lw      ra 80(sp)
        lw      fp 76(sp)
        addi    sp sp 80
        jr ra