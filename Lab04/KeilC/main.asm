ORG 00H 
	SECONDNUM EQU P2.7 ;BIT SE DUOC SET KHI NHAP SO THU 2
	SECONDDIGIT EQU P2.6 ;BIT SE DUOC SET THI NHAP SO HANG THU 2 CUA MOI SO
ORG 0030H 
SETUP:
	;SET UP TOC DO BAUD
	MOV TMOD, #21H 
	MOV TH1, #0FDH 
	MOV SCON, #50H 
	SETB TR1
	; SETUP CAC THANH GHI 
	MOV R5, #00H ;R5 CHUA SO DU
	MOV R4, #00H ;R4 CHUA KETQUA
	MOV R3, #00H ;R3 CHUA SO THU 2
	MOV R2, #00H ;R2 CHUA MA ASCII CUA PHEP TOAN
	MOV R1, #00H ;R1 CHUA SO THU 1
	MOV P1 , #0FEH ; BAT DAU QUET VOI HANG 1
	MOV P2, #00H 
	//MOV R1, #01H ;CHANGE TO DEBUG
	;QUET HANG
SCANHANG:
	JNB P1.0, SCANCOT1  ; NEU P1.0 = 0 THI QUET COT 1
	JNB P1.1, SCANCOT2  ; NEU P1.1 = 0 THI QUET COT 2
	JNB P1.2, SCANCOT3  ; NEU P1.2 = 0 THI QUET COT 3
	JNB P1.3, SCANCOT4  ; NEU P1.3 = 0 THI QUET COT 4
SJMP SCANHANG

SCANCOT1:
	//CLR P1.4 //CHANGE TO DEBUG
	JNB P1.4, BUTTON_ON ; NEU P1.4 = 0 THI VAO LABEL BUTTON_ON
	JNB P1.5, BUTTON_0 ; NEU P1.5 = 0 THI VAO LABEL BUTTON_0
	JNB P1.6, BUTTON_EQUAL ; NEU P1.6 = 0 THI VAO LABEL BUTTON_EQUAL
	JNB P1.7, BUTTON_ADD ; NEU P1.7 = 0 THI VAO LABEL BUTTON_ADD
	SETB P1.0 ; SET BIT P1.0
	CLR P1.1 ; CLR P1.1 DE QUET COT THU 2
SJMP SCANHANG

SCANCOT2:
	//CLR P1.4 ;CHANGE TO DEBUG
	JNB P1.4, BUTTON_1 ; NEU P1.4 = 0 THI VAO LABEL BUTTON_1
	JNB P1.5, BUTTON_2 ; NEU P1.5 = 0 THI VAO LABEL BUTTON_2
	JNB P1.6, BUTTON_3 ; NEU P1.6 = 0 THI VAO LABEL BUTTON_3
	JNB P1.7, BUTTON_SUB ; NEU P1.7 = 0 THI VAO LABEL BUTTON_SUB
	SETB P1.1 ; SET BIT P1.1
	CLR P1.2 ; CLR P1.2 DE QUET COT THU 3
SJMP SCANHANG

SCANCOT3:
	JNB P1.4, BUTTON_4  ; NEU P1.4 = 0 THI VAO LABEL BUTTON_4
	JNB P1.5, BUTTON_5  ; NEU P1.5 = 0 THI VAO LABEL BUTTON_5
	JNB P1.6, BUTTON_6  ; NEU P1.6 = 0 THI VAO LABEL BUTTON_6
	JNB P1.7, BUTTON_MUL  ; NEU P1.7 = 0 THI VAO LABEL BUTTON_MUL
	SETB P1.2 ; SET BIT P1.2
	CLR P1.3 ; CLR P1.3 DE QUET COT THU 4
SJMP SCANHANG

SCANCOT4: 
	JNB P1.4, BUTTON_7 ; NEU P1.4 = 0 THI VAO LABEL BUTTON_7
	JNB P1.5, BUTTON_8 ; NEU P1.5 = 0 THI VAO LABEL BUTTON_8
	JNB P1.6, BUTTON_9 ; NEU P1.6 = 0 THI VAO LABEL BUTTON_9
	JNB P1.7, BUTTON_DIVIDE ; NEU P1.7 = 0 THI VAO LABEL BUTTON_DIVIDE
	SETB P1.3 ; SET BIT P1.3
	CLR P1.0 ; CLR P1.0 DE QUET COT THU 1
