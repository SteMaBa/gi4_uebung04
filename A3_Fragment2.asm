SECTION .data

a resd 10               ; Array a mit 10 4-Byte-int-Elementen

SECTION .text

global main


main:

push ebp
mov ebp, esp

mov ecx, dword 0        ; Schleifenvariable i vom Stack in ecx laden
mov ebx, a              ; Adresse des Arrayanfangs in ebx kopieren
jmp loop                ; in Schleife springen

loop:
mov [ebx], ecx          ; i in a[i] kopieren
add ebx, Byte 4         ; Adresse in ebx auf naechsten Arrayeintrag erhoehen
inc ecx                 ; i inkrementieren
cmp ecx, dword 10       ; Zaehler mit 10 vergleichen
jae FinishMain          ; Wenn i >= 10 (in C < 10), dann springe zu Ende
jmp loop                ; Sonst Schleife wiederholen

FinishMain:
mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
