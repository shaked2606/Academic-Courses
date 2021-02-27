section .rodata
	format_integer: db "%d", 0
	format_integer_p: db "%d", 10 ,0
	format_float: db "%f", 0
section .data
; constants:	
	FUNC_OFFSET:equ 0			; function field position

	STK_OFFSET: equ 4			; stack pointer field position
		
	X_OFFSET: equ 8				; x coordinate field poisition
	
	Y_OFFSET: equ 18			; y coordinate field poisition

	ANGLE_OFFSET: equ 28			; angle field poisition

	SCORE_OFFSET: equ 38			; score of drone field poisition

	STK_size: equ 16*1024			; 16Kb for stack for each coroutine

	global MAX_INTEGER_VALUE
	MAX_INTEGER_VALUE: dd 65535		; max integer value for 16 bits of LFSR

	ANGLE_MAX_SIZE: dd 360			; range of angle value is [0,360]

	DISTANCE_MAX_SIZE: dd 100		; range of distnace value is [0,100]

	LFSR_counter: dd 0			; counting 16 times of doing LFSR for generating new random number
	
; input variables:

	global number_of_drones
	number_of_drones: dd 0			; stores N input

	global number_of_targets
	number_of_targets: dd 0			; stores T input

	global steps_for_print
	steps_for_print: dd 0			; stores K input

	global angle_of_drone
	angle_of_drone: dt 0.0			; stores beta input

	global max_distance_destroy
	max_distance_destroy: dt 0.0		; stores d input

	global seed
	seed: dw 0				; stores seed input

; data structer for co-routines and drones data:

	global CORS
	CORS: 					; array of the 3 co-rs + array of N pointers to drone's data
		dd COR_target
		dd COR_scheduler
		dd COR_printer
		dd COR_drones

	global COR_target
	COR_target:
		dd target			; pointer to co-r function
		dd STK_target+STK_size		; pointer to the beginning of co-r stack

	global COR_scheduler
	COR_scheduler:
		dd scheduler			; pointer to co-r function
		dd STK_scheduler+STK_size	; pointer to the beginning of co-r stack

	global COR_printer
	COR_printer:
		dd printer			; pointer to co-r function
		dd STK_printer+STK_size		; pointer to the beginning of co-r stack

	global COR_drones
	COR_drones:
		dd 0				; pointer to array of N pointers to drones data

; define floating point variables:
	global target_x_coordinate
	target_x_coordinate: dt 0.0
	global target_y_coordinate
	target_y_coordinate: dt 0.0 
	global degree_to_radian			
	degree_to_radian: dt 0.01745329252	; degree*degree_to_radian = radian

section .bss
	STK_target: resb STK_size		; variable stores pointer to stack of target co-routine
	STK_scheduler: resb STK_size		; variable stores pointer to stack of scheduler co-routine
	STK_printer: resb STK_size		; variable stores pointer to stack of printer co-routine
	global SPT
	SPT: resd 1				; termporary stack pointer
	global SPMAIN
	SPMAIN: resd 1				; stack pointer of main
	global CURR
	CURR: resd 1				; points to the struct of the current co-routine

section .text
	align 16
	global main
	global resume
	global scale_angle
	global scale_distance
	global create_random_number
	global endCo
	extern scheduler
	extern printer
	extern target
	extern drone
	extern sscanf
	extern calloc
	extern free
     
; macro for converting string input to integer value
%macro string_to_integer 3				
	lea dword eax, [%1]
	push eax
	push %3
	push dword [%2]
	call sscanf
	add esp, 12
%endmacro

; this macro is responsible for create random number with the right scailing, and save it in the right variable
%macro random_number 2
	call create_random_number	; call create_random_number
	fild dword [seed]		; load new seed value to stack
	call %1				; call scailing function
	fstp tword [%2]			; store in  variable the scale value that was generated
%endmacro

