cr EQU 13
lf EQU 10
 print macro arg1
    push ax
    push dx
    lea dx,arg1
    mov ah,9
    int 21h
    pop dx
    pop ax; imprime en pantalla conforme la modificacion de orden
 endm
 read macro arg1
    push ax
    push dx
    lea dx,arg1
    mov ah,10
    int 21h
    pop dx
    pop ax; modifica el orden de entrada y salida conforme obtiene datos
  endm
dades SEGMENT PARA PUBLIC
    missatge DB 'Introduce el Texto',cr,lf,'$'
    maxcad DB 30
    lencad DB 0
    cadena DB 30 DUP(0)
    girat DB 30 DUP(0)
    linia_blanc DB cr,lf,'$'
    missatge2 DB 'Desea salir? s o n',cr,lf,'$'
    maxcad2 DB 2
    lencad2 DB 0
    cadena2 DB 2 DUP(0); captura el texto e inicia un bucle conforme la salida
    
dades ENDS
codi SEGMENT PARA PUBLIC 'code'
    main PROC FAR
    ASSUME CS:codi,DS:dades,SS:pila,ES:dades
    mov ax,dades
    mov ds,ax
    mov es,ax
    
inicio:
    print missatge
    read maxcad
    print linia_blanc
    mov bx,0;imprime inicio de codigo
    
pushpila:
    mov al, cadena[bx]
    push ax
    inc bl
    cmp bl, lencad
    jne pushpila
    
    mov bx, 0;modifica el orden primero a ultimo
poppila:
    pop ax
    mov girat[bx], al
    inc bl
    cmp bl,lencad
    jne poppila
    
    mov girat[bx], '$'
    print girat
    print linia_blanc
    
    print missatge2
    read maxcad2
    print linia_blanc
    
    cmp cadena2[0],'s'
    je salir
    cmp cadena2[0],'S'
    je salir
    jmp inicio;orden modificado mediante pop ultimo primero en imprimir
    
salir: 
    mov ax,4c00h
    int 21h;fin
main ENDP
codi ENDS
pila SEGMENT PARA STACK 'stack'
DB 128 DUP(0)
pila ENDS
END main
    
    