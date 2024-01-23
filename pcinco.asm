;Captura texto
;muestra la cantidad de texto ingresada
;busca un caracter en el texto y muestra el porcentaje de veces que aparece
.MODEL small; modelo de memoria
.STACK 100h

DATA SEGMENT
    msj1 db 'Ingrese Texto',10,13,'$'
    msj2 db 10,10,13, 'Ingrese un Caracter: $'
    msj3 db 10,10,13, 'EL texto tiene $'
    msj4 db ' Caracteres',10,13,'$'
    msj5 db 10,13,'El caracter $'
    msj6 db ' aparece $'
    msj7 db ' veces, lo que representa el $'
    msj8 db ' %',10,10,10,13,9, 'Fin',10,13,'$';variables con mensajes a imprimir a pantalla
    chr db ?
    ntot db 255
    nch db ?
    texto db 255 dup(?)
    nsi db ?
    cien db 100
DATA ENDS; DATA captura una cadena de texto, captura un caracter, imprime la cantidad de texto, busca el caracter especifico en la cadena e imprime el porcentaje que representa en la cadena

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    
INICIO:

    MOV AX,DATA
    MOV DS,AX
uno:    lea dx,msj1
        call mostrar
        mov ah,10
        lea dx,ntot
        int 21h
        lea dx,msj2
        call mostrar
        mov ah,1
        int 21h; 
        mov chr,al
        lea dx,msj3
        call mostrar
        mov al,nch; 
        call numero
        lea dx,msj4
        call mostrar
        lea dx,msj5
        call mostrar
        mov dl,chr
        mov ah,2
        int 21h
        lea dx,msj6
        call mostrar; uno captura texto e inicia contador de texto y caracteres
dos:    mov cl,nch
        xor ch,ch
        xor bx,bx
        tres:   mov al,texto[bx]; lee caracter senialado por bx
        cmp al,chr
        jne cuatro
        inc ch
        cuatro: inc bx
        dec cl 
        jne tres
        mov al,ch
        mov nsi,al
        call numero
        lea dx, msj7
        call mostrar
        mov al,nsi
        mul cien
        div nch
        call numero
        lea dx, msj8
        call mostrar
        MOV AH,4ch
        INT 21h;  dos inicia contador de caracteres del texto, pabalabras y apuntador de caracteres del texto
mostrar:
        mov ah,9
        int 21h   ;muestra en pantalla el mensaje se?alado por dx
        ret
numero:
        xor ah,ah
        div cien
        mov dx,ax
        mov ah,2
        add dl,30h
        int 21h
        mov al,dh ;muestra porcentaje del caracter en la cadena
        aam
        mov dx,ax
        xchg dh,dl
        add dx,3030h
        mov ah,2
        int 21h
        mov dl,dh
        int 21h
        ret
        
    CODE ENDS
END INICIO