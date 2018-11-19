	AREA	Calc,CODE,READWRITE
	
SWI_EscrCar	EQU	&0		; codigo de impresion de caracter (0) asignado a SWI_EscrCar
SWI_Salir	EQU	&11		; codigo de impresion de salida del programa(11)
SWI_write0	EQU 	&2
SWI_ReadC	EQU 	&4

	ENTRY					; Punto de entrada del código

BUCLE

	ADRL 	r0, cad1				; Obtenemos la direccion de la cadena1
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena
		; PARA INTRODUCIR EL DATO PONER PUNTO DE RUPTURA EN LA SIGUIENTE LINEA Y INTRODUCIR EL DATO EN R0
	MOV	r1, r0				; Movemos el valor introducido en r0 a r1



	ADRL	r0, cad2				; Obtenemos la direccion de la cadena2
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena
		; PARA INTRODUCIR EL DATO PONER PUNTO DE RUPTURA EN LA SIGUIENTE LINEA Y INTRODUCIR EL DATO EN R0
	MOV	r2, r0				; Movemos el valor introducido en r0 a r1

	

	ADRL 	r0, cad3				; Obtenemos la direccion de la cadena3
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena

	
	
	SWI 	SWI_ReadC			; Interrupcion de Soft. para leer un caracter de teclado
         CMP 	r0, #49				; Se ha pulsado la tecla 1 ??
	BLEQ 	SUMA				; 	ejecuta la rutina SUMA
	CMP 	r0, #50				; Se ha pulsado la tecla 2 ??
	BLEQ 	PROD				; 	ejecuta la rutina PROD
	CMP  	r0, #51
	BLEQ	RESTA
	CMP 	r0, #52
	BLEQ     DIV
	CMP	r0, #53
	BLEQ 	POT
	CMP 	r0, #54				; Se ha pulsado la tecla 3 ??
	BLEQ 	FACT
	CMP 	r0, #55
	BLEQ	EXIT

	ADRL 	r0, cad4				; Obtenemos la direccion de la cadena3
	SWI 	SWI_write0			; Interrupcion de Soft. para mostrar la cadena


		; PARA INTRODUCIR EL DATO PONER PUNTO DE RUPTURA EN LA SIGUIENTE LINEA Y CONSULTAR EL RESULTADO EN R3
	SWI SWI_Salir ; Sale del programa
	
	
SUMA	
	ADD r3, r1, r2
	MOV pc, r14

PROD
	MUL	r3, r1, r2
	MOV pc,r14

RESTA
	SUB 	r3, r1, r2
	MOV pc,r14
DIV
	CMP r1,r2
	BLE ULT
	SUB r1,r1,r2
	ADD r3,r3,#1
	B DIV	
POT	
	CMP r2,#0
	BEQ ULT
	MUL r3,r2,r1
	SUB r2,r2,#1
	MOV r3,r1
	B POT

FACT
	CMP r1,#0
	BEQ ULT
	MOV r2,r1
	SUB r2,r2,#1
	MUL r3,r1,r2
	SUB r1,r1,#1


ULT
	MOV r2,r4
	MOV pc, r14
	MOV r3,#1
	MOV pc,r14

cad1	=	"Intoduce operando 1 en registro r0 y pulsa F5", &0a, &0d, 0
cad2	=	"Intoduce operando 2 en registro r0 y pulsa F5", &0a, &0d, 0
cad3	=	"Elige operacion PULSANDO EN TECLADO el numero correspondiente:", &0a, &0d, "1. Sumar", &0a, &0d, "2. Multiplicar", &0a, &0d, "3.Restar", &0a, &0d, "4.Dividir", &0a,&0d, "5.Potencia", &0a,&0d "6.Factorial", &0a,&0d, "6.Salir"
cad4	=	&0a, &0d, "Programa terminado. Resultado en r3", &0a, &0d, 0
	
	B BUCLE
	
EXIT


	END
