.model small
.stack 100h
.data
.code
main proc         
    mov cl,1      ; Line counter (1 to 4)   
   
row:              
    mov bh,4             
    sub bh,cl     ; Total spaces to print (bh - cl)
     
    mov al, cl    
    mov bl, 2
    mul bl       
    dec al        
    mov bl,al     ; Total star 2n - 1
   
space:
    mov ah, 2      
    mov dl, 32    ; space
    int 21h
    
    dec bh        ; Decrement space counter
    cmp bh, 0
    jge space     ; Continue printing spaces until bh == 0       

star:          
    mov ah, 2     
    mov dl, 42    ;'*' (star)
    int 21h
    
    dec bl        ; Decrement star counter
    cmp bl, 1
    jge star      ; Continue printing stars until bl == 1

    ; New line 
    mov ah, 2
    mov dl, 10    ; new line
    int 21h
    mov dl, 13    ; left shift
    int 21h
    
    inc cl        ; Increment line counter
    cmp cl, 4     ; Check if we've printed 4 lines
    jle row       ; If cl <= 4, continue to next line

exit:

main endp
end main