SJMP SCANHANG

BUTTON_ON:  
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_ON ; DEN LABEL CLICK_ON
BUTTON_0: 
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_0 ; DEN LABEL CLICK_0
BUTTON_EQUAL: 
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_EQUAL ; DEN LABEL CLICK_EQUAL
BUTTON_ADD:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_ADD ; DEN LABEL CLICK_ADD
BUTTON_1:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_1 ; DEN LABEL CLICK_1
BUTTON_2:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_2 ; DEN LABEL CLICK_2
BUTTON_3:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_3 ; DEN LABEL CLICK_3
BUTTON_SUB:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_SUB ; DEN LABEL CLICK_SUB
BUTTON_4: 
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_4 ; DEN LABEL CLICK_4
BUTTON_5:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_5 ; DEN LABEL CLICK_5
BUTTON_6:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_6 ; DEN LABEL CLICK_6
BUTTON_MUL: 
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_MUL ; DEN LABEL CLICK_MUL
BUTTON_7:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_7 ; DEN LABEL CLICK_7
BUTTON_8:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_8 ; DEN LABEL CLICK_8
BUTTON_9:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_9 ; DEN LABEL CLICK_9
BUTTON_DIVIDE:
	ACALL DELAY ;CHONG DOI
	LJMP CLICK_DIVIDE ; DEN LABEL CLICK_DIVIDE

CLICK_ON: 
	SETB P2.0 ;SET BIT P2.0 DE RESET 8051
LJMP SCANHANG

CLICK_0:
	MOV R0, #'0' ; R0 CHUA MA ASCII CUA '0'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_EQUAL:
	MOV R0, #'=' ; R0 CHUA MA ASCII CUA '='
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
	ACALL RESULT ;GOI DEN LABEL RESULT
LJMP SCANHANG

CLICK_ADD:
	MOV R0, #'+' ;; R0 CHUA MA ASCII CUA '+'
	ACALL OPERATOR ;GOI DEN LABEL OPERATOR
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_1:
	MOV R0, #'1' ; R0 CHUA MA ASCII CUA '1'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_2:
	MOV R0, #'2' ; R0 CHUA MA ASCII CUA '2'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_3:
	MOV R0, #'3' ; R0 CHUA MA ASCII CUA '3'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_SUB:
	MOV R0, #'-' ; R0 CHUA MA ASCII CUA '-'
	ACALL OPERATOR ;GOI DEN LABEL OPERATOR
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_4: 
	MOV R0, #'4' ; R0 CHUA MA ASCII CUA 4'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_5:
	MOV R0, #'5' ; R0 CHUA MA ASCII CUA '5'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_6:
	MOV R0, #'6' ; R0 CHUA MA ASCII CUA '6'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_MUL:
	MOV R0, #'*' ; R0 CHUA MA ASCII CUA '*'
	ACALL OPERATOR ;GOI DEN LABEL OPERATOR
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_7:
	MOV R0, #'7' ; R0 CHUA MA ASCII CUA '7'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_8:
	MOV R0, #'8' ; R0 CHUA MA ASCII CUA '8'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_9:
	MOV R0, #'9' ; R0 CHUA MA ASCII CUA '9'
	ACALL STORE_NUM ; GOI LABEL STORE_NUM
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

CLICK_DIVIDE:
	MOV R0, #'/' ; R0 CHUA MA ASCII CUA '/'
	ACALL OPERATOR ;GOI DEN LABEL OPERATOR
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
LJMP SCANHANG

;DUNG DE TRUYEN KI TU DEN UART LCD
TRUYEN: 
	MOV SBUF, R0 ;SBUF = R0
	JNB TI, $ ;DOI T1 = 1
	CLR TI ; KHI T1=1 THI CLR T1 
	ACALL DELAY1MS 
RET

