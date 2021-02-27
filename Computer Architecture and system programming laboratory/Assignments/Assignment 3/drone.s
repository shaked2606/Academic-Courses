section .rodata
	winning_string: db "Drone id %d: I am a winner", 10, 0
section .data
	delta_angle: dt 0.0
	delta_distance: dt 0.0
	RANGE_OF_DELTA_ANGLE: dd 120
	RANGE_OF_DELTA_DISTANCE: dd 50

	neg_delta_angle: dd -60

	range_of_distance: dd 100

	x_coordinate: dt 0.0
	y_coordinate: dt 0.0
	angle: dt 0.0
	score: dd 0

	gamma: dt 0.0

	FUNC_OFFSET:equ 0			; function field position

	STK_OFFSET: equ 4			; stack pointer field position
		
	X_OFFSET: equ 8				; x coordinate field poisition
	
	Y_OFFSET: equ 18			; y coordinate field poisition

	ANGLE_OFFSET: equ 28			; angle field poisition

	SCORE_OFFSET: equ 38			; score of drone field poisition

section .bss
section .text
	align 16
	global drone
	extern printf
	extern resume
	extern create_random_number
	extern degree_to_radian
	extern COR_scheduler
	extern COR_drones
	extern COR_target
	extern MAX_INTEGER_VALUE
	extern target_x_coordinate
	extern target_y_coordinate
	extern angle_of_drone
	extern max_distance_destroy
	extern winner

	extern number_of_targets
	extern seed

	extern id

; this macro is responsible for create random number with the right scailing, and save it in the right variable
%macro random_number 2
	call create_random_number	; call create_random_number
	fild dword [seed]		; load new seed value to stack
	call %1				; call scailing function
	fstp tword [%2]			; store in  variable the scale value that was generated
%endmacro

drone:
	fld tword [edi+X_OFFSET]				; load from struct the current x coordinate of drone
	fstp tword [x_coordinate]				; store the value in local variable

	fld tword [edi+Y_OFFSET]				; load from struct the current y coordinate of drone
	fstp tword [y_coordinate]				; store the value in local variable

	fld tword [edi+ANGLE_OFFSET]				; load from struct the current angle of drone
	fstp tword [angle]					; store the value in local variable

	mov dword ecx, [edi+SCORE_OFFSET]			; load from struct the score of drone
	mov dword [score], ecx					; store the value in local variable

movement_of_drone:						; generate new delta_angle and new_distance for movement of the drone
randomize_delta_angle:						
	random_number scale_delta_angle, delta_angle		; create new delta angle
randomize_delta_distance:
	random_number scale_delta_distance, delta_distance	; create new delta distance


calculate_new_angle:						; calculate alpha + delta_alpha
	fldpi							; load pi to stack
	fldpi							; load pi to stack
	faddp							; add 2pi as a range of radians (2pi = 360)
	fld tword [angle]					; load current angle
	fld tword [delta_angle]					; load delta angle
	fadd							; angle + delta_angle
modulu_angle:							; we
	fprem							; (angle + delta_angle) % 2pi	
	fstp tword [angle]					; save the result in angle variable
	fstp st0						; popping the range of angle (2pi) for clean stack
check_if_angle_is_negative:					; checking if the angle is negative
	fld tword [angle]					; load angle
	fldz							; load zero
	fcomi st0, st1						; compare between angle to zero
	jc valid_new_angle					; if angle > zero so angle is positive and valid
	fcomi st0, st1						; compare again between angle to zero
	jz valid_new_angle					; if angle == zero so angle is non-negative and valid
angle_is_negative:						; if we got here so angle is negative and we want to add 360 degrees to the angle
	faddp							; add between angle and zero for popping the zero from stack
	fldpi							; add pi for adding 2pi to negative angle
	fldpi							; add pi for adding 2pi to negative angle
	faddp							; pi+pi = 2pi - now in stack
	faddp							; add angle +2pi	
	fstp tword [angle]					; save the result in angle
	jmp calculate_new_distance
