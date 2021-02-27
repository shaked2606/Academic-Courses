section	.rodata			                        ; we define (global) read-only variables in .rodata section
	format_string: db "%s", 10, 0	            ; format string

section .bss			                        ; we define (global) uninitialized variables in .bss section
	an: resb 12		                            ; enough to store integer in [-2,147,483,648 (-2^31) : 2,147,483,647 (2^31-1)]
	temp_an: resb 12			                ; temporary array for storing reversed string
	powers: resd 32       		            	; define array of powers of 2
section .text
	global convertor
	extern printf

convertor:
	push ebp
	mov ebp, esp	
	pushad			

	mov ecx, dword [ebp+8]	; get function argument (pointer to string)

	mov eax, 1                      	        ; value of powers of 2
	xor esi, esi                    	  		; reset register esi for using as counter in iteration
	mov ebx, powers                   	 		; ebx pointing to the begin of powers array

	powers_loop:                    			; build array of powers of 2
		cmp esi, 32             	  			; finish to assign all powers of 2 (up to 2^31-1)
		jz end_of_powers_loop    	  			; if so - jumping outside loop
		mov [ebx], eax           	  			; assign powers^esi(in eax) to [ebx](pointing on powers)
		add ebx, 4		          				; increment ebx address by 4 bytes (next cell from powers array)
		inc esi                 	  			; increment counter register
		shl eax, 1               	  			; multiplicating the number in 2 by shift 1 byte left (push 0 from right side)
		jmp powers_loop          	  			; iterating the loop again

						 						; now we have full powers array of 2 named powers
	end_of_powers_loop:     
		xor eax,eax                       		; reset the register eax for re-use
		xor esi,esi			  					; reset the counter esi for re-use
		xor edi, edi                      		; reset the counter edi, used as a character counter of the input-string
	    mov ebx, powers                   		; ebx pointing again to begining of powers array (now it's full array of powers)

	loop_till_end_string:                 	  	; iterating to reach the end of string
		cmp byte [ecx], 10                		; we got to '\n' - end of string
		jz end_loop_of_string   	  			; if so - we get outside the loop
		inc ecx                    	  			; if not - increment ecx
		inc edi	  			 					; counts number of characters not include '\n' '\0'
		jmp loop_till_end_string          		; jump again to loop start

						 						; ecx pointing now to \n of the input-string, so we want to get back to the prev character
	end_loop_of_string:                     
		dec ecx				  					; we decrease ecx for pointing to the last char
		cmp edi,32	                  			; checking if the length of the input-string is 32 bit
		je read_full_string_loop          		; if so - we need to take care of negative numbers

			 									; if we got here so for sure the number is positive - we just need to sum all the '1's
	read_loop:				 
		cmp esi, edi             	  			; checking if we iterate all charcters
		je end_of_read_loop	  	  				; if so - we finish to sum all characters and we get out from loop
		cmp byte [ecx], 49    		  			; checking if the char is '1' 
		jnz case_0			  					; if not (the char is '0') we do nothing (just increasing counter and decrease ecx for the next char)
		add eax, [ebx+esi*4]        	 		; sum the power^esi (ebx pointing on powers array) to eax register
		
	case_0:
		dec ecx               		  			; decrease ecx
		inc esi               		  			; increase counter
		jmp read_loop         		  			; continue iterating

												; if we got here we're handling case of full-string with 32 bits (number can be either positive or negative):	
	read_full_string_loop:                    	
		cmp esi, 32                      	 	; if we get to the MSB
		jz handle_msb			  				; handling sign of number in handle_msb label
		cmp byte [ecx], 49    		  			; if the char is '1' 
		jnz full_string_case_0		  			; if not (the char is '0') we do nothing (just increasing counter and decrease ecx for the next char)
		add eax,dword [ebx+esi*4]         		; sum the power^esi (ebx pointing on powers array) to eax register
		
	full_string_case_0:                        	; this label handles increasing iteration of full-string with 32 bits
	dec ecx               		   				; decrease ecx
		inc esi               		   			; increase counter
		jmp read_full_string_loop          		; continue iterating

												; handle_msb label handles a case of when we get to MSB bit
	handle_msb:
		inc ecx									; increase ecx for pointing on MSB bit
		cmp byte [ecx], 49    		  			; if the char is '1' 
		jnz end_of_read_loop		  			; if not - we do nothing, the number is positive
		neg eax				  					; if so - we do 2 complement to the number
		mov ecx, temp_an	          			; ecx pointing to the start of temp_an
		mov byte [ecx], 45                		; because it's negative number we need to add the '-' charcter to temp_an string
		inc ecx				  					; increase ecx to the next cell in temp_an
		jmp division           					; jumping to the label of convert from int to string

												; if the number is positive - we just need to point to the start of ecx
	end_of_read_loop:   
		xor ebx, ebx			  				; reset the register ebx for re-use
		mov ecx, temp_an                  		; pointing to the start of temp_an array

												; notice that now if the original number is negative - there's in temp_an '-' char at the begining of the string
												; notice that now we have the decimal number in eax, so we use division for convert from int to string
	division:                 		
		mov ebx, 10                       		; assign in ebx the number 10 for division
	reminder:                                 	; this is the label of reset the reminder and divide again
	xor edx, edx                      			; reset the register edx for re-use
		div ebx                           		; divide by ebx(10) and store the division in eax
		add edx, 48			  					; convert content of edx to string by adding '0'
		mov [ecx], edx                    		; assign the reminder in the next cell at temp_an array
		inc ecx                           		; increment ecx to the next cell of an
		cmp eax, 0                        		; checking if eax is still positive number (so we can divide more)
		jnz reminder                      		; if so - go to label reminder and devide again

												; now we have reversed-string in temp_an, and we need to do swap between characters to get the wanted-output-string (mov to an)
						  						; first we want to count the length of the temp_an string

	xor edi, edi				  				; reset counter for store the final length
	xor esi, esi				  				; reset counter for iterate temp_an cells

	count_length:			          			; label of counting length of temp_an
		cmp byte [temp_an+esi], 0 	  			; checking if we got to null terminated char
		jz end_of_count_length		  			; if so - end of loop
		inc edi			          				; if not - we need to iterate again and increase the counter length
		inc esi				  					; mov to the next cell
		jmp count_length		  				; looping again

												; now edi stores the length+1 of the string (including '-' in case of negative number)
	end_of_count_length:			  
		dec edi				  					; decrement edi for represent the length of the string
		xor esi, esi			  				; reset counter esi for iterating
		cmp byte [temp_an], 45	          		; checking if the first character in temp_an is '-'
		jnz reverse_positive_number       		; if not - the number is positive and we jump to label of reverse string
		mov byte [an], 45		  				; push '-' to the first cell of an because it's negative number
		inc esi				  					; increment esi for iterating from the second cell (after '-')										

												; this label reverse string:
	reverse_positive_number:		  			
		xor eax, eax			  				; reset eax for using in loop
		cmp edi, 0			  					; checking if we got to the end of string length
		jz end_of_reverse_string	  			; if so - stop looping
		mov al, [temp_an+edi]		  			; assign to al cell from temp_an (al connects between content in temp_an and an arrays)
		mov [an+esi], al		  				; mov the content to an
		inc esi				  					; increment esi for the next cell in an
		dec edi				  					; decrement edi for pointing the prev cell in temp_an
		jmp reverse_positive_number	  			; looping again

						  						; now we have in an the reversed string like we want to, we can print an
	end_of_reverse_string:
		cmp byte [an], 45		  				; checking if the number is negative, if so we do nothing except printing an
		jz print_string			  
		mov al, [temp_an]		  				; if not - we need to assign first cell (decimal digit and not '-') from temp_an to an by moving the content to al
		mov [an+esi], al		  				; assign the content to an from al

	print_string:
	push an										; call printf with 2 arguments -  
	push format_string							; pointer to str and pointer to format string
	call printf
	
												; reset an for re-use:
	xor edi, edi			  					; reset edi counter for being a counter
	reset_array:			  					
		cmp edi, 11			  					; checking if we got to the end of number
		jz end_of_program		  				; if so - end program
		mov dword [an+edi], 0	      	  		; if not over iterate - reset cell of an
		inc edi				  					; increment counter to the next cell
		jmp reset_array			  				; looping again

	end_of_program:
		add esp, 8								; clean up stack after call
		popad			
		mov esp, ebp	
		pop ebp
		ret
