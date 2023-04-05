ORG 4000H
DB 0c0h,0f9h,0a4h,0b0h,99h,92h,82h,0f8h,80h,90h
;Thu tu luu tru cua cac thanh ghi {R2}{R3}:{R4}{R5}
ORG 0000H
LJMP main
ORG 30H
delay_10ms_Timer:
    MOV TMOD, #01h
	MOV TH0, #0D8h
	MOV TL0, #0F0h
	SETB TR0
	JNB TF0, $
	CLR TF0
	CLR TR0
RET
Setup_Clock:
MOV R6, #250
MOV R7, #6
CJNE R2, #2d,Init_Clock
CJNE R3, #4d,Init_Clock
RET
Init_Clock:
	MOV DPTR, #4000H
    HienThiChucGio:
	MOV P3, #00000000b
	HienThiChucGio_1:
		;MOV P3, A
		CLR A
		;MOV R2, #01h
		MOV A,R2
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_10ms_Timer
    HienThiDonViGio:
	MOV P3, #0000001b
	HienThiDonViGio_1:
		;MOV P3, A
		CLR A
		;MOV R3, #00h
		MOV A,R3
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_10ms_Timer
    HienThiChucPhut:
	MOV P3, #00000010b
	HienThiChucPhut_1:
		;MOV P3, A
		CLR A
		;MOV R4, #03h
		MOV A,R4
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_10ms_Timer
    HienThiDonViPhut:
	MOV P3, #00000011b
	HienThiDonViPhut_1:
		;MOV P3, A
		CLR A
		;MOV R5, #09h
		MOV A,R5
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_10ms_Timer
	DJNZ R6, Init_Clock
	MOV R6, #250
	DJNZ R7, Init_Clock
	INC R5
	CJNE R5,#10, Setup_Clock
	MOV R5, #0
	INC R4
	CJNE R4,#6, Setup_Clock
	MOV R4, #0
	INC R3
	CJNE R3,#10, Setup_Clock
	MOV R3, #0
	INC R2
	JMP Setup_Clock
RET
main:      
	   MOV R5,#0
	   MOV R4,#3
	   MOV R3,#3
	   MOV R2,#2
	   Loop:
			LCALL Setup_Clock
			LCALL delay_10ms_Timer
		    MOV R5,#0
			MOV R4,#0
			MOV R3,#0
			MOV R2,#0
		JMP Loop
END