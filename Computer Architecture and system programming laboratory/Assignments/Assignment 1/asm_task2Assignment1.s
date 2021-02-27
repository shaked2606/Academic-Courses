section .rodata
	format_integer: db "%d", 10, 0	           	; format integer
	invalid: db "illegal input", 10, 0  	   	; print-string for invalid input
	
section .text
	global assFunc			
	extern c_checkValidity		           	   	; extern the c function for check validity
	extern printf			           			; extern the c function for printing

assFunc:
	push ebp                                   	; backup ebp
	mov ebp, esp                              	; set ebp to assFunc activation frame	
	pushad	
	mov ebx, dword [ebp+8]                     	; get first argument to ebx (x)
	mov edx, dword [ebp+12]                    	; get second argument to edx (y)
	push edx                                   	; push edx to stack for being the second argument to the function (y)
	push ebx 			           				; push ebx to stack for being the first argument to the function  (x)
	call c_checkValidity                   	   	; check if the numbers are valid using c_checkValidity function, the result is stored in eax
	pop ebx					   					; pop ebx from stack
	pop edx				 	   					; pop edx from stack
	cmp eax, 49                         	   	; check if valid
	jnz print_invalid_input                    	; if not valid - go to label invalid
	add edx, ebx				   				; add to edx the content in ebx				
	push edx				   					; push edx to stack (4 bytes int)
	push format_integer			   				; push format_integer for printf
	call printf				   					; call printf
	jmp end_of_program			   				; jumping to end of the program

	print_invalid_input:			   			; in case of one of the arguments is not valid
		push invalid		           			; push string invalid
		call printf	    		   				; call printf for printing invalid string

	end_of_program:				   				; ending the program
		add esp, 8		
		popad			           				; pop the registers
		mov esp, ebp		           			; mov esp to point on ebp
		pop ebp				   					; pop ebp
		ret			           					; ending program, return to the activation frame from where it's called
