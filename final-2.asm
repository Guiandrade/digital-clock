;
;                    PROJECTO DE ARQUITECTURA DE COMPUTADORES
;							IST 23/05/2014
;
; NOMES: GUILHERME ANDRADE 77955, GABRIEL FREIRE 78081
; CURSO: LETI
; Turno Lab: Terça-Feira, 12h30
; Grupo: 18
;
; **************************************************************************************************************
; * Constantes
; **************************************************************************************************************

PIXEL		EQU	0C00CH	; endereço onde se começa a desenhar no Pixel Shader
PIXEL3		EQU	0C00EH	; endereço necessário do Pixel Shader para a rotina pontinhos
VAL			EQU	0009H	; número de linhas acendidas
LIM			EQU	0006H	; número de dígitos colocoado no Pixel Shader(6)
STRING1		EQU	2000H	; posição onde comeca a tabela de strings
STRING2		EQU	205AH	; posição onde comeca a string para fazer os dois pontos
POS1		EQU	0005H	; número de vezes que será feito shift para posicionar o primeiro dígito na posição certa
M1			EQU	00EH	; máscara para limpar o primeiro dígito mantendo o segundo
M2			EQU	0E0H	; máscara para escrever o segundo dígito mantendo o primeiro
M3			EQU	0F0H	; máscara para limpar o primeiro dígito mantendo o segundo
limite		EQU	0C07FH	; último endereço do pixel shader
reset 		EQU 00H     ;

M_H_D		EQU 4000H    ;endereço onde guardamos dados (horas,dezenas)
M_H_U		EQU 4001H    ;endereço onde guardamos dados (horas,unidades)
M_M_D		EQU 4002H    ;endereço onde guardamos dados (minutos,dezenas)
M_M_U		EQU 4003H    ;endereço onde guardamos dados (minutos,unidades)
M_S_D		EQU 4004H    ;endereço onde guardamos dados (segundos,dezenas)
M_S_U		EQU 4005H    ;endereço onde guardamos dados (segundos,unidades)


FlagMODO	EQU	4FF0H	 ;indica se está em modo cronómetro ou relógio

C_H_D		EQU 5000H    ;endereço onde guardamos dados (horas,dezenas)
C_H_U		EQU 5001H    ;endereço onde guardamos dados (horas,unidades)
C_M_D		EQU 5002H    ;endereço onde guardamos dados (minutos,dezenas)
C_M_U		EQU 5003H    ;endereço onde guardamos dados (minutos,unidades)
C_S_D		EQU 5004H    ;endereço onde guardamos dados (segundos,dezenas)
C_S_U		EQU 5005H    ;endereço onde guardamos dados (segundos,unidades)

M_S_A		EQU 400FH	 ;regista o número do alarme seleccionado (1,2,3)

M_H_D_A1	EQU 4010H    ;endereço onde guardamos dados (horas,dezenas)
M_H_U_A1	EQU 4011H    ;endereço onde guardamos dados (horas,unidades)
M_M_D_A1	EQU 4012H    ;endereço onde guardamos dados (minutos,dezenas)
M_M_U_A1	EQU 4013H    ;endereço onde guardamos dados (minutos,unidades)
M_L_A1 		EQU 4014H 	 ;endereço onde guardamos a informação se o alarme foi programado ou não
M_A_A1		EQU 4015H 	 ;endereço onde guardamos a informação se o relógio chegou à hora do alarme


M_H_D_A2	EQU 4020H    ;endereço onde guardamos dados (horas,dezenas)
M_H_U_A2	EQU 4021H    ;endereço onde guardamos dados (horas,unidades)
M_M_D_A2	EQU 4022H    ;endereço onde guardamos dados (minutos,dezenas)
M_M_U_A2	EQU 4023H    ;endereço onde guardamos dados (minutos,unidades)
M_L_A2 		EQU 4024H 	 ;endereço onde guardamos a informação se o alarme foi programado ou não
M_A_A2		EQU 4025H 	 ;endereço onde guardamos a informação se o relógio chegou à hora do alarme