; XU LI VIEC LUU TOAN HANG THU 1 VAO THANH GHI
STORE_NUM:
	JB SECONDNUM, STORE_NUM2 ;NEU SECONDNUM = 1 NGHIA LA LUA TOAN HANG THU 2 THI NHAY DEN LABEL STORE_NUM2
	JB SECONDDIGIT, STORE_SECONDDIGIT_NUM1 ; NEU SECONDDIGIT = 1 NGHIA LA DANG LUU DIGIT THU2 THI NHAAY DEN LABEL STORE_SECONDDIGIT
	MOV A, R0 ;LUU MA ASCII CUA KI TU VAO THANH GHI ACC
	SUBB A, #30H ; DUA MA ASCII VE SO TUONG UNG
	MOV R1, A ; LUU GIA TRI CUA A VAO R1
	SETB SECONDDIGIT ;SET BIT SECONDDIGIT
RET

;DUNG DE LUU DIGIT THU 2 CUA TOAN HANG THU 1
STORE_SECONDDIGIT_NUM1:
	MOV A, R0  ;LUU MA ASCII VAO THANH GHI ACC
	MOV B, #10D ; GAN THANH GHI B = 10
	SUBB A, #30H  ; DUA MA ASCII VE SO TUONG UNG
	MOV R7, A ;GAN SO DO CHO R7
	MOV A, R1 ;DUA GIA TRI SAN CO TRONG R1(FIRST DIGIT) VAO ACC
	MUL AB ;NHAN A CHO B
	MOV R6, B ;DUA GIA TRI B VAO R6
	CJNE R6, #00H, OVERFLOW ; NEU B!-0 THI NHAY DE OVERFLOW(VI TRONG LEN MUL AB, B CHUA BIT TRAN)
	ADD A, R7 ;CONG GIA TRI CUA A VA R7
	JC OVERFLOW ; NEU KET QUA A + R7 BI TRAN THI NHAY DEN OVERFLOW
	MOV R1, A ; DUA GIA TRI TRONG A VAO R1
	SETB SECONDDIGIT ;SET BIT SECONDDIGIT
RET
; XU LI VIEC LUU TOAN HANG THU 2 VAO THANH GHI
STORE_NUM2:
	JB SECONDDIGIT, STORE_SECONDDIGIT_NUM2 ;NEU SECODDIGIT = 1 NGHIA LA DANG NHAP DIGIT THU 2 THI NHAY DEN LABEL STORE_SECONDDIGIT_NUM2
	MOV A, R0 ;R0=A
	SUBB A, #30H ;DUA MA ASCII VE SO TUONG UNG
	MOV R3, A ;LUA GIA TRI TRONG A VAO R3
	SETB SECONDDIGIT ;SET BIT SECONDDIGIT
RET

;DUNG DE LUU DIGIT THU 2 CUA TOAN HANG THU 2
STORE_SECONDDIGIT_NUM2:
	MOV A, R0 ; R0 = A 
	MOV B, #10D ; B=10
	SUBB A, #30H ;DUA MA ASCII VE SO TUONG UNG
	MOV R7, A ;LUU SO DO VAO R7
	MOV A, R3 ;LUU SO SAN CO TRONG R3(FIRST DIGIT CUA TOAN HANG THU 2) VAO A
	MUL AB ;A NHAN B
	MOV R6, B ;R6 = B
	CJNE R6, #00H, OVERFLOW ;NEU R6 != 0 THI NHAY DE LABEL OVERFLOW
	ADD A, R7 ; A+R7
	JC OVERFLOW ; NEU A + R7 BI TRAN THI NHAY DE LABEL OVERFLOW
	MOV R3, A ;LUA GIA TRI TRONG A VAO R3
	SETB SECONDDIGIT ;SET BIT SECONDDIGIT
RET

;XU LI VIEC LUA MA ASCII CUA PHEP TOAN(+-*/) VAO THANH GHI R2
OPERATOR:
	SETB SECONDNUM ;SET BIT SECONDNUM
	CLR SECONDDIGIT ;CLR BIT SECONDDIGIT
	MOV A, R0 ; R0 = A
	MOV R2, A ; A= R2
RET