valid_new_angle:						; if we got here so the angle is non-negative, so we need to pop all things we push into stack
	faddp							; angle + zero
	fstp tword [angle]					; save result in angle

calculate_new_distance:					; calculate distance + delta_distance:
	fld tword [angle]				; load updated angle
	fsincos						; calculating sin(angle) in st0, cos(angle) in st1
	fld tword [delta_distance]			; load delta_distance [0,50] randomized
	fmul st1, st0 					; delta_distance * sin(angle)
	fmulp st2, st0 					; delta_distance * cos(angle)
	fld tword [x_coordinate]			; load x_coordinate
	faddp	 					; add delta_distance to y_coordinate
	fld tword [y_coordinate]			; load y_coordinate
	faddp st2, st0
	
	fstp tword [x_coordinate]			; store in x_coordinate
	fstp tword [y_coordinate]			; store in y_coordinate
	fild dword [range_of_distance]
	fld tword [x_coordinate]
module_x_coordinate:
	fprem						; calcultaing torus
	fstp tword [x_coordinate]			; store in x_coordinate
	fld tword [y_coordinate]
module_y_coordinate:
	fprem						; calcultaing torus
	fstp tword [y_coordinate]			; store in y_coordinate
	fstp st0					; popping the range of distance

check_if_x_coordinate_is_negative:
	fld tword [x_coordinate]
	fldz
	fcomi st0, st1
	jc pop_x_coordinate
	fcomi st0, st1
	jz pop_x_coordinate
	faddp
	fild dword [range_of_distance]
	faddp
	fstp tword [x_coordinate]
	jmp check_if_y_coordinate_is_negative
pop_x_coordinate:
	faddp
	fstp tword [x_coordinate]
check_if_y_coordinate_is_negative:
	fld tword [y_coordinate]
	fldz
	fcomi st0, st1
	jc valid_new_distance
	fcomi st0, st1
	jz valid_new_distance
	faddp
	fild dword [range_of_distance]
	faddp
	fstp tword [y_coordinate]
	jmp check_if_drone_can_destroy
valid_new_distance:
	faddp
	fstp tword [y_coordinate]

check_if_drone_can_destroy:
	call mayDestroy					; checks if drone, after movement, may destroy the target

	cmp eax, 0					; if not - save the movement and resume to scheduler
	jz resume_to_scheduler				
	mov eax, [number_of_targets]			; store in eax number_of_targets to destroy
	cmp dword [score], eax				; check if drone destroy enough targets to win
	jl resume_to_target_co_routine			; if less - didn't win yet
	add dword [id], 1
	push dword [id]					
	push winning_string			; if so - the drone is the winner, so we print winning string
	call printf			
	add esp, 8
	sub dword [id], 1
	mov dword [winner], 1					; change to winner mode
	mov ebx, COR_scheduler				
	call resume
resume_to_target_co_routine:				; we need to generate new target
	call update_field_in_drones_array_struct	; update fields
	mov ebx, COR_target				; mov ebx to point on COR_target
	call resume					; activate target
	jmp drone
resume_to_scheduler:					; jmp to scheduler
	call update_field_in_drones_array_struct	; update fields
	mov ebx, COR_scheduler				; mov ebx to point on COR_scheduler
	call resume					; activate scheduler
	jmp drone					; after we back to this drone we want to start from the beginning of the code of drone function


mayDestroy:
	push ebp
	mov ebp, esp

; (y2-y1)
	fld tword [target_y_coordinate]
	fld tword [y_coordinate]
	fsub

; (x2-x1)
	fld tword [target_x_coordinate]
	fld tword [x_coordinate]
	fsub

