section .rodata
section .data
	i: dd 0
	global winner
	winner: dd 0
	global id
	id: dd 0				; id of drone field, global field that uses for drone knowing who is he
section .bss
section .text
align 16
	global scheduler
	extern resume
	extern endCo
	extern steps_for_print
	extern number_of_drones
	extern COR_drones
	extern COR_scheduler
	extern COR_printer
	extern CURR

scheduler:
	mov dword eax, 1			; eax uses for counting number_of_drones we loop on
	mov dword ecx, 0			; ecx uses for calculating the id of the drone
	mov edx, [steps_for_print]
scheduler_loop:
	cmp eax, [number_of_drones]		; checks if eax equl to number_of_drones
	jle same_round				; if less or equal - we continue in the same round robin
	mov dword eax, 1			; if not - start again round robin, reset eax to be 1
	mov dword ecx, 0			; if not - start again round robin, reset ecx to be 0
same_round:
	push edx				; recover steps for print
	push eax				; save eax, because we want to do an multiplication function
	mov eax, 42				; mov size of drone data struct to eax
	mov ebx, ecx				; mov id to ebx
	mul ebx					; calculating the position in the array of data drones
	mov ebx, eax				; save the result in ebx
	pop eax					; restore eax from before the multiplication
	add dword ebx, [COR_drones]		; add to ebx the address of the start of COR_drones array
	mov dword [id], ecx			; store in global variable id the id of the drone we want to act now
	call resume				; call resume for drone to be activate
	cmp dword [winner], 1			
	jz endCo
	inc eax					; increment by 1 the number_of_drones we loop on
	inc ecx					; inceremnt to the next id of drone
	inc dword [i]				; increment steps
	pop edx					; pop value of steps_of_print
	cmp dword [i], edx			; checks if the number is equal to K (steps_of_print)
	jnz scheduler_loop			; if not - loop again regulary
	mov ebx, COR_printer			; if so - we want to activate printer co-routine for printing the status of the game board
	call resume				; call resume for activate printer co-routine
	mov dword [i], 0			; reset i, for counting steps from the beginning
	jmp scheduler_loop			; loop again the scheduler
