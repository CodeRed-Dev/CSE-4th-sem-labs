	AREA RESET, CODE, READONLY
    EXPORT __Vectors
__Vectors
	DCD 0x10001000
	DCD Reset_Handler
	
	AREA mycode, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =SRC1
	LDR R1, =SRC2
	LDR R2, =DST
	LDR R3, [R0]
	MOV R6, #0xF
	MOV R7, #1
	MOV R9, #10
	BL CONV
	
	MOV R5, R4
	LDR R3, [R1]
	MOV R7, #1
	MOV R4, #0
	MOV R8, #0
	BL CONV
	
	MUL R4, R4, R5
	MOV R0, #0
	MOV R1, #0
	MOV R7, #0
	
	BL DON
	
	STR R1, [R2]

STOP 	B STOP


CONV	AND R8, R3, R6
	MUL R8, R7
	ADD R4, R8
	MUL R7, R9
	LSR R3, #4
	CMP R3, #0
	BHI CONV
	BX LR
	
DON CMP R4, #10
 	BCC STO
	SUB R4, #10
	ADD R0, #1
	B DON
STO	LSL R4, R7
	ADD R1, R4
	ADD R7, #4
	MOV R4, R0
	MOV R0, #0
	CMP R4, #0
	BHI DON
	BX LR

SRC1	DCD 0x1234
SRC2	DCD 0x2222
	AREA MYDATA, DATA, READWRITE
DST DCD 0x0
	END
