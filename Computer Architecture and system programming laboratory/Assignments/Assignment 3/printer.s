section .rodata
	current_target_coordinate_s: db "%.2f,%.2f", 10, 0
	drone_print_line: db "%d,%.2f,%.2f,%.2f,%d", 10, 0
section .data
	counter: dd 0

	STK_OFFSET: equ 4			; stack pointer field position
		
	X_OFFSET: equ 8				; x coordinate field poisition
	
	Y_OFFSET: equ 18			; y coordinate field poisition

	ANGLE_OFFSET: equ 28			; angle field poisition

	SCORE_OFFSET: equ 38			; score of drone field poisition
section .bss
section .text
align 16
	global printer
	extern printf
	extern degree_to_radian
	extern COR_scheduler
	extern COR_drones
	extern target_x_coordinate
	extern target_y_coordinate
	extern number_of_drones
	extern resume

printer:
	finit						; reset x87 stack
	fld tword [target_y_coordinate]			; load target_y_coordinate
	sub esp, 8					; save space for double in stack
	fstp qword [esp]				; store double in stack

	fld tword [target_x_coordinate]			; load target_y_coordinate
	sub esp, 8					; save space for double in stack
	fstp qword [esp]				; store double in stack

	push current_target_coordinate_s		; push format
	call printf					; call printf
	add esp, 20					; delete from stack

	; print each drone's data:
	mov edi, [COR_drones]				; edi is pointing to array of drones
	mov dword ebx, 1					; reset ebx for clean using
print_drones_loop:
	cmp ebx, [number_of_drones]			; check if we print all drones
	jg end_of_print_drones_loop			; if so - finish looping
; print drone's data:
	push dword [edi+SCORE_OFFSET]			; push score of drone

	fld tword [edi+ANGLE_OFFSET]			; load angle of drone
	sub esp, 8					; save space for double in stack
	call scale_angle_for_print			; convert from radian to degrees
	fstp qword [esp]				; store in stack
		
	fld tword [edi+Y_OFFSET]			; load y coordinate of drone
	sub esp, 8					; save space for double in stack
	fstp qword [esp]				; store in stack
	
	fld tword [edi+X_OFFSET]			; load x coordinate of drone
	sub esp, 8					; save space for double in stack
	fstp qword [esp]				; store in stack

	push dword ebx					; push id of drone
	push drone_print_line				; push format
	call printf					; call printf
	add esp, 36					; delete from stack
	add edi, 42					; move to the next drone
	add ebx, 1					; inc counter by one
	jmp print_drones_loop				; looping again
end_of_print_drones_loop:				; we end printing all values
	mov ebx, COR_scheduler				; store in ebx poiner to scheduler co-routine
	call resume					; call resume for resuming scheduler
	jmp printer					; after back here we want to start from the beginning of the code

; assume current angle was loaded
scale_angle_for_print:
	push ebp
	mov ebp, esp

	fld tword [degree_to_radian]			; load number of converting between degree to radian
	fdiv						; divide the value in this number for getting the angle in degrees and not in radian

	mov esp, ebp
	pop ebp
	ret
