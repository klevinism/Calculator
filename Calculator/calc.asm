; printf1.asm   print an integer from storage and from a register
; Assemble:	nasm -f elf -l printf.lst  printf1.asm
; Link:		gcc -o printf1  printf1.o
; Run:		printf1
; Output:	a=5, eax=7

; Equivalent C code
; /* printf1.c  print an int and an expression */
; #include 
; int main()
; {
;   int a=5;
;   printf("a=%d, eax=%d\n", a, a+2);
;   return 0;
; }

; Declare some external functions
;
	extern _printf		; the C function, to be called
	
section .data		; Data section, initialized variables

	a:	dd	5		; int a=5;
	b:	dd	2		; int b=2;
	
	c:	dd	78		; int c=78;
	d:	dd	8		; int d=8;
	
	e:	dd	12		; int e=12;
	f:	dd	12		; int f=12;
	
	g:	dd	80		; int g=80;
	h:	dd	10		; int h=10;
	
	fmtadd:   db "a=%d, b=%d, sum=%d", 10, 0 ; The printf format, "\n",'0'
	fmtdiff:  db "c=%d, d=%d, sub=%d", 10, 0 ; The printf format, "\n",'0'
	fmtmult:  db "e=%d, f=%d, mult=%d", 10, 0 ; The printf format, "\n",'0'
	fmtdiv:   db "g=%d, h=%d, div=%d", 10, 0 ; The printf format, "\n",'0'
	fmtsuccess: db "Calculator @2018 By Bajram Teferici :) ", 10, 0 ; The printf format, "\n",'0'

section .text                   ; Code section.

        global _main		; the standard gcc entry point
_main:				; the program label for the entry point
;--------------------------------------Sum-----------------------------------------
        push    ebp		; set up stack frame
        mov     ebp,esp

		mov	eax, [a]	; put a from store into register
		add	eax, [b]	; a+b
		push	eax		; value of a+b
        push    dword [a]	; value of variable a
		push    dword [b]	; value of variable a
        push    dword fmtadd	; address of ctrl string
        call    _printf		; Call C function
        add     esp, 12		; pop stack 3 push times 4 bytes

        mov     esp, ebp	; takedown stack frame
        pop     ebp		; same as "leave" op

;--------------------------------------Difference-----------------------------------------
		push    ebp		; set up stack frame
        mov     ebp,esp

		mov	eax, [c]	; put a from store into register
		sub	eax, [d]	; c-d
		push	eax		; value of c-d
        push    dword [c]	; value of variable c
		push    dword [d]	; value of variable d
        push    dword fmtdiff	; address of ctrl string
        call    _printf		; Call C function
        add     esp, 12		; pop stack 3 push times 4 bytes

        mov     esp, ebp	; takedown stack frame
        pop     ebp		; same as "leave" op

;--------------------------------------Multiplication-----------------------------------------
		push    ebp		; set up stack frame
        mov     ebp,esp

		mov	eax, [e]	    ; put a from store into register
		imul	eax, [f]	; c-d
		push	eax		    ; value of c-d
        push    dword [e]	; value of variable c
		push    dword [f]	; value of variable d
        push    dword fmtmult	; address of ctrl string
        call    _printf		; Call C function
        add     esp, 12		; pop stack 3 push times 4 bytes

        mov     esp, ebp	; takedown stack frame
        pop     ebp		    ; same as "leave" op
;--------------------------------------Division-----------------------------------------
		push    ebp		    ; set up stack frame
        mov     ebp,esp

		xor     eax, eax
		mov	    eax, [g]	; put g from store into register
		mov 	ebx, [h]	; put h from store into register
		div		ebx
		push	eax		    ; value of c-d
        push    dword [g]	; value of variable c
		push    dword [h]	; value of variable d
        push    dword fmtdiv	; address of ctrl string
        call    _printf		; Call C function
        add     esp, 12		; pop stack 3 push times 4 bytes

        mov     esp, ebp	; takedown stack frame
        pop     ebp		; same as "leave" op		
		
		push    fmtsuccess	; address of ctrl string
        call    _printf		; Call C function
		add     esp, 4		; pop stack 3 push times 4 bytes

		mov	eax,0		;  normal, no error, return value
		ret			; return
	
