.model tiny
.code
org 100h
;==========================================================================================================

;VD: Number1:12345678h + Number2:321E654Dh 
;de nhap 12345678h e cho nhap lan luot 16bit dau(nhap ban so DECIMAL 5678HEX = 22136DECIMAL)va 16bit sau(nhap ban so DECIMAL 1234HEX = 4660DECIMAL)
;tuong tu de nhap 321E654Dh e cho nhap lan luot 16bit dau(nhap ban so DECIMAL 654DHEX = 25933DECIMAL )va 16bit sau(nhap ban so DECIMAL 321EHEX = 12830DECIMAL) 

;==========================================================================================================
main proc near
;LABEL DOC 16BIT DAU CUA NUMBER 1(5678H = 22136D) 
loop_number_1_1_main:
    ;xuat ra chuoi messageinputnumber_1_1
    mov ah,09h  
    mov dx,offset messageinputnumber_1_1    
    int 21h     
    
    ;cai gia tri mac dinh cho number_1=0
    mov number_1,0     
loop_read_number_1_1:
    
    ;doc 1 ki tu duoc nhap tu ban phim. ki tu doc duoc luu trong thanh ghi AL
    mov ah,01h  
    int 21h     
    
    ;kiem tra xem ki tu enter da duoc nhan hay chua. Neu chua thi thuc thi lenh tiep theo, neu roi thi nhay den label numbercomplete_1_1
    cmp al,0dh  
    je numbercomplete_1_1   
    
    ;kiem tra ki tu nhap vao co < '0' hay khong, neu < '0' thi nhay den label invaildcharacter_1_1
    cmp al,30h ;30 la ma acsii cua '0'   
    jl invalidcharacter_1_1 
    
    ;kiem tra ki tu nhap vao co > '9' hay khong, neu > '9' thi nhay den label invaildcharacter_1_1
    cmp al,39h  ;39 la ma ascii cua '9'
    jg invalidcharacter_1_1 
    
    ;dua ma ascii ve so tuong ung va luu trong thanh ghi bl
    sub al,30h                             
    mov bl,al   
    
    ;copy ki tu san co trong ax vao number_1
    mov ax,number_1
    ;nhan so san co trong ax cho 10    
    mul numberplace  
                    
    ;cong so vua moi nhap cho ax
    add ax,bx       
    mov number_1,ax
    
   
    jmp loop_read_number_1_1
;Label xuat chuoi message invaild character
invalidcharacter_1_1:
    mov ah,09h  
    mov dx,offset messageinvalidcharacter    
    int 21h     
    
    jmp loop_number_1_1_main

;Label Luu gia tri duoc nhap vao bo nho    
numbercomplete_1_1: 
    
    mov ax,number_1  
    
;==========================================================================================================
;LABEL DOC 16BIT TIEP THEO CUA NUMBER 1(1234H = 4660D)
loop_number_1_2_main:
    mov ah,09h  
    mov dx,offset messageinputnumber_1_2    
    int 21h     
    
    mov number_1+2,0    
loop_read_number_1_2:

    mov ah,01h  
                
    int 21h     
    
    cmp al,0dh  
    je numbercomplete_1_2   
    
    cmp al,30h  ;
                
    jl invalidcharacter_1_2 
 
    cmp al,39h  
    jg invalidcharacter_1_2 
    
    
    sub al,30h  
    mov ah,00                            
    mov bx,ax    
    
    mov ax,number_1+2   
    mul numberplace  
                    
    
    add ax,bx       
    mov number_1+2,ax
    
   
    jmp loop_read_number_1_2    

    
invalidcharacter_1_2:
    mov ah,09h  
    mov dx,offset messageinvalidcharacter    
    int 21h     
    
    jmp loop_number_1_2_main           

numbercomplete_1_2:
    
    mov ax,number_1+2  

;==========================================================================================================
;LABEL DOC 16BIT DAU CUA NUMBER 2(654DH=25933D)       

loop_number_2_1_main:
    mov ah,09h  
    mov dx,offset messageinputnumber_2_1    
    int 21h     
    
    mov number_2,0     
