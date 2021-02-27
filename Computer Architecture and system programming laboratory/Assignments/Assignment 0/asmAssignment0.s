section .data                    	; we define (global) initialized variables in .data section
        an: dd 0              		; an is a local variable of size double-word, we use it to count the string characters

section .text                    	; we write code in .text section
        global do_Str          		; 'global' directive causes the function do_Str(...) to appear in global scope
        extern printf            	; 'extern' directive tells linker that printf(...) function is defined elsewhere
 					; (i.e. external to this file)

do_Str:                        		; do_Str function definition - functions are defined as labels
        push ebp              		; save Base Pointer (bp) original value
        mov ebp, esp         		; use Base Pointer to access stack contents (do_Str(...) activation frame)
        pushad                   	; push all signficant registers onto stack (backup registers values)
        mov ecx, dword [ebp+8]		; get function argument on stack
					; now ecx register points to the input string
	mov dword [an], 0		; initialize an variable with 0 value
	loop_again:                     ; use label to build a loop for treating the input string characters
                cmp byte [ecx], 'a'
                je char_is_a
                jnz non_a
                char_is_a:
                        mov byte [ecx], 'A'
                        jmp non_increment
                non_a:
                	cmp byte [ecx], 'B'
                        je char_is_b
                        jnz non_a_b
                char_is_b:
                        mov byte [ecx], 'b'
                        jmp non_increment
                non_a_b:
                        cmp byte [ecx], 32
                        je incrementing
                        cmp byte [ecx], 9
                        je incrementing
                        cmp byte [ecx], 10
                        je incrementing
                        jmp non_increment
                incrementing:
                        inc byte [an]
                non_increment:
                        inc ecx    	    	; increment ecx value; now ecx points to the next character of the string
                        cmp byte [ecx], 0   	; check if the next character (character = byte) is zero (i.e. null string termination)
                        jnz loop_again      	; if not, keep looping until meet null termination character

        popad                    	; restore all previously used registers
        mov eax,[an]         		; return an (returned values are in eax)
        mov esp, ebp			; free function activation frame
        pop ebp				; restore Base Pointer previous value (to returnt to the activation frame of main(...))
        ret				; returns from do_Str(...) function
