SECTION .data

n DD 10         ; Variable n, 32 Bit
ergebnis DD 0   ; Variable ergebnis, 32 Bit

SECTION .text

global main

main:

push ebp
mov ebp, esp

; Aufgabenteil 1, Fakultaet von n

mov eax, dword 1        ; 1 in eax kopieren
mov ecx, [n]            ; n in ecx kopieren, Zaehler
cmp ecx, dword 1        ; ecx mit 1 vergleichen, falls n < 2 ergebnis = 1
ja Fakultaet            ; sonst gehe zu Fakultaet
jmp FinishA1            ; zum Ende springen

Fakultaet:
mul ecx                 ; eax mit ecx multiplizieren, n*(n-1)
sub ecx, dword 1        ; ecx um 1 verringern, n=n-1
cmp ecx, dword 1        ; ecx mit 1 vergleichen, falls ecx = 1, Ruecksprung
ja Fakultaet            ; ecx (Zaehler) noch groesser 1, Schleife erneut durchlaufen
jmp FinishA1            ; zum Ende springen

FinishA1:
mov [ergebnis], eax     ; ergebnis = eax = n!

mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
