section .rodata
	format_hexa: db "%X", 0				; format hexa print
	format_hexa02: db "%02X", 0			; format hexa print
	format_hexa_for_operations: db "%X",10, 0	; format hexa 2 digits print
	new_line: db "",10, 0				; new_line string
	print_call: db "calc: ", 0       		; string for printing in prompt
	stack_overflow: db "Error: Operand Stack Overflow", 10, 0  
	empty_stack: db "Error: Insufficient Number of Arguments on Stack", 10, 0
	wrong_Y_value: db "wrong Y value", 10, 0
	debug_mode_print_string: db "debug: ", 0

section .data
	operations_counter: dd 0             	; counter for the operations (for printing in the end)
	number_of_operands: dd 0	    	; number of operands(*4) in operand stack
	size_of_link: equ 5		    	; define const size of link for malloc
	count_pops: dd 0 		    	; variable for print function
	even_or_odd: db 1		    	; variable for knowing if the number of the digits of the input is even/odd
	carry: db 0			     	; variable for addition function
	size_of_slots: equ 5			; constant for defining the size of the stack

section .bss
	operand_stack: resd size_of_slots       ; static array of -size_of_slots- - defining the operand stack
	input_string: resb 81		        ; input string from the user
	debug_mode: resb 1 		     	; flag for debug_mode
	shifting_times: resb 1			; variable for v function
	reset_operand_value: resd 1		; variable for reset operand stack

section .text
  align 16
     global main
     extern printf
     extern fprintf
     extern fflush
     extern malloc
     extern free
     extern gets
     extern stderr
main: 
	mov ebp, esp			    	 ; storing the begining of the stack in ebp
	cmp byte [ebp+4], 2		    	 ; checking if the debug mode is activated
	jnz continue_regulary		    	 ; if not - continue as is
	mov byte [debug_mode], 1	    	 ; else - change the variable debug mode to true, so we need to handle the debug mode in the program
continue_regulary:	
	pushad                              	 ; back-up registers content
	call myCalc			    	 ; call myCalc function
	push eax				; push eax to stack
	push format_hexa_for_operations		; push hexa format
	call printf				; call printf for printing
	add esp, 8				; add 8 byte to esp for clean the 2 last pushes
	popad				    	 ; restoring the registers content
	mov esp, ebp
	mov eax, 1			    	 ; call exit system-call for finish program
	mov ebx, 0			    	 ; call exit system-call for finish program
	int 0x80                            	 ; call exit system-call for finish program

%macro print_calc 0			    	 ; macro for printing "calc: "
	push print_call			    	 ; push the const string "calc: " to stack
	call printf			    	 ; call printf for printing the string
	add esp, 4			    	 ; remove from stack
%endmacro

%macro create_new_link 0   		    	 ; macro for creating new link
	push size_of_link		    	 ; push number of bytes to allocate
	call malloc			    	 ; call malloc for allocating the link - address is in eax. ebx is'nt influenced from malloc
	add esp, 4
%endmacro

%macro string_to_hexa 1			    	 ; macro for convert from string to hexa
	cmp %1, 65			    	 ; check if the digit is 'A'		
	jge %%letters			      	 ; if so or higher (ascii) - we deal with letters A,B,C,D,E,F
	sub %1, 48			    	 ; else - we deal with 0-9 digits
	jmp %%finish
%%letters:
	sub %1, 55
%%finish:
%endmacro

%macro reset_operand_stack 0		     	 ; this macro resets the operand stack for clean using (for any size of operand-stack)
	mov dword eax, size_of_slots
%%reset_label:
	cmp dword eax, 0
	jz %%end_of_reset_macro
	shl eax, 2
	mov dword [ecx+eax], 0	
	shr eax, 2
	sub dword eax, 1
	jmp %%reset_label
%%end_of_reset_macro:
mov dword [ecx], 0	
xor eax, eax
%endmacro

%macro free_link 1				; this macro frees the pointer
	pushad
	push %1
	call free
	add esp, 4
	popad
%endmacro


%macro ecx_point_to_current_operand_stack 0	   ; macro for refresh the pointing of ecx, depends on how much the stack is full at this current moment
	mov dword ecx, operand_stack               ; ecx is pointing to begining of operand stack
	add ecx, [number_of_operands]		   ; add value of number_of_operands to assign ecx for pointing the right position in operand stack
%endmacro

%macro pop_from_operand_stack 1		           ; this macro pops from the operand stack the element of the top of stack, if exist
	ecx_point_to_current_operand_stack
	sub ecx, 4				   ; sub ecx by 4 bytes to remove the linked-list
	sub dword [number_of_operands], 4	   ; sub the number_of_operands
	mov dword %1, [ecx]			   ; esi pointing on the first link in the linked list
	mov dword [ecx], 0			   ; we reset the cell in the operand stack to 0
%endmacro

myCalc:
	push ebp			    	 ; saving the caller-state in stack
	mov ebp, esp		             	 ; ebp is now pointing to the begining of the stack
	ecx_point_to_current_operand_stack	 ; macro for reset ecx to point to the current operand stack
	reset_operand_stack		     	 ; reset all cells of address in operand stack
get_input_user:
	print_calc			    	 ; print "calc: " to the prompt
	push input_string		    	 ; push the variable that we want to insert the input into
	call gets			    	 ; call gets, after calling eax is pointing to input_string
	xor ebx, ebx			    	 ; reset ebx for clean using
	mov ebx, input_string  	     	    	 ; assign ebx to point the begining of the input_string (ebx not changed after calling malloc/printf)
	add esp, 4				 ; add 4 (because of the input string) from the address of esp
	ecx_point_to_current_operand_stack  	 ; macro for reset ecx to point to the current operand stack