M_H_D_A3	EQU 4030H    ;endereço onde guardamos dados (horas,dezenas)
M_H_U_A3	EQU 4031H    ;endereço onde guardamos dados (horas,unidades)
M_M_D_A3	EQU 4032h    ;endereço onde guardamos dados (minutos,dezenas)
M_M_U_A3	EQU 4033H    ;endereço onde guardamos dados (minutos,unidades)
M_L_A3 		EQU 4034H 	 ;endereço onde guardamos a informação se o alarme foi programado ou não
M_A_A3		EQU 4035H 	 ;endereço onde guardamos a informação se o relógio chegou à hora do alarme

FLAG 		EQU 4006H    ; indica se houve interrupção


LINHA		EQU	1H		; posição do bit correspondente à linha a testar
PINPOUT		EQU	0B000H	; endereço do porto de E/S do teclado
LIMITE      EQU 10H     ; verificámos a quarta linha
VALOR     	EQU 0H		; valor inicial de R4
MULTI		EQU	4H		; número de elementos por linha
OITO		EQU	8H		; valor quando testamos a ultima linha
NADA		EQU	00FFH	; valor se nada for pressionado no teclado

; **************************************************************************************************************
; * Código
; **************************************************************************************************************

PLACE		2000H		;  endereço inicial que guarda as strings

n0:		STRING	07H, 05H, 05H, 05H, 05H, 05H, 05H, 05H, 07H	; coloca o número zero no Pixel Shader
n1:		STRING	01H, 01H, 01H, 01H, 01H, 01H, 01H, 01H, 01H	; coloca o número um no Pixel Shader
n2:		STRING	07H, 01H, 01H, 01H, 07H, 04H, 04H, 04H, 07H	; coloca o número dois no Pixel Shader	
n3:		STRING	07H, 01H, 01H, 01H, 07H, 01H, 01H, 01H, 07H	; coloca o número três no Pixel Shader
n4:		STRING	05H, 05H, 05H, 05H, 07H, 01H, 01H, 01H, 01H	; coloca o número quatro no Pixel Shader
n5:		STRING	07H, 04H, 04H, 04H, 07H, 01H, 01H, 01H, 07H	; coloca o número cinco no Pixel Shader		
n6:		STRING	07H, 04H, 04H, 04H, 07H, 05H, 05H, 05H, 07H	; coloca o número seis no Pixel Shader		
n7:		STRING	07H, 01H, 01H, 01H, 01H, 01H, 01H, 01H, 01H	; coloca o número sete no Pixel Shader
n8:		STRING	07H, 05H, 05H, 05H, 07H, 05H, 05H, 05H, 07H	; coloca o número oito no Pixel Shader		
n9:		STRING	07H, 05H, 05H, 05H, 07H, 01H, 01H, 01H, 07H	; coloca o número nove no Pixel Shader
npont:	STRING	00H, 00H, 01H, 00H, 00H, 00H, 01H, 00H, 00H	; coloca um ponto no Pixel Shader

; **************************************************************************************************************
; * Stack 
; **************************************************************************************************************

PLACE		1000H
pilha:		TABLE 100H	; espaço reservado para a pilha 
						;(200H bytes, pois são 100H words)
SP_inicial:				; este é o endereço (1200H) com que o SP deve ser 
						;inicializado. O 1º end. de retorno será 
						;armazenado em 11F0EH (1200H-2)

PLACE	2200H

tab:	WORD rot0   	; tabela de interrupções




PLACE		0						; o código tem de começar em 0000H

inicio1:	MOV BTE,tab 			; 
			MOV	SP, SP_inicial		; inicializa SP para a palavra a seguir
									; à última da pilha	

			MOV R4,0AH
			MOV R0,0H 				;
 			MOV R8,0H 				;
 			MOV	R1,0H 				;
 			MOV R9,0H 				;
			MOV	R3,LIM 				;
			MOV R2,PIXEL			;
			MOV R10,0FH             ;
			CALL limpa 				;
			CALL pontinhos			;
			EI0 					; permite interrupções 
 			EI 						;
 