loop_read_number_2_1:

    mov ah,01h  
    int 21h     
    
    cmp al,0dh  
    je numbercomplete_2_1   
    
    cmp al,30h  
                
    jl invalidcharacter_2_1 
 
    cmp al,39h 
    jg invalidcharacter_2_1 
    
    
    sub al,30h  
    mov ah,00                            
    mov bx,ax    
    
    mov ax,number_2   
    mul numberplace  
                    
    
    add ax,bx       
    mov number_2,ax
    
   
    jmp loop_read_number_2_1

invalidcharacter_2_1:
    mov ah,09h  
    mov dx,offset messageinvalidcharacter    
    int 21h     
    
    jmp loop_number_2_1_main
    
numbercomplete_2_1: 
    
    mov ax,number_2  
;==========================================================================================================
;LABEL DOC 16BIT TIEP THEO CUA NUMBER 2(123EH=12830D)
loop_number_2_2_main:
    mov ah,09h  
    mov dx,offset messageinputnumber_2_2    
    int 21h    
    
    mov number_2+2,0    
loop_read_number_2_2:

    mov ah,01h  
    int 21h     
    
    cmp al,0dh 
    je numbercomplete_2_2   
    
    cmp al,30h   
                
    jl invalidcharacter_2_2 
 
    cmp al,39h  
    jg invalidcharacter_2_2 
    
    
    sub al,30h  
    mov ah,00                            
    mov bx,ax   
    
    mov ax,number_2+2   
    mul numberplace  
                    
    
    add ax,bx       
    mov number_2+2,ax
    
   
    jmp loop_read_number_2_2    

    
invalidcharacter_2_2:
    mov ah,09h  
    mov dx,offset messageinvalidcharacter    
    int 21h     
    
    jmp loop_number_2_2_main           

numbercomplete_2_2:
    
    mov ax,number_2+2  
 
;==========================================================================================================
;THUC HIEN CONG 2 SO 32 BIT BANG CACH CONG LAN LUOT 16 BIT DAU CUA NUMBER 1 CHO 16 BIT DAU CUA NUMBER 2 
;VA 16BIT TIEP THEO CUA NUMBER 1 CHO 16BIT TIEP THEO CUA NUMBER 2
    mov ax, number_1 ;Copy 16 bit dau cua number 1 vao ax 
    mov bx, number_2 ;Copy 16 bit dau cua number 2 vao bx
    clc              ;Clear carry
    add ax, bx       ;Cong ax cho bx
    mov result, ax   ;Luu ket qua vao 16 bit dau cua result
    mov ax, number_1+2; copy 16bit tiep theo cua number 1 vao ax 
    mov bx, number_2+2; Copy 16bit tiep theo cua number 2 vao bx
    adc ax, bx ; ax + bx + carry
    mov result+2, ax ;luu ket qua vao 16bit sau cua result
    adc dx, 00h ;luu carry vao dx
    mov result+4,dx ; luu dx vao 16bit tiep theo 
    
    ;xuat chuoi result
    mov ah,09h  
    mov dx,offset messageresult    
    int 21h
;==========================================================================================================          
;XUAT KET QUA DUOI DANG DECIMAL    
    ;luu 16bit cao cua result vao var_32bits_high 
    mov     ax,result+2
    mov     var_32bits_high,ax
    ;luu 16bit thap cua result vao var_32bits_low
    mov     ax,result
    mov     var_32bits_low,ax
    
    ;cai gia tri khoi dau cho cac thanh ghi
    mov     ax,0
    mov     bx,0        ;bx: quotidient_32bits_high    
    mov     dx,0        ;dx: quotidient_32bits_low  
    mov     cx,0        ;counter = 0  
    
    ;kiem tra xem result la so 16bit hay 32 bit
    mov     ax,var_32bits_high
    cmp     ax,0                                                 
    jne     _32bits_routine; neu la so 32 bit thi nhay den label _32bits_routine de xuat so 32 bit
    jmp     _16bits_routine; neu la so 16 bit thi nhay den label _16bits_routine de xuat so 16 bit
    
