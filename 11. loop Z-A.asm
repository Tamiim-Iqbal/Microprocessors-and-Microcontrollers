.model small
.stack 100h
.data
.code

main proc
    mov cl,90
    print:
    mov ah,2
    mov bl,cl
    
    mov dl,bl
    int 21h    
    
    mov dl,32
    int 21h

    
    dec cl 
    cmp cl, 65
    jge print
exit:

main endp       ; end the procedure
end main        ; end program
            
