.model small
.stack 100h
.data
.code

main proc
    mov cl,97
    print:
    mov ah,2
    mov bl,cl
    
    mov dl,bl
    int 21h    
    
    mov dl,32
    int 21h
    
    inc cl 
    cmp cl, 122
    jle print
exit:

main endp       ; end the procedure
end main        ; end program
            
