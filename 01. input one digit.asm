.model small
.stack 100h
.data
.code

main proc
    mov ah,1    ; take input
    int 21h     ; call intarrupt
    mov bl,al   ; move the value to base register
    
    mov ah,2    ; display output 
    
    mov dl, 10  ; new line
    int 21h     
    
    mov dl, 13  ; 1 bit 
    int 21h
    
    mov dl, bl  ; place the value to display register
    int 21h
 
exit:

main endp       ; end the procedure
end main        ; end program
            