Ciclo:		MOV R3,FLAG
			MOVB R9, [R3] 
			CMP R9, 0H				; verifica se a flag está activa,indicativo de + 1 segundo
			JZ fim
			CALL incrementa 		; incrementa 1 segundo no relogio
			; CALL alarmes			; compara relogio com os alarmes
			CALL refresh			; actualiza os valores no ecra
			MOV R3,FLAG
			MOV R0,0H
			MOVB [R3], R0			; desactiva flag

fim:	
			CALL retorna_valor		; le teclado
			MOV R6,0FH
			CMP R8,R6 				; verifica se o utilizador pressionou a tecla F,indo para o modo de acerto do relógio
			JZ acertox
			JMP Ciclo

acertox:	CALL acerto
			EI
			JMP Ciclo

; *************************************************************************************************************
; * Rotinas
; *************************************************************************************************************

;* -- refresh --------------------------------------------------------------------------------------------
;* 
;* Descrição: Rotina que actualiza o display com os valores que estão na memória
;*
;* Parâmetros: R8,R1
;* Retorna:	--  
;* Destrói: --

refresh:		PUSH R3
				PUSH R1
				PUSH R8


				MOV R3,M_H_D	  	
				MOVB R8, [R3]	; vamos buscar à memória o valor das horas(dezenas)
				MOV	R1,0H
				CALL escreve_valor		
				MOV R3,M_H_U	
				MOVB R8, [R3]	; vamos buscar à memória o valor das horas(unidades)
				MOV	R1,1H	
				CALL escreve_valor	
				MOV R3,M_M_D	
				MOVB R8, [R3]	; vamos buscar à memória o valor dos minutos(dezenas)
				MOV	R1,2H	
				CALL escreve_valor	
				MOV R3,M_M_U	
				MOVB R8, [R3]	; vamos buscar à memória o valor das minutos(unidades)
				MOV	R1,3H	
				CALL escreve_valor	
				MOV R3,M_S_D	
				MOVB R8, [R3]	; vamos buscar à memória o valor dos segundos(dezenas)
				MOV	R1,4H	
				CALL escreve_valor	
				MOV R3,M_S_U	
				MOVB R8, [R3]	; vamos buscar à memória o valor das segundos(unidades)
				MOV	R1,5H	
				CALL escreve_valor		
				
				POP R8
				POP R1
				POP R3

				RET		


;* -- escreve_valor--------------------------------------------------------------------------------------------
;* 
;* Descrição: Rotina que escreve um dígito no pixel shader
;*
;* Parâmetros: R8,R1
;* Retorna:	--  
;* Destrói: --

