; Przyk≥ad wywo≥ywania funkcji MessageBoxA ze znakami polskimi
.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
extern __write : PROC
extern __read : PROC
public _main
.data
tekstPocz db 'wprowad',0ABH ,' tekst i kliknij ', 'Enter ',10
tekstKon db ?
tytul_Win1250 db 'Tekst w standardzie Windows 1250', 0

bufor db 80 dup (?)
.code
_main PROC

mov ecx ,(offset tekstKon) - (offset tekstPocz);dlugosc tekstu
push ecx 
push offset tekstPocz
push 1 ;w konsoli
call __write 
add esp ,12
push 80;max d≥ugosc tekstu
push offset bufor
push 0
call __read
add esp,12
mov ecx,eax
mov ebx,0
ptl:
mov dl,bufor[ebx]
cmp dl,0A5H;π
jnz con1
mov dl,0B9H
con1:
cmp dl,86H;Ê
jnz con2
mov dl,0E6H
jmp next
con2:
cmp dl,0A9H;Í
jnz con3
mov dl,0EAH
jmp next
con3:
cmp dl,88H;≥
jnz con4
mov dl,0B3H
jmp next
con4:
cmp dl,0E4H;Ò
jnz con5
mov dl,0F1H
jmp next
con5:
cmp dl,0A2H;Û
jnz con6
mov dl,0F3H
jmp next
con6:
cmp dl,98H;ú
jnz con7
mov dl,9CH
jmp next
con7:
cmp dl,0ABH;ü
jnz con8
mov dl,9FH
jmp next
con8:
cmp dl,0A4H;•
jnz con9
mov dl,0A5H
jmp next
con9:
cmp dl,8FH;∆
jnz con10
mov dl,0C6H
jmp next
con10:
cmp dl,0A8H; 
jnz con11
mov dl,0CAH
jmp next
con11:
cmp dl,9DH;£
jnz con12
mov dl,0A3H
jmp next
con12:
cmp dl,0E3H;—
jnz con13
mov dl,0D1H
jmp next
con13:
cmp dl,0E0H;”
jnz con14
mov dl,0D3H
jmp next
con14:
cmp dl,97H;å
jnz con15
mov dl,8CH
jmp next
con15:
cmp dl,8DH;è
jnz con16
mov dl,8FH
jmp next
con16:
cmp dl,0BDH;Ø
jnz con17
mov dl,0AFH
jmp next
con17:
cmp dl,0BEH;ø
jnz con18
mov dl,0BFH
next:
mov bufor[ebx],dl
con18:
inc ebx
dec ecx
jnz ptl
 push 0 ; sta≥a MB_OK
; adres obszaru zawierajπcego tytu≥
 push OFFSET tytul_Win1250
; adres obszaru zawierajπcego tekst
 push OFFSET bufor
 push 0 ; NULL
 call _MessageBoxA@16
 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END