main:
	mov ebp, esp			    	; storing the begining of the stack in ebp
	xor ebx, ebx				; reset ebx for clean using
	; get the input from command line:

	mov ebx, [ebp+8]			; ebx point to the begin address of argv
	string_to_integer number_of_drones, ebx+4, format_integer
	string_to_integer number_of_targets, ebx+8, format_integer
	string_to_integer steps_for_print, ebx+12, format_integer
	string_to_integer angle_of_drone, ebx+16, format_float
	string_to_integer max_distance_destroy, ebx+20, format_float
	string_to_integer seed, ebx+24, format_integer

	; convert seed from dword to word
	xor ebx, ebx
	mov bx, word [seed]
	mov dword [seed], 0
	mov word [seed], bx

	; now all input is stored in local variable

	; init 3 co-routines with initco:
	push dword COR_target
	call initCo_helper_cors
	add esp, 4
	push dword COR_scheduler
	call initCo_helper_cors
	add esp, 4
	push dword COR_printer
	call initCo_helper_cors
	add esp, 4

	; now we want to initiailize the coordinates of the first target:
init_target:
	call create_random_number
	fild dword [seed]
	call scale_distance
	fstp tword [target_x_coordinate]

	random_number scale_distance, target_y_coordinate

	; now we want to allocate memory for the co-routines of drones (N drones):
init_cors_of_drones:
	mov eax, 42
	mov ebx, [number_of_drones]
	push eax						; push eax (size of each drone) to stack for calloc
	push ebx						; push ebx (number of drones) to stack for calloc
	call calloc						; calling malloc for creating array of N co-routines
	add esp, 8
	mov dword [COR_drones], eax
	mov edi, eax						; edi pointing to beginning of the array of co-routines
init_cors_of_drones_loop:
	cmp ebx, 0					
	jz startCo
	push ebx						; counter of number of drones
	mov edx, STK_size
	push dword edx
	mov dword ecx, 1
	push dword ecx
	call calloc
	add esp, 8
	mov dword [edi], drone					; save function drone
	mov [edi+STK_OFFSET], eax
	add dword [edi+STK_OFFSET], STK_size			; save stack pointer of drone

	random_number scale_distance, edi+X_OFFSET 		; save x coordinate of drone
	random_number scale_distance, edi+Y_OFFSET		; save y coordinate of drone	
	random_number scale_angle, edi+ANGLE_OFFSET		; save angle of drone
	mov dword [edi+SCORE_OFFSET], 0				; save reset score of drone

	call initCo
next_drone:
	add edi, 42				; jumping to the next drone by 42 byets
	pop ebx					; recover the original number of drones after all the randomization
	dec ebx					; decrement number of drones
	jmp init_cors_of_drones_loop		; loop again for init next drone

; init co-routine of drone
initCo:
	push ebp
	mov ebp, esp
	mov ebx, edi
	mov eax, [ebx+FUNC_OFFSET]		; get initial EIP value - pointer to COi function
	mov [SPT], esp				; save esp value
	mov esp, [ebx+STK_OFFSET]		; get initial esp value - pointer to COi stack
	push eax				; push initial "return" address	
	pushfd					; push flags
	pushad					; push all other registers
	mov [ebx+STK_OFFSET], esp		; save new SPi value (after all the pushes)
	mov esp, [SPT]				; restore esp value
	mov esp, ebp
	pop ebp
	ret					; return to the init_cors

; init co-routine of scheduler, target and printer
initCo_helper_cors:
	push ebp
	mov ebp, esp
	mov ebx, [ebp+8]			; stores in ebx pointer to the beginning of the struct
	mov eax, [ebx+FUNC_OFFSET]		; get initial EIP value - pointer to COi function
	mov [SPT], esp				; save esp value
	mov esp, [ebx+STK_OFFSET]		; get initial esp value - pointer to COi stack
	push eax				; push initial "return" address
	pushfd					; push flags
	pushad					; push all other registers
	mov [ebx+STK_OFFSET], esp		; save new SPi value (after all the pushes)
	mov esp, [SPT]				; restore esp value
	mov esp, ebp
	pop ebp
	ret

; after all init of all cors, we can start the scheduling by startCo
startCo:
	pushad					; save registers of main()
	mov [SPMAIN], esp			; save ESP of main()
	mov ebx, COR_scheduler			; gets a pointer to a scheduler struct
	jmp do_resume				; resume a scheduler co-routine