escreve_valor:	PUSH R3
				PUSH R4
				PUSH R10
				PUSH R6
				PUSH R7
				PUSH R2
				PUSH R9
				PUSH R8	

	inicio:	MOV R3, VAL			; o número de linhas é 9
			MOV R4, 0H			; contador para gerir o número  de pixeis 
			MOV R10,STRING1		; endereço das strings
			MUL R8, R3			; transformar o número a colocar no número do endereço onde começa a sua representação
			ADD R10,R8			; endereço de memória correspondente
			CMP R1,0H			; verificamos qual é o dígito que vai ser escrito no Pixel Shader
			JZ ciclo1			; primeiro dígito
			CMP R1,1H			
			JZ ciclo2			; segundo dígito 
			ADD R2, 1H 			; actualiza endereço do pixel shader a colocar o número 
			CMP R1,2H			
			JZ ciclo3			; terceiro  dígito 
			ADD R2, 1H 			; actualiza endereço do pixel shader a colocar o número 
			CMP R1,3H			
			JZ ciclo4			; quarto  dígito 
			ADD R2, 1H 			; actualiza endereço do pixel shader a colocar o número 
			CMP R1,4H			
			JZ ciclo5			; quinto  dígito
			CMP R1,5H			
			JGE ciclo6			; sexto  dígito 
			RET		
			
	ciclo1:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ pops
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M1	; 
			MOVB R7,[R2]		; copia o que está na memória
			AND R7, R6			; vai apagar o primeiro dígito e manter o segundo
			SHL R5,5H			; posiciona o novo primeiro dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado na memória
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			; soma um ao contador
			ADD R10,01H			; endereço de memória a seguir
			JMP ciclo1		
	
	ciclo2:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ pops
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M3	;
			MOVB R7,[R2]		; copia o que está na memória
			AND R7, R6			; vai apagar o segundo dígito e manter o primeiro
			SHL R5, 1H			; posiciona o novo segundo dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado na memória
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			
			ADD R10,01H			; endereço de memória a seguir
			JMP ciclo2

	ciclo3:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ pops
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M2 	;
			MOVB R7,[R2]		; copia o que está na memória
			AND R7, R6			; vai apagar o dígito anterior
			SHL R5, 1H			; posiciona o novo dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado na memória
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			; soma um ao contador
			ADD R10,01H			; endereço de memória a seguir
			JMP ciclo3
	
	ciclo4:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ pops
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M1	 
			MOVB R7,[R2]		; copia o que está na memória
			AND R7, R6			; vai apagar o dígito anterior
			SHL R5,5H			; posiciona o novo  dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado na memória
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			
			ADD R10,01H			; endereço de memória a seguir
			JMP ciclo4

	ciclo5:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ pops
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M1			; máscara
			MOVB R7,[R2]		; copia o que está na memória
			AND R7, R6			; vai apagar o dígito anterior, guardando o que esta na posição ao lado
			SHL R5,5H			; posiciona o novo  dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado na memória
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			; soma um ao contador
			ADD R10,01H			; endereço de memória a seguir
			JMP ciclo5

	ciclo6:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ pops
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M2			; máscara
			MOVB R7,[R2]
			AND R7, R6			; vai apagar o dígito anterior, guardando o que está na posição ao lado
			SHL R5, 1H			; posiciona o novo dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado na memória
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			; soma um ao contador
			ADD R10,01H			; endereço de memória a seguir
			JMP ciclo6	
	
	pops:	POP R8
			POP R9
			POP R2
			POP R7
			POP R6	
			POP R10
			POP R4
			POP R3
			RET
	
		
;* -- pontinhos----------------------------------------------------------------------------------------------------
;* 
;* Descrição: Rotina que liga os pontos que separam as horas dos minutos e os minutos dos segundos no Pixel Shader.
;*
;* Parâmetros: --
;* Retorna: -- 
;* Destrói: --

pontinhos:		PUSH R2
				PUSH R10
				PUSH R5
				PUSH R4
				PUSH R3
				PUSH R7
				PUSH R9

	start:	MOV R9,PIXEL3		
			MOV R3, VAL			; o número de linhas é 9
			MOV R4, 0H			; contador para gerir o número  de pixeis 
			MOV R10, STRING2	; endereço das strings
			ADD R2,1H			; passa para o endereço seguinte do pixel shader
			CMP R2, R9			; verifica se já temos os primeiros pontos colocados
			JZ ponts2

	
	ponts:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ muda
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M1			; máscara
			AND R7, R6			; guarda o dígito  que está ao lado
			MOVB R7,[R2]		; copia o que está na memória
			SHL R5, 6H			; posiciona o novo dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado
			MOVB [R2],R5		; acende-se os pixeis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H			; soma um ao contador
			ADD R10,01H			; endereço de memória a seguir
			JMP ponts

	muda:	MOV R2, PIXEL		; repete-se devido à reposição do valor inicial
			ADD R2,1H			; avança duas posições no endereço do pixel shader	
			JMP start
		
	ponts2:	CMP R4,R3			; compara com o número 9 para saber se já terminámos a representação do número
			JZ sai
			MOVB R5,[R10]		; copia da tabela criada o que será colocado nesta linha do pixel shader
			MOV R6, M2			; máscara
			MOVB R7,[R2]		; copia o que está na memória
			AND R7, R6			; guarda o dígito  que está ao lado
			SHL R5, 2H			; posiciona o novo dígito 
			OR   R5,R7			; actualiza-se o que vai ser colocado
			MOVB [R2],R5		; acende-se os pixéis
			ADD R2,4H			; endereço da linha seguinte
			ADD R4,01H		
			ADD R10,01H			; endereço de memória a seguir
			JMP ponts2
	
	sai:	POP R9
			POP R7
			POP R3
			POP R4
			POP R5
			POP R10
			POP R2
			RET
	