;XU LI VIEC LUA VA XUAT KET QUA
RESULT:
	;XU LI PHEP CONG
	CJNE R2, #"+", SUB ;NEU KHONG PHEP PHEP CONG THI NHAY DE LABEL SUB
	MOV A, R1 ;LUA R1 VAO A
	CLR C ; CLR CARRY BIT
	ADD A, R3 ; A + R3
	JC OVERFLOW ; NEU A + R3 BI TRAN => OVERFLOW
	MOV R5, #0H ; GAN R5 = 0
	MOV R4, A ; DUA KET QUA VAO R4
LJMP ERROR ; NHAY DE LABEL ERROR
; XU LI PHEP TRU
SUB:
	CJNE R2, #"-", MULTI ;NEU KHONG PHAI PHEP TRU THI NHAY DE LABEL MULTI
	MOV A, R1 ; R1 = A
	CLR C ;CLR CARRY BIT
	SUBB A, R3 ;A = R3
	JC OVERFLOW ;NEU CARRY BIT DC SET THI NHAY DE OVERFLOW
	MOV R5, #0H ; R5 = 0
	MOV R4, A ; LUU KET QUA VAO R4
LJMP ERROR ; NHAY DEN LABEL ERROR

;XU LI PHEP NHAN
MULTI:
	CJNE R2, #"*", DIVIDE ;NEU KHONG PHAI PHEP NHAN THI NHAY DE LABEL DIVIDE
	MOV A, R1 ;R1 = A
	MOV B, R3 ;R3 = B
	MUL AB ; A X B
	MOV R7, B ; R7 = B
	CJNE R7, #0H, OVERFLOW ; NEU R7 != 0 THI NHAY DEN OVERFLOW
	MOV R5, #0H ; R5 = 0
	MOV R4, A ;LUA KET QUA VAO R4
LJMP ERROR ;NHAY DEN LABEL ERROR
;XU LI PHEP CHIA
DIVIDE:
	MOV A, R1 ; R1 = A
	MOV B, R3 ; R3 = B
	DIV AB; A / B
	MOV R4, A ; R4 = A
	MOV R5, B ; R5 = B
LJMP ERROR ; NHAY DEN LABEL ERROR

;XU LI VIEC XUAT "OVERFLOW" RA MAN HINH
OVERFLOW:
	MOV DPTR, #MES_OVERFLOW ;DUA CON TRO DEN #MES_OVERFLOW
	CLR C ;XOA CARRY BIT
	MOV R7, #0D ;R7 = 0
SHOW_MES_OVERFLOW:
	MOV A, R7 ;A = R7
	MOVC A, @A+DPTR ;A = DIA CHI DPTR TRO TOI + A
	MOV R0, A ;A = R0
	ACALL TRUYEN ;GOI DE LABEL TRUYEN
	JZ END_SHOW; NEU A = 0 THI END_SHOW
	INC R7 ; R7 + 1
	SJMP SHOW_MES_OVERFLOW ;NHAY DEN SHOW_MES_OVERFLOW
END_SHOW:
RET

ERROR:
	CJNE R3, #0D, NORMAL ; NEU R3 != 0 THI NHAY DE LABEL NORMAL
	CJNE R2, #"/", NORMAL ; NEU R2 != '/' THI NHAY DEN LABEL NORMAL
	MOV DPTR, #MES_ERROR ; DUA CON TRO DPTR DEN #MES_ERROR
	CLR C ;CLR CARRY BIT
	MOV R7, #0D ;R7 = 0
SHOW_MES_ERROR:
	MOV A, R7 ;A = R7
	MOVC A, @A+DPTR ;A = DIA CHI DPTR TRO TOI + A
	MOV R0, A ; A= R0
	ACALL TRUYEN ; NHAY DEN LABEL TRUYEN
	INC R7 ;R7 + 1
	JNZ SHOW_MES_ERROR ; NEU A != 0 THI NHAY VE SHOW_MES_ERROR
RET