;//////////////////////////////////////////////////////////////////////////////////////////////////////////
;GIAI THUAT XUAT SO 32 BIT
;Let A be the number in question, we now divide by 10:
;A = q*10 + r (0 <= r <= 9)
;now separate A into the high and low parts:
;A_high * 2^16 + A_low = q*10 + r (0 <= r <= 9)
;our task is to find q and r. To do that we first divide the high part:
;A_high = q_high * 10 + r_high (0<= r_high <= 9)
;=> A_high * 2^16 = (q_high*2^16)*10 + r_high * 2^16 . Note that r_high is from 0 to 9, so to divide r_high * 2^16 by 10, we simply need to perform the calculations and then store the results in a lookup table! The result:
;r_high * 2^16 = q_high_redundant * 10 + r_high_redundant (0 <= r_high_redundant <= 9) (found by using a lookup table) (an interesting note: q_high_redundant is only 16 bits!)
;Now divide the low part:
;A_low = q_low * 10 + r_low
;=> A = A_high * 2^16 + A_low=((q_high*2^16)*10 + r_high * 2^16) + q_low * 10 + r_low = ((q_high*2^16)*10 + q_high_redundant * 10 + r_high_redundant) + q_low * 10 + r_low= (q_high*2^16 + q_low + q_high_redundant)*10 + r_low + r_high_redundant
;//////////////////////////////////////////////////////////////////////////////////////////////////////////
;XUAT SO 32 BIT        
_32bits_routine:
    mov     cx,0 ;
;if == -2147483648 (-2^31)
    ;kiem tra xem result == 2^31(8000 0000h) hay khong neu khong bang thi nhay de label check_if_neg   
    mov     ax,var_32bits_high
    cmp     ax,lowest_signed_32bits_high
    jne     check_if_neg  
    mov     ax,var_32bits_low
    cmp     ax,lowest_signed_32bits_low
    jne     check_if_neg
    ; neu result == 2^31(8000 0000h) thi xuat ra -2147483648 
    lea     dx,lowest_signed_32bits_string 
    mov     ah,9
    int     21h
    jmp     return_to_dos
    ;kiem tra xem result < 0 hay khong. Neu khong thi nhay de label preparations  
check_if_neg:
    mov     ax,var_32bits_high
    cmp     ax,0
    jnl      preparations
    ;xuat ra dau tru
    mov     ah,2
    mov     dl,'-'
    int     21h 
    ; doi result -> result bu 2(-result) vi result < 0 => -result > 0
    mov     ax,var_32bits_high 
    xor     ax,negate_mask
    mov     var_32bits_high,ax
    mov     ax,var_32bits_low
    xor     ax,negate_mask
    inc     ax  
    mov     var_32bits_low,ax
    jnc     preparations
    mov     ax,var_32bits_high
    inc     ax
    mov     var_32bits_high,ax           
preparations: ;  var_32bits_high = quotidient_32bits_high va var_32bits_low = quotidient_32bits_low  
    mov     ax,var_32bits_high
    mov     quotidient_32bits_high,ax
    mov     ax,var_32bits_low
    mov     quotidient_32bits_low,ax
while_32bits:
    ; chia quotidient_32bits_high va quotidient_32bits_low. Neu chia het(quotidient_32bits_high=0, quotidient_32bits_low=0) thi se out vong lap va print
    mov     ax,quotidient_32bits_high
    cmp     ax,0
    jne     div_high_part
    mov     ax,quotidient_32bits_low
    cmp     ax,0
    jne     div_high_part
    jmp     print_char    
div_high_part:           
    ;chia quotidient_32bits_high cho 10. Luu thuong vao qhigh, du vao rhigh 
    mov     dx,0
    mov     ax,quotidient_32bits_high
    div     base_10
    mov     qhigh,ax
    mov     rhigh,dx
    ;xet cac truong hop cua rhigh
    mov     ax,rhigh
    cmp     ax,0    ; neu rhigh = 0 thi nhay den label _rhigh0 
    je      _rhigh0
    cmp     ax,1    ; neu rhigh = 1 thi nhay den label _rhigh1
    je      _rhigh1
    cmp     ax,2    ; neu rhigh = 2 thi nhay den label _rhigh2
    je      _rhigh2
    cmp     ax,3    ; neu rhigh = 3 thi nhay den label _rhigh3
    je      _rhigh3
    cmp     ax,4    ; neu rhigh = 4 thi nhay den label _rhigh4
    je      _rhigh4
    cmp     ax,5    ; neu rhigh = 5 thi nhay den label _rhigh5
    je      _rhigh5
    cmp     ax,6    ; neu rhigh = 6 thi nhay den label _rhigh6
    je      _rhigh6
    cmp     ax,7    ; neu rhigh = 7 thi nhay den label _rhigh7
    je      _rhigh7
    cmp     ax,8    ; neu rhigh = 8 thi nhay den label _rhigh8
    je      _rhigh8
    cmp     ax,9    ; neu rhigh = 9 thi nhay den label _rhigh9
    je      _rhigh9