;* -- limpa----------------------------------------------------------------
;* 
;* Descrição: Rotina que limpa qualquer ruído da memória do Pixel Shader.
;*
;* Parâmetros: --
;* Retorna: -- 
;* Destrói: --

limpa:			PUSH	R10
				PUSH	R11
				PUSH	R2
				MOV R10, reset				; inicializa registo com valor do primeiro endereço do pixel shader
				MOV R11, limite				; inicializa registo com valor do ultimo endereço do pixel shader

		limpa_ciclo:	MOVB [R2], R10		; limpa a memória do byte do endereço do pixel shader selecionado
						CMP R2, R11			; verifica se já atingiu o último endereço do pixel shader
						JLE limpa_add		; caso não se verifique a condição, incrementa-se o endereço (através da função limpa_add)
						JMP limpa_fim

		limpa_add: 	ADD R2,1
	   				JMP limpa_ciclo

		limpa_fim:	POP R2
					POP R11
					POP R10		
					RET	

; *********************************************************************************
;* -- incrementa----------------------------------------------------------------
;* 
;* Descrição: Rotina que actualiza os valores dos dígitos na memória
;*
;* Parâmetros: --
;* Retorna: --
;* Destrói:
;* Notas: --

incrementa: PUSH R0
			PUSH R3
			PUSH R1
			PUSH R4
			PUSH R5

			MOV R0,0AH

			MOV R1,M_S_U
			MOVB R3, [R1] 
			ADD R3,1H      
			CMP R3, R0 	  	; compara com AH para saber se já temos 9 no ultimo dígito dos segundos
			JZ s1   
			MOVB [R1],R3	
			JMP saida

	s1: 	MOV R3,0H
			MOVB [R1],R3 	; depois do valor 9 recolocamos o valor 0
	
	s2: 	MOV R0, 6H
			MOV R1,M_S_D
			MOVB R3, [R1] 	; vamos buscar a memoria o número de segundos (dezenas)
			ADD R3,1H
			CMP R3, R0    	; verificamos se ja temos 60 segundos
			JZ m
			MOVB [R1],R3	
			JMP saida

	m: 		MOV R3,0H
			MOVB [R1],R3 	; colocamos os segundos a zero

	m0:		MOV R0, 0AH
			MOV R1,M_M_U 	; vamos buscar a memoria o número de minutos (unidades)
			MOVB R3, [R1]
			ADD R3,1H
			CMP R3, R0   	; verificamos se ja temos 10 minutos
			JZ m1
			MOVB [R1],R3	
			JMP saida

	m1:		MOV R3,0H
			MOVB [R1],R3 	; depois do valor 9 recolocamos o valor 0


	m2:		MOV R0, 6H
			MOV R1,M_M_D
			MOVB R3, [R1] 	; vamos buscar a memoria o número de minutos (dezenas)
			ADD R3,1H
			CMP R3, R0    	; verificamos se ja temos 60 minutos
			JZ h
			MOVB [R1],R3	
			JMP saida

	h:		MOV R3,0H
			MOVB [R1],R3	; colocamos os minutos a zero

	h0:		MOV R0, 0AH
			MOV R1,M_H_U 	; vamos buscar a memoria o número de horas (unidades)
			MOVB R3, [R1]
			ADD R3,1H
			MOV R4,M_H_D
			MOVB R5,[R4]
			CMP R5,2H 		; caso específico das 24 horas
			JNZ normal
			CMP R3,4H 		; caso específico das 24 horas
			JZ midnight

	normal:	CMP R3, R0   	; verificamos se ja temos 10 minutos
			JZ h1
			MOVB [R1],R3
			JMP saida

	h1: 	MOV R3,0H
			MOVB [R1],R3 	; depois do valor 9 recolocamos o valor 0

	h2:		MOV R0, 6H
			MOV R1,M_H_D
			MOVB R3, [R1] 	; vamos buscar a memoria o número de minutos (dezenas)
			ADD R3,1H
			MOVB [R1],R3	
			JMP saida


	midnight: 	MOV R3,0H 	; todas as memorias ficarão com o valor zero
				MOV R1,M_H_D
				MOVB [R1],R3
				MOV R1,M_H_U
				MOVB [R1],R3
				MOV R1,M_M_D
				MOVB [R1],R3
				MOV R1,M_M_U
				MOVB [R1],R3
				MOV R1,M_S_D
				MOVB [R1],R3
				MOV R1,M_S_U
				MOVB [R1],R3
				
	saida:	POP R5
			POP R4
			POP R1
			POP R3
			POP R0
			RET

