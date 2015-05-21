SECTION .data

n DD 25         ; Variable n, 32 Bit
ergebnis DQ 0   ; Variable ergebnis, 64 Bit

SECTION .text

global main
global Fibonacci
global Finish01
global FinishOverflow
global FinishFib
global FinishMain

main:

push ebp
mov ebp, esp

; Aufgabenteil 2, n-te Fibonaccizahl

mov eax, [n]            ; n in eax kopieren
cmp eax, dword 1        ; falls n <= 1, eax=ergebnis
jbe Finish01            ; springe zu Finish01, ergebnis ist 0 oder 1
                        ; n >= 2
mov ecx, dword 1        ; ecx ist Zaehler, beginne bei 1
push dword 0            ; erste 32 Bit von F(1) auf den Stack
push dword 0            ; erste 32 Bit von F(0) auf den Stack
push dword 1            ; letzte 32 Bit von F(1) auf den Stack
push dword 0            ; letzte 32 Bit von F(0) auf den Stack  
jmp Fibonacci           ; in Schleife springen

Fibonacci:
                        ; Addition von F(n-2) und F(n-1) getrennt in 32Bit-Hälften
                        ; Stack-Struktur: 32Bit high von F(n-1)   Wachstumsrichtung
                        ;                 32Bit high von F(n-2)     ||  
                        ;                 32Bit low von F(n-1)      ||
                        ;                 32Bit low von F(n-2)      \/
pop eax                 ; F(n-2)-low in eax
pop ebx                 ; F(n-1)-low in ebx
pop esi                 ; F(n-2)-high in esi
add eax, ebx            ; low's in eax addieren         EAX->F(n)-low, EBX->F(n-1)-low, ECX->Zaehler
adc esi, dword 0        ; F(n-2)-high + CF in esi
jo FinishOverflow       ; Overflow
pop edx                 ; F(n-1)-high in edx
add esi, edx            ; high's+CF in esi              EDX->F(n-1)-high, ESI->F(n)-high
jo FinishOverflow       ; Overflow 
push esi                ; F(n)-h wird zu F(n-1)-h        
push edx                ; F(n-1)-h wird zu F(n-2)-h
push eax                ; F(n)-l wird zu F(n-1)-l
push ebx                ; F(n-1)-l wird zu F(n-2)-l
inc ecx                 ; F(n+1) wurde berechnet, Zaehler erhoehen
cmp dword ecx, [n]      ; pruefen, ob n erreicht
je FinishFib            ; zum Ende von Fibonacci springen
jmp Fibonacci          ; sonst wiederholen 

Finish01:
mov [ergebnis], dword eax  ; eax in ergebnis kopieren
jmp FinishMain             ; zum Ende von main springen

FinishOverflow:
mov [ergebnis], dword 0    ; Overflow der 64Bit, ergebnis auf 0 setzen
jmp FinishMain             ; zum Ende von main springen

FinishFib:                      
pop eax;                   ; 32Bit low von F(n-1) in eax
pop ebx;                   ; 32Bit low von F(n) in ebx  
pop ecx;                   ; 32Bit high von F(n-1) in ecx     
pop edx;                   ; 32Bit high von F(n) in edx
mov [ergebnis], dword 0    ; ergebnis auf 0 setzen
mov [ergebnis], dword ebx  ; 32 Bit low an niedriger Position
mov [ergebnis+32], dword edx;32Bit high an hoher Position 
jmp FinishMain             ; zum Ende von main springen


FinishMain:
mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
