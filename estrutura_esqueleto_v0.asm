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
;														(Paginação de Banco de Memória)

#DEFINE	BANK0	BCF STATUS,RP0 	; seleciona o banco 0
#DEFINE BANK1	BSF	STATUS,RP0	; seleciona o banco 1


;-----------------------------------------------------------------------------------------
;													(Seção para Declaração de Variáveis)

	CBLOCK	0X20	;endereço inicial no banco de memória
	
			;num1	;variável qualquer1
			;num2	;variável qualquer2
			;W_TEMP
			;STATUS_TEMP

	ENDC			;finaliza o bloco criado para as variáveis.
;------------------------------------------------------------------------------------------
;															(Definição de Flags Internos)


;------------------------------------------------------------------------------------------
;																			(Constantes)


;------------------------------------------------------------------------------------------
;															(Definição de Entradas/Saidas)

#DEFINE	BOT1	GPIO,0	;botao solto 1
						;botao pres 0 
						;;botao SOLTO 1 
#DEFINE	LED1	GPIO,2	;led aceso em 0
						;led apagado em 1
						;led ACESO 0


;------------------------------------------------------------------------------------------
; 													(Posição Inicial do Programa apos Reset)

	ORG	0x00	;organiza endereço de inicio do reset.
	GOTO INICIO

;------------------------------------------------------------------------------------------
;												(Endereço Inicial da Interrupção e Rotina)

	ORG	0x04 ; endereço inicial da interrupção

	;MOVWF	W_TEMP			;salvar w e status quando entra na interrupção
	;SWAPF	STATUS,W
	;MOVWF	STATUS_TEMP

	; toda rotina segue aqui.
	;	
	;
	;

	;SWAPF 	STATUS_TEMP,W	;rotina para recuperar os valos de w e status
	;MOVWF	STATUS			;antes de sair da interrupção
	;SWAPF	W_TEMP,F
	;SWAPF	W_TEMP,W
	
	RETFIE					;para se retornar de uma interrupção

;------------------------------------------------------------------------------------------(Local para CRIAÇÃO DE Rotinas) 
;
;
;



;-------------------------------------------------------------------------------------------(Inicio do Programa)

INICIO

;INICIO DA CONFIGURAÇÃO DA "MÁQUINA" (O CONTROLADOR).

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

;TÉRMINO DA CONFIGURAÇÃO DA "MÁQUINA" (O CONTROLADOR).
	
		

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