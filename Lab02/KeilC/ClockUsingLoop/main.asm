ORG 4000H
DB 0c0h,0f9h,0a4h,0b0h,99h,92h,82h,0f8h,80h,90h
;Thu tu luu tru cua cac thanh ghi {R2}{R3}:{R4}{R5}
ORG 0000H
LJMP main
ORG 30H
delay_60ms_Loop:
	MOV R7, #60
	Start: 
		ACALL delay
		DJNZ R7, Start
		RET	
	delay:
		MOV R0, #250
		MOV R1, #250
	Loop1:
		DJNZ R0, Loop1
	Loop2:
		DJNZ R1, Loop2
	RET
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
		CLR A
		MOV A,R2
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_60ms_Loop
    HienThiDonViGio:
	MOV P3, #00000001b
	HienThiDonViGio_1:
		CLR A
		MOV A,R3
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_60ms_Loop
    HienThiChucPhut:
	MOV P3, #00000010b
	HienThiChucPhut_1:
		CLR A
		MOV A,R4
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_60ms_Loop
    HienThiDonViPhut:
	MOV P3, #00000011b
	HienThiDonViPhut_1:
		CLR A
		MOV A,R5
		MOVC A,@A+DPTR
		MOV P2, A
		LCAlL delay_60ms_Loop
	DJNZ R6, Init_Clock
	MOV R6, #50
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
			LCALL delay_60ms_Loop
		    MOV R5,#0
			MOV R4,#0
			MOV R3,#0
			MOV R2,#0
		JMP Loop
END