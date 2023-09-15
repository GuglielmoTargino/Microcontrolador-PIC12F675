; ESTRUTURA-ESQUELETO PARA PROGRAMACAO BASE DO P12F675
;	ESTE PROGRAMA UTILIZA O PINO GPIO,0 COMO ENTRADA DE UM BOTAO. E O PINO GPIO,2-
;	COMO SAIDA PARA ACENDER UM LED.
;AUTOR: GUGLIELMO HENRIQUES TARGINO 
;DATA: 09/09/23
;VERSAO: V0

;----------------------------------------------------------------------------------------
;													(Inserindo Bibliotecas de Arquivos)

#INCLUDE <p12f675.inc>
	__CONFIG _INTRC_OSC_NOCLKOUT & _BOREN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _MCLRE_ON

;-----------------------------------------------------------------------------------------
;														(Pagina��o de Banco de Mem�ria)

#DEFINE	BANK0	BCF STATUS,RP0 	; seleciona o banco 0
#DEFINE BANK1	BSF	STATUS,RP0	; seleciona o banco 1


;-----------------------------------------------------------------------------------------
;													(Se��o para Declara��o de Vari�veis)

	CBLOCK	0X20	;endere�o inicial no banco de mem�ria
	
			;num1	;vari�vel qualquer1
			;num2	;vari�vel qualquer2
			;W_TEMP
			;STATUS_TEMP

	ENDC			;finaliza o bloco criado para as vari�veis.
;------------------------------------------------------------------------------------------
;															(Defini��o de Flags Internos)


;------------------------------------------------------------------------------------------
;																			(Constantes)


;------------------------------------------------------------------------------------------
;															(Defini��o de Entradas/Saidas)

#DEFINE	BOT1	GPIO,0	;botao solto 1
						;botao pres 0 
						;;botao SOLTO 1 
#DEFINE	LED1	GPIO,2	;led aceso em 0
						;led apagado em 1
						;led ACESO 0


;------------------------------------------------------------------------------------------
; 													(Posi��o Inicial do Programa apos Reset)

	ORG	0x00	;organiza endere�o de inicio do reset.
	GOTO INICIO

;------------------------------------------------------------------------------------------
;												(Endere�o Inicial da Interrup��o e Rotina)

	ORG	0x04 ; endere�o inicial da interrup��o

	;MOVWF	W_TEMP			;salvar w e status quando entra na interrup��o
	;SWAPF	STATUS,W
	;MOVWF	STATUS_TEMP

	; toda rotina segue aqui.
	;	
	;
	;

	;SWAPF 	STATUS_TEMP,W	;rotina para recuperar os valos de w e status
	;MOVWF	STATUS			;antes de sair da interrup��o
	;SWAPF	W_TEMP,F
	;SWAPF	W_TEMP,W
	
	RETFIE					;para se retornar de uma interrup��o

;------------------------------------------------------------------------------------------(Local para CRIA��O DE Rotinas) 
;
;
;



;-------------------------------------------------------------------------------------------(Inicio do Programa)

INICIO

;INICIO DA CONFIGURA��O DA "M�QUINA" (O CONTROLADOR).

	CLRF	GPIO	
	BANK1
	MOVLW 	B'00000001'
	MOVWF	TRISIO
	MOVLW	B'10000000'
	MOVWF	OPTION_REG
	MOVLW	B'00000000'
	MOVWF	ANSEL
	BANK0
	MOVLW	B'00000000'
	MOVWF	INTCON
	MOVLW	B'00000111'
	MOVWF	CMCON

;T�RMINO DA CONFIGURA��O DA "M�QUINA" (O CONTROLADOR).
	
		

MAIN

	;	escreve todo o programa aqui

	BTFSC	BOT1
	GOTO	APAGA_LED
	GOTO	ACENDE_LED
	
	

APAGA_LED
	BSF		LED1
	GOTO	MAIN

ACENDE_LED
	BCF		LED1
	GOTO	MAIN

	END