; gamma = arctan(y2-y1,x2-x1)
	fpatan						; arctan operation
	fstp tword [gamma]				; store in gamma variable the result of arctan(y2-y1, x2-x1)
	fld tword [gamma]
	fld tword [angle]				; load current angle
	fcomi st0, st1					; compare between angles
	jc gamma_greater_than_angle			; if carry flag is on, so angle <= gamma
	fcomi st0, st1					; compare again
	jz gamma_angle_valid				; if zero flag is on, so angle == gamma
angle_greater_than_gamma:				; if carray flag is off, so gamma <= angle
	fldpi
	faddp st2, st0
	fcomi st0, st1
	jc gamma_angle_valid
	fcomi st0, st1
	jz gamma_angle_valid
add_2pi_to_gamma:
	fldpi
	faddp st2
	fstp tword [angle]
	fstp tword [gamma]
	jmp abs_operation
gamma_greater_than_angle:
	fldpi
	fadd
	fcomi st0, st1
	jnc gamma_angle_valid
	fcomi st0, st1
	jz gamma_angle_valid
add_2pi_to_angle:
	fldpi
	faddp st1
	fstp tword [angle]
	fstp tword [gamma]
	jmp abs_operation
gamma_angle_valid:
	fstp st0					
	fstp st0	
			
abs_operation:
	; abs(angle-gamma)
	fld dword [angle_of_drone]
	fld tword [degree_to_radian]
	fmul
	fld tword [angle]
	fld tword [gamma]
	fsub
	fabs
checks_if_beta_bigger_than_abs:
	fcomi st0, st1
	jnc cant_destroy
condition_1_ok:
	; checking condition2:
	fstp st0
	fstp st0
	fld dword [max_distance_destroy]
	; (y2-y1)^2
	fld tword [target_y_coordinate]
	fld tword [y_coordinate]
	fsub
	fld tword [target_y_coordinate]
	fld tword [y_coordinate]
	fsub
	fmul

	; (x2-x1)^2
	fld tword [target_x_coordinate]
	fld tword [x_coordinate]
	fsub
	fld tword [target_x_coordinate]
	fld tword [x_coordinate]
	fsub
	fmul
	; (y2-y1)^2+(x2-x1)^2
	fadd
	; sqrt((y2-y1)^2+(x2-x1)^2)
	fsqrt
checks_if_distance_bigger_than_sqrt:
	fcomi st0, st1
	jnc cant_destroy
	mov eax, 1
	add dword [score], 1 				; if destroy the target - add one to the score of the drone
	fstp st0
	fstp st0
	jmp finish_may_destroy
cant_destroy:
	fstp st0
	fstp st0
	mov eax, 0	
finish_may_destroy:
	mov esp, ebp
	pop ebp
	ret


; we want to update the fields of the drone in the struct
update_field_in_drones_array_struct:
	push ebp
	mov ebp, esp

	fld tword [x_coordinate]
	fstp tword [edi+X_OFFSET]

	fld tword [y_coordinate]
	fstp tword [edi+Y_OFFSET]

	fld tword [angle]
	fstp tword [edi+ANGLE_OFFSET]

	mov dword eax, [score]
	mov dword [edi+SCORE_OFFSET], eax

	mov esp, ebp
	pop ebp
	ret


; input: assume seed in top of float-stack
; output: assume result in top of float-stack
scale_delta_angle:
	push ebp
	mov ebp, esp

	fild dword [RANGE_OF_DELTA_ANGLE]
	fild dword [MAX_INTEGER_VALUE]
	fdiv
	fmul
	fild dword [neg_delta_angle]
	fadd
	fld tword [degree_to_radian]
	fmul

	mov esp, ebp
	pop ebp
	ret

; input: assume seed in top of float-stack
; output: assume result in top of float-stack
scale_delta_distance:
	push ebp
	mov ebp, esp

	fild dword [RANGE_OF_DELTA_DISTANCE]
	fild dword [MAX_INTEGER_VALUE]
	fdiv
	fmul

	mov esp, ebp
	pop ebp
	ret