checking_if_one_of_the_functions:
	cmp byte [input_string], 113	    	; check if the char is 'q'
	jz end_of_program		     	; if so - finish the program
	cmp byte [input_string], 43	     	; char if the char is '+'
	jz addition			    	; if so - calculate addition function
	cmp byte [input_string], 112	     	; check if  the char is 'p'
	jz pop_and_print		     	; if so - calculate pop_and_print function
	cmp byte [input_string], 100 	     	; check if the char is 'd'
	jz duplicate		     	     	; if so - calculate duplicate function
	cmp byte [input_string], 94 	    	; check if the char is '^'
	jz pos_power			    	; if so - calculate positive_power function
	cmp byte [input_string], 118 	     	; check if the char is 'v'
	jz neg_power			     	; if so - calculate negative_power function
	cmp byte [input_string], 110 	     	; check if the char is 'n'
	jz counting_1			     	; if so - calculate counting_1 function
	
	; if we got here so the char-input is not any of the functions - so we get hexa number, and we need to handle it (create linked list of the number):

handle_lead_0:					; first of all, we want to delete all leading 0 from the number before we create the linked list
	ecx_point_to_current_operand_stack	; macro for reset ecx to point to the current operand stack
	sub ecx, operand_stack			; check how much operands in the stack right now
	cmp ecx, size_of_slots*4		; compare to the capcity of the stack
	je overflow_error_to_number		; if the stack is full, we can't add another number, so we print an stack overflow error
	ecx_point_to_current_operand_stack	; macro for reset ecx to point to the current operand stack
	cmp byte [ebx], 48			; checking if the char is '0'
	jnz even_or_odd_label			; if not - the number is not with leading zeroes anymore, and we can continue
	mov byte [ebx], 0			; else - we reset the byte in input string for clean using in the next time we will get input
	add ebx, 1				; go to the next char in the input string
	cmp byte [ebx], 0			; checking if we finish the input string
	jnz handle_lead_0			; if not - looping again
	sub ebx, 1				; if so - the input number is '0', so we go back to the previous byte
	mov byte [ebx], 48			; we change the byte back to '0'
	mov byte [even_or_odd], 0		; the number '0' is odd, so we edit the even_or_odd variable too
	jmp handle_hexa_number			; we continue to create a linked list

	; now the input_string isn't including leading zeroes. we want to check if the number of digits in the input_string is even or odd (this is for the build of the linked list)

even_or_odd_label:
	mov edx, ebx				; store the pointer to the input_string in edx, because we now change ebx value
check_if_even_or_odd:				
	cmp byte [ebx], 0			; check if char is '/0'
	jnz odd_count				; if not - the number of digits is odd for this moment
	jmp finish_even_or_odd			; if so - we got to the end of the input_string
odd_count:
	mov byte [even_or_odd], 0		; changing the var 'even_or_odd' to be odd (0 value)
	add ebx, 1				; move to the next char
	cmp byte [ebx], 0			; check if the char is '/0'
	jnz even_count				; if not - the number of digist is even for this moment
	jmp finish_even_or_odd			; is so - we got to the end of the input_string
even_count:
	mov byte [even_or_odd], 1		; changing the var 'even_or_odd' to be even (1 value)
 	add ebx, 1				; move to the next char
	jmp check_if_even_or_odd		; jumping to the begining of the check
finish_even_or_odd:
	mov ebx, edx				; restore ebx to point to be at the begining of input_string

	; now we know if the input_string count digits is even or odd. we will build the linked list depends on that

handle_odd_string_case:				; this label is responsible for deal with case of odd number of digits in the input_string
	cmp byte [even_or_odd], 0		; check if the var even_or_odd is 0 (odd)
	jnz handle_hexa_number			; is not - we will build the linked list regulary
	create_new_link				; else - we weill create new link
	ecx_point_to_current_operand_stack	; refresh ecx pointing, because malloc is changing ecx value
	mov byte [eax], 0			; assign to eax (pointing to the begining of the first link) the value 0
	jmp odd_string				; jumping to the middle of the handle_hexa_number label, because we want to handle odd number of digits in input_string


handle_hexa_number:
	cmp byte [ebx], 0		     	; if we got to the char '/0' and finish the input-string
	jz close_linked_list	            	; if so - close_linked_list, and inc to the next operand stack
	create_new_link		      	     	; if not - we need to create new link for storing the char. eax holds the address for the new allocated cells
	ecx_point_to_current_operand_stack   	; because of the malloc, ecx value is changed. we want to restore to the current position in the operand stack
	xor edx, edx				; reset edx for clean using
	mov byte dl, [ebx]			; assign edx to be the ascii value of the char in the input-string
	string_to_hexa edx		     	; convert ascii value char to integer value
	mov byte [eax], dl			; assign to [eax] the value of the hexa
	mov byte [ebx], 0			; reset the byte where the char was for re-use input_string
	add ebx, 1				; move to the next char in input-string
odd_string:
	cmp byte [ebx], 0		     	; if we got to the char '/0' and finish the input-string
	jz close_link				; is so - close the current link
	xor edx, edx				; reset edx for clean using
	mov byte dl, [ebx]			; assign edx to be the ascii value of the char in the input-string
	string_to_hexa edx		     	; convert ascii value char to integer value
	shl byte [eax], 4			; shift left the value in eax for multiply by 16
	add byte [eax], dl			; add the other digit to eax