; *********************************************************************************
;* -- retorna_valor----------------------------------------------------------------
;* 
;* Descrição: Rotina que retorna o valor da tecla pressionada ou FFH se nenhuma for carregada
;*
;* Parâmetros: R1,R3
;* Retorna: R8	--   valor da tecla pressionada
;* Destrói:
;* Notas: --

retorna_valor:	
				PUSH R1
				PUSH R2
				PUSH R3
				PUSH R4
				PUSH R5
				PUSH R6
				PUSH R7
				PUSH R10		


				MOV	R1, LINHA		; testar a linha 1
				MOV	R2, PINPOUT		; R2 com o endereço do periférico
				MOV R6, LIMITE  	; R6 com o valor 16 em decimal
				MOV	R3, VALOR		; R3 com valor 0
				MOV	R4, MULTI		; R4 com valor 4H
				MOV	R5,OITO			; R5 com valor 8H
				
			ciclox:	MOVB [R2], R1	; escrever no porto de saída
					MOVB R3, [R2]	; ler do porto de entrada
					MOV R10,0FH 	; Máscara
					AND R3, R10		; afectar as flags (MOVs não afectam as flags)
					JZ 	linhas		; nenhuma tecla premida
					MOV R8,R1		; cópia do valor de R1 para R8 
					CMP	R1,2H		; saber o número da linha para saber que calculo teremos de fazer para obter o valor a exibir no display
					JLE	Calc1		;
					CMP	R1,R4		; saber o número da linha para saber que calculo teremos de fazer para obter o valor a exibir no display
					JZ	Calc2	
					CMP	R1,R5		; saber o número da linha para saber que calculo teremos de fazer para obter o valor a exibir no display
					JZ	Calc3

			nada:   MOV R10,0FFH
					MOV	R8,R10		; retorna o valor FFH
					JMP  popes

			linhas:	SHL R1,1H   	; troca de linha
					CMP	R1,R6       ; verifica se ja lemos a 4a linha
					JZ 	nada		; salta se ja tiver lido a ultima linha
					JMP ciclox	; salta se ainda nao tiver lido a ultima linha


			Calc1:	SUB R8,1H		
					JMP valor		


			Calc2:	SHR	R8,1H		; dividimos o valor da linha por 2
					JMP valor		;


			Calc3:	SUB	R8,5H		; subtraimos 5 ao valor da linha

			valor:	CMP	R3,2H		; saber o número da linha para saber que calculo teremos de fazer para obter o valor a exibir no display
					JLE	Colunas1		
					CMP	R3,R4		; saber o número da linha para saber que calculo teremos de fazer para obter o valor a exibir no display
					JZ	Colunas2	
					CMP	R3,R5		; saber o número da linha para saber que calculo teremos de fazer para obter o valor a exibir no display
					JZ	Colunas3

			Colunas1:	SUB	R3,1H		

			Colunas2:	SHR	R3,1H		; dividimos o valor da coluna por 2
						JMP display		

			Colunas3: 	SUB R3,5H		

			display:	MUL	R8,R4		; multiplicamos pelo número de elementos do teclado por linha (4)
						ADD	R8,R3		; somamos os dois valores para obter o valor para exibir no display

			press: 	MOVB R3,[R2]		; ler do porto de entrada
					AND R3, R3          ; afectar as flags (MOVs não afectam as flags)
					JNZ press
			
			popes:	POP R10
					POP R7
					POP R6
					POP R5
					POP R4
					POP R3
					POP R2
					POP R1
					RET

