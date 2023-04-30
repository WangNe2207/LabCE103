org 00h
ljmp main
org 0003H
ljmp pause
Cong1:
	lcall Delay1ms
	jnb P1.0, $
	inc R3
	cjne R3, #10, dem
	mov R3, #0
	inc R2
ret
Tru1:
	lcall Delay1ms
	jnb P1.1, $
	dec R3
	cjne R3, #0, dem
	mov R3, #9
	dec R2
ret
Delay2_49ms:
	mov TMOD, #01H
	mov TH0, #0F7H
	mov TL0, #09H
	setb TR0
	jnb TF0, $
	clr TF0
	clr TR0
ret
Delay1ms:
	mov TMOD, #01H
	mov TH0, #0FCH
	mov TL0, #67H
	setb TR0
	jnb TF0, $
	clr TF0
	clr TR0
ret
pause:
	inc R6
	cjne R6, #2, out
	mov R6, #0
	out:
reti
reset:
	mov R6, #0
	mov R5, #0
	mov R4, #0
	mov R3, #0
	mov R2, #0
dem:
	mov P3, #8Fh
	mov P2, R5
	lcall Delay2_49ms
	mov P3, #4Fh
	mov P2, R4
	lcall Delay2_49ms
	mov P3, #2Fh
	mov P2, R3
	lcall Delay2_49ms
	mov P3, #1Fh
	mov P2, R2
	lcall Delay2_49ms
	jnb P1.0, Cong1
	jnb P1.1, Tru1
	cjne R6, #1, up
jmp dem
up:
	inc R5
	cjne R5, #10, dem
	mov R5, #0
	inc R4
	cjne R4, #10, dem
	mov R4, #0
	inc R3
	cjne R3, #10,dem
	mov R3, #0
	inc R2
	cjne R2, #10, dem
	mov R2, #0
ret
main:
	mov IE, #85h
	setb IT1
	setb IT0
	
	mov R6, #0
	mov R5, #0
	mov R4, #0
	mov R3, #0
	mov R2, #0
	
	loop:
		lcall dem
	sjmp loop
	
end
	