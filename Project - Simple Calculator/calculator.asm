.model small                    
.stack 100h                     
.data                           
    msg1 db 'Enter first digit: $'                       ; string message for first input
    msg2 db 'Enter second digit: $'                      ; string message for second input 
    msg3 db 'Choose operation (+, -, *, /): $'           ; string message for operation  
    msg4 db 10,13,'Invalid Operation$'                   ; invalid operation message with newline
    div_zero_msg db 10,13,'Cannot divide by zero!$'      ; division by zero message
    result_msg db 10,13,'Result: $'                      ; result message with newline and carriage return
    newline db 10,13,'$'                                 ; newline string (line feed + carriage return)

.code                           
main proc                       
    mov ax, @data               ; Load address of data segment into AX register
    mov ds, ax                  ; Move data segment address from AX to DS register (initialize data segment)
    
    ; Get first number
    lea dx, msg1                ; Load effective address of msg1 into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display first prompt
    mov ah, 1                   ; function to read single character
    int 21h                     ; Call interrupt to read first digit from keyboard
    mov bl, al                  ; Move the input character from AL to BL register (store first digit)
    
    ; New line
    lea dx, newline             ; Load address of newline string into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; interrupt to display newline
    
    ; Get second number
    lea dx, msg2                ; Load effective address of msg2 into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display second prompt
    mov ah, 1                   ; function to read single character
    int 21h                     ; Call interrupt to read second digit from keyboard
    mov bh, al                  ; Move the input character from AL to BH register (store second digit)
    
    ; New line
    lea dx, newline             ; Load address of newline string into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display newline
    
    ; Get operation
    lea dx, msg3                ; Load effective address of msg3 into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display operation prompt
    mov ah, 1                   ; function to read single character
    int 21h                     ; Call interrupt to read operation symbol from keyboard
    mov cl, al                  ; Move the operation character from AL to CL register (store operation)    
    
    ; Check operation and perform calculation
    cmp cl, '+'                 ; Compare operation in CL with '+' character
    je addition                 ; Jump to addition label if equal (if operation is +)
    cmp cl, '-'                 ; Compare operation in CL with '-' character
    je subtraction              ; Jump to subtraction label if equal (if operation is -)
    cmp cl, '*'                 ; Compare operation in CL with '*' character
    je multiplication           ; Jump to multiplication label if equal (if operation is *)
    cmp cl, '/'                 ; Compare operation in CL with '/' character
    je division                 ; Jump to division label if equal (if operation is /)
    jmp invalid                 ; Jump to invalid if none of the operations match
 
invalid:                        ; Label for invalid operation
    lea dx, msg4                ; Load address of invalid message into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display invalid message
    jmp exit                    ; Jump to exit to end program   
    
addition:                       ; Label for addition operation
    ; Show result message first
    lea dx, result_msg          ; Load address of result message into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display "Result: "
    
    sub bl, 48                  ; Convert first digit from ASCII to numeric
    sub bh, 48                  ; Convert second digit from ASCII to numeric
    add bl, bh                  ; Add second digit (BH) to first digit (BL), result in BL
    add bl, 48                  ; Convert numeric result back to ASCII
    mov dl, bl                  ; Move result from BL to DL register (prepare for display)
    mov ah, 2                   ; Set AH to 2 (DOS function to display single character)
    int 21h                     ; Call interrupt to display the result character
    jmp exit                    ; Jump to exit label to end program

subtraction:                    ; Label for subtraction operation
    ; Show result message first
    lea dx, result_msg          ; Load address of result message into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display "Result: "
    
    sub bl, 48                  ; Convert first digit from ASCII to numeric
    sub bh, 48                  ; Convert second digit from ASCII to numeric
    sub bl, bh                  ; Subtract second digit (BH) from first digit (BL), result in BL
    add bl, 48                  ; Convert numeric result back to ASCII
    mov dl, bl                  ; Move result from BL to DL register (prepare for display)
    mov ah, 2                   ; function to display single character
    int 21h                     ; Call interrupt to display the result character
    jmp exit                    ; Jump to exit label to end program

multiplication:                 ; Label for multiplication operation
    ; Show result message first
    lea dx, result_msg          ; Load address of result message into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display "Result: "
    
    sub bl, 48                  ; Convert first digit from ASCII to numeric (subtract 48)
    sub bh, 48                  ; Convert second digit from ASCII to numeric (subtract 48)
    mov al, bl                  ; Move first number from BL to AL register (prepare for multiplication)
    mul bh                      ; Multiply AL by BH, result stored in AL (AX for 16-bit result)
    
    ; Convert result to ASCII and display
    cmp al, 9                   ; Compare result with 9 (check if single digit)
    jle single_digit            ; Jump to single_digit if result is 9 or less
    
    ; Two digit result
    mov bl, 10                  ; Move 10 to BL register (divisor for extracting digits)
    div bl                      ; Divide AL by 10: quotient in AL, remainder in AH
    add al, 48                  ; Convert tens digit to ASCII (add 48)
    mov dl, al                  ; Move tens digit to DL register (prepare for display)
    push ax                     ; Save AX register (contains remainder in AH)
    mov ah, 2                   ;  function to display single character
    int 21h                     ; Call DOS interrupt to display tens digit
    pop ax                      ; Restore AX register
    
    mov dl, ah                  ; Move remainder (units digit) to DL register
    add dl, 48                  ; Convert units digit to ASCII (add 48)
    mov ah, 2                   ; Set AH to 2 (DOS function to display single character)
    int 21h                     ; Call DOS interrupt to display units digit
    jmp exit                    ; Jump to exit label to end program
    
single_digit:                   ; Label for single digit multiplication result
    add al, 48                  ; Convert single digit result to ASCII (add 48)
    mov dl, al                  ; Move result to DL register (prepare for display)
    mov ah, 2                   ; Set AH to 2 (DOS function to display single character)
    int 21h                     ; Call DOS interrupt to display the result
    jmp exit                    ; Jump to exit label to end program

division:                       ; Label for division operation
    sub bl, 48                  ; Convert first digit from ASCII to numeric (subtract 48)
    sub bh, 48                  ; Convert second digit from ASCII to numeric (subtract 48)

    cmp bh, 0                   ; Check if divisor is zero
    je div_zero                 ; Jump to div_zero if second number is 0

    ; Show result message first
    lea dx, result_msg          ; Load address of result message into DX register
    mov ah, 9                   ; function to display string
    int 21h                     ; Call interrupt to display "Result: "

    mov al, bl                  ; Move dividend from BL to AL register
    mov ah, 0                   ; Clear AH register (prepare for division - AX/BH)
    div bh                      ; Divide AX by BH: quotient in AL, remainder in AH
    
    add al, 48                  ; Convert quotient to ASCII (add 48)
    mov dl, al                  ; Move quotient to DL register (prepare for display)
    mov ah, 2                   ; Set AH to 2 (DOS function to display single character)
    int 21h                     ; Call DOS interrupt to display the quotient
    jmp exit                    ; Jump to exit label to end program

div_zero:                       ; Label for division by zero error
    lea dx, div_zero_msg        ; Load address of division by zero message
    mov ah, 9                   ; function to display string
    int 21h                     ; Call DOS interrupt to display error message
    jmp exit                    ; Exit program

exit:                           ; Label for program exit
    mov ah, 4ch                 ; Set AH to 4Ch (DOS function to terminate program)
    int 21h                     ; Call DOS interrupt to exit program and return to DOS

main endp                       ; End of main procedure
end main                        ; End of program, specify main as entry point
