.model small
.stack 100h
.data
.code

main proc
    mov cl,1  
    
    print:
    mov ah,2
    mov bl,cl
    add bl,48 
    mov dl,bl
    int 21h    
    
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    inc cl
    cmp cl,9
    jle print
exit:

main endp       ; end the procedure
end main        ; end program
            