; we back here after one of the drone destroy at least T targets, and he won
endCo:
	mov esp, [SPMAIN]			; back to stack of main
	popad					; recover all the registers
	
free_allocated_memory:
	mov ebx, 0
	mov dword edi, [COR_drones]
free_loop:					; free allocated memory of stack pointers of drones
	cmp ebx, [number_of_drones]
	jz exit
	mov eax, [edi+STK_OFFSET]
	add eax, 40
	sub eax, STK_size
	push dword eax
	call free
	add esp, 4
	add edi, 42
	inc ebx
	jmp free_loop
exit:
	push dword [COR_drones]
	call free				; free allocated memory of array of data of drones
	add esp, 4				
	mov eax, 1			    	; call exit system-call for finish program
	mov ebx, 0			    	; call exit system-call for finish program
	int 0x80                            	; call exit system-call for finish program


; function for generate new random_number, last number is stored in seed

create_random_number:
	push ebp
	mov ebp, esp
	xor ebx, ebx				; reset ebx
	xor eax, eax
	xor ecx, ecx				; reset ecx
	xor edx, edx				; reset edx
	mov dword [LFSR_counter], 0		; reset counter
LFSR_loop:
	cmp dword [LFSR_counter], 16		; checks if we did 16 times the LFSR
	jz end_of_LFSR_loop			; if so, end loop
	mov bx, word [seed]			; store seed value in bx
	mov word ax, bx				; store temproraly in ax the value in bx
	mov dl, 1				; mov to dl the value of 1
	and dl, al				; do and with al for know the lsb
	add cl, dl				; add to cl the digit

	; now we take the 16th digit in cl
	mov dl, 1				; mov again to dl the value of 1	
	shr ax, 2				; shift right 2 times for getting the 14th digit
	and dl, al				; do and with dl for know ths lsb
	xor cl, dl				; do xor with the value in cl

	; now we know xor 14, 16
	mov dl, 1				; mov to dl the value of 1
	shr ax, 1				; shift right 1 time for 13th digit
	and dl, al				; do and with dl for know the lsb
	xor cl, dl				; do xor with the value in cl

	; now we know xor, 14, 16, 13
	mov dl, 1				; mov to dl the value of 1
	shr ax, 2				; shift right 2 times for 11th digit
	and dl, al				; do and with dl for know the lsb
	xor cl, dl				; do xor with the value in cl

	; now we know xor 14, 16, 13, 11, we want to add it to the msb of bx
	shr bx, 1				; shiftright the original number
	shl cx, 15				; shift left 15 times the value of cx for shift the digit to the MSB
	add bx, cx				; add the value to the original number
	mov word [seed], bx			; store back the random number value in seed
	add dword [LFSR_counter], 1
	jmp LFSR_loop
end_of_LFSR_loop:				; the loop ended, the new random number stores in seed variable
	mov esp, ebp
	pop ebp
	ret					; return to caller state

; input: assume seed in top of float-stack
; output: assume result in top of float-stack
scale_angle:
	push ebp
	mov ebp, esp
	fild dword [ANGLE_MAX_SIZE]
	fild dword [MAX_INTEGER_VALUE]
	fdiv
	fmul
	fld tword [degree_to_radian]
	fmul
	mov esp, ebp
	pop ebp
	ret

; input: assume seed in top of float-stack
; output: assume result in top of float-stack
scale_distance:
	push ebp
	mov ebp, esp
	fild dword [DISTANCE_MAX_SIZE]
	fild dword [MAX_INTEGER_VALUE]
	fdiv
	fmul
	mov esp, ebp
	pop ebp
	ret

; resume function:
resume:					; save state of current co-routine
	pushfd				
	pushad
	mov edx, [CURR]
	mov [edx+STK_OFFSET], esp	; save current esp
do_resume:				; load esp for resumed co-routine
	mov esp, [ebx+STK_OFFSET]
	mov [CURR], ebx
	popad				; restore resumed co-routine state
	popfd
	ret				; return to resumed co-routine