;* -- acerto--------------------------------------------------------------------------------------------
;* 
;* Descrição: Rotina que desliga a ocorrência de interrupções e permite realizar o ajuste do relógio
;*
;* Parâmetros: R8
;* Retorna:	--  
;* Destrói: --

acerto:			DI
				PUSH R1
				PUSH R2
				PUSH R3
				PUSH R4
				PUSH R5
	

				MOV R1,M_H_D
				MOV R2,M_H_U
				MOV R3,M_M_D
				MOV R4,M_M_U
          		MOV R5, 9H

		begin:	CALL retorna_valor
				CMP R8,2H 			; o número de horas(dezenas) não pode ser superior a 2
				JGT begin
				MOVB [R1],R8
		begin2:	CALL retorna_valor
				CMP R8,R5
				JGT begin2			; o número de horas (unidades) não pode ser superior a 9
				MOVB [R2],R8
		begin3:	CALL retorna_valor
				CMP R8,5H 			; o número de minutos(dezenas) não pode ser superior a 5
				JGT begin3
				MOVB [R3],R8
		begin4:	CALL retorna_valor
				CMP R8,R5 			; o número de minutos(unidades) não pode ser superior a 9
				JGT begin4
				MOVB [R4],R8
				MOV R1,M_S_D
				MOV R2,0H 			; vamos colocar os dois dígitos dos segundos a 0
				MOVB [R1], R2
				MOV R1,M_S_U
				MOVB [R1], R2

		waitf:	CALL retorna_valor
				MOV R3,0FH	
				CMP R8,R3 			; verifica se o utilizador pressionou a tecla F
				JZ volta
				JMP waitf

		volta:	POP R5 
				POP R4
				POP R3
				POP R2
				POP R1
				RET			
;* -- acertot--------------------------------------------------------------------------------------------
;* 
;* Descrição: Rotina que permite colocar valores no relogio para efeitos de teste
;*
;* Parâmetros: R8
;* Retorna:	--  
;* Destrói: --

acertot:	
				PUSH R1
				PUSH R2
				PUSH R3
				PUSH R4
				PUSH R6

				MOV R1,M_H_D
				MOV R2,M_H_U
				MOV R3,M_M_D
				MOV R4,M_M_U
          

		begin1:	MOV R8,2H
				MOVB [R1],R8
				MOV R8,3H
				MOVB [R2],R8
				MOV R8,5H
				MOVB [R3],R8
				MOV R6,9H
				MOV R8,R6
				MOVB [R4],R8
				MOV R1,M_S_D
				MOV R2,0H
				MOVB [R1], R2
				MOV R1,M_S_U
				MOVB [R1], R2

			 	POP R6
			 	POP R4
				POP R3
				POP R2
				POP R1
				RET			

; *************************************************************************************************************
; * Interrupções
; *************************************************************************************************************

rot0:							; rotina de interrupção
			PUSH R3
			PUSH R0

			MOV R3,FLAG
			MOV R0,1H 			; indicativo de + 1 segundo
			MOVB [R3], R0	    ; guarda na memória do endereço FLAG
			
			POP R0
			POP R3
			RFE

