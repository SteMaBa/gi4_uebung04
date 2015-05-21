SECTION .data

a DD 0          ; Variable a = 0, 4 Byte int
b DD 7          ; Variable b = 7, 4 Byte int

SECTION .text

global main


main:

push ebp
mov ebp, esp

cmp [a], dword 0        ; a == 0?
je if                   ; zu if springen
mov [b], dword 0        ; else b = 0
jmp mainFin             ; ans Ende springen

if: 
inc dword [a]           ; Postinkrement von a
mov [b], dword 1        ; b = 1
jmp mainFin             ; ans Ende springen


mainFin:
mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
