SECTION .data

testvalue DD 832040             ; testvalue = 30, 32Bit
ergebnis DD 0                   ; ergebnis = 0, 32Bit

SECTION .text

global main

main:

push ebp
mov ebp, esp

cmp [testvalue], dword 1        ; F(n)=n für 0<=n<=1
jbe FinBE                       ; n <= 1
mov eax, dword 0                ; eax enthaelt F(n-2)
mov ebx, dword 1                ; ebx enthaelt F(n-1)
mov ecx, dword 1                ; counter, beginne bei F(n-1 = 1)
jmp Loop                        ; in Schleife springen

FinBE:
mov eax, [testvalue]            ; testvalue zwischenspeichern und in ergebnis kopieren
mov [ergebnis], eax             ; F(n)=n fuer 0<=n<=1
jmp FinMain                     ; ans Ende springen

Loop:
inc ecx                         ; Counter um eins erhoehen
mov edx, eax                    ; F(n-2) in edx speichern
add edx, ebx                    ; F(n-1) zu F(n-2) in edx addieren
jo FinOverflow                  ; Overflow, F(n) groesser als 32Bit-Zahl, aus Loop springen        
mov eax, ebx                    ; F(n-1) wird zu F(n-2), in eax
mov ebx, edx                    ; F(n) wird zu F(n-1), in ebx
cmp ebx, dword [testvalue]      ; neues F(n) mit gesuchtem testvalue vergleichen
je FinEqual                     ; F(n) gefunden
jmp Loop                        ; sonst Schleife wiederholen

FinOverflow:
mov [ergebnis], dword 0         ; testvalue ist keine 32Bit-Fibonacci-Zahl
jmp FinMain                     ; ans Ende springen

FinEqual:
mov [ergebnis], ecx             ; Zaehler n in ecx in ergebnis kopieren
jmp FinMain                     ; ans Ende springen

FinMain:
mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
