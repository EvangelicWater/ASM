.MODEL small
.STACK 100h

.DATA
inv db 10,13,'ingresa tu estatura en cm: $'
resp db 10,13, 'equivale a: '
r1  db ?,' ft, '
r2 db ?
r3 db ?,' pg',10,10,13,'Michael Jordan tiene 6ft 10pg', 10 ,13
   db 'respecto a MJ te faltan '
r4 db ?,' ft y '
r5 db ?
r6 db ?,' pg',10,13,'$'
wcm db ?
wft db ?
inch db ?
pie db 30
pgd db 12
mj db 82
dift db ?
dipg db ?
.CODE
inicio:
      MOV AX,@DATA
      MOV DS,AX
      lea dx, inv
      call mostrar
      call captNro3c
      mov wcm,al
      xor ah,ah
      div pie
      mov wft, al
      mov al,ah
      mul pgd
      div pie
      mov inch,al
      cmp ah,14
      jbe siga
      inc inch
siga:   mov al,wft
        mul pgd
        add al,inch
        mov ah,mj
        sub ah,al
        mov al,ah
        xor ah,ah
        div pgd
        
        mov dift,al
        mov dipg,ah
        
        mov al,wft
        add al,30h
        mov r1,al
        mov al,inch
        aam
        add ax,3030h
        mov r2,ah
        mov r3,al
        mov al,dift
        add al,30h
        mov r4,al
        mov al,dipg
        aam
        add ax,3030h
        mov r5,ah
        mov r6,al
        lea dx, resp
        call mostrar
     MOV AH,4ch
     int 21h     
mostrar:
     mov ah,9
     int 21h
     ret
captNro3c:
        mov ah,1
        int 21h
        mov cl,al
        int 21h
        mov ch,al
        int 21h
        mov ah,ch
        sub ax,3030h
        aad 
        cmp cl,'1'
        jne sale
        add al,100
sale:   ret
END inicio