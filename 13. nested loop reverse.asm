.model small
.stack 100h
.data
.code
main proc        ; main procedure
    mov cl,4
    
lavel1:          ; line number
    mov bl,cl
    
lavel2:          ; star
    
    mov ah,2
    mov dl,42    ; star in ascii code
    int 21h
    
    dec bl
    cmp bl,0
    jne lavel2
    
    
    mov ah,2     ; show output
    mov dl,10    ; new line
    int 21h      ; call interrupt
    mov dl,13    ; left shift
    int 21h      ; call interrupt
    
    dec cl       ; increment
    cmp cl,1     
    jge lavel1   
    
main endp
end main