_rhigh0:
    mov     ax,qhigh0 ;neu rhigh = 0 => qhigh_redundant = qhigh0(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh0(TRA TRONG BANG CHIA RHIGH) 
    mov     qhigh_redundant,ax
    mov     ax,rhigh0
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh1:
    mov     ax,qhigh1 ;neu rhigh = 1 => qhigh_redundant = qhigh1(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh1(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh1
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh2:
    mov     ax,qhigh2 ;neu rhigh = 2 => qhigh_redundant = qhigh2(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh2(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh2
    mov     rhigh_redundant,ax    
    jmp     _aftercase
_rhigh3:
    mov     ax,qhigh3 ;neu rhigh = 3 => qhigh_redundant = qhigh3(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh3(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh3
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh4:
    mov     ax,qhigh4 ;neu rhigh = 4 => qhigh_redundant = qhigh4(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh4(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh4
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh5:
    mov     ax,qhigh5 ;neu rhigh = 5 => qhigh_redundant = qhigh5(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh5(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh5
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh6:
    mov     ax,qhigh6 ;neu rhigh = 6 => qhigh_redundant = qhigh6(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh6(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh6
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh7:
    mov     ax,qhigh7 ;neu rhigh = 7 => qhigh_redundant = qhigh7(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh7(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh7
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh8:
    mov     ax,qhigh8 ;neu rhigh = 8 => qhigh_redundant = qhigh8(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh8(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh8
    mov     rhigh_redundant,ax
    jmp     _aftercase
_rhigh9:    
    mov     ax,qhigh9 ;neu rhigh = 9 => qhigh_redundant = qhigh9(TRA TRONG BANG CHIA RHIGH), rhigh_redundant=rhigh9(TRA TRONG BANG CHIA RHIGH)
    mov     qhigh_redundant,ax
    mov     ax,rhigh9
    mov     rhigh_redundant,ax
    jmp     _aftercase
_aftercase:
    ;chia quotidient_32bits_low cho 10. Luu thuong vao qlow, du vao rlow
    mov     ax,0
    mov     q_0,ax ; q_0 = 0 chuan bi chua so du tu phep chia phan high
    mov     dx,0   ; dx = 0 chuan bi chua so nho len phan high(neu co)
    mov     ax,quotidient_32bits_low
    div     base_10
    mov     qlow,ax
    mov     rlow,dx
    
    mov     ax,rlow
    add     ax,rhigh_redundant ; cong phan du cua phep chia phan high cho phan du cua phan low          
    ; tong phan du chia cho 10 10 => q_0 chua thuong, ax chua phan du (vi rlow va rhigh_redundant deu la phan du nen rlow + rhigh_redundant chi co 2 truong hop la > 10 hoac < 10 )  
    cmp     ax,base_10
    jl      after_if
    sub     ax,base_10
    mov     dx,1 
    mov     q_0,dx     
after_if:
    ;cong 
    mov     rlow,ax ;dua phan du vao rlow
    
    mov     ax,q_0  ;q_0 + qlow 
    add     ax,qlow
    
    ; q_o + qlow co carry thi se tang qhigh len 1 don vi neu khong thi nhay de label1 
    mov     qlow,ax
    jnc     label1
    mov     ax,qhigh
    inc     ax
    mov     qhigh,ax     
label1: ;qlow + qhigh_redundant co carry thi se  tang qhigh len 1 don vi. Neu khong thi nhay den label2    
    mov     ax,qlow
    add     ax,qhigh_redundant
    mov     qlow,ax
    jnc     label2
    mov     ax,qhigh
    inc     ax
    mov     qhigh,ax
label2:    
    ;dua rlow vao stack va tang cx    
    mov     ax,rlow
    push    ax     
    inc     cx
    ;qhigh = quotidient_32bits_high, qlow=quotidient_32bits_low va lap lai long lap
    mov     ax,qhigh
    mov     quotidient_32bits_high,ax
    mov     ax,qlow
    mov     quotidient_32bits_low,ax
    jmp     while_32bits

;XUAT DSO 16 BIT      
_16bits_routine: ; gan cac gia tri de chuan bi chia
    mov     ax,var_32bits_low
    mov     bx,0    
    mov     cx,0   
while_loop:
    ; neu chia het(ax=0) thi nhay de label print
    cmp     ax,0
    je      print_char                 
    ;chia ax cho 10. Thuong luu trong ax, dx luu so du
    mov     dx,0
    div     base_10
    mov     bx,ax ;bx stores quotidient  
    mov     ax,dx ;dx stores remainder
    ;dua so du vao stack
    push    ax  
    ; cx = cx +1
    inc     cx       
    ;
    mov     ax,bx ; gan thuong = ax de tiep tuc vong lap
    jmp     while_loop 
print_char:
    ;neu cx = 0 thi out chuong trinh
    cmp     cx,0
    je      return_to_dos
    ;pop lan luot cac so nho trong stack
    pop     ax
    ; vi cac so nho 0 -> 9 nen set ah =2 k lm anh huong den al
    mov     ah,2 ; ah = 2 de xuat ki tu ra
    mov     dl,al
    add     dl,30h   ;du so du ve dang ascii 0 -> '0', 1 -> '1'
    int     21h
    dec     cx ; cx=cx - 1
    jmp     print_char

return_to_dos:
    mov     ah,4ch
    int     21h

numberplace dw 0AH
number_1 dw 2 dup(?)
number_2 dw 2 dup(?)
result dw 3 dup(?)
messageresult db 0ah,0dh,"Result: $"
messageinvalidcharacter db 0ah,0dh,"Invalid Character$"
messageinputnumber_1_1 db 0ah,0dh,"Please Input first 16-bit number 1: $"
messageinputnumber_1_2 db 0ah,0dh,"Please Input second 16-bit number 1: $"
messageinputnumber_2_1 db 0ah,0dh,"Please Input first 16-bit number 2: $"
messageinputnumber_2_2 db 0ah,0dh,"Please Input second 16-bit number 2: $"
base_10     dw      10     
var_32bits_high     dw      0
var_32bits_low     dw      0
quotidient_32bits_high      dw      0
quotidient_32bits_low       dw      0
negate_mask         equ      0FFFFh  
lowest_signed_32bits_high        dw     8000h
lowest_signed_32bits_low         dw     0000h
lowest_signed_32bits_string      dw     "-2147483648$"
qhigh       dw      0
rhigh       dw      0
qlow        dw      0
rlow        dw      0
qhigh_redundant     dw      0 
rhigh_redundant     dw      0
q_0         dw      0
;BANG CHIA RHIGH     
qhigh0      equ     0h
rhigh0      equ     0h
qhigh1      equ     1999h
rhigh1      equ     6h
qhigh2      equ     3333h
rhigh2      equ     2h
qhigh3      equ     4CCCh
rhigh3      equ     8h
qhigh4      equ     6666h
rhigh4      equ     4h
qhigh5      equ     8000h
rhigh5      equ     0h
qhigh6      equ     9999h
rhigh6      equ     6h
qhigh7      equ     0B333h
rhigh7      equ     2h
qhigh8      equ     0CCCCh
rhigh8      equ     8h
qhigh9      equ     0E666h
rhigh9      equ     4h
end main




;                    EM SE THUC HIEN PHEP CONG 32 BIT 1111 1111H + 2222 2222H = 3333 3333H(858993459D)
;                    DE NHAP SO 1111 1111H, E THUC HIEN NHAP 2 LAN, 1 LAN 16 BIT LOW(1111H = 4369D), 1 LAN 16 BIT HIGH(1111H = 4369D) BANG SO DECIMAL 
;                    THUC HIEN TUONG TU VOI KHI NHAP 2222 2222H (2222H = 8738D)
 