close_link:
	add eax, 1				; move to the address of the begining of the 4 other bytes in the link
	mov edx, [ecx]				; assign to edx the address of the prev link created (or 0 if this is the first link)
	mov dword [eax], 0			; reset the 4 bytes in the link
	mov [eax], edx				; assign to eax the address (or 0 if it's the first link) of the prev link created
	sub eax,1				; back to the begining of the link
	mov [ecx], eax				; assign to operand_stack pointer to the linked list
	mov byte [ebx], 0			; reset the byte where the char was for re-use input_string
	add ebx, 1				; move to the next char in input-string
	jmp handle_hexa_number			; looping again till the end of the input_string

close_linked_list:				; this label is responsible for closing the linked list
	add ecx, 4				; add to operand stack another operand by add 4 bytes to ecx address (now ecx will point to the next free memory in stack)
	add dword [number_of_operands], 4	; add 4 to number_of_operands
	cmp byte [debug_mode], 0
	jnz debug_mode_print			
	jmp get_input_user			; looping again for another input


addition:					; this label is responsible for addition function
	mov byte [carry], 0			; helper variable for keeping the previous carry
	ecx_point_to_current_operand_stack	; refresh ecx pointing, because malloc is changing ecx value 
	sub ecx, operand_stack			; check how much operands is there on stack right now
	cmp ecx, 8				; if at least 2 operands, we can do the addition
	jl empty_error				; if not - print an empty_error
	ecx_point_to_current_operand_stack	; refresh ecx pointing, because malloc is changing ecx value
	mov byte [carry], 0			; reset carry variable
	pop_from_operand_stack esi		; pop from the operand stack and move esi to point on the linked list
	pop_from_operand_stack edi		; pop from the operand stack and move edi to point on the linked list
	create_new_link				; create new link for the new sum linked list
	ecx_point_to_current_operand_stack	; because of the malloc, ecx value is changed. we want to restore to the current position in the operand stack
	xor edx, edx				; reset edx for clean using
	mov [ecx], eax				; assign to operand_stack pointer to the linked list
addition_loop:
	mov byte [carry], dl			; save the carry from before, if exist (for the first run the carry is 0)
	xor ebx, ebx				; reset ebx for clean using
	add bl, [esi]				; add value of first linked list to bl
	add bl, [edi]				; add value of second linked list to bl
	setc dl					; if there is a carry, we save it in dl
	add byte bl, [carry]			; add carry (from previous link) to bl
add_sum_of_links:
	mov [eax], bl				; mov the sum to the new link of the sum linked list
	add esi, 1				; move forward first linked list
	add edi, 1				; move forward second linked list
	cmp dword [esi], 0			; check if there's next link in the first linked list (esi)
	jz main_end_of_first_list		; if so - we need to handle sum of just one linked list (edi)
	cmp dword [edi], 0			; check if there's next link in the first linked list (edi)
	jz main_end_of_second_list		; if so - we need to handle sum of just one linked list (esi)
both_list_not_end:				; this label is when both list on the same length for this moment (and both of them not ended yet)
	xor ecx, ecx				; reset ecx for clean using
	sub esi, 1				; move to the begining of the link of the first linked list
	mov ecx, esi				; save pointer to the begining of the link of the first linked list
	add esi, 1				; move forward to the 4 bytes address in the link of the first linked list
	mov esi, [esi]				; move forward to the next link of the first linked list
	free_link ecx				; call free link for the link we just passed
	xor ecx, ecx				; reset ecx for clean using
	sub edi, 1				; move to the begining of the link of the second linked list
	mov ecx, edi				; save pointer to the begining of the link of the second linked list
	add edi, 1				; move forward to the 4 bytes address in the link of the first linked list
	mov edi, [edi]				; move forward to the next link of the first linked list
	free_link ecx				; call free link for the link we just passed
	add eax, 1				; eax is pointing on the sum linked list, and we finish to sum both of links in both lists, so we move eax to the next 4 bytes
	mov ebx, eax				; save pointer to eax
	push edx				; save register edx
	create_new_link				; call to create new link, remember ebx doesn't change when calling malloc
	pop edx					; restor register edx
	mov [ebx], eax				; connect between the prev link to the curr link
	ecx_point_to_current_operand_stack	; refresh ecx pointer to the current position on stack
	jmp addition_loop			; looping again to sum more links
main_end_of_first_list:				; when the first linked list is over, we want to continue sum the rest of the other linked list, if it doesn't over too
	sub esi, 1				; we want to point to the begining of the link pointed by esi
	free_link esi				; release the last link of the first linked list
end_of_first_list:				; this label deal with the other linked list that still exist
	cmp dword [edi], 0			; check if the second linked list isn't over yet
	jz main_edi_end_of_addition_function	; if over - end the summing
	xor ecx, ecx				; reset ecx for clean using
	sub edi, 1				; point edi to the begining of the link
	mov ecx, edi				; save pointer to this link
	add edi, 1				; move forward to the 4 other bytes in the link
	mov edi, [edi]				; move to the next link
	free_link ecx				; free the prev link
	xor ebx, ebx				; reset ebx for clean using
	mov ebx, eax				; save pointer to prev link
	add ebx, 1				; move forward to the 4 other bytes of the link
	push edx				; save edx data
	create_new_link				; create new link by malloc
	pop edx					; restore edx data
	mov [ebx], eax				; connect between prev link to curr link
	xor ebx, ebx				; reset ebx for clean using
	add byte bl, dl				; add carry, if exist
	add bl, [edi]				; add the content of the second linked list
	setc dl					; dl save the carry, if exist
	mov [eax], bl				; move the sum to the link in the sum linked list
	add edi, 1				; move forward to the 4 other bytes of the address of the next link, if exist
	jmp end_of_first_list			; looping again
main_end_of_second_list:
	sub edi, 1				; we want to point to the begining of the link pointed by edi
 	free_link edi				; release the last link of the first linked list
end_of_second_list:				; this label deal with the other linked list that still exist
	cmp dword [esi], 0			; check if the first linked list isn't over yet
	jz main_esi_end_of_addition_function	; if over - end the summing
	xor ecx, ecx				; reset ecx for clean using
	sub esi, 1				; point esi to the begining of the link
	mov ecx, esi				; save pointer to this link
	add esi, 1				; move forward to the 4 other bytes in the link
	mov esi, [esi]				; move to the next link
	free_link ecx				; free the prev link
	xor ebx, ebx				; reset ebx for clean using
	mov ebx, eax				; save pointer to prev link
	add ebx, 1				; move forward to the 4 other bytes of the link
	push edx				; save edx data
	create_new_link				; create new link by malloc
	pop edx					; restore edx data
	mov [ebx], eax				; connect between prev link to curr link
	xor ebx, ebx				; reset ebx for clean using
	add byte bl, dl				; add carry, if exist
	add bl, [esi]				; add the content of the second linked list
	setc dl					; dl save the carry, if exist
	mov [eax], bl				; move the sum to the link in the sum linked list
	add esi, 1				; move forward to the 4 other bytes of the address of the next link, if exist
	jmp end_of_second_list			; looping again
main_edi_end_of_addition_function:		; release the last link in the second linked list
	sub edi, 1				; point edi to the begining of the link
	free_link edi				; release the last link of the first linked list
	jmp end_of_addition_function		; finish to sum, we want to close the linked list and finish the function
main_esi_end_of_addition_function:		; release the last link in the first linked list
	sub esi, 1				; point esi to the begining of the link
	free_link esi				; release the last link of the first linked list
	jmp end_of_addition_function		; finish to sum, we want to close the linked list and finish the function
end_of_addition_function:			; check if there is a carry, is so - we need to open new link that will be new MSB link of the number
	cmp byte dl, 0				; checking the carry
	jz end_function_with_no_carry		; if no carry - we don't need to add another link
	mov ebx, eax				; save pointer to the current link
	push edx				; save edx content (carry is in it)
	create_new_link				; create new link by malloc
	pop edx					; restore edx
	add ebx, 1				; move to the next 4 other bytes of the prev link
	mov dword [ebx], eax			; connect between the prev link to the curr link
	mov byte [eax], dl			; move the carry to the new link
end_function_with_no_carry:
	add eax, 1				; move to the 4 other bytes of the curr link
	mov dword [eax], 0			; closine the link to be the last one in the linked list
	add dword [number_of_operands], 4	; add 4 bytes to number_of_operands
	inc dword [operations_counter]		; increase by one the number of operations in the program
	cmp byte [debug_mode], 0		; checking if the program running on debug mode
	jz get_input_user			; if not - loop again to get next input
	jmp debug_mode_print			; if so - print the added operand to the screen


debug_mode_print:				; this label is for debug mode - we want to print every number we add and every number we push to operand stack
	ecx_point_to_current_operand_stack	; refresh ecx to the current position in operand stack
	sub ecx, 4				; sub the ecx address to point the last operand pushed
	mov esi, [ecx]				; assign esi to point this operand
	push debug_mode_print_string		; push "debug: " string
	push dword [stderr]			; because we are in debug mode, we want to print to stderr 
	call fprintf				; call printf for printing
	add esp, 8				; remove string from stack
push_loop_debug_mode:
	xor eax, eax				; reset eax for clean using
	mov byte al, [esi]			; assign to eax the value of the first link in the linked list
	add esi, 1				; move esi to the next 4 bytes of the link
	push eax				; push the value of eax
	inc dword [count_pops]			; increment number of pops, so we can know how much we need to pop for printing
	cmp dword [esi], 0			; checking if no other links exist in the linked list
	jz debug_mode_pop			; if so - we want to start popping and printing
	push format_hexa02			; we want to print with %02X for correct printing
	push dword [stderr]			; because we are in debug mode, we want to print to stderr
	mov esi, [esi]				; move to the next link (or 0 if not exist next link)
	jmp push_loop_debug_mode		; looping again till the end of the linked list
debug_mode_pop:					; we finish to push all links, now we want to pop and print them
	push format_hexa			; push format of %X for correct printing for the first link (MSB link)
	push dword [stderr]			;  because we are in debug mode, we want to print to stderr
debug_mode_pop_loop:				; this label is pop loop for printing all links that pushed
	cmp dword [count_pops], 0		; checking if there is something to pop
	jz debug_mode_end_of_pop_and_print	; if not - we jump to the end of the printing function
	call fprintf				; if so - we call fprintf and printing the top of the stack
	add esp, 12				; add 12 bytes to esp for delete the 3 pushes we use for fprintf
	sub dword [count_pops], 1		; we decrease by 1 count_pops
	jmp debug_mode_pop_loop			; looping again
debug_mode_end_of_pop_and_print:
	push new_line				; push new_line for nice ouput
	call printf				; call printf for printing "\n"
	add esp, 4				; remove string from stack
	jmp get_input_user			; looping again for another input


pop_and_print:					; this label is responsible for print the number in the top of the stack
	ecx_point_to_current_operand_stack	; refresh operand stack position 
	sub ecx, operand_stack			; check how much operands is there on stack right now
	cmp ecx, 4				; at least one operand need to be on stack for this function
	jl empty_error				; if not - print empty error
	pop_from_operand_stack esi		; pop from the operand stack the top number
push_loop:		
	xor eax, eax				; reset eax for clean using			
	mov byte al, [esi]			; assign to eax the value of the first link in the linked list
	add esi, 1				; move esi to the next 4 bytes of the link
	push eax				; push the value of eax
	inc dword [count_pops]			; increment number of pops, so we can know how much we need to pop for printing
	cmp dword [esi], 0			; checking if no other links exist in the linked list
	jz pop					; if so - we want to start popping and printing
	push format_hexa02			; we want to print with %02X for correct printing
	xor ecx, ecx				; reset ecx for clean using
	sub esi, 1				; move back to the begining of the link
	mov ecx, esi				; save pointer to the begining of the link
	add esi, 1				; move to the 4 other bytes of the link
	mov esi, [esi]				; move to the next link
	free_link ecx				; free the prev link
	jmp push_loop				; looping again till the end of the linked list
pop:
	push format_hexa			; push format of %X for correct printing of the MSB link
	sub esi, 1				; move to the begining of the last link
	mov ecx, esi				; move ecx to point of this link
	free_link ecx				; free the last link
pop_loop:
	cmp dword [count_pops], 0		; checking if there's something to pop
	jz end_of_pop_and_print			; if not - we jump to the end of the printing function
	call printf				; if so - we call printf and printing the top of the stack
	add esp, 8				; add 8 bytes to esp for delete the 2 pushes we use for printf
	sub dword [count_pops], 1		; we decrease by 1 count_pops
	jmp pop_loop				; looping again

end_of_pop_and_print:
	push new_line				; push new_line for nice output
	call printf				; call printf for printing "\n"
	add esp, 4				; remove the push from stack
	inc dword [operations_counter]		; increment number of operations by 1 for the end of the program
	jmp get_input_user			; looping again for another input


duplicate:					; this function is responsible for duplicate the top linked list in the stack
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	sub ecx, operand_stack			; check how much operands in the stack
	cmp ecx, 4				; if we have at least 1, we can do the function
	jl empty_error				; if not - print empty error to the screen
	cmp ecx, size_of_slots*4		; check if the operand stack is full so we can't add more operand
	je overflow_error			; if so - print overflow error to the screen
	ecx_point_to_current_operand_stack	; refresh position of stack
	xor esi, esi				; reset esi for clean using
	xor ebx, ebx				; reset ebx for clean using
	sub ecx, 4				; sub ecx by 4 bytes to point to the top linked list
	mov esi, [ecx]				; assign to esi to point the linked list
	mov byte bl, [esi]			; assign to eax the data of the first link
	create_new_link				; creating new link by malloc
	ecx_point_to_current_operand_stack	; refresh ecx pointing (malloc change ecx)
	mov [ecx], eax				; add the first link to the operand stack
	mov byte [eax], bl			; assign to the new link the data from the old link
	add eax, 1				; increment eax to the next 4 bytes of the new link
	add esi, 1				; increment esi to the next 4 bytes of the old link
duplicate_loop:
	cmp dword [esi], 0			; checking if there's next link
	je end_of_duplicate			; is not - end the function
	mov esi, [esi]				; is so - move to the next link
	xor ebx, ebx				; reset ebx for clean using
	mov ebx, eax				; assign to ebx the address of the link, because we want to use malloc and we don't want to lose the pointer
	create_new_link				; using malloc for next link
	ecx_point_to_current_operand_stack	; refresh ecx pointing
	mov [ebx], eax				; assign next link address to the prev link that created before
	xor ebx, ebx				; reset ebx for clean using
	mov byte bl, [esi]			; assign the data of the old link to ebx
	mov byte [eax], bl			; assign the data to the new link created
	add eax, 1				; increment eax to the next 4 bytes of the new link
	add esi, 1				; increment esi to the next 4 bytes of the old link
	jmp duplicate_loop			; looping again
end_of_duplicate:
	mov dword [eax], 0			; assign the last link to point to 0
	add ecx, 4   				; assign to ecx the address of the first link
	add dword [number_of_operands], 4	; add 4 bytes to number_of_operands
	inc dword [operations_counter]		; increment number of operations by 1 for the end of the program
	cmp byte [debug_mode], 0		; checking if the program running on debug mode
	jz get_input_user			; if not - loop again to get next input
	jmp debug_mode_print			; if so - print the added operand to the screen


pos_power:					; this function does X*2^Y, when X is the first operand and Y is the second operand
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	sub ecx, operand_stack			; check how much operands in the stack
	cmp ecx, 8				; if we have at least 2, we can do the function
	jl empty_error				; if not - print empty error to the screen
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	sub ecx, 4				; sub ecx by 4 bytes to point to the top linked list (to get address to the begining of first linked list - X)
	mov esi, [ecx]				; assign to esi to point the first linked list
	sub ecx, 4				; sub ecx by more 4 bytes to point to the top linked list (to get address to the begining of thesecond linked list - Y)
	mov edi, [ecx]				; assign to edi to point the second linked list
check_if_Y_bigger_than_200:			; we want to check if Y is bigger that 200 - if so this is an error !
	xor ebx, ebx				; reset ebx for clean using
	xor edx, edx 				; reset edx for clean using
	mov ebx, edi				; assign ebx to point on the second linked list
	mov byte dl, [ebx]			; move to dl the value of Y
	cmp edx, 200				; check if decimal value of Y is 200
	jg Y_bigger_than_200			; if greater - this is an error
	add ebx, 1				; move forawrd by one to see if there's next link
	cmp dword [ebx], 0			; if no next link - that's ok, but if there's next link - so the number is greate than 200 and this is an error
	jnz Y_bigger_than_200			; if there's another link - this is an error !
valid_Y_value:					; if we got to this label - Y is valid and we can do the function
	pop_from_operand_stack esi		; pop from the operand stack and move esi to point on the linked list - X
	pop_from_operand_stack edi		; pop from the operand stack and move edi to point on the linked list - Y
	mov [ecx], esi				; we connect X to the operand stack, because we just edit the linked list
	mov edx, edi				; edx is pointing to Y
	cmp byte [esi], 0			; checking if lsb of X is 0
	jnz pos_power_X_is_not_zero		; if not - the result is not zero for sure
	add esi, 1				; if so - we need to check if there's another link to X
	cmp byte [esi], 0			; we check if the next 4 bytes of the link is 0 (value of the address to next link)
	jz end_of_function_pos_power_X_or_Y_are_zero		; if so - X is 0 and the result is 0, no matter what is Y
pos_power_X_is_not_zero:			; now we want to check if Y is 0
	cmp byte [edx], 0			; we check if Y is not zero, if so - the result is X himself because 2^0=1 so 1*X = X
	jz end_of_function_pos_power_X_or_Y_are_zero		; we jump to deal with result of 0
sub_Y_loop:					;this label is the start of the function
	cmp dword [edx], 8			;check if Y is greate than 8
	jl handle_shift_left			; if less - we need to do shifting,  if not - we want to add link of 0 to the lsb
	push edx				; save edx because we want to call malloc
	create_new_link				; creating new link
	pop edx					; restore edx value
	ecx_point_to_current_operand_stack	; refresh ecx position
	mov dword [ecx], eax			; because we pop operands before, ecx now pointing to the right position
	mov byte [eax], 0			; we assign to the new link value of 0
	add eax, 1				; we move forward to the 4 other bytes of the link
	mov [eax], esi				; connectiong between links
	sub eax, 1				; we move back to the begining of the link
	mov esi, eax				; now we want that esi will point to the new link, because it become the last link of X
	mov edx, edi				; save pointer in edx
	sub byte [edx], 8			; sub 8 from edx, because of the new link added
	jmp sub_Y_loop				; looping again
handle_shift_left:				; if we got here, it means that we have less than 8 in edx, so we need to start doing shifting
	xor ebx, ebx				; reset ebx for clean using
	xor eax, eax				; reset eax for clean using
	mov dword ebx, 1			; assign ebx to 1 (we want to assign in ebx the value of the multipliaction)
calculate_bl:					; in this label we will calcaulate how much we need to multiply every link
	cmp dword [edx], 0			; check if we finish counting edx
	jz end_of_calculating_bl		; if so - we finish to calculate the number we need to multiply with
	shl dword ebx, 1			; shift left for multiply ebx by 2
	sub dword [edx], 1			; decrease edx for counting backward
	jmp calculate_bl			; looping again till we finish edx
end_of_calculating_bl:				; in this label we don't need anymore Y link, so we can free the link
	free_link edx				; call free to release Y
	xor edx, edx				; reset edx for clean using
shift_loop:					; this is the main loop for shifting the number
	mov byte al, [esi]			; move value of link to al
	mul bl					; do mul with the value in bl
	mov byte [esi], al			; move the result back to the link
	add [esi], dh				; add to result the carry from prev link
	add esi, 1				; move forawrd to the next 4 bytes
	cmp dword [esi], 0			; if we finish to pass all over the linked list, we finish the loop
	jz end_of_shift_loop			; if so - jump to the end of shift loop, to see if we need to add another MSB linked list or not
	mov esi, [esi]				; move to the next link
	mov byte dh, ah				; save carry in dh for adding to the next link
	jmp shift_loop				; looping again
end_of_shift_loop:				; in this label we need to check if we need to add new MSB link or not (depends on the carry)
	cmp byte ah, 0				; check if we have carry from the last link in the linked list
	jz end_of_function_pos_power		; if not - we can end the function, if so - we want to add new link to be the MSB with the carry
	xor edx, edx
	mov dword edx, eax
	push edx
	create_new_link
	pop edx
	mov [esi], eax				; connect prev link to new link
	mov byte [eax], dh			; move the value of the carry to the new link
	add eax, 1				; move forward to the 4 other bytes
	mov dword [eax], 0			; assign in them 0, because this is the last link of the linked list
	jmp end_of_function_pos_power
end_of_function_pos_power_X_or_Y_are_zero:
	free_link edx				; free Y
end_of_function_pos_power:			
	add ecx, 4   				; assign to ecx the address of the first link
	add dword [number_of_operands], 4	; add 4 bytes to number_of_operands
	inc dword [operations_counter]		; increment number of operations by 1 for the end of the program
	cmp byte [debug_mode], 0		; checking if the program running on debug mode
	jz get_input_user			; if not - loop again to get next input
	jmp debug_mode_print			; if so - print the added operand to the screen


neg_power:					; this function does X*2^(-Y), when X is the first operand and Y is the second operand
	mov byte [shifting_times], 0		; reset variable that count times of shifting
	ecx_point_to_current_operand_stack	; refresh ecx to the curr position of operand stack
	sub ecx, operand_stack			; check how much operands there is in operand stack
	cmp ecx, 8				; if there's at least 8 - we can do the function
	jl empty_error				; if not - print empty error to the screen
	ecx_point_to_current_operand_stack	; refresh ecx to the curr position of operand stack
	sub ecx, 4				; sub ecx to point to the top operand of stack
	mov esi, [ecx]				; assign esi to point on the top linked list
	sub ecx, 4				; sub ecx to point to the second operand of stack from top
	mov edi, [ecx]				; assign edi to point on the top linked list
check_if_Y_bigger_than_200_neg:			; we want to check if Y is valid number (Y <= 200)
	xor ebx, ebx				; reset ebx for clean using
	xor edx, edx 				; reset edx for clean using
	mov ebx, edi				; assign ebx to point Y
	mov byte dl, [ebx]			; assign dl to the value of Y
	cmp edx, 200				; check Y with 200
	jg Y_bigger_than_200			; if greater, print error message
	add ebx, 1				; if the lsb is not greater than 200, maybe there's next link and than Y is greate than 200 too
	cmp dword [ebx], 0			; check if there's next link
	jnz Y_bigger_than_200			; if so - preint error message
valid_Y_value_neg:				; if we got to this label than Y is valid number, and we can do the function
	pop_from_operand_stack esi		; pop from the operand stack and move esi to point on the linked list - X
	pop_from_operand_stack edi		; pop from the operand stack and move edi to point on the linked list - Y
	xor ebx, ebx				; reset ebx for clean using
	mov edx, edi				; assign edx to point Y
	mov [ecx], esi				; assign top operand stack to point on X
	cmp byte [esi], 0			; check if the lsb link of X is 0
	jnz neg_power_X_is_not_zero		; if not - X is for sure not 0
	add esi, 1				; if ths lsb 0, we want to check if there's next link
	cmp byte [esi], 0			; checking if there's next link
	jz main_end_of_function_neg_power ; if so - X is zero, and the result is zero
	sub esi, 1				; move back to the begining of the link				
neg_power_X_is_not_zero:			; X not zero, but maybe Y is zero
	cmp byte [edx], 0			; check if Y is zero
	jz main_end_of_function_neg_power ; if so - the result is X
	mov byte bl, [edx]			; assign bl to be Y
	mov byte [shifting_times], bl		; move to variable the value of Y
sub_Y_loop_neg:					
	cmp ebx, 0				; check if ebx is 0, so we don't need to shift at all
	jz main_end_of_function_neg_power		; if so - end the function
	cmp ebx, 8				; if ebx is greater than 8 so we need to delete the lsb link from the linked list
	jl handle_shift_right			; if not - we need to handle shifting right
	xor ecx,ecx				; reset ecx for clean using
	mov ecx, esi				; move ecx to point on X
	add esi, 1				; move to point on the next link address
	cmp dword [esi], 0			; check if there's next link
	jnz continue_looping			; if so - continue looping
	sub esi, 1				; move back to the begining of the link
	mov byte [esi], 0			; if we got here it means that all the links were deleted, and this is the last link servived, so the result is 0
	jmp main_end_of_function_neg_power	
continue_looping:
	mov esi, [esi]				; move to the next link
	free_link ecx				; free the prev link
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	mov dword [ecx], esi			; connectiong the edited linked list to operand stack
	sub ebx, 8				; dec Y by 8 
	mov byte [shifting_times], bl		; update shifting_times variable
	sub byte [edx], 8			; dec Y by 8
	jmp sub_Y_loop_neg			; looping again
handle_shift_right:
	xor ebx, ebx				; reset ebx for clean using
	xor eax, eax				; reset eax for clean using
	mov dword ebx, 1			; assign ebx to be 1
calculate_bl_neg:
	cmp dword [edx], 0			; check if Y is 0
	jz end_of_calculating_bl_neg		; if so - we stop multiply ebx
	shl dword ebx, 1			; multiply ebx by 2
	sub dword [edx], 1			; dec Y 
	jmp calculate_bl_neg			; looping again
end_of_calculating_bl_neg:			
	free_link edx				; free Y - we got our information
	xor edx, edx				; reset edx for clean using
	xor edi, edi				; reset edi for clean using
main_shift_right_loop:
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	mov esi, [ecx]				; assign esi to point the first link in the linked list
	xor eax, eax				; reset eax for clean using
	mov byte al, [esi]			; assign value of X to al
	div bl					; dividing by ebx(2^Y)
	mov byte [esi], al			; move the value to X
	xor eax, eax				; reset eax for clean using
	mov edi, esi				; mov edi to point esi
	add esi, 1				; add esi to point on other 4 bytes
	cmp dword [esi], 0			; check if this is the only link in the linked list, if so, finish the loop
	jz main_end_of_function_neg_power	; if so - we finish the function	
	mov esi, [esi]				; move to the next link
second_shift_right_loop:
	xor eax, eax				; reset eax for clean using
	mov byte al, [esi]			; assign value of X to al
	div bl					; dividing by ebx(2^Y)
	mov byte [esi], al			; move the value to X
	mov dh, ah				; save in dh the carry from the dividing
	xor ecx, ecx				; reset ecx for clean using
	mov byte cl, 8				; move to cl the value 8 (8 bits)
	sub byte cl, [shifting_times]		; sub the shifting times 
	cmp byte cl, 0				; check if it's 0
	jz ignore_shifting			; if so - don't do the shift
	shl dh, cl				; shifting
ignore_shifting:
	add byte [edi], dh			; add to X the shifting from the next link
	add esi, 1				; move esi to the 4 other bytes
	cmp dword [esi], 0			; check if there's next link
	jz check_if_the_MSB_is_zero		; if so - we need to check if the MSB is zero, and delete it
	sub esi, 1				; move back to the begining of the link
	mov edi, esi				; save pointer in edi
	add esi, 1				; move to the 4 other bytes
	mov esi, [esi]				; move to the next link
	jmp second_shift_right_loop		; looping again
check_if_the_MSB_is_zero:
	xor edx, edx				; reset edx for clean using
	sub esi, 1				; move to the begining of the link
	cmp byte [esi], 0			; if the value is 0, we want to delete it
	jnz main_end_of_function_neg_power	; if not 0 - we finish the function
	mov ecx, esi				; save pointer to esi
	free_link ecx				; delete the link
	add edi, 1				; add to the prev link value 0
	mov dword [edi], 0
main_end_of_function_neg_power:
	cmp edx, 0				; check if edx is 0
	jz end_function_neg_power		; if so - we finish the function
	free_link edx				; if not - this is Y and we want to release the link
end_function_neg_power:
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	add ecx, 4   				; assign to ecx the address of the first link
	add dword [number_of_operands], 4	; add 4 bytes to number_of_operands
	inc dword [operations_counter]		; increment number of operations by 1 for the end of the program
	cmp byte [debug_mode], 0		; checking if the program running on debug mode
	jz get_input_user			; if not - loop again to get next input
	jmp debug_mode_print			; if so - print the added operand to the screen


counting_1:
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	sub ecx, operand_stack			; check how much operands there is in operand stack
	cmp ecx, 4				; if there's at least 4 - we can do the function
	jl empty_error				; if not - print empty error to the screen
	pop_from_operand_stack esi		; pop from the operand stack and move esi to point on the linked list	
	xor eax, eax				; reset eax for clean using
	xor ebx, ebx				; reset ebx for clean using
	xor edx, edx				; reset edx for clean using
	xor edi, edi				; reset edi for clean using	
	create_new_link			
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	mov edi, eax				; mov edi to point on the new link created
	add edi, 1				; go to the other 4 bytes of the link
	mov dword [edi], 0			; assign in the addrsess of the next link 0
	sub edi, 1				; get back to the begining of the link
	mov byte bl, [esi]			; move the value of the link in the linked list pointed by esi
	popcnt eax, ebx				; count how much 1 bits in the number
	mov byte [edi], al			; move the count result to the link
	mov eax, edi				; assign eax to the counter link
	mov [ecx], eax				; add the new link to the operand stack
	add esi, 1				; move to the next 4 bytes for moving to the next link, if exist
counting_1_loop:
	cmp dword [esi], 0			; check if there is next link
	jz end_of_counting_1_loop		; if not - finish counting
	xor ecx, ecx				; reset ecx for clean using
	sub esi, 1				; move to the begining of the link
	mov ecx, esi				; save pointer to the begining of the link
	add esi, 1				; mov forward to the 4 bytes of the address of the next link
	mov esi, [esi]				; move to next link
	free_link ecx				; free the prev link
	mov edi, eax				; move edi to point the counter linked list
	xor ebx, ebx				; reset ebx for clean using
	mov byte bl, [esi]			; move the value of the link in the linked list pointed by esi
	popcnt eax, ebx				; count how much 1 bits in the number
	xor ebx, ebx				; reset ebx for clean using
	add byte [edi], al			; move the count result to the link
	jnc carry_false				; if no carry - continue counting in this link, if there's carry we need to create new link
carry_loop:
	setc bl					; bl save the carry
	mov eax, edi				; save pointer to the curr counter link
	add eax, 1				; move forawrd by 1 to the next link
	cmp dword [eax], 0			; if there's no next link we need to create new one
	jnz move_to_the_next_link_for_add_carry	; if there's next link we move to it
	mov edi, eax				; save pointer to curr link
	create_new_link				; create new link
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	mov byte [eax], bl			; mov the value of carry to the new link
	mov dword [edi], eax			; connect between the prev link and curr link
	mov edi, eax				; back to point of the current link
	add eax, 1				; move to the next 4 bytes of the link
	mov dword [eax], 0			; assign in the address of the next link 0
	mov dword eax, [ecx]			; go to the begining of the linked list for continue counting
	add esi, 1				; move forward to poist on the 4 bytes of the linked list
	jmp counting_1_loop			; looping again
move_to_the_next_link_for_add_carry:
	mov eax, [eax]				; move to the next link
	add byte [eax], bl			; add value of carry to next link
	jc carry_loop				; if carry - do the carry loop again
	ecx_point_to_current_operand_stack	; refresh position of operand stack
	mov dword eax, [ecx]			; go to the begining of the linked list for continue counting
	jmp counting_1_loop			; looping again
carry_false:
	mov eax, edi				; move eax to the linked list that we count from it 1 bits
	add esi, 1				; move forawrd to the 4 bytes of the next link address
	jmp counting_1_loop			; looping again
end_of_counting_1_loop:
	sub esi, 1				; go to the begining of the last link
	mov ecx, esi				; ecx point to the last link
	free_link ecx				; free the last link
	ecx_point_to_current_operand_stack	; increment number of operations by 1 for the end of the program
	add ecx, 4   				; assign to ecx the address of the first link
	add dword [number_of_operands], 4	; add 4 bytes to number_of_operands
	inc dword [operations_counter]		; increment number of operations by 1 for the end of the program
	cmp byte [debug_mode], 0		; checking if the program running on debug mode
	jz get_input_user			; if not - loop again to get next input
	jmp debug_mode_print			; if so - print the added operand to the screen

empty_error:					; this label is for print an error about no enough arguments to do some function 
	push empty_stack
	call printf
	add esp, 4
	inc dword [operations_counter]
	jmp get_input_user

overflow_error:					; this label is for print an error about stack overflow - we can't add more operands to stack
	inc dword [operations_counter]
overflow_error_to_number:
	push stack_overflow
	call printf
	add esp, 4
	jmp get_input_user			; looping again for another input

Y_bigger_than_200:				; this label is for print an error about invalid value of Y in pos_power and neg_power
	push wrong_Y_value			
	call printf
	add esp, 4
	inc dword [operations_counter]
	jmp get_input_user

end_of_program:					; this label is dealing with clean all linked list that inside the operand stack
	ecx_point_to_current_operand_stack	; refresh ecx position to current position in operand stack
	sub ecx, operand_stack			; check how much operands do we have on operand stack
	cmp ecx, 0				; check if there are no operands
	jz finish				; if so - we can finish the program gracefully
	xor eax, eax				; reset eax for clean using
	xor ecx, ecx				; reset ecx for clean using
	xor edx, edx				; reset edx for clean using
	ecx_point_to_current_operand_stack	; refresh ecx position to current position in operand stack
	sub ecx, 4				; mov ecx to point on the top operand in the stack
	mov eax, [ecx]				; assign eax to point on the linked list
	mov edx, eax				; assign edx to point on the linked list
	add eax, 1				; move forward to the 4 other bytes of the linked list
release_linked_lists:				; this label is responsible to release all links
	cmp dword [eax], 0			; check if this is the last link
	jz release_last_link			; if so - we need to free this link and we finish
	mov eax, [eax]				; move to the next link
	free_link edx				; free the prev link
	mov edx, eax				; assign edx to point to the next link
	add eax, 1				; move forawrd to the other 4 bytes of the link
	jmp release_linked_lists		; looping again till we release all links in the linked list
release_last_link:					
	sub eax, 1				; mov to the begining of the link
	free_link eax				; free the link
	sub dword [number_of_operands], 4	; sub the operands by 4 bytes
	jmp end_of_program			; going to end the program....

finish:
	xor eax, eax				; reset eax for clean using
 	mov dword eax, [operations_counter]	; printing the total number of operations
	mov esp, ebp				; mov esp to the begining of the stack
	pop ebp					; pop return address from calling
	ret					; return from calling function

