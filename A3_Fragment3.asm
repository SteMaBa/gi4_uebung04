SECTION .data

i dd 10                 ; int i = 10
ergebnis dd 1           ; int ergebnis = 1

SECTION .text

global main


main:

push ebp
mov ebp, esp

jmp loop;               ; In die Schleife springen

loop:
dec dword [i]           ; --i
cmp [i], dword 0        ; i und 0 vergleichen
ja while                ; i > 0 in while springen
jmp mainFin             ; main Ende

while:
mov eax, [ergebnis]     ; ergebnis in eax zwischenspeichern
imul dword [i]          ; ergebnis *= i
mov [ergebnis], eax     ; eax' neues Ergebnis in ergebnis kopieren
jmp loop                ; Zurueck in die Schleife

mainFin:

mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
