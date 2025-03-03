.model small
.stack 100h
.data
.code

main proc
    mov ah,1
    int 21h
    mov bl,al 
    
    mov ah,2
    mov dl,43
    int 21h
    
    mov ah,1
    int 21h
    mov bh,al 
    
    mov ah,2
    mov dl,43
    int 21h
    
    mov ah,1
    int 21h
    mov cl,al
    
    add bl,bh
    sub bl,48
    
    add cl,bl
    sub cl,48
    
    mov ah,2  
    mov dl, 10
    int 21h
    
    mov dl, 13
    int 21h
    
    mov dl, cl   
    int 21h

exit:

main endp       ; end the procedure
end main        ; end program
            