; XU LI VIEC XUAT KET QUA (NEU KHONG OVERFLOW HAY ERROR)
NORMAL:
	MOV R7, #100D ;R7 = 100
	CLR C ; CLR CARRY BIT
	SUBB A, R7 ; LAY A - R7 (A LA KET QUA SAU KHI TINH TOAN)
	JC MINIMUM100 ; NEU CARRY BIT = 1 => A  R7 => NHAY DEN LABEL MINIMUM100
	MOV A, R4 ;LUU R4 VAO A(R4 LA KET QUA SAU KHI TINH TOAN)
	MOV B, R7 ;LUU R7 VAO B
	DIV AB ; A / B
	ADD A, #30H ;DUA A THANH MA ASCII TUONG UNG
	MOV R0, A ;R0 = A
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN
	MOV R4, B ;R4 = B
	MOV A, B ;A = B
	MOV R7, #10D ;R7 = 10
	MOV B, R7 ;B = R7
	DIV AB ; A / B
	ADD A, #30H ; DUA A VE MA ASCII TUONG UNG
	MOV R0, A ; R0 = A
	ACALL TRUYEN ; GOI DEN LABEL TRUYEN
	MOV A, B ; A = B
	ADD A, #30H ; DUA A VE MA ASCII TUONG UNG
	MOV R0, A ; R0 = A
	ACALL TRUYEN ; GOI DEN LABEL TRUYEN
	CJNE R5, #00H, DECIMAL ; NEU R5 != 0 THI NHAY DEN DECIMAL
RET

;; XU LI VIEC XUAT KET QUA BE HON 100 (NEU KHONG OVERFLOW HAY ERROR)
MINIMUM100:
	MOV R7, #10D ; R7 = 10
	CLR C ; CLR CARRY BIT
	MOV A, R4 ;R4 = A
	SUBB A, R7 ; A = A-R7
	JC MINIMUM10 ; NEU CARRY BIT DUOC SET => A < R7 => NHAY DEN LABEL MINIMUM10
	MOV A, R4 ;R4 =A
	MOV B, R7 ;B = R7
	DIV AB ; A/B
	ADD A, #30H ;DUA A VE MA ASCII TUONG UNG
	MOV R0, A ; R0 = A
	ACALL TRUYEN ; GOI DEN LABEL TRUYEN
	MOV A, B ; A = B
	ADD A, #30H ; DUA A VE MA ASCII TUONG UNG
	MOV R0, A ; R0=A
	ACALL TRUYEN ; GOI DEN LABEL TRUYEN
	CJNE R5, #00H, DECIMAL ; NEU R5 != 0 THI NHAY DEN LABEL DECIMAL
RET
;; XU LI VIEC XUAT KET QUA BE HON 10 (NEU KHONG OVERFLOW HAY ERROR)
MINIMUM10:
	MOV A, R4 ;R4=0
	ADD A, #30H ;DUA A VE MA ASCII TUONG UNG
	MOV R0, A ; R0 = A
	ACALL TRUYEN ; GOI DEN LABEL TRUYEN
	CJNE R5, #00H, DECIMAL ;NEU R5 != THI GOI DEN DECIMAL
RET

;XU LI VIEC TRUYEN PHAN THAP PHAN
DECIMAL:
	MOV R0, #"." ;R0 = '.'
	ACALL TRUYEN ;GOI DEN LABEL TRUYEN 
	MOV A, R5 ; R5 = A
	MOV B, #10D ; B = 10
	MUL AB ;A X B
	MOV B, R3 ;B = R3
	DIV AB ; A / B
	ADD A, #30H ; DUA A VE MA ASCII TUONG UNG
	MOV R0, A ; R0 = A
	ACALL TRUYEN ; GOI DEN LABEL TRUYEN
RET

;CAC HAM DELAY
DELAY1MS:
	MOV TH0, #0FCH
	MOV TL0, #67H
	SETB TR0
	JNB TF0, $
	CLR TF0
	CLR TR0
RET

DELAY:	MOV 62, #2		
DELAY1:	MOV 61, #250
DELAY2:	MOV 60, #250	
	DJNZ 60, $
	DJNZ 61, DELAY2
	DJNZ 62, DELAY1
	RET

;MANG KI TU
MES_OVERFLOW: DB "OVERFLOW!",0
MES_ERROR: DB "ERROR", 0

END