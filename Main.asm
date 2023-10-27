; Przyk³ad wywo³ywania funkcji MessageBoxA ze znakami polskimi
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

push 80
push offset bufor
push 0
call __read
add esp,12

mov ecx,eax
mov ebx,0
ptl:
mov dl,bufor[ebx]
cmp dl,0A5H;¹
jnz con1
mov dl,0B9H
con1:
cmp dl,86H;æ
jnz con2
mov dl,0E6H
jmp next
con2:
cmp dl,0A9H;ê
jnz con3
mov dl,0EAH
jmp next
con3:
cmp dl,88H;³
jnz con4
mov dl,0B3H
jmp next
con4:
cmp dl,0E4H;ñ
jnz con5
mov dl,0F1H
jmp next
con5:
cmp dl,0A2H;ó
jnz con6
mov dl,0F3H
jmp next
con6:
cmp dl,98H;œ
jnz con7
mov dl,9CH
jmp next
con7:
cmp dl,0ABH;Ÿ
jnz con8
mov dl,9FH
jmp next
con8:
cmp dl,0BEH;¿
jnz con9
mov dl,0BFH
next:
mov bufor[ebx],dl
con9:
inc ebx
dec ecx
jnz ptl

 push 0 ; sta³a MB_OK
; adres obszaru zawieraj¹cego tytu³
 push OFFSET tytul_Win1250
; adres obszaru zawieraj¹cego tekst
 push OFFSET bufor
 push 0 ; NULL
 call _MessageBoxA@16
 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END
