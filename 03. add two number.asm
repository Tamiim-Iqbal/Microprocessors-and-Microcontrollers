.model small
.stack 100h
.data
.code

main proc
     mov ah,1    ; take input
    int 21h     ; call intarrupt
    mov bl,al   
    
    mov ah,2    ; display output
    mov dl,32   ; display space
    int 21h
    
    mov ah,1    ; take input2
    int 21h  
    mov bh, al
    
    mov ah,2    ; display output
    mov dl, 10  ; new line
    int 21h
    
    mov dl, 13  ; left shift
    int 21h     
    
    mov dl,bl   ; place the 1st value to display register
    int 21h    
    
    mov dl, 32  ; display space
    int 21h
    
    mov dl, bh  ; place the 2nd value to display register
    int 21h  
    
    mov ah,2    ; display output
    mov dl, 10  ; new line
    int 21h    
    
    mov dl, 13  ; left shift
    int 21h
    
    add bl,bh  
    sub bl,48
    mov ah,2
    
    mov dl, bl
    int 21h
 
exit:

main endp       ; end the procedure
end main        ; end program
            
