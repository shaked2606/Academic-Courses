section .rodata
section .data
section .bss
section .text
align 16
	global target
	extern resume
	extern create_random_number
	extern scale_distance
	extern target_x_coordinate
	extern target_y_coordinate
	extern seed
	extern COR_scheduler

; this macro is responsible for create random number with the right scailing, and save it in the right variable
%macro random_number 2
	call create_random_number	; call create_random_number
	fild dword [seed]		; load new seed value to stack
	call %1				; call scailing function
	fstp tword [%2]			; store in  variable the scale value that was generated
%endmacro



target:
	call createTarget
	mov ebx, COR_scheduler
	call resume
	jmp target

createTarget:
	push ebp
	mov ebp, esp
	random_number scale_distance, target_x_coordinate
	random_number scale_distance, target_y_coordinate
	mov esp, ebp
	pop ebp
	ret
