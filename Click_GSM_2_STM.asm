Click_GSM_2_STM_gsm2_configTimer:
;click_gsm_2_timer.h,13 :: 		static void gsm2_configTimer()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;click_gsm_2_timer.h,15 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;click_gsm_2_timer.h,16 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;click_gsm_2_timer.h,17 :: 		TIM2_PSC = 24;
MOVS	R1, #24
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;click_gsm_2_timer.h,18 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;click_gsm_2_timer.h,19 :: 		NVIC_IntEnable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;click_gsm_2_timer.h,20 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;click_gsm_2_timer.h,21 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;click_gsm_2_timer.h,22 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;click_gsm_2_timer.h,23 :: 		}
L_end_gsm2_configTimer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of Click_GSM_2_STM_gsm2_configTimer
_Timer_interrupt:
;click_gsm_2_timer.h,25 :: 		void Timer_interrupt() iv IVT_INT_TIM2 // 100ms
SUB	SP, SP, #4
STR	LR, [SP, #0]
;click_gsm_2_timer.h,27 :: 		gsm2_tick();
BL	_gsm2_tick+0
;click_gsm_2_timer.h,28 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;click_gsm_2_timer.h,29 :: 		}
L_end_Timer_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer_interrupt
_systemInit:
;Click_GSM_2_STM.c,67 :: 		void systemInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_GSM_2_STM.c,69 :: 		callFlag    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_callFlag+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_callFlag+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,70 :: 		smsReceived = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsReceived+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsReceived+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,71 :: 		smsDecode   = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsDecode+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsDecode+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,72 :: 		smsReady    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsReady+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsReady+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,73 :: 		i           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_i+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,74 :: 		noCarrier   = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_noCarrier+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_noCarrier+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,75 :: 		isBusy      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_isBusy+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_isBusy+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,76 :: 		noAnswer    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_noAnswer+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_noAnswer+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,79 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT ); // pin A4
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_GSM_2_STM.c,80 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT ); // pin A0
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_GSM_2_STM.c,81 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT ); // pin D10
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_GSM_2_STM.c,82 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT ); // pin C2
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_GSM_2_STM.c,83 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT ); // pin D13
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_GSM_2_STM.c,84 :: 		mikrobus_uartInit( _MIKROBUS1, &_GSM2_UART_CFG[0] ); // UART3 for GSM device (9600 8N1)
MOVW	R0, #lo_addr(__GSM2_UART_CFG+0)
MOVT	R0, #hi_addr(__GSM2_UART_CFG+0)
MOV	R1, R0
MOVS	R0, #0
BL	_mikrobus_uartInit+0
;Click_GSM_2_STM.c,85 :: 		mikrobus_logInit( _LOG_USBUART_A, 9600 ); // UART1 for debugging (9600 8N1)
MOVW	R1, #9600
MOVS	R0, #32
BL	_mikrobus_logInit+0
;Click_GSM_2_STM.c,88 :: 		Start_TP();
BL	_Start_TP+0
;Click_GSM_2_STM.c,89 :: 		TFT_Fill_Screen(CL_WHITE); // white background
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,90 :: 		}
L_end_systemInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _systemInit
_applicationInit:
;Click_GSM_2_STM.c,92 :: 		void applicationInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_GSM_2_STM.c,95 :: 		gsm2_configTimer();
BL	Click_GSM_2_STM_gsm2_configTimer+0
;Click_GSM_2_STM.c,99 :: 		gsm2_uartDriverInit((T_GSM2_P)&_MIKROBUS1_GPIO, (T_GSM2_P)&_MIKROBUS1_UART);
MOVW	R1, #lo_addr(__MIKROBUS1_UART+0)
MOVT	R1, #hi_addr(__MIKROBUS1_UART+0)
MOVW	R0, #lo_addr(__MIKROBUS1_GPIO+0)
MOVT	R0, #hi_addr(__MIKROBUS1_GPIO+0)
BL	_gsm2_uartDriverInit+0
;Click_GSM_2_STM.c,100 :: 		gsm2_coreInit( gsm2_default_handler, 1500 ); // handler (callback), watchdog
MOVW	R0, #lo_addr(_gsm2_default_handler+0)
MOVT	R0, #hi_addr(_gsm2_default_handler+0)
MOVW	R1, #1500
BL	_gsm2_coreInit+0
;Click_GSM_2_STM.c,103 :: 		gsm2_hfcEnable( true ); // Hardware Flow Control
MOVS	R0, #1
BL	_gsm2_hfcEnable+0
;Click_GSM_2_STM.c,104 :: 		gsm2_modulePower( true ); // turn on
MOVS	R0, #1
BL	_gsm2_modulePower+0
;Click_GSM_2_STM.c,107 :: 		gsm2_cmdSingle( "AT" );// negotiates the baud rate with the module
MOVW	R0, #lo_addr(?lstr1_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr1_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,108 :: 		gsm2_cmdSingle( "AT" );
MOVW	R0, #lo_addr(?lstr2_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr2_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,109 :: 		gsm2_cmdSingle( "AT" );
MOVW	R0, #lo_addr(?lstr3_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr3_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,111 :: 		gsm2_cmdSingle( "ATE0" ); // turn command echo off
MOVW	R0, #lo_addr(?lstr4_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr4_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,112 :: 		gsm2_cmdSingle( "AT+IFC=2,2" ); // enable hardware flow control - necessary in case of UART polling
MOVW	R0, #lo_addr(?lstr5_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr5_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,113 :: 		gsm2_cmdSingle( "AT+CMGF=1" ); // SMS in text mode
MOVW	R0, #lo_addr(?lstr6_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr6_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,114 :: 		}
L_end_applicationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationInit
_gsm2_default_handler:
;Click_GSM_2_STM.c,116 :: 		void gsm2_default_handler( uint8_t *rsp, uint8_t *evArgs )
; rsp start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
; rsp end address is: 0 (R0)
; rsp start address is: 20 (R5)
;Click_GSM_2_STM.c,121 :: 		if (1 == smsDecode) // if we were expecting an SMS
MOVW	R2, #lo_addr(Click_GSM_2_STM_smsDecode+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_smsDecode+0)
LDRB	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L_gsm2_default_handler0
;Click_GSM_2_STM.c,123 :: 		smsDecode = 0; // reset flag
MOVS	R3, #0
MOVW	R2, #lo_addr(Click_GSM_2_STM_smsDecode+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_smsDecode+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,124 :: 		smsReady = 1; // raise flag for application_task()
MOVS	R3, #1
MOVW	R2, #lo_addr(Click_GSM_2_STM_smsReady+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_smsReady+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,125 :: 		rsp += 67; // point at SMS text
ADDW	R0, R5, #67
; rsp end address is: 20 (R5)
; rsp start address is: 0 (R0)
;Click_GSM_2_STM.c,126 :: 		i = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_i+0)
STRB	R3, [R2, #0]
; rsp end address is: 0 (R0)
;Click_GSM_2_STM.c,127 :: 		while((*rsp != '\r') && (i < 50))
L_gsm2_default_handler1:
; rsp start address is: 0 (R0)
LDRB	R2, [R0, #0]
CMP	R2, #13
IT	EQ
BEQ	L__gsm2_default_handler38
MOVW	R2, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_i+0)
LDRB	R2, [R2, #0]
CMP	R2, #50
IT	CS
BCS	L__gsm2_default_handler37
L__gsm2_default_handler36:
;Click_GSM_2_STM.c,129 :: 		sms_content[i] = *rsp;
MOVW	R4, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R4, #hi_addr(Click_GSM_2_STM_i+0)
LDRB	R3, [R4, #0]
MOVW	R2, #lo_addr(Click_GSM_2_STM_sms_content+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_sms_content+0)
ADDS	R3, R2, R3
LDRB	R2, [R0, #0]
STRB	R2, [R3, #0]
;Click_GSM_2_STM.c,130 :: 		i++;
MOV	R2, R4
LDRB	R2, [R2, #0]
ADDS	R2, R2, #1
STRB	R2, [R4, #0]
;Click_GSM_2_STM.c,131 :: 		rsp++;
ADDS	R0, R0, #1
;Click_GSM_2_STM.c,132 :: 		}
; rsp end address is: 0 (R0)
IT	AL
BAL	L_gsm2_default_handler1
;Click_GSM_2_STM.c,127 :: 		while((*rsp != '\r') && (i < 50))
L__gsm2_default_handler38:
L__gsm2_default_handler37:
;Click_GSM_2_STM.c,133 :: 		sms_content[i] = 0; // properly terminate string
MOVW	R2, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_i+0)
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(Click_GSM_2_STM_sms_content+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_sms_content+0)
ADDS	R3, R2, R3
MOVS	R2, #0
STRB	R2, [R3, #0]
;Click_GSM_2_STM.c,134 :: 		}
IT	AL
BAL	L_gsm2_default_handler5
L_gsm2_default_handler0:
;Click_GSM_2_STM.c,135 :: 		else if (0 == strncmp("RING", rsp + 2, 4)) // if incoming call
; rsp start address is: 20 (R5)
ADDS	R3, R5, #2
MOVW	R2, #lo_addr(?lstr7_Click_GSM_2_STM+0)
MOVT	R2, #hi_addr(?lstr7_Click_GSM_2_STM+0)
MOV	R1, R3
MOV	R0, R2
MOVS	R2, #4
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_gsm2_default_handler6
; rsp end address is: 20 (R5)
;Click_GSM_2_STM.c,137 :: 		callFlag = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(Click_GSM_2_STM_callFlag+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_callFlag+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,138 :: 		}
IT	AL
BAL	L_gsm2_default_handler7
L_gsm2_default_handler6:
;Click_GSM_2_STM.c,139 :: 		else if (0 == strncmp("NO CARRIER", rsp + 2, 10)) // if call failed due to low network coverage
; rsp start address is: 20 (R5)
ADDS	R3, R5, #2
MOVW	R2, #lo_addr(?lstr8_Click_GSM_2_STM+0)
MOVT	R2, #hi_addr(?lstr8_Click_GSM_2_STM+0)
MOV	R1, R3
MOV	R0, R2
MOVS	R2, #10
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_gsm2_default_handler8
; rsp end address is: 20 (R5)
;Click_GSM_2_STM.c,141 :: 		noCarrier = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(Click_GSM_2_STM_noCarrier+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_noCarrier+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,142 :: 		}
IT	AL
BAL	L_gsm2_default_handler9
L_gsm2_default_handler8:
;Click_GSM_2_STM.c,143 :: 		else if (0 == strncmp("CMTI: \"SM\"", rsp + 3, 10)) // if SMS is received
; rsp start address is: 20 (R5)
ADDS	R3, R5, #3
MOVW	R2, #lo_addr(?lstr9_Click_GSM_2_STM+0)
MOVT	R2, #hi_addr(?lstr9_Click_GSM_2_STM+0)
MOV	R1, R3
MOV	R0, R2
MOVS	R2, #10
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_gsm2_default_handler10
;Click_GSM_2_STM.c,145 :: 		smsReceived = 1; // prepare flag for next round of callback function
MOVS	R3, #1
MOVW	R2, #lo_addr(Click_GSM_2_STM_smsReceived+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_smsReceived+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,146 :: 		rsp += 14; // point at ID
ADDW	R0, R5, #14
; rsp end address is: 20 (R5)
; rsp start address is: 0 (R0)
;Click_GSM_2_STM.c,147 :: 		i = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_i+0)
STRB	R3, [R2, #0]
; rsp end address is: 0 (R0)
;Click_GSM_2_STM.c,149 :: 		while ((*rsp != '\r') && (i < 3))
L_gsm2_default_handler11:
; rsp start address is: 0 (R0)
LDRB	R2, [R0, #0]
CMP	R2, #13
IT	EQ
BEQ	L__gsm2_default_handler40
MOVW	R2, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_i+0)
LDRB	R2, [R2, #0]
CMP	R2, #3
IT	CS
BCS	L__gsm2_default_handler39
L__gsm2_default_handler35:
;Click_GSM_2_STM.c,151 :: 		sms_get_request[8 + i] = *rsp;
MOVW	R4, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R4, #hi_addr(Click_GSM_2_STM_i+0)
LDRB	R2, [R4, #0]
ADDW	R3, R2, #8
SXTH	R3, R3
MOVW	R2, #lo_addr(Click_GSM_2_STM_sms_get_request+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_sms_get_request+0)
ADDS	R3, R2, R3
LDRB	R2, [R0, #0]
STRB	R2, [R3, #0]
;Click_GSM_2_STM.c,152 :: 		sms_del_request[8 + i] = *rsp;
MOV	R2, R4
LDRB	R2, [R2, #0]
ADDW	R3, R2, #8
SXTH	R3, R3
MOVW	R2, #lo_addr(Click_GSM_2_STM_sms_del_request+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_sms_del_request+0)
ADDS	R3, R2, R3
LDRB	R2, [R0, #0]
STRB	R2, [R3, #0]
;Click_GSM_2_STM.c,153 :: 		rsp++;
ADDS	R0, R0, #1
;Click_GSM_2_STM.c,154 :: 		i++;
MOV	R2, R4
LDRB	R2, [R2, #0]
ADDS	R2, R2, #1
STRB	R2, [R4, #0]
;Click_GSM_2_STM.c,155 :: 		}
; rsp end address is: 0 (R0)
IT	AL
BAL	L_gsm2_default_handler11
;Click_GSM_2_STM.c,149 :: 		while ((*rsp != '\r') && (i < 3))
L__gsm2_default_handler40:
L__gsm2_default_handler39:
;Click_GSM_2_STM.c,156 :: 		sms_get_request[8 + i] = 0; // properly terminate string
MOVW	R4, #lo_addr(Click_GSM_2_STM_i+0)
MOVT	R4, #hi_addr(Click_GSM_2_STM_i+0)
LDRB	R2, [R4, #0]
ADDW	R3, R2, #8
SXTH	R3, R3
MOVW	R2, #lo_addr(Click_GSM_2_STM_sms_get_request+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_sms_get_request+0)
ADDS	R3, R2, R3
MOVS	R2, #0
STRB	R2, [R3, #0]
;Click_GSM_2_STM.c,157 :: 		sms_del_request[8 + i] = 0; // properly terminate string
MOV	R2, R4
LDRB	R2, [R2, #0]
ADDW	R3, R2, #8
SXTH	R3, R3
MOVW	R2, #lo_addr(Click_GSM_2_STM_sms_del_request+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_sms_del_request+0)
ADDS	R3, R2, R3
MOVS	R2, #0
STRB	R2, [R3, #0]
;Click_GSM_2_STM.c,158 :: 		}
IT	AL
BAL	L_gsm2_default_handler15
L_gsm2_default_handler10:
;Click_GSM_2_STM.c,159 :: 		else if (0 == strncmp("BUSY", rsp + 2, 4)) // if call failed because of busy line
; rsp start address is: 20 (R5)
ADDS	R3, R5, #2
MOVW	R2, #lo_addr(?lstr10_Click_GSM_2_STM+0)
MOVT	R2, #hi_addr(?lstr10_Click_GSM_2_STM+0)
MOV	R1, R3
MOV	R0, R2
MOVS	R2, #4
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_gsm2_default_handler16
; rsp end address is: 20 (R5)
;Click_GSM_2_STM.c,161 :: 		isBusy = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(Click_GSM_2_STM_isBusy+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_isBusy+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,162 :: 		}
IT	AL
BAL	L_gsm2_default_handler17
L_gsm2_default_handler16:
;Click_GSM_2_STM.c,163 :: 		else if (0 == strncmp("NO ANSWER", rsp + 2, 9)) // if call failed because no answer
; rsp start address is: 20 (R5)
ADDS	R3, R5, #2
; rsp end address is: 20 (R5)
MOVW	R2, #lo_addr(?lstr11_Click_GSM_2_STM+0)
MOVT	R2, #hi_addr(?lstr11_Click_GSM_2_STM+0)
MOV	R1, R3
MOV	R0, R2
MOVS	R2, #9
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_gsm2_default_handler18
;Click_GSM_2_STM.c,165 :: 		noAnswer = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(Click_GSM_2_STM_noAnswer+0)
MOVT	R2, #hi_addr(Click_GSM_2_STM_noAnswer+0)
STRB	R3, [R2, #0]
;Click_GSM_2_STM.c,166 :: 		}
IT	AL
BAL	L_gsm2_default_handler19
L_gsm2_default_handler18:
;Click_GSM_2_STM.c,172 :: 		}
L_gsm2_default_handler19:
L_gsm2_default_handler17:
L_gsm2_default_handler15:
L_gsm2_default_handler9:
L_gsm2_default_handler7:
L_gsm2_default_handler5:
;Click_GSM_2_STM.c,173 :: 		}
L_end_gsm2_default_handler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _gsm2_default_handler
_applicationTask:
;Click_GSM_2_STM.c,175 :: 		void applicationTask()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_GSM_2_STM.c,178 :: 		gsm2_process(); // This function should be placed inside the infinite while loop
BL	_gsm2_process+0
;Click_GSM_2_STM.c,180 :: 		if (1 == callFlag)
MOVW	R0, #lo_addr(Click_GSM_2_STM_callFlag+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_callFlag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_applicationTask20
;Click_GSM_2_STM.c,182 :: 		callFlag = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_callFlag+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_callFlag+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,183 :: 		TFT_Fill_Screen(CL_WHITE); // clear screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,184 :: 		TFT_Write_Text("A call is received", 0, 0);
MOVW	R0, #lo_addr(?lstr12_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr12_Click_GSM_2_STM+0)
MOVS	R2, #0
MOVS	R1, #0
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,186 :: 		Delay_ms( 3000 );
MOVW	R7, #9214
MOVT	R7, #244
NOP
NOP
L_applicationTask21:
SUBS	R7, R7, #1
BNE	L_applicationTask21
NOP
NOP
NOP
;Click_GSM_2_STM.c,187 :: 		rejectCall(); // disconnect existing call
MOVW	R0, #lo_addr(?lstr13_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr13_Click_GSM_2_STM+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,190 :: 		TFT_Fill_Screen(CL_WHITE); // clear screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,191 :: 		TFT_Write_Text("Call is disconnected", 0, 0);
MOVW	R0, #lo_addr(?lstr14_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr14_Click_GSM_2_STM+0)
MOVS	R2, #0
MOVS	R1, #0
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,192 :: 		}
L_applicationTask20:
;Click_GSM_2_STM.c,194 :: 		if (1 == smsReceived) // if any SMS is received, request its content
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsReceived+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsReceived+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_applicationTask23
;Click_GSM_2_STM.c,196 :: 		smsReceived = 0; // reset flag
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsReceived+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsReceived+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,197 :: 		smsDecode = 1; // prepare decode flag for callback function
MOVS	R1, #1
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsDecode+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsDecode+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,198 :: 		gsm2_cmdSingle(sms_get_request); // request sms content
MOVW	R0, #lo_addr(Click_GSM_2_STM_sms_get_request+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_sms_get_request+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,199 :: 		}
L_applicationTask23:
;Click_GSM_2_STM.c,201 :: 		if (1 == smsReady) // if SMS is ready to be read
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsReady+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsReady+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_applicationTask24
;Click_GSM_2_STM.c,203 :: 		smsReady = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_smsReady+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_smsReady+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,204 :: 		TFT_Fill_Screen(CL_WHITE); // clear screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,205 :: 		TFT_Write_Text("SMS content is [", 0, 0);
MOVW	R0, #lo_addr(?lstr15_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr15_Click_GSM_2_STM+0)
MOVS	R2, #0
MOVS	R1, #0
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,206 :: 		TFT_Write_Text(sms_content, 0, 13); // get sms content
MOVS	R2, #13
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_sms_content+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_sms_content+0)
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,207 :: 		TFT_Write_Char(']', 0, 25);
MOVS	R2, #25
MOVS	R1, #0
MOVS	R0, #93
BL	_TFT_Write_Char+0
;Click_GSM_2_STM.c,208 :: 		gsm2_cmdSingle(sms_del_request); // delete sms from SIM card
MOVW	R0, #lo_addr(Click_GSM_2_STM_sms_del_request+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_sms_del_request+0)
BL	_gsm2_cmdSingle+0
;Click_GSM_2_STM.c,210 :: 		if (0 == strncmp(sms_content, "on", 2))
MOVW	R0, #lo_addr(?lstr16_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr16_Click_GSM_2_STM+0)
MOVS	R2, #2
MOV	R1, R0
MOVW	R0, #lo_addr(Click_GSM_2_STM_sms_content+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_sms_content+0)
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_applicationTask25
;Click_GSM_2_STM.c,212 :: 		GPIOD_ODR |= 1 << 0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Click_GSM_2_STM.c,213 :: 		}
IT	AL
BAL	L_applicationTask26
L_applicationTask25:
;Click_GSM_2_STM.c,214 :: 		else if (0 == strncmp(sms_content, "off", 3))
MOVW	R0, #lo_addr(?lstr17_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr17_Click_GSM_2_STM+0)
MOVS	R2, #3
MOV	R1, R0
MOVW	R0, #lo_addr(Click_GSM_2_STM_sms_content+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_sms_content+0)
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_applicationTask27
;Click_GSM_2_STM.c,216 :: 		GPIOD_ODR &= ~(1 << 0);
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Click_GSM_2_STM.c,217 :: 		}
IT	AL
BAL	L_applicationTask28
L_applicationTask27:
;Click_GSM_2_STM.c,218 :: 		else if (0 == strncmp(sms_content, "toggle", 6))
MOVW	R0, #lo_addr(?lstr18_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr18_Click_GSM_2_STM+0)
MOVS	R2, #6
MOV	R1, R0
MOVW	R0, #lo_addr(Click_GSM_2_STM_sms_content+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_sms_content+0)
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_applicationTask29
;Click_GSM_2_STM.c,220 :: 		GPIOD_ODR ^= 1 << 0;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Click_GSM_2_STM.c,221 :: 		}
L_applicationTask29:
L_applicationTask28:
L_applicationTask26:
;Click_GSM_2_STM.c,222 :: 		}
L_applicationTask24:
;Click_GSM_2_STM.c,224 :: 		if (0 != noCarrier)
MOVW	R0, #lo_addr(Click_GSM_2_STM_noCarrier+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_noCarrier+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_applicationTask30
;Click_GSM_2_STM.c,226 :: 		noCarrier = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_noCarrier+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_noCarrier+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,227 :: 		TFT_Fill_Screen(CL_WHITE); // clear screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,228 :: 		}
L_applicationTask30:
;Click_GSM_2_STM.c,230 :: 		if (0 != isBusy)
MOVW	R0, #lo_addr(Click_GSM_2_STM_isBusy+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_isBusy+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_applicationTask31
;Click_GSM_2_STM.c,232 :: 		isBusy = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_isBusy+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_isBusy+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,233 :: 		TFT_Fill_Screen(CL_WHITE); // clear screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,234 :: 		TFT_Write_Text("Busy!", 0, 0);
MOVW	R0, #lo_addr(?lstr19_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr19_Click_GSM_2_STM+0)
MOVS	R2, #0
MOVS	R1, #0
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,235 :: 		}
L_applicationTask31:
;Click_GSM_2_STM.c,237 :: 		if (0 != noAnswer)
MOVW	R0, #lo_addr(Click_GSM_2_STM_noAnswer+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_noAnswer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_applicationTask32
;Click_GSM_2_STM.c,239 :: 		noAnswer = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Click_GSM_2_STM_noAnswer+0)
MOVT	R0, #hi_addr(Click_GSM_2_STM_noAnswer+0)
STRB	R1, [R0, #0]
;Click_GSM_2_STM.c,240 :: 		TFT_Fill_Screen(CL_WHITE); // clear screen
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Click_GSM_2_STM.c,241 :: 		TFT_Write_Text("No answer", 0, 0);
MOVW	R0, #lo_addr(?lstr20_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr20_Click_GSM_2_STM+0)
MOVS	R2, #0
MOVS	R1, #0
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,242 :: 		}
L_applicationTask32:
;Click_GSM_2_STM.c,245 :: 		}
L_end_applicationTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationTask
_main:
;Click_GSM_2_STM.c,247 :: 		void main()
;Click_GSM_2_STM.c,249 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;Click_GSM_2_STM.c,250 :: 		GPIOD_ODR &= ~(1 << 0);
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Click_GSM_2_STM.c,252 :: 		systemInit();
BL	_systemInit+0
;Click_GSM_2_STM.c,253 :: 		applicationInit();
BL	_applicationInit+0
;Click_GSM_2_STM.c,259 :: 		TFT_Write_Text("Started", 0, 0);
MOVW	R0, #lo_addr(?lstr21_Click_GSM_2_STM+0)
MOVT	R0, #hi_addr(?lstr21_Click_GSM_2_STM+0)
MOVS	R2, #0
MOVS	R1, #0
BL	_TFT_Write_Text+0
;Click_GSM_2_STM.c,261 :: 		while (1)
L_main33:
;Click_GSM_2_STM.c,263 :: 		applicationTask();
BL	_applicationTask+0
;Click_GSM_2_STM.c,264 :: 		}
IT	AL
BAL	L_main33
;Click_GSM_2_STM.c,265 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
