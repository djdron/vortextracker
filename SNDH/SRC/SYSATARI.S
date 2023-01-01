
	SECTION _CODE,CODE
	CNOP 0,2
	XDEF _SYSATARI$$_HLT
_SYSATARI$$_HLT:
	XDEF HALT_ERROR
HALT_ERROR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.b	d0,-2(a6)
	move.b	-2(a6),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L3:
.L4:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FILLCHAR$$$$$LONGINT$BYTE
_SYSATARI$$_FILLCHAR$$$$$LONGINT$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a0
	move.l	12(a6),d1
	move.b	16(a6),d0
	cmp.l	#65535,d1
	ble	.L9
	bra	.L10
.L11:
	move.b	d0,(a0)+
.L10:
	subq.l	#1,d1
	cmp.b	#-1,d1
	bne	.L11
	bra	.L12
.L13:
	move.b	d0,(a0)+
.L9:
	dbra	D1,.L13
.L12:
.L7:
.L8:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_FILLOBJECT$$$$$LONGINT$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a0
	move.l	12(a6),d1
	move.w	16(a6),d0
	cmp.l	#65535,d1
	ble	.L16
	bra	.L17
.L18:
	move.b	d0,(a0)+
.L17:
	subq.l	#1,d1
	cmp.b	#-1,d1
	bne	.L18
	bra	.L19
.L20:
	move.b	d0,(a0)+
.L16:
	dbra	D1,.L20
.L19:
.L14:
.L15:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_INT_HELP_CONSTRUCTOR:
	move.l	a6,-(sp)
	move.l	sp,a6
	XDEF HELP_CONSTRUCTOR
HELP_CONSTRUCTOR:
	move.l	a5,d0
	tst.l	d0
	bne	.L23
	subq.l	#4,sp
	move.l	sp,a5
	movem.l	d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp,-(sp)
	move.l	8(a6),a0
	move.l	(a0),-(sp)
	move.l	a5,-(sp)
	jsr	_SYSATARI$$_GETMEM$POINTER$LONGINT
	movem.l	(sp)+,d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp
	move.l	(a5),a5
	add.l	#4,sp
	move.l	a5,d0
	tst.l	d0
	beq	.L24
	move.l	a5,12(a6)
.L23:
	move.l	8(a6),d0
	or.l	d0,d0
	bne	.L25
	add.l	#1,d0
	rts
.L25:
	movem.l	d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp,-(sp)
	move.w	#0,-(sp)
	move.l	8(a6),a0
	move.l	(a0),-(sp)
	move.l	a5,-(sp)
	jsr	_SYSATARI$$_FILLOBJECT$$$$$LONGINT$BYTE
	movem.l	(sp)+,d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp
	move.l	8(a6),d0
	move.l	d0,(a5)
	or.l	d0,d0
.L24:
	rts
.L21:
.L22:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_HELP_FAIL:
	move.l	a6,-(sp)
	move.l	sp,a6
.L26:
.L27:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_INT_HELP_DESTRUCTOR:
	move.l	a6,-(sp)
	move.l	sp,a6
	XDEF HELP_DESTRUCTOR
HELP_DESTRUCTOR:
	subq.l	#4,sp
	move.l	sp,d6
	movem.l	d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp,-(sp)
	move.l	8(a6),d0
	or.l	d0,d0
	beq	.L30
	move.l	12(a6),a0
	move.l	(a0),a1
	move.l	(a1),-(sp)
	clr.l	(a0)
	move.l	d6,a1
	move.l	a0,(a1)
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_FREEMEM$POINTER$LONGINT
.L30:
	movem.l	(sp)+,d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp
	add.l	#4,sp
	rts
.L28:
.L29:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_NEW_CLASS:
	XDEF NEW_CLASS
NEW_CLASS:
	move.l	8(a6),d0
	tst.l	d0
	beq	.L33
	move.l	a5,-(sp)
	jsr	16(a5)
	move.l	d0,8(a6)
	move.l	d0,a5
	bra	.L34
.L33:
	move.l	a5,8(a6)
.L34:
.L31:
.L32:
	rts
	CNOP 0,2
_SYSATARI$$_DISPOSE_CLASS:
	XDEF DISPOSE_CLASS
DISPOSE_CLASS:
	move.l	8(a6),d0
	move.l	a5,8(a6)
	tst.l	d0
	beq	.L37
	move.l	(a5),d0
	move.l	a5,-(sp)
	move.l	d0,a0
	jsr	20(a0)
.L37:
	move.l	8(a6),a5
.L35:
.L36:
	rts
	CNOP 0,2
_SYSATARI$$_CO:
	XDEF CHECK_OBJECT
CHECK_OBJECT:
	move.l	d0,-(sp)
	tst.l	a0
	beq	.L40
	move.l	(a0),d0
	add.l	4(a0),d0
	bne	.L40
	bra	.L41
.L40:
	move.l	(sp)+,d0
	move.b	#210,d0
	jsr	HALT_ERROR
.L41:
	move.l	(sp)+,d0
.L38:
.L39:
	rts
	CNOP 0,2
_SYSATARI$$_GET_ADDR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),a0
	cmp.l	#0,a0
	beq	.L44
	move.l	4(a0),a0
.L44:
	move.l	a0,-4(a6)
.L42:
	move.l	-4(a6),d0
.L43:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_GET_NEXT_FRAME$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),a0
	cmp.l	#0,a0
	beq	.L47
	move.l	(a0),a0
.L47:
	move.l	a0,-4(a6)
.L45:
	move.l	-4(a6),d0
.L46:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_HANDLEERROR$2$_$GET_ADDR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	(a6),a0
	move.l	4(a0),a0
	move.l	a0,-4(a6)
.L50:
	move.l	-4(a6),d0
.L51:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_HANDLEERROR$2$_$GET_ERROR_BP:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	(a6),d0
	move.l	d0,-4(a6)
.L52:
	move.l	-4(a6),d0
.L53:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_HANDLEERROR$LONGINT:
handleerror:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	TC__SYSATARI$$_ERRORPROC,d2
	cmp.l	#0,d2
	bne	.L54
	jmp	.L55
.L54:
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$2$_$GET_ADDR
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	8(a6),-(sp)
	move.l	TC__SYSATARI$$_ERRORPROC,a1
	jsr	(a1)
.L55:
	move.l	8(a6),d2
	move.w	d2,TC__SYSATARI$$_ERRORCODE
	move.l	8(a6),d2
	move.w	d2,U_SYSATARI_EXITCODE
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$2$_$GET_ADDR
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_ERRORADDR
	move.b	#1,TC__SYSATARI$$_DOERROR
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$2$_$GET_ERROR_BP
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_ERRORBASE
	move.w	TC__SYSATARI$$_ERRORCODE,d2
	and.l	#65535,d2
	move.b	d2,d3
	lsl.w	#8,d3
	move.w	d3,-(sp)
	jsr	_SYSATARI$$_HALT$BYTE
.L48:
.L49:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_RUNERROR_$GET_ADDR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	(a6),a0
	move.l	4(a0),a0
	move.l	a0,-4(a6)
.L74:
	move.l	-4(a6),d0
.L75:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_RUNERROR_$GET_ERROR_BP:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	(a6),d0
	move.l	d0,-4(a6)
.L76:
	move.l	-4(a6),d0
.L77:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RUNERROR$WORD
_SYSATARI$$_RUNERROR$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	8(a6),d2
	move.w	d2,TC__SYSATARI$$_ERRORCODE
	move.w	8(a6),d2
	move.w	d2,U_SYSATARI_EXITCODE
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_RUNERROR_$GET_ADDR
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_ERRORADDR
	move.b	#1,TC__SYSATARI$$_DOERROR
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_RUNERROR_$GET_ERROR_BP
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_ERRORBASE
	move.w	TC__SYSATARI$$_ERRORCODE,d2
	and.l	#65535,d2
	move.b	d2,d3
	lsl.w	#8,d3
	move.w	d3,-(sp)
	jsr	_SYSATARI$$_HALT$BYTE
.L72:
.L73:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_IO1$LONGINT
_SYSATARI$$_IO1$LONGINT:
	XDEF IOCHECK
IOCHECK:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#264,sp
	movem.l	d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp,-(sp)
	jsr	_SYSATARI$$_IORESULT
	move.w	d0,d2
	and.l	#65535,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),d2
	tst.l	d2
	bne	.L94
	jmp	.L95
.L94:
	lea.l	U_SYSATARI_OUTPUT,a0
	move.l	a0,-8(a6)
	pea.l	.L98
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-4(a6),-(sp)
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_LONGINT
	pea.l	.L103
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	#2048,-(sp)
	move.l	8(a6),-(sp)
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_HEXSTR$LONGINT$BYTE
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-8(a6),-(sp)
	jsr	WRITELN_TEXT
	jsr	FLUSH_STDOUT
	move.l	-4(a6),d2
	move.b	d2,d3
	lsl.w	#8,d3
	move.w	d3,-(sp)
	jsr	_SYSATARI$$_HALT$BYTE
.L95:
	movem.l	(sp)+,d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp
.L90:
.L91:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RE_OVERFLOW
_SYSATARI$$_RE_OVERFLOW:
	XDEF RE_OVERFLOW
RE_OVERFLOW:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#264,sp
	move.l	4(a6),d0
	move.l	d0,-4(a6)
	lea.l	U_SYSATARI_OUTPUT,a0
	move.l	a0,-8(a6)
	pea.l	.L116
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	#2048,-(sp)
	move.l	-4(a6),-(sp)
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_HEXSTR$LONGINT$BYTE
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-8(a6),-(sp)
	jsr	WRITELN_TEXT
	jsr	FLUSH_STDOUT
	move.l	#215,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L112:
.L113:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_STRCOPY:
	XDEF STRCOPY
STRCOPY:
	move.l	d0,d1
	move.b	(a0)+,d0
	and.w	#255,d0
	cmp.w	d1,d0
	ble	.L127
	move.b	d1,d0
.L127:
	andi.l	#255,d0
	move.l	d0,d1
	move.b	d0,(a1)+
	tst.b	d1
	beq	.L128
	bra	.L129
.L130:
	move.b	(a0)+,(a1)+
.L129:
	dbra	D1,.L130
.L128:
.L125:
.L126:
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_STRCONCAT$POINTER$POINTER
_SYSATARI$$_STRCONCAT$POINTER$POINTER:
	XDEF STRCONCAT
STRCONCAT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.b	#255,d0
	move.l	8(a6),a0
	move.l	12(a6),a1
	sub.b	(a0),d0
	move.b	(a1),d6
	and.w	#255,d0
	and.w	#255,d6
	cmp.w	d6,d0
	ble	.L133
	move.b	(a1),d0
.L133:
	move.b	(a0),d6
	and.l	#255,d6
	lea	1(a0,d6.l),a0
	add.l	#1,a1
	move.b	d0,d6
	tst.b	d6
	beq	.L134
	bra	.L135
.L136:
	move.b	(a1)+,(a0)+
.L135:
	dbra	D6,.L136
	move.l	8(a6),a0
	add.b	d0,(a0)
.L134:
.L131:
.L132:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_STRCMP:
	XDEF STRCMP
STRCMP:
	move.b	(a0)+,d0
	move.b	(a1)+,d6
	move.b	d6,d1
	cmp.b	d0,d6
	ble	.L139
	move.b	d0,d6
.L139:
	tst.b	d6
	beq	.L140
	andi.l	#255,d6
	subq.l	#1,d6
	bmi	.L140
	or.l	d0,d0
.L141:
	cmpm.b	(a1)+,(a0)+
.L142:
	dbne	D6,.L141
	bne	.L143
.L140:
	cmp.b	d1,d0
.L143:
.L137:
.L138:
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_STRPAS$PCHAR
_SYSATARI$$_STRPAS$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#260,sp
	move.b	#0,-2(a6)
	move.b	#0,-260(a6)
	jmp	.L152
.L151:
	move.b	-2(a6),d2
	and.l	#255,d2
	add.l	#1,d2
	move.b	d2,-2(a6)
	move.b	-2(a6),d2
	and.l	#255,d2
	sub.l	#260,d2
	move.l	12(a6),a2
	move.b	-2(a6),d3
	and.l	#255,d3
	sub.l	#1,d3
	move.b	0(a2,d3.l),d4
	move.b	d4,0(a6,d2.l)
.L152:
	move.l	12(a6),a2
	move.b	-2(a6),d2
	and.l	#255,d2
	move.b	0(a2,d2.l),d2
	and.l	#255,d2
	tst.l	d2
	bne	.L158
	jmp	.L153
.L158:
	move.b	-2(a6),d2
	and.l	#255,d2
	cmp.l	#255,d2
	blt	.L151
	jmp	.L153
.L153:
	move.b	-2(a6),d2
	move.b	d2,-260(a6)
	movea.l	8(a6),a2
	lea.l	(a2),a1
	lea.l	-260(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L144:
.L145:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_STRLEN$PCHAR
_SYSATARI$$_STRLEN$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	#0,-4(a6)
.L167:
	move.l	-4(a6),d2
	add.l	#1,d2
	move.l	d2,-4(a6)
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	and.l	#255,d2
	tst.l	d2
	beq	.L168
	jmp	.L167
.L168:
	move.l	-4(a6),d2
	move.l	d2,-8(a6)
.L163:
	move.l	-8(a6),d0
.L164:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MOVE$$$$$$$$$LONGINT
_SYSATARI$$_MOVE$$$$$$$$$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	clr.l	d0
	move.l	16(a6),d0
.L175:
	move.l	12(a6),a1
	move.l	8(a6),a0
	cmp.l	#65535,d0
	ble	.L176
	cmp.l	a0,a1
	bls	.L177
	add.l	d0,a0
	add.l	d0,a1
	bra	.L178
.L179:
	move.b	-(a0),-(a1)
.L178:
	subq.l	#1,d0
	cmp.l	#-1,d0
	bne	.L179
	bra	.L180
.L181:
	move.b	(a0)+,(a1)+
.L177:
	subq.l	#1,d0
	cmp.l	#-1,d0
	bne	.L181
	bra	.L180
.L176:
	cmp.l	a0,a1
	bls	.L182
	add.l	d0,a0
	add.l	d0,a1
	bra	.L183
.L184:
	move.b	-(a0),-(a1)
.L183:
	dbra	D0,.L184
	bra	.L180
.L185:
	move.b	(a0)+,(a1)+
.L182:
	dbra	D0,.L185
.L180:
.L173:
.L174:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FILLWORD$$$$$LONGINT$WORD
_SYSATARI$$_FILLWORD$$$$$LONGINT$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a0
	move.l	12(a6),d1
	move.w	16(a6),d0
	bra	.L188
.L189:
	move.w	d0,(a0)+
.L188:
	subq.l	#1,d1
	cmp.b	#-1,d1
	bne	.L189
.L186:
.L187:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ABS$LONGINT
_SYSATARI$$_ABS$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),d0
	tst.l	d0
	bpl	.L192
	neg.l	d0
.L192:
	move.l	d0,-4(a6)
.L190:
	move.l	-4(a6),d0
.L191:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ODD$LONGINT
_SYSATARI$$_ODD$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	8(a6),d2
	and.l	#1,d2
	cmp.l	#1,d2
	beq	.L195
	jmp	.L196
.L195:
	move.b	#1,-1(a6)
	jmp	.L199
.L196:
	move.b	#0,-1(a6)
.L199:
.L193:
	move.b	-1(a6),d0
.L194:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SQR$LONGINT
_SYSATARI$$_SQR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),d2
	move.l	8(a6),d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,-4(a6)
.L202:
	move.l	-4(a6),d0
.L203:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_INT_STR$LONGINT$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#518,sp
	move.b	#0,-6(a6)
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.l	8(a6),d2
	cmp.l	#-2147483648,d2
	beq	.L212
	jmp	.L213
.L212:
	move.l	12(a6),a2
	lea.l	(a2),a1
	lea.l	.L216,a0
	move.l	#255,d0
	jsr	STRCOPY
	jmp	.L206
.L213:
	move.l	8(a6),d2
	tst.l	d2
	beq	.L217
	jmp	.L218
.L217:
	move.l	12(a6),a2
	move.w	#304,(a2)
	jmp	.L206
.L218:
	move.l	8(a6),d2
	tst.l	d2
	blt	.L221
	jmp	.L222
.L221:
	move.b	#1,-6(a6)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_ABS$LONGINT
	move.l	d0,d2
	move.l	d2,-4(a6)
	jmp	.L229
.L222:
	move.l	8(a6),d2
	move.l	d2,-4(a6)
.L229:
	jmp	.L233
.L232:
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.l	#10,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	add.l	#48,d2
	move.b	d2,d0
	move.b	#1,-262(a6)
	move.b	d0,-261(a6)
	move.l	a2,-(sp)
	lea.l	-518(a6),a1
	lea.l	-262(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	12(a6),a3
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	lea.l	-518(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-518(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	-4(a6),d2
	move.l	#10,d1
	move.l	d2,d0
	jsr	LONGDIV
	move.l	d0,d2
	move.l	d2,-4(a6)
.L233:
	move.l	-4(a6),d2
	tst.l	d2
	bgt	.L232
	jmp	.L234
.L234:
	tst.b	-6(a6)
	bne	.L239
	jmp	.L240
.L239:
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-262(a6),a1
	lea.l	.L243,a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	12(a6),a3
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	lea.l	-262(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-262(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L240:
.L206:
.L207:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_F1
_SYSATARI$$_F1:
	XDEF FLUSH_STDOUT
FLUSH_STDOUT:
	move.l	a6,-(sp)
	move.l	sp,a6
	movem.l	d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp,-(sp)
	pea.l	U_SYSATARI_OUTPUT
	move.l	U_SYSATARI_OUTPUT+24,a1
	jsr	(a1)
	movem.l	(sp)+,d0/d1/d2/d3/d4/d5/d6/d7/a0/a1/a2/a3/a4/a5/a6/sp
.L244:
.L245:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SPTR
_SYSATARI$$_SPTR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	sp,d0
	add.l	#8,d0
	move.l	d0,-4(a6)
.L248:
	move.l	-4(a6),d0
.L249:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_BOUNDSCHECK:
	XDEF RE_BOUNDS_CHECK
RE_BOUNDS_CHECK:
	cmp.l	(a1),d0
	bmi	.L252
	add.l	#4,a1
	cmp.l	(a1),d0
	bmi	.L253
	beq	.L253
.L252:
	move.l	#201,d0
	jsr	HALT_ERROR
.L253:
.L250:
.L251:
	rts
	CNOP 0,2
_SYSATARI$$_DO_SET:
	XDEF SET_SET_BYTE
SET_SET_BYTE:
	move.l	d0,d6
	lsr.l	#5,d6
	lsl.l	#2,d6
	add.l	d6,a0
	move.l	d0,d6
	andi.l	#31,d0
	move.l	(a0),d0
	bset.l	d6,d0
	bne	.L256
	andi.b	#254,ccr
	bra	.L257
.L256:
	or.b	#1,ccr
.L257:
	move.l	d0,(a0)
.L254:
.L255:
	rts
	CNOP 0,2
_SYSATARI$$_DO_IN:
	XDEF SET_IN_BYTE
SET_IN_BYTE:
	move.l	d0,d6
	lsr.l	#5,d6
	lsl.l	#2,d6
	add.l	d6,a0
	move.l	d0,d6
	andi.l	#31,d0
	move.l	(a0),d0
	btst.l	d6,d0
	bne	.L260
	andi.b	#254,ccr
	bra	.L261
.L260:
	or.b	#1,ccr
.L261:
.L258:
.L259:
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ADD_SETS$POINTER$POINTER$POINTER
_SYSATARI$$_ADD_SETS$POINTER$POINTER$POINTER:
	XDEF SET_ADD_SETS
SET_ADD_SETS:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	#32,d6
.L264:
	move.b	(a0)+,d0
	or.b	(a1)+,d0
	move.b	d0,(a2)+
	subq.b	#1,d6
	bne	.L264
	move.l	a2,(sp)+
.L262:
.L263:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SYM_SUB_SETS$POINTER$POINTER$POINTER
_SYSATARI$$_SYM_SUB_SETS$POINTER$POINTER$POINTER:
	XDEF SET_SYMDIF_SETS
SET_SYMDIF_SETS:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	#32,d6
.L267:
	move.b	(a0)+,d0
	move.b	(a1)+,d1
	eor.b	d1,d0
	move.b	d0,(a2)+
	subq.b	#1,d6
	bne	.L267
	move.l	a2,(sp)+
.L265:
.L266:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DO_SET$POINTER$BYTE$BYTE
_SYSATARI$$_DO_SET$POINTER$BYTE$BYTE:
	XDEF SET_SET_RANGE
SET_SET_RANGE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.b	14(a6),d0
.L270:
	cmp.b	12(a6),d0
	blt	.L271
	move.w	d0,-(sp)
	lsl.w	#8,d0
	pea	8(a6)
	jsr	SET_SET_BYTE
	sub.b	#1,d0
	bra	.L270
.L271:
.L268:
.L269:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MUL_SETS$POINTER$POINTER$POINTER
_SYSATARI$$_MUL_SETS$POINTER$POINTER$POINTER:
	XDEF SET_MUL_SETS
SET_MUL_SETS:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	#32,d6
.L274:
	move.b	(a0)+,d0
	and.b	(a1)+,d0
	move.b	d0,(a2)+
	subq.b	#1,d6
	bne	.L274
	move.l	a2,(sp)+
.L272:
.L273:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SUB_SETS$POINTER$POINTER$POINTER
_SYSATARI$$_SUB_SETS$POINTER$POINTER$POINTER:
	XDEF SET_SUB_SETS
SET_SUB_SETS:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	#32,d6
.L277:
	move.b	(a0)+,d0
	move.b	(a1)+,d1
	not.b	d1
	and.b	d1,d0
	move.b	d0,(a2)+
	sub.b	#1,d6
	bne	.L277
	move.l	a2,(sp)+
.L275:
.L276:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_COMP_SETS:
	XDEF SET_COMP_SETS
SET_COMP_SETS:
	move.l	#32,d6
.L280:
	move.b	(a0)+,d0
	move.b	(a1),d1
	cmp.b	d1,d0
	bne	.L281
	add.l	#1,a1
	sub.b	#1,d6
	bne	.L280
	cmp.b	d0,d0
.L281:
.L278:
.L279:
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DO_SET$POINTER$WORD
_SYSATARI$$_DO_SET$POINTER$WORD:
	XDEF SET_SET_WORD
SET_SET_WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a0
	move.w	12(a6),d6
	andi.l	#65528,d6
	lsl.l	#3,d6
	add.l	d6,a0
	move.b	12(a6),d6
	andi.l	#7,d6
	move.l	(a0),d0
	btst.l	d6,d0
	bne	.L284
	andi.b	#254,ccr
	bra	.L285
.L284:
	or.b	#1,ccr
.L285:
.L282:
.L283:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DO_IN$POINTER$WORD
_SYSATARI$$_DO_IN$POINTER$WORD:
	XDEF SET_IN_WORD
SET_IN_WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a0
	move.w	12(a6),d6
	andi.l	#65528,d6
	lsl.l	#3,d6
	add.l	d6,a0
	move.b	12(a6),d6
	andi.l	#7,d6
	move.l	(a0),d0
	btst.l	d6,d0
	bne	.L288
	andi.b	#254,ccr
	bra	.L289
.L288:
	or.b	#1,ccr
.L289:
.L286:
.L287:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ADD_SETS$POINTER$POINTER$POINTER$LONGINT
_SYSATARI$$_ADD_SETS$POINTER$POINTER$POINTER$LONGINT:
	XDEF SET_ADD_SETS_SIZE
SET_ADD_SETS_SIZE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	20(a6),d6
.L292:
	move.l	(a0)+,d0
	or.l	(a1)+,d0
	move.l	d0,(a2)+
	subq.l	#4,d6
	bne	.L292
	move.l	a2,(sp)+
.L290:
.L291:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MUL_SETS$POINTER$POINTER$POINTER$LONGINT
_SYSATARI$$_MUL_SETS$POINTER$POINTER$POINTER$LONGINT:
	XDEF SET_MUL_SETS_SIZE
SET_MUL_SETS_SIZE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	20(a6),d6
.L295:
	move.l	(a0)+,d0
	and.l	(a1)+,d0
	move.l	d0,(a2)+
	subq.l	#4,d6
	bne	.L295
	move.l	a2,(sp)+
.L293:
.L294:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SUB_SETS$POINTER$POINTER$POINTER$LONGINT
_SYSATARI$$_SUB_SETS$POINTER$POINTER$POINTER$LONGINT:
	XDEF SET_SUB_SETS_SIZE
SET_SUB_SETS_SIZE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	a2,-(sp)
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),a2
	move.l	20(a6),d6
.L298:
	move.l	(a0)+,d0
	not.l	d0
	and.l	(a1)+,d0
	move.l	d0,(a2)+
	subq.l	#4,d6
	bne	.L298
	move.l	a2,(sp)+
.L296:
.L297:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_COMP_SETS$POINTER$POINTER$LONGINT
_SYSATARI$$_COMP_SETS$POINTER$POINTER$LONGINT:
	XDEF SET_COMP_SETS_SIZE
SET_COMP_SETS_SIZE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a0
	move.l	12(a6),a1
	move.l	16(a6),d6
.L301:
	move.l	(a0)+,d0
	move.l	(a1),d1
	cmp.l	d1,d0
	bne	.L302
	add.l	#4,a1
	subq.l	#1,d6
	bne	.L301
	cmp.l	d0,d0
.L302:
.L299:
.L300:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_STR_REAL$LONGINT$LONGINT$BESTREAL$TREAL_TYPE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#814,sp
	move.l	20(a6),d2
	tst.l	d2
	beq	.L305
	subq.l	#1,d2
	beq	.L307
	subq.l	#1,d2
	beq	.L309
	subq.l	#1,d2
	beq	.L311
	subq.l	#1,d2
	beq	.L313
	jmp	.L316
.L313:
	move.l	#22,-4(a6)
	move.l	#9,-8(a6)
	move.l	#6,-12(a6)
	jmp	.L315
.L311:
	move.l	#26,-4(a6)
	move.l	#10,-8(a6)
	move.l	#6,-12(a6)
	jmp	.L315
.L309:
	move.l	#16,-4(a6)
	move.l	#8,-8(a6)
	move.l	#4,-12(a6)
	jmp	.L315
.L307:
	move.l	#16,-4(a6)
	move.l	#8,-8(a6)
	move.l	#4,-12(a6)
	jmp	.L315
.L305:
	move.l	#23,-4(a6)
	move.l	#9,-8(a6)
	move.l	#5,-12(a6)
	jmp	.L315
.L316:
.L315:
	move.l	8(a6),d2
	cmp.l	#-32767,d2
	beq	.L347
	jmp	.L348
.L347:
	move.l	-4(a6),d2
	move.l	d2,8(a6)
.L348:
	move.l	16(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	slt.b	-294(a6)
	neg.b	-294(a6)
	tst.b	-294(a6)
	bne	.L354
	jmp	.L355
.L354:
	move.l	16(a6),d2
	bchg.l	#31,d2
	move.l	d2,16(a6)
.L355:
	move.l	-4(a6),d2
	sub.l	-12(a6),d2
	sub.l	#3,d2
	move.l	d2,-20(a6)
	move.l	12(a6),d2
	cmp.l	-20(a6),d2
	bgt	.L360
	jmp	.L361
.L360:
	move.l	-20(a6),d2
	move.l	d2,12(a6)
.L361:
	move.l	12(a6),d2
	tst.l	d2
	blt	.L364
	jmp	.L366
.L366:
	move.l	16(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bne	.L367
	jmp	.L365
.L367:
	move.l	16(a6),d3
	move.l	.L369,d0
	move.l	d3,d1
	jsr	SINGLE_CMP
	bgt	.L364
	jmp	.L368
.L368:
	move.l	16(a6),d4
	move.l	.L370,d0
	move.l	d4,d1
	jsr	SINGLE_CMP
	blt	.L364
	jmp	.L365
.L364:
	move.l	8(a6),d2
	tst.l	d2
	bge	.L373
	jmp	.L372
.L373:
	move.l	8(a6),d2
	cmp.l	-8(a6),d2
	blt	.L371
	jmp	.L372
.L371:
	move.l	-8(a6),d2
	move.l	d2,8(a6)
.L372:
	move.l	8(a6),d2
	tst.l	d2
	bgt	.L378
	jmp	.L377
.L378:
	move.l	8(a6),d2
	cmp.l	-4(a6),d2
	blt	.L376
	jmp	.L377
.L376:
	move.l	8(a6),d2
	sub.l	-12(a6),d2
	sub.l	#3,d2
	move.l	d2,-20(a6)
.L377:
.L365:
	move.l	#0,-16(a6)
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bge	.L383
	jmp	.L384
.L383:
	jmp	.L387
.L386:
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,16(a6)
	addq.l	#1,-16(a6)
.L387:
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bge	.L386
	jmp	.L388
.L388:
	jmp	.L391
.L384:
	move.l	16(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L394
	jmp	.L393
.L394:
	move.l	16(a6),d3
	move.l	.L353,d0
	move.l	d3,d1
	jsr	SINGLE_CMP
	bne	.L392
	jmp	.L393
.L392:
	jmp	.L397
.L396:
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,16(a6)
	subq.l	#1,-16(a6)
.L397:
	move.l	16(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L396
	jmp	.L398
.L398:
.L393:
.L391:
	move.l	.L403,d2
	move.l	d2,-24(a6)
	move.l	12(a6),d2
	tst.l	d2
	blt	.L404
	jmp	.L405
.L404:
	move.w	#1,-296(a6)
	move.l	-20(a6),d2
	move.w	d2,-302(a6)
	move.w	-296(a6),d2
	cmp.w	-302(a6),d2
	bgt	.L407
.L408:
	move.l	-24(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,-24(a6)
.L406:
	move.w	-296(a6),d2
	cmp.w	-302(a6),d2
	bge	.L407
	add.w	#1,-296(a6)
	jmp	.L408
.L407:
	jmp	.L413
.L405:
	move.w	#1,-296(a6)
	move.l	-16(a6),d2
	add.l	12(a6),d2
	move.w	d2,-302(a6)
	move.w	-296(a6),d2
	cmp.w	-302(a6),d2
	bgt	.L415
.L416:
	move.l	-24(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,-24(a6)
.L414:
	move.w	-296(a6),d2
	cmp.w	-302(a6),d2
	bge	.L415
	add.w	#1,-296(a6)
	jmp	.L416
.L415:
.L413:
	move.l	16(a6),d2
	move.l	-24(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,16(a6)
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bge	.L423
	jmp	.L424
.L423:
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,16(a6)
	addq.l	#1,-16(a6)
.L424:
	tst.b	-294(a6)
	bne	.L427
	jmp	.L428
.L427:
	move.w	#301,-280(a6)
	jmp	.L431
.L428:
	move.w	#288,-280(a6)
.L431:
	lea.l	-554(a6),a1
	lea.l	-280(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	16(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	add.l	#48,d2
	move.b	d2,d0
	move.b	#1,-810(a6)
	move.b	d0,-809(a6)
	lea.l	-810(a6),a1
	move.l	a1,-(sp)
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-280(a6),a1
	lea.l	-554(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	16(a6),-(sp)
	jsr	_SYSATARI$$_INT$REAL
	move.l	d0,d2
	move.l	d2,d0
	move.l	16(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,16(a6)
	move.w	#1,-296(a6)
	move.l	-20(a6),d2
	move.w	d2,-302(a6)
	move.w	-296(a6),d2
	cmp.w	-302(a6),d2
	bgt	.L443
.L444:
	move.l	16(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,16(a6)
	lea.l	-558(a6),a1
	lea.l	-280(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	16(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	add.l	#48,d2
	move.b	d2,d0
	move.b	#1,-814(a6)
	move.b	d0,-813(a6)
	lea.l	-814(a6),a1
	move.l	a1,-(sp)
	lea.l	-558(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-280(a6),a1
	lea.l	-558(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	16(a6),-(sp)
	jsr	_SYSATARI$$_INT$REAL
	move.l	d0,d2
	move.l	d2,d0
	move.l	16(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,16(a6)
.L442:
	move.w	-296(a6),d2
	cmp.w	-302(a6),d2
	bge	.L443
	add.w	#1,-296(a6)
	jmp	.L444
.L443:
	move.l	12(a6),d2
	tst.l	d2
	blt	.L457
	jmp	.L459
.L459:
	move.l	-16(a6),d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	.L460,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L457
	jmp	.L458
.L457:
	move.w	#3,-(sp)
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	pea.l	.L467
	jsr	_SYSATARI$$_INSERT$STRING$STRING$STRLENINT
	lea.l	-292(a6),a1
	move.l	a1,-(sp)
	moveq.l	#-1,d6
	move.l	d6,-(sp)
	move.l	-16(a6),-(sp)
	jsr	_SYSATARI$$_ABS$LONGINT
	move.l	d0,d2
	move.l	d2,-(sp)
	jsr	STR_LONGINT
	move.b	-292(a6),d2
	and.l	#255,d2
	move.l	-12(a6),d3
	sub.l	#2,d3
	cmp.l	d2,d3
	bgt	.L474
	jmp	.L475
.L474:
	move.l	-12(a6),d2
	sub.l	#2,d2
	move.b	-292(a6),d3
	and.l	#255,d3
	sub.l	d3,d2
	move.w	d2,-(sp)
	move.w	#1,-(sp)
	pea.l	.L484
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
	lea.l	-810(a6),a1
	lea.l	-554(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	lea.l	-292(a6),a1
	move.l	a1,-(sp)
	lea.l	-810(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-292(a6),a1
	lea.l	-810(a6),a0
	move.l	#10,d0
	jsr	STRCOPY
.L475:
	move.l	-16(a6),d2
	tst.l	d2
	blt	.L485
	jmp	.L486
.L485:
	lea.l	-554(a6),a1
	lea.l	.L243,a0
	move.l	#255,d0
	jsr	STRCOPY
	lea.l	-292(a6),a1
	move.l	a1,-(sp)
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-292(a6),a1
	lea.l	-554(a6),a0
	move.l	#10,d0
	jsr	STRCOPY
	jmp	.L489
.L486:
	lea.l	-554(a6),a1
	lea.l	.L492,a0
	move.l	#255,d0
	jsr	STRCOPY
	lea.l	-292(a6),a1
	move.l	a1,-(sp)
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-292(a6),a1
	lea.l	-554(a6),a0
	move.l	#10,d0
	jsr	STRCOPY
.L489:
	lea.l	-554(a6),a1
	lea.l	-280(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	pea.l	.L495
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-292(a6),a1
	move.l	a1,-(sp)
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-280(a6),a1
	lea.l	-554(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	jmp	.L496
.L458:
	move.b	-294(a6),d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L497
	jmp	.L498
.L497:
	move.w	#1,-(sp)
	move.w	#1,-(sp)
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DELETE$STRING$STRLENINT$STRLENINT
	move.b	#2,-298(a6)
	jmp	.L507
.L498:
	move.b	#3,-298(a6)
.L507:
	move.l	-16(a6),d2
	tst.l	d2
	bge	.L510
	jmp	.L511
.L510:
	move.b	-280(a6),d2
	and.l	#255,d2
	move.b	-298(a6),d3
	and.l	#255,d3
	add.l	-16(a6),d3
	add.l	12(a6),d3
	cmp.l	d2,d3
	bgt	.L512
	jmp	.L513
.L512:
	lea.l	-554(a6),a1
	lea.l	-280(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.b	-298(a6),d2
	and.l	#255,d2
	add.l	-16(a6),d2
	add.l	12(a6),d2
	move.b	-280(a6),d3
	and.l	#255,d3
	sub.l	d3,d2
	move.w	d2,-(sp)
	move.w	#1,-(sp)
	pea.l	.L484
	lea.l	-810(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
	lea.l	-810(a6),a1
	move.l	a1,-(sp)
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-280(a6),a1
	lea.l	-554(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L513:
	move.b	-298(a6),d2
	and.l	#255,d2
	add.l	-16(a6),d2
	move.w	d2,-(sp)
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	pea.l	.L467
	jsr	_SYSATARI$$_INSERT$STRING$STRING$STRLENINT
	jmp	.L528
.L511:
	move.l	-16(a6),-(sp)
	jsr	_SYSATARI$$_ABS$LONGINT
	move.l	d0,d2
	move.l	d2,-16(a6)
	move.b	-298(a6),d2
	and.l	#255,d2
	sub.l	#1,d2
	move.w	d2,-(sp)
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	move.l	-16(a6),d2
	move.w	d2,-(sp)
	move.w	#1,-(sp)
	pea.l	.L484
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INSERT$STRING$STRING$STRLENINT
	move.b	-298(a6),d2
	and.w	#255,d2
	move.w	d2,-(sp)
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	pea.l	.L467
	jsr	_SYSATARI$$_INSERT$STRING$STRING$STRLENINT
.L528:
	move.l	12(a6),d2
	tst.l	d2
	bgt	.L551
	jmp	.L552
.L551:
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	move.w	#11776,-(sp)
	jsr	_SYSATARI$$_POS$CHAR$STRING
	move.b	d0,d2
	and.l	#255,d2
	add.l	12(a6),d2
	move.b	d2,-280(a6)
	jmp	.L559
.L552:
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	move.w	#11776,-(sp)
	jsr	_SYSATARI$$_POS$CHAR$STRING
	move.b	d0,d2
	and.l	#255,d2
	sub.l	#1,d2
	move.b	d2,-280(a6)
.L559:
.L496:
	move.b	-280(a6),d2
	and.l	#255,d2
	cmp.l	8(a6),d2
	blt	.L566
	jmp	.L567
.L566:
	move.l	24(a6),a2
	move.l	a2,-(sp)
	move.b	-280(a6),d2
	and.l	#255,d2
	move.l	8(a6),d6
	sub.l	d2,d6
	move.l	d6,d2
	move.b	d2,d3
	lsl.w	#8,d3
	move.w	d3,-(sp)
	lea.l	-554(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_SPACE$BYTE
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	lea.l	-810(a6),a1
	lea.l	-554(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	lea.l	-280(a6),a1
	move.l	a1,-(sp)
	lea.l	-810(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-810(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	jmp	.L572
.L567:
	move.l	24(a6),a2
	lea.l	(a2),a1
	lea.l	-280(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L572:
.L303:
.L304:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#20,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	18(a6),d2
	ext.l	d2
	tst.l	d2
	blt	.L577
	jmp	.L578
.L577:
	move.w	#0,18(a6)
.L578:
	move.w	16(a6),d2
	ext.l	d2
	cmp.l	#1,d2
	bgt	.L581
	jmp	.L582
.L581:
	subq.w	#1,16(a6)
	jmp	.L583
.L582:
	move.w	#0,16(a6)
.L583:
	move.w	16(a6),d2
	ext.l	d2
	move.l	12(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	blt	.L586
	jmp	.L587
.L586:
	move.w	#0,18(a6)
	jmp	.L590
.L587:
	move.w	16(a6),d2
	ext.l	d2
	move.w	18(a6),d3
	ext.l	d3
	add.l	d2,d3
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	d3,d2
	blt	.L591
	jmp	.L592
.L591:
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.w	16(a6),d3
	ext.l	d3
	sub.l	d3,d2
	move.w	d2,18(a6)
.L592:
.L590:
	movea.l	8(a6),a2
	move.w	18(a6),d2
	ext.l	d2
	move.b	d2,(a2)
	move.w	18(a6),d2
	ext.l	d2
	move.l	d2,-(sp)
	movea.l	8(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.w	16(a6),d2
	ext.l	d2
	add.l	#1,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L575:
.L576:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DELETE$STRING$STRLENINT$STRLENINT
_SYSATARI$$_DELETE$STRING$STRLENINT$STRLENINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	12(a6),d2
	ext.l	d2
	tst.l	d2
	ble	.L605
	jmp	.L606
.L605:
	move.w	14(a6),d2
	ext.l	d2
	move.w	12(a6),d3
	ext.l	d3
	add.l	d2,d3
	sub.l	#1,d3
	move.w	d3,14(a6)
	move.w	#1,12(a6)
.L606:
	move.w	12(a6),d2
	ext.l	d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bge	.L613
	jmp	.L612
.L613:
	move.w	14(a6),d2
	ext.l	d2
	tst.l	d2
	bgt	.L611
	jmp	.L612
.L611:
	move.w	14(a6),d2
	ext.l	d2
	move.w	12(a6),d3
	ext.l	d3
	add.l	d2,d3
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	d3,d2
	blt	.L614
	jmp	.L615
.L614:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.w	12(a6),d3
	ext.l	d3
	sub.l	d3,d2
	add.l	#1,d2
	move.w	d2,14(a6)
.L615:
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	and.l	#255,d2
	move.w	14(a6),d3
	ext.l	d3
	sub.l	d3,d2
	move.b	d2,(a2)
	move.w	12(a6),d2
	ext.l	d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bge	.L620
	jmp	.L621
.L620:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.w	12(a6),d3
	ext.l	d3
	sub.l	d3,d2
	add.l	#1,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.w	12(a6),d2
	ext.l	d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.w	12(a6),d2
	ext.l	d2
	move.w	14(a6),d3
	ext.l	d3
	add.l	d2,d3
	lea.l	0(a2,d3.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L621:
.L612:
.L603:
.L604:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INSERT$STRING$STRING$STRLENINT
_SYSATARI$$_INSERT$STRING$STRING$STRLENINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#512,sp
	move.w	16(a6),d2
	ext.l	d2
	cmp.l	#1,d2
	bgt	.L630
	jmp	.L631
.L630:
	subq.w	#1,16(a6)
	jmp	.L632
.L631:
	move.w	#0,16(a6)
.L632:
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.w	16(a6),-(sp)
	move.w	#1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	lea.l	-512(a6),a1
	lea.l	-256(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	8(a6),a3
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	lea.l	-512(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.b	(a2),d2
	and.w	#255,d2
	move.w	d2,-(sp)
	move.w	16(a6),d2
	ext.l	d2
	add.l	#1,d2
	move.w	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	lea.l	-512(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-512(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L628:
.L629:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_POS$STRING$STRING
_SYSATARI$$_POS$STRING$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#268,sp
	move.l	#0,-4(a6)
	move.l	#0,-8(a6)
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	tst.l	d2
	sgt.b	-10(a6)
	neg.b	-10(a6)
	jmp	.L658
.L657:
	addq.l	#1,-4(a6)
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.l	8(a6),a3
	move.b	0(a2,d2.l),d2
	cmp.b	1(a3),d2
	beq	.L662
	jmp	.L661
.L662:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.b	(a2),d2
	and.w	#255,d2
	move.w	d2,-(sp)
	move.l	-4(a6),d2
	move.w	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-268(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_COPY$STRING$STRLENINT$STRLENINT
	move.l	(sp)+,a2
	lea.l	(a2),a0
	lea.l	-268(a6),a1
	jsr	STRCMP
	beq	.L660
	jmp	.L661
.L660:
	move.l	-4(a6),d2
	move.l	d2,-8(a6)
	move.b	#0,-10(a6)
.L661:
.L658:
	tst.b	-10(a6)
	bne	.L673
	jmp	.L659
.L673:
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	sub.l	d3,d2
	cmp.l	-4(a6),d2
	bge	.L657
	jmp	.L659
.L659:
	move.l	-8(a6),d2
	move.b	d2,-11(a6)
.L649:
	move.b	-11(a6),d0
.L650:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_POS$CHAR$STRING
_SYSATARI$$_POS$CHAR$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#10,sp
	move.l	#1,-4(a6)
	move.l	10(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-10(a6)
	move.l	-4(a6),d2
	cmp.l	-10(a6),d2
	bgt	.L679
.L680:
	move.l	10(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	8(a6),d2
	beq	.L683
	jmp	.L684
.L683:
	move.l	-4(a6),d2
	move.b	d2,-5(a6)
	jmp	.L676
.L684:
.L678:
	move.l	-4(a6),d2
	cmp.l	-10(a6),d2
	bge	.L679
	add.l	#1,-4(a6)
	jmp	.L680
.L679:
	move.b	#0,-5(a6)
.L676:
	move.b	-5(a6),d0
.L677:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_UPCASE$CHAR
_SYSATARI$$_UPCASE$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.b	8(a6),d0
	and.l	#255,d0
	cmp.w	#97,d0
	bcs	.L694
	cmp.w	#123,d0
	bcs	.L693
.L694:
	and.b	#254,ccr
.L693:
	bcs	.L691
	jmp	.L692
.L691:
	move.b	8(a6),d2
	and.l	#255,d2
	sub.l	#32,d2
	move.b	d2,-1(a6)
	jmp	.L697
.L692:
	move.b	8(a6),d2
	move.b	d2,-1(a6)
.L697:
.L689:
	move.b	-1(a6),d0
.L690:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_UPCASE$STRING
_SYSATARI$$_UPCASE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	movea.l	8(a6),a2
	move.l	12(a6),a3
	move.b	(a3),d2
	move.b	d2,(a2)
	move.l	#1,-4(a6)
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-8(a6)
	move.l	-4(a6),d2
	cmp.l	-8(a6),d2
	bgt	.L705
.L706:
	movea.l	8(a6),a2
	move.l	-4(a6),d2
	move.l	d2,-(sp)
	move.l	12(a6),a3
	move.l	-4(a6),d2
	move.b	0(a3,d2.l),d2
	lsl.w	#8,d2
	move.w	d2,-(sp)
	jsr	_SYSATARI$$_UPCASE$CHAR
	move.b	d0,d3
	move.l	(sp)+,d2
	move.b	d3,0(a2,d2.l)
.L704:
	move.l	-4(a6),d2
	cmp.l	-8(a6),d2
	bge	.L705
	add.l	#1,-4(a6)
	jmp	.L706
.L705:
.L700:
.L701:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_LOWERCASE$CHAR
_SYSATARI$$_LOWERCASE$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.b	8(a6),d0
	and.l	#255,d0
	cmp.w	#65,d0
	bcs	.L718
	cmp.w	#91,d0
	bcs	.L717
.L718:
	and.b	#254,ccr
.L717:
	bcs	.L715
	jmp	.L716
.L715:
	move.b	8(a6),d2
	and.l	#255,d2
	add.l	#32,d2
	move.b	d2,-1(a6)
	jmp	.L721
.L716:
	move.b	8(a6),d2
	move.b	d2,-1(a6)
.L721:
.L713:
	move.b	-1(a6),d0
.L714:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_LOWERCASE$STRING
_SYSATARI$$_LOWERCASE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	movea.l	8(a6),a2
	move.l	12(a6),a3
	move.b	(a3),d2
	move.b	d2,(a2)
	move.l	#1,-4(a6)
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-8(a6)
	move.l	-4(a6),d2
	cmp.l	-8(a6),d2
	bgt	.L729
.L730:
	movea.l	8(a6),a2
	move.l	-4(a6),d2
	move.l	d2,-(sp)
	move.l	12(a6),a3
	move.l	-4(a6),d2
	move.b	0(a3,d2.l),d2
	lsl.w	#8,d2
	move.w	d2,-(sp)
	jsr	_SYSATARI$$_LOWERCASE$CHAR
	move.b	d0,d3
	move.l	(sp)+,d2
	move.b	d3,0(a2,d2.l)
.L728:
	move.l	-4(a6),d2
	cmp.l	-8(a6),d2
	bge	.L729
	add.l	#1,-4(a6)
	jmp	.L730
.L729:
.L724:
.L725:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_HEXSTR$LONGINT$BYTE
_SYSATARI$$_HEXSTR$LONGINT$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	movea.l	8(a6),a2
	move.b	16(a6),d2
	move.b	d2,(a2)
	move.b	16(a6),d2
	and.l	#255,d2
	move.l	d2,-4(a6)
	cmp.l	#1,-4(a6)
	blt	.L742
.L743:
	movea.l	8(a6),a2
	move.l	-4(a6),d2
	move.l	12(a6),d3
	and.l	#15,d3
	lea.l	TC__SYSATARI$$_HEXSTR_HEXTBL,a3
	move.b	0(a3,d3.l),d4
	move.b	d4,0(a2,d2.l)
	move.l	12(a6),d2
	lsr.l	#4,d2
	move.l	d2,12(a6)
.L741:
	cmp.l	#1,-4(a6)
	ble	.L742
	sub.l	#1,-4(a6)
	jmp	.L743
.L742:
.L737:
.L738:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BINSTR$LONGINT$BYTE
_SYSATARI$$_BINSTR$LONGINT$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	movea.l	8(a6),a2
	move.b	16(a6),d2
	move.b	d2,(a2)
	move.b	16(a6),d2
	and.l	#255,d2
	move.l	d2,-4(a6)
	cmp.l	#1,-4(a6)
	blt	.L755
.L756:
	movea.l	8(a6),a2
	move.l	-4(a6),d2
	move.l	12(a6),d3
	and.l	#1,d3
	add.l	#48,d3
	move.b	d3,0(a2,d2.l)
	move.l	12(a6),d2
	lsr.l	#1,d2
	move.l	d2,12(a6)
.L754:
	cmp.l	#1,-4(a6)
	ble	.L755
	sub.l	#1,-4(a6)
	jmp	.L756
.L755:
.L750:
.L751:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SPACE$BYTE
_SYSATARI$$_SPACE$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	movea.l	8(a6),a2
	move.b	12(a6),d2
	move.b	d2,(a2)
	move.w	#8192,-(sp)
	move.b	12(a6),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	movea.l	8(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$CHAR
.L763:
.L764:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_STR_REAL$REAL$LONGINT$LONGINT$STRING
_SYSATARI$$_INT_STR_REAL$REAL$LONGINT$LONGINT$STRING:
	XDEF STR_REAL
STR_REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	20(a6),a2
	move.l	a2,-(sp)
	moveq.l	#1,d6
	move.l	d6,-(sp)
	move.l	8(a6),-(sp)
	move.l	16(a6),-(sp)
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_STR_REAL$LONGINT$LONGINT$BESTREAL$TREAL_TYPE$STRING
.L773:
.L774:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_STR_LONGINT$LONGINT$LONGINT$STRING
_SYSATARI$$_INT_STR_LONGINT$LONGINT$LONGINT$STRING:
	XDEF STR_LONGINT
STR_LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#512,sp
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_INT_STR$LONGINT$STRING
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	12(a6),d2
	blt	.L791
	jmp	.L792
.L791:
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	12(a6),d6
	sub.l	d2,d6
	move.l	d6,d2
	move.b	d2,d3
	lsl.w	#8,d3
	move.w	d3,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_SPACE$BYTE
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	lea.l	-512(a6),a1
	lea.l	-256(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	16(a6),a3
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	lea.l	-512(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-512(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L792:
.L785:
.L786:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_STR_CARDINAL$CARDINAL$LONGINT$STRING
_SYSATARI$$_INT_STR_CARDINAL$CARDINAL$LONGINT$STRING:
	XDEF STR_CARDINAL
STR_CARDINAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#512,sp
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_INT_STR$LONGINT$STRING
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	12(a6),d2
	blt	.L803
	jmp	.L804
.L803:
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	12(a6),d6
	sub.l	d2,d6
	move.l	d6,d2
	move.b	d2,d3
	lsl.w	#8,d3
	move.w	d3,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_SPACE$BYTE
	move.l	(sp)+,a2
	move.l	a2,-(sp)
	lea.l	-512(a6),a1
	lea.l	-256(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	16(a6),a3
	move.l	a2,-(sp)
	move.l	a3,-(sp)
	lea.l	-512(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-512(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L804:
.L797:
.L798:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_INITVAL$STRING$BOOLEAN$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#6,sp
	move.l	#1,-4(a6)
	jmp	.L822
.L821:
	addq.l	#1,-4(a6)
.L822:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	-4(a6),d2
	bge	.L824
	jmp	.L823
.L824:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#9,d0
	beq	.L825
	cmp.w	#32,d0
	beq	.L825
.L825:
	beq	.L821
	jmp	.L823
.L823:
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	sub.b	#43,d2
	beq	.L813
	subq.b	#2,d2
	beq	.L811
	jmp	.L829
.L813:
	addq.l	#1,-4(a6)
	jmp	.L828
.L811:
	move.l	12(a6),a2
	move.b	#1,(a2)
	addq.l	#1,-4(a6)
	jmp	.L828
.L829:
.L828:
	move.l	16(a6),a2
	move.b	#10,(a2)
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	-4(a6),d2
	bge	.L834
	jmp	.L835
.L834:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	sub.b	#36,d2
	beq	.L815
	subq.b	#1,d2
	beq	.L817
	jmp	.L837
.L817:
	move.l	16(a6),a2
	move.b	#2,(a2)
	addq.l	#1,-4(a6)
	jmp	.L836
.L815:
	move.l	16(a6),a2
	move.b	#16,(a2)
.L842:
	addq.l	#1,-4(a6)
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	-4(a6),d2
	ble	.L843
	jmp	.L844
.L844:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#48,d2
	bne	.L843
	jmp	.L842
.L843:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	sub.l	-4(a6),d2
	cmp.l	#7,d2
	bgt	.L845
	jmp	.L846
.L845:
	move.l	-4(a6),d2
	add.l	#8,d2
	move.l	d2,-4(a6)
.L846:
	jmp	.L836
.L837:
.L836:
.L835:
	move.l	-4(a6),d2
	move.w	d2,-6(a6)
.L809:
	move.w	-6(a6),d0
.L810:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$LONGINT$WORD
_SYSATARI$$_VAL$STRING$LONGINT$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#6,sp
	move.l	12(a6),a2
	move.l	#0,(a2)
	move.l	16(a6),a2
	move.l	a2,-(sp)
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	lea.l	-6(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_INITVAL$STRING$BOOLEAN$BYTE
	move.w	d0,d2
	move.l	(sp)+,a2
	move.w	d2,(a2)
	move.l	16(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	blt	.L869
	jmp	.L870
.L869:
	jmp	.L851
.L870:
	tst.b	-6(a6)
	bne	.L873
	jmp	.L872
.L873:
	move.l	8(a6),a2
	lea.l	(a2),a0
	lea.l	.L216,a1
	jsr	STRCMP
	beq	.L871
	jmp	.L872
.L871:
	move.l	16(a6),a2
	move.w	#0,(a2)
	move.l	12(a6),a2
	move.l	#-2147483648,(a2)
	jmp	.L851
.L872:
	jmp	.L879
.L878:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d3
	move.b	d3,-4(a6)
	move.b	-4(a6),d2
	sub.b	#47,d2
	bls	.L884
	sub.b	#10,d2
	bls	.L853
	subq.b	#7,d2
	bls	.L884
	sub.b	#6,d2
	bls	.L855
	sub.b	#26,d2
	bls	.L884
	sub.b	#8,d2
	bls	.L857
	jmp	.L884
.L857:
	move.b	-4(a6),d2
	and.l	#255,d2
	sub.l	#87,d2
	move.b	d2,-4(a6)
	jmp	.L883
.L855:
	move.b	-4(a6),d2
	and.l	#255,d2
	sub.l	#55,d2
	move.b	d2,-4(a6)
	jmp	.L883
.L853:
	move.b	-4(a6),d2
	and.l	#255,d2
	sub.l	#48,d2
	move.b	d2,-4(a6)
	jmp	.L883
.L884:
	move.b	#16,-4(a6)
.L883:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.b	-2(a6),d2
	and.l	#255,d2
	move.l	(a3),d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,(a2)
	move.b	-4(a6),d2
	and.l	#255,d2
	move.b	-2(a6),d3
	and.l	#255,d3
	cmp.l	d2,d3
	ble	.L895
	jmp	.L897
.L897:
	move.b	-2(a6),d2
	and.l	#255,d2
	cmp.l	#10,d2
	beq	.L898
	jmp	.L896
.L898:
	move.l	12(a6),a2
	move.l	(a2),d2
	move.l	#2147483647,d6
	sub.l	d2,d6
	move.l	d6,d2
	move.b	-4(a6),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bgt	.L895
	jmp	.L896
.L895:
	move.l	12(a6),a2
	move.l	#0,(a2)
	jmp	.L851
.L896:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.b	-4(a6),d2
	and.l	#255,d2
	add.l	(a3),d2
	move.l	d2,(a2)
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L879:
	move.l	16(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bge	.L878
	jmp	.L880
.L880:
	move.l	16(a6),a2
	move.w	#0,(a2)
	tst.b	-6(a6)
	bne	.L905
	jmp	.L906
.L905:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.l	(a3),d2
	move.l	#0,d6
	sub.l	d2,d6
	move.l	d6,d2
	move.l	d2,(a2)
.L906:
.L851:
.L852:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$LONGINT$INTEGER
_SYSATARI$$_VAL$STRING$LONGINT$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
.L909:
.L910:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$LONGINT
_SYSATARI$$_VAL$STRING$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
.L917:
.L918:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$BYTE
_SYSATARI$$_VAL$STRING$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	d2,(a2)
.L925:
.L926:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$BYTE$WORD
_SYSATARI$$_VAL$STRING$BYTE$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	16(a6),a2
	move.l	a2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	d2,(a2)
.L933:
.L934:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$BYTE$INTEGER
_SYSATARI$$_VAL$STRING$BYTE$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$BYTE$WORD
.L943:
.L944:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$SHORTINT
_SYSATARI$$_VAL$STRING$SHORTINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	d2,(a2)
.L951:
.L952:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$SHORTINT$WORD
_SYSATARI$$_VAL$STRING$SHORTINT$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	16(a6),a2
	move.l	a2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	d2,(a2)
.L959:
.L960:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$SHORTINT$INTEGER
_SYSATARI$$_VAL$STRING$SHORTINT$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$SHORTINT$WORD
.L969:
.L970:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$WORD
_SYSATARI$$_VAL$STRING$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L977:
.L978:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$WORD$WORD
_SYSATARI$$_VAL$STRING$WORD$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	16(a6),a2
	move.l	a2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L985:
.L986:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$WORD$INTEGER
_SYSATARI$$_VAL$STRING$WORD$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$WORD$WORD
.L995:
.L996:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$INTEGER
_SYSATARI$$_VAL$STRING$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L1003:
.L1004:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$INTEGER$WORD
_SYSATARI$$_VAL$STRING$INTEGER$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	16(a6),a2
	move.l	a2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L1011:
.L1012:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$INTEGER$INTEGER
_SYSATARI$$_VAL$STRING$INTEGER$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$INTEGER$WORD
.L1021:
.L1022:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$VALREAL$WORD
_SYSATARI$$_VAL$STRING$VALREAL$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#26,sp
	move.l	12(a6),a2
	move.l	.L353,d2
	move.l	d2,(a2)
	move.l	16(a6),a2
	move.w	#1,(a2)
	move.l	#0,-16(a6)
	move.l	.L395,d2
	move.l	d2,-8(a6)
	move.b	#0,-22(a6)
	move.l	.L395,d2
	move.l	d2,-12(a6)
	jmp	.L1048
.L1047:
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L1048:
	move.l	16(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bge	.L1050
	jmp	.L1049
.L1050:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#9,d0
	beq	.L1051
	cmp.w	#32,d0
	beq	.L1051
.L1051:
	beq	.L1047
	jmp	.L1049
.L1049:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	sub.b	#43,d2
	beq	.L1031
	subq.b	#2,d2
	beq	.L1033
	jmp	.L1053
.L1033:
	move.l	.L1056,d2
	move.l	d2,-12(a6)
	move.l	16(a6),a2
	addq.w	#1,(a2)
	jmp	.L1052
.L1031:
	move.l	16(a6),a2
	addq.w	#1,(a2)
	jmp	.L1052
.L1053:
.L1052:
	jmp	.L1058
.L1057:
	move.b	-22(a6),d2
	and.l	#255,d2
	or.l	#1,d2
	move.b	d2,-22(a6)
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.l	(a3),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,(a2)
	move.l	12(a6),a2
	move.l	8(a6),a3
	move.l	16(a6),a4
	move.w	(a4),d2
	and.l	#65535,d2
	move.b	0(a3,d2.l),d2
	and.l	#255,d2
	sub.l	#48,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	12(a6),a3
	move.l	(a3),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,(a2)
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L1058:
	move.l	16(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bge	.L1066
	jmp	.L1059
.L1066:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#48,d0
	bcs	.L1068
	cmp.w	#58,d0
	bcs	.L1067
.L1068:
	and.b	#254,ccr
.L1067:
	bcs	.L1057
	jmp	.L1059
.L1059:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#46,d2
	beq	.L1071
	jmp	.L1070
.L1071:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	16(a6),a2
	move.w	(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L1069
	jmp	.L1070
.L1069:
	move.l	.L1074,d2
	move.l	d2,-4(a6)
	move.l	16(a6),a2
	addq.w	#1,(a2)
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#48,d0
	bcs	.L1079
	cmp.w	#58,d0
	bcs	.L1078
.L1079:
	and.b	#254,ccr
.L1078:
	bcc	.L1075
	jmp	.L1077
.L1077:
	move.l	8(a6),a3
	move.b	(a3),d3
	and.l	#255,d3
	move.l	16(a6),a3
	move.w	(a3),d4
	and.l	#65535,d4
	cmp.l	d3,d4
	bgt	.L1075
	jmp	.L1076
.L1075:
	move.l	12(a6),a2
	move.l	.L353,d2
	move.l	d2,(a2)
	jmp	.L1029
.L1076:
	jmp	.L1083
.L1082:
	move.b	-22(a6),d2
	and.l	#255,d2
	or.l	#2,d2
	move.b	d2,-22(a6)
	move.l	12(a6),a2
	move.l	8(a6),a3
	move.l	16(a6),a4
	move.w	(a4),d2
	and.l	#65535,d2
	move.b	0(a3,d2.l),d2
	and.l	#255,d2
	sub.l	#48,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	-4(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	12(a6),a3
	move.l	(a3),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,(a2)
	move.l	-4(a6),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L1083:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#48,d0
	bcs	.L1093
	cmp.w	#58,d0
	bcs	.L1092
.L1093:
	and.b	#254,ccr
.L1092:
	bcs	.L1091
	jmp	.L1084
.L1091:
	move.l	8(a6),a3
	move.b	(a3),d3
	and.l	#255,d3
	move.l	16(a6),a3
	move.w	(a3),d4
	and.l	#65535,d4
	cmp.l	d3,d4
	ble	.L1082
	jmp	.L1084
.L1084:
.L1070:
	move.b	-22(a6),d2
	and.l	#255,d2
	tst.l	d2
	beq	.L1094
	jmp	.L1095
.L1094:
	move.l	12(a6),a2
	move.l	.L353,d2
	move.l	d2,(a2)
	jmp	.L1029
.L1095:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	lsl.w	#8,d2
	move.w	d2,-(sp)
	jsr	_SYSATARI$$_UPCASE$CHAR
	move.b	d0,d2
	cmp.b	#69,d2
	beq	.L1100
	jmp	.L1099
.L1100:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	16(a6),a2
	move.w	(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L1098
	jmp	.L1099
.L1098:
	move.l	16(a6),a2
	addq.w	#1,(a2)
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#43,d2
	beq	.L1103
	jmp	.L1104
.L1103:
	move.l	16(a6),a2
	addq.w	#1,(a2)
	jmp	.L1105
.L1104:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#45,d2
	beq	.L1106
	jmp	.L1107
.L1106:
	move.l	.L1056,d2
	move.l	d2,-8(a6)
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L1107:
.L1105:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#48,d0
	bcs	.L1114
	cmp.w	#58,d0
	bcs	.L1113
.L1114:
	and.b	#254,ccr
.L1113:
	bcc	.L1110
	jmp	.L1112
.L1112:
	move.l	8(a6),a3
	move.b	(a3),d3
	and.l	#255,d3
	move.l	16(a6),a3
	move.w	(a3),d4
	and.l	#65535,d4
	cmp.l	d3,d4
	bgt	.L1110
	jmp	.L1111
.L1110:
	move.l	12(a6),a2
	move.l	.L353,d2
	move.l	d2,(a2)
	jmp	.L1029
.L1111:
	jmp	.L1118
.L1117:
	move.l	-16(a6),d2
	move.l	#10,d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,-16(a6)
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	and.l	#255,d2
	add.l	-16(a6),d2
	sub.l	#48,d2
	move.l	d2,-16(a6)
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L1118:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#48,d0
	bcs	.L1126
	cmp.w	#58,d0
	bcs	.L1125
.L1126:
	and.b	#254,ccr
.L1125:
	bcs	.L1124
	jmp	.L1119
.L1124:
	move.l	8(a6),a3
	move.b	(a3),d3
	and.l	#255,d3
	move.l	16(a6),a3
	move.w	(a3),d4
	and.l	#65535,d4
	cmp.l	d3,d4
	ble	.L1117
	jmp	.L1119
.L1119:
.L1099:
	move.l	-8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1127
	jmp	.L1128
.L1127:
	move.l	#1,-20(a6)
	move.l	-16(a6),d2
	move.l	d2,-26(a6)
	move.l	-20(a6),d2
	cmp.l	-26(a6),d2
	bgt	.L1130
.L1131:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.l	(a3),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,(a2)
.L1129:
	move.l	-20(a6),d2
	cmp.l	-26(a6),d2
	bge	.L1130
	add.l	#1,-20(a6)
	jmp	.L1131
.L1130:
	jmp	.L1136
.L1128:
	move.l	#1,-20(a6)
	move.l	-16(a6),d2
	move.l	d2,-26(a6)
	move.l	-20(a6),d2
	cmp.l	-26(a6),d2
	bgt	.L1138
.L1139:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.l	(a3),d2
	move.l	.L385,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,(a2)
.L1137:
	move.l	-20(a6),d2
	cmp.l	-26(a6),d2
	bge	.L1138
	add.l	#1,-20(a6)
	jmp	.L1139
.L1138:
.L1136:
	move.l	8(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	16(a6),a2
	move.w	(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L1144
	jmp	.L1145
.L1144:
	move.l	12(a6),a2
	move.l	.L353,d2
	move.l	d2,(a2)
	jmp	.L1029
.L1145:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.l	(a3),d2
	move.l	-12(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,(a2)
	move.l	16(a6),a2
	move.w	#0,(a2)
.L1029:
.L1030:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$VALREAL$INTEGER
_SYSATARI$$_VAL$STRING$VALREAL$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$VALREAL$WORD
.L1152:
.L1153:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$VALREAL
_SYSATARI$$_VAL$STRING$VALREAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$VALREAL$WORD
.L1160:
.L1161:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$CARDINAL$WORD
_SYSATARI$$_VAL$STRING$CARDINAL$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#6,sp
	move.l	12(a6),a2
	move.l	#0,(a2)
	move.l	16(a6),a2
	move.l	a2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_INITVAL$STRING$BOOLEAN$BYTE
	move.w	d0,d2
	move.l	(sp)+,a2
	move.w	d2,(a2)
	move.l	16(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	blt	.L1186
	jmp	.L1188
.L1188:
	tst.b	-2(a6)
	bne	.L1186
	jmp	.L1187
.L1186:
	jmp	.L1168
.L1187:
	jmp	.L1190
.L1189:
	move.l	8(a6),a2
	move.l	16(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d3
	move.b	d3,-6(a6)
	move.b	-6(a6),d2
	sub.b	#47,d2
	bls	.L1195
	sub.b	#10,d2
	bls	.L1170
	subq.b	#7,d2
	bls	.L1195
	sub.b	#6,d2
	bls	.L1172
	sub.b	#26,d2
	bls	.L1195
	sub.b	#8,d2
	bls	.L1174
	jmp	.L1195
.L1174:
	move.b	-6(a6),d2
	and.l	#255,d2
	sub.l	#87,d2
	move.b	d2,-6(a6)
	jmp	.L1194
.L1172:
	move.b	-6(a6),d2
	and.l	#255,d2
	sub.l	#55,d2
	move.b	d2,-6(a6)
	jmp	.L1194
.L1170:
	move.b	-6(a6),d2
	and.l	#255,d2
	sub.l	#48,d2
	move.b	d2,-6(a6)
	jmp	.L1194
.L1195:
	move.b	#16,-6(a6)
.L1194:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.b	-4(a6),d2
	and.l	#255,d2
	move.l	(a3),d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,(a2)
	move.b	-6(a6),d2
	and.l	#255,d2
	move.b	-4(a6),d3
	and.l	#255,d3
	cmp.l	d2,d3
	blt	.L1206
	jmp	.L1208
.L1208:
	move.l	12(a6),a2
	move.l	(a2),d2
	move.l	#-1,d6
	sub.l	d2,d6
	move.l	d6,d2
	move.b	-6(a6),d3
	and.l	#255,d3
	cmp.l	d2,d3
	blt	.L1206
	jmp	.L1207
.L1206:
	move.l	12(a6),a2
	move.l	#0,(a2)
	jmp	.L1168
.L1207:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.b	-6(a6),d2
	and.l	#255,d2
	add.l	(a3),d2
	move.l	d2,(a2)
	move.l	16(a6),a2
	addq.w	#1,(a2)
.L1190:
	move.l	16(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.b	(a2),d3
	and.l	#255,d3
	cmp.l	d2,d3
	bge	.L1189
	jmp	.L1191
.L1191:
	move.l	16(a6),a2
	move.w	#0,(a2)
.L1168:
.L1169:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$CARDINAL
_SYSATARI$$_VAL$STRING$CARDINAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$CARDINAL$WORD
.L1215:
.L1216:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_VAL$STRING$CARDINAL$INTEGER
_SYSATARI$$_VAL$STRING$CARDINAL$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$CARDINAL$WORD
.L1223:
.L1224:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DECR_ANSI_REF$POINTER:
DECR_ANSI_REF:
	move.l	a6,-(sp)
	move.l	sp,a6
.L1231:
.L1232:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_INCR_ANSI_REF$POINTER:
INCR_ANSI_REF:
	move.l	a6,-(sp)
	move.l	sp,a6
.L1233:
.L1234:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_HI$BYTE
_SYSATARI$$_HI$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.b	8(a6),d2
	and.l	#255,d2
	lsr.l	#4,d2
	move.b	d2,-1(a6)
.L1235:
	move.b	-1(a6),d0
.L1236:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_LO$BYTE
_SYSATARI$$_LO$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.b	8(a6),d2
	and.l	#255,d2
	and.l	#15,d2
	move.b	d2,-1(a6)
.L1239:
	move.b	-1(a6),d0
.L1240:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$CARDINAL$LONGINT
_SYSATARI$$_INC$CARDINAL$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	add.l	12(a6),d2
	move.l	d2,(a2)
.L1243:
.L1244:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$CARDINAL$LONGINT
_SYSATARI$$_DEC$CARDINAL$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	sub.l	12(a6),d2
	move.l	d2,(a2)
.L1247:
.L1248:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$LONGINT$LONGINT
_SYSATARI$$_INC$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	add.l	12(a6),d2
	move.l	d2,(a2)
.L1251:
.L1252:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$LONGINT$LONGINT
_SYSATARI$$_DEC$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	sub.l	12(a6),d2
	move.l	d2,(a2)
.L1255:
.L1256:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$WORD$LONGINT
_SYSATARI$$_DEC$WORD$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	sub.l	12(a6),d2
	move.w	d2,(a2)
.L1259:
.L1260:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$WORD$LONGINT
_SYSATARI$$_INC$WORD$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.w	(a3),d2
	and.l	#65535,d2
	add.l	12(a6),d2
	move.w	d2,(a2)
.L1263:
.L1264:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$INTEGER$LONGINT
_SYSATARI$$_DEC$INTEGER$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.w	(a3),d2
	ext.l	d2
	sub.l	12(a6),d2
	move.w	d2,(a2)
.L1267:
.L1268:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$INTEGER$LONGINT
_SYSATARI$$_INC$INTEGER$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.w	(a3),d2
	ext.l	d2
	add.l	12(a6),d2
	move.w	d2,(a2)
.L1271:
.L1272:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$BYTE$LONGINT
_SYSATARI$$_DEC$BYTE$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	and.l	#255,d2
	sub.l	12(a6),d2
	move.b	d2,(a2)
.L1275:
.L1276:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$BYTE$LONGINT
_SYSATARI$$_INC$BYTE$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	and.l	#255,d2
	add.l	12(a6),d2
	move.b	d2,(a2)
.L1279:
.L1280:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$SHORTINT$LONGINT
_SYSATARI$$_DEC$SHORTINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	ext.w	d2
	ext.l	d2
	sub.l	12(a6),d2
	move.b	d2,(a2)
.L1283:
.L1284:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$SHORTINT$LONGINT
_SYSATARI$$_INC$SHORTINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	ext.w	d2
	ext.l	d2
	add.l	12(a6),d2
	move.b	d2,(a2)
.L1287:
.L1288:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$CHAR$LONGINT
_SYSATARI$$_DEC$CHAR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	and.l	#255,d2
	sub.l	12(a6),d2
	move.b	d2,(a2)
.L1291:
.L1292:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$CHAR$LONGINT
_SYSATARI$$_INC$CHAR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.b	(a3),d2
	and.l	#255,d2
	add.l	12(a6),d2
	move.b	d2,(a2)
.L1295:
.L1296:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DEC$PCHAR$LONGINT
_SYSATARI$$_DEC$PCHAR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	sub.l	12(a6),d2
	move.l	d2,(a2)
.L1299:
.L1300:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INC$PCHAR$LONGINT
_SYSATARI$$_INC$PCHAR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	add.l	12(a6),d2
	move.l	d2,(a2)
.L1303:
.L1304:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SWAP$WORD
_SYSATARI$$_SWAP$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	8(a6),d2
	and.l	#65535,d2
	and.l	#255,d2
	lsl.l	#8,d2
	move.w	8(a6),d3
	and.l	#65535,d3
	lsr.l	#8,d3
	add.l	d2,d3
	move.w	d3,-2(a6)
.L1307:
	move.w	-2(a6),d0
.L1308:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SWAP$INTEGER
_SYSATARI$$_SWAP$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	8(a6),-(sp)
	jsr	_SYSATARI$$_SWAP$WORD
	move.w	d0,d2
	move.w	d2,-2(a6)
.L1311:
	move.w	-2(a6),d0
.L1312:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SWAP$LONGINT
_SYSATARI$$_SWAP$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),d2
	and.l	#65535,d2
	move.l	#16,d6
	lsl.l	d6,d2
	move.l	8(a6),d3
	move.l	#16,d6
	lsr.l	d6,d3
	add.l	d2,d3
	move.l	d3,-4(a6)
.L1317:
	move.l	-4(a6),d0
.L1318:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SWAP$CARDINAL
_SYSATARI$$_SWAP$CARDINAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_SWAP$LONGINT
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1321:
	move.l	-4(a6),d0
.L1322:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RANDOM
_SYSATARI$$_RANDOM:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	tst.b	TC__SYSATARI$$_INITIALSEED
	bne	.L1329
	jmp	.L1331
.L1331:
	move.l	U_SYSATARI_RANDSEED,d2
	cmp.l	TC__SYSATARI$$_OLDRANDSEED,d2
	bne	.L1332
	jmp	.L1330
.L1332:
	move.b	TC__SYSATARI$$_INITIALSEED,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L1329
	jmp	.L1330
.L1329:
	move.l	U_SYSATARI_RANDSEED,d2
	move.l	d2,TC__SYSATARI$$_OLDRANDSEED
	move.b	#0,TC__SYSATARI$$_INITIALSEED
	move.l	U_SYSATARI_RANDSEED,-(sp)
	jsr	_SYSATARI$$_USESEED$LONGINT
.L1330:
	addq.l	#1,TC__SYSATARI$$_SEED1
	move.l	TC__SYSATARI$$_SEED1,d2
	move.l	#706,d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	#500009,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_SEED1
	addq.l	#1,TC__SYSATARI$$_SEED2
	move.l	TC__SYSATARI$$_SEED2,d2
	move.l	#774,d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	#600011,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_SEED2
	addq.l	#1,TC__SYSATARI$$_SEED3
	move.l	TC__SYSATARI$$_SEED3,d2
	move.l	#871,d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	#765241,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_SEED3
	move.l	TC__SYSATARI$$_SEED1,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	.L1347,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	TC__SYSATARI$$_SEED2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d3
	addq.l	#4,sp
	move.l	.L1348,d0
	move.l	d3,d1
	jsr	SINGLE_DIV
	move.l	d0,d3
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	TC__SYSATARI$$_SEED3,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d4
	addq.l	#4,sp
	move.l	.L1349,d0
	move.l	d4,d1
	jsr	SINGLE_DIV
	move.l	d0,d4
	move.l	d4,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),-(sp)
	jsr	_SYSATARI$$_FRAC$REAL
	move.l	d0,d2
	move.l	d2,-8(a6)
.L1327:
	move.l	-8(a6),d0
.L1328:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RANDOM$LONGINT
_SYSATARI$$_RANDOM$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	tst.b	TC__SYSATARI$$_INITIALSEED
	bne	.L1356
	jmp	.L1358
.L1358:
	move.l	U_SYSATARI_RANDSEED,d2
	cmp.l	TC__SYSATARI$$_OLDRANDSEED,d2
	bne	.L1359
	jmp	.L1357
.L1359:
	move.b	TC__SYSATARI$$_INITIALSEED,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L1356
	jmp	.L1357
.L1356:
	move.l	U_SYSATARI_RANDSEED,d2
	move.l	d2,TC__SYSATARI$$_OLDRANDSEED
	move.b	#0,TC__SYSATARI$$_INITIALSEED
	move.l	U_SYSATARI_RANDSEED,-(sp)
	jsr	_SYSATARI$$_USESEED$LONGINT
.L1357:
	addq.l	#1,TC__SYSATARI$$_SEED1
	move.l	TC__SYSATARI$$_SEED1,d2
	move.l	#998,d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	#1000003,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_SEED1
	move.l	TC__SYSATARI$$_SEED1,d2
	move.l	8(a6),d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1354:
	move.l	-4(a6),d0
.L1355:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_USESEED$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),d2
	move.l	#1000003,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_SEED1
	move.l	#65000,-(sp)
	jsr	_SYSATARI$$_RANDOM$LONGINT
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	#65000,-(sp)
	jsr	_SYSATARI$$_RANDOM$LONGINT
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d2,d0
	move.l	d3,d1
	jsr	LONGMUL
	move.l	d0,d3
	move.l	#600011,d1
	move.l	d3,d0
	jsr	LONGMOD
	move.l	d0,d3
	move.l	d3,TC__SYSATARI$$_SEED2
	move.l	#65000,-(sp)
	jsr	_SYSATARI$$_RANDOM$LONGINT
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	#65000,-(sp)
	jsr	_SYSATARI$$_RANDOM$LONGINT
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d2,d0
	move.l	d3,d1
	jsr	LONGMUL
	move.l	d0,d3
	move.l	#765241,d1
	move.l	d3,d0
	jsr	LONGMOD
	move.l	d0,d3
	move.l	d3,TC__SYSATARI$$_SEED3
.L1370:
.L1371:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT$REAL
_SYSATARI$$_INT$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-4(a6)
.L1386:
	move.l	-4(a6),d0
.L1387:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_TRUNC$REAL
_SYSATARI$$_TRUNC$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	8(a6),d0
	move.l	d2,-(sp)
	move.l	d0,d1
	swap	d1
	move.w	d1,d2
	bclr	#15,d1
	lsr.w	#7,d1
	and.l	#8388607,d0
	bset	#23,d0
	cmp.w	#126,d1
	blt	.L1394
	cmp.w	#158,d1
	bgt	.L1395
	sub.w	#150,d1
	bgt	.L1396
	beq	.L1397
	neg.w	d1
	lsr.l	d1,d0
	bra	.L1397
.L1396:
	lsl.l	d1,d0
.L1398:
	cmp.l	#-2147483648,d0
	bne	.L1399
	tst.w	d2
	bpl	.L1395
	bra	.L1400
.L1399:
	tst.l	d0
	bmi	.L1395
.L1397:
	tst.w	d2
	bpl	.L1400
	neg.l	d0
	bra	.L1400
.L1394:
	clr.l	d0
	bra	.L1400
.L1395:
	moveq	#-1,d0
	bclr	#31,d0
.L1400:
	move.l	(sp)+,d2
	move.l	d0,-4(a6)
	move.l	-4(a6),d2
	cmp.l	#2147483647,d2
	beq	.L1401
	jmp	.L1402
.L1401:
	move.w	#207,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
	jmp	.L1405
.L1402:
	move.l	-4(a6),d2
	move.l	d2,-8(a6)
.L1405:
.L1392:
	move.l	-8(a6),d0
.L1393:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ABS$REAL
_SYSATARI$$_ABS$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1410
	jmp	.L1411
.L1410:
	move.l	8(a6),d2
	bchg.l	#31,d2
	move.l	d2,-4(a6)
	jmp	.L1414
.L1411:
	move.l	8(a6),d2
	move.l	d2,-4(a6)
.L1414:
.L1408:
	move.l	-4(a6),d0
.L1409:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_FREXP$REAL$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	move.w	#0,(a2)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_ABS$REAL
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1421
	jmp	.L1422
.L1421:
	jmp	.L1426
.L1425:
	move.l	8(a6),d2
	move.l	.L1430,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	12(a6),a2
	subq.w	#1,(a2)
.L1426:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_ABS$REAL
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1425
	jmp	.L1427
.L1427:
	jmp	.L1433
.L1422:
	jmp	.L1435
.L1434:
	move.l	8(a6),d2
	move.l	.L1430,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	12(a6),a2
	addq.w	#1,(a2)
.L1435:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_ABS$REAL
	move.l	d0,d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1434
	jmp	.L1436
.L1436:
.L1433:
	move.l	8(a6),d2
	move.l	d2,-4(a6)
.L1417:
	move.l	-4(a6),d0
.L1418:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_LDEXP$REAL$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	.L395,d2
	move.l	d2,-4(a6)
	move.w	12(a6),d2
	ext.l	d2
	tst.l	d2
	bgt	.L1447
	jmp	.L1448
.L1447:
	jmp	.L1450
.L1449:
	move.l	-4(a6),d2
	move.l	.L1430,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-4(a6)
	subq.w	#1,12(a6)
.L1450:
	move.w	12(a6),d2
	ext.l	d2
	tst.l	d2
	bgt	.L1449
	jmp	.L1451
.L1451:
	jmp	.L1454
.L1448:
	jmp	.L1456
.L1455:
	move.l	-4(a6),d2
	move.l	.L1430,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,-4(a6)
	addq.w	#1,12(a6)
.L1456:
	move.w	12(a6),d2
	ext.l	d2
	tst.l	d2
	blt	.L1455
	jmp	.L1457
.L1457:
.L1454:
	move.l	8(a6),d2
	move.l	-4(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-8(a6)
.L1443:
	move.l	-8(a6),d0
.L1444:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#14,sp
	move.l	12(a6),a2
	move.l	(a2),d2
	move.l	d2,-4(a6)
	move.w	#1,-6(a6)
	move.w	16(a6),d2
	move.w	d2,-14(a6)
	move.w	-6(a6),d2
	cmp.w	-14(a6),d2
	bgt	.L1467
.L1468:
	move.l	12(a6),a2
	move.w	-6(a6),d2
	ext.l	d2
	lsl.l	#2,d2
	move.l	8(a6),a3
	move.l	(a3),d3
	move.l	-4(a6),d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	0(a2,d2.l),d0
	move.l	d3,d1
	jsr	SINGLE_ADD
	move.l	d0,d3
	move.l	d3,-4(a6)
.L1466:
	move.w	-6(a6),d2
	cmp.w	-14(a6),d2
	bge	.L1467
	add.w	#1,-6(a6)
	jmp	.L1468
.L1467:
	move.l	-4(a6),d2
	move.l	d2,-10(a6)
.L1462:
	move.l	-10(a6),d0
.L1463:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_P1EVL$REAL$TABCOEF$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#14,sp
	move.l	8(a6),a2
	move.l	12(a6),a3
	move.l	(a2),d2
	move.l	(a3),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.w	#1,-6(a6)
	move.w	16(a6),d2
	ext.l	d2
	sub.l	#1,d2
	move.w	d2,-14(a6)
	move.w	-6(a6),d2
	cmp.w	-14(a6),d2
	bgt	.L1480
.L1481:
	move.l	12(a6),a2
	move.w	-6(a6),d2
	ext.l	d2
	lsl.l	#2,d2
	move.l	8(a6),a3
	move.l	(a3),d3
	move.l	-4(a6),d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	0(a2,d2.l),d0
	move.l	d3,d1
	jsr	SINGLE_ADD
	move.l	d0,d3
	move.l	d3,-4(a6)
.L1479:
	move.w	-6(a6),d2
	cmp.w	-14(a6),d2
	bge	.L1480
	add.w	#1,-6(a6)
	jmp	.L1481
.L1480:
	move.l	-4(a6),d2
	move.l	d2,-10(a6)
.L1475:
	move.l	-10(a6),d0
.L1476:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SQR$REAL
_SYSATARI$$_SQR$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1488:
	move.l	-4(a6),d0
.L1489:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_PI
_SYSATARI$$_PI:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	.L1496,d2
	move.l	d2,-4(a6)
.L1492:
	move.l	-4(a6),d0
.L1493:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SQRT$REAL
_SYSATARI$$_SQRT$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#16,sp
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	ble	.L1499
	jmp	.L1500
.L1499:
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1501
	jmp	.L1502
.L1501:
	move.w	#207,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L1502:
	move.l	.L353,d2
	move.l	d2,-16(a6)
	jmp	.L1507
.L1500:
	move.l	8(a6),d2
	move.l	d2,-8(a6)
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_FREXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,-12(a6)
	move.l	-12(a6),d2
	move.l	.L1518,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	.L1519,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,8(a6)
	move.w	-2(a6),d2
	ext.l	d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_ODD$LONGINT
	move.b	d0,d2
	tst.b	d2
	bne	.L1520
	jmp	.L1521
.L1520:
	move.l	8(a6),d2
	move.l	.L1526,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
.L1521:
	move.w	-2(a6),d2
	ext.l	d2
	tst.l	d2
	bpl	.L1531
	addq.l	#1,d2
.L1531:
	asr.l	#1,d2
	move.w	d2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	8(a6),d2
	move.l	d2,-16(a6)
.L1507:
.L1497:
	move.l	-16(a6),d0
.L1498:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_EXP$REAL
_SYSATARI$$_EXP$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#20,sp
	move.l	8(a6),d2
	move.l	.L1552,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1550
	jmp	.L1551
.L1550:
	move.w	#205,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
	jmp	.L1555
.L1551:
	move.l	8(a6),d2
	move.l	.L1558,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1556
	jmp	.L1557
.L1556:
	move.w	#205,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
	jmp	.L1561
.L1557:
	move.l	8(a6),d2
	move.l	.L1564,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-12(a6)
	move.l	-12(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.w	d2,-2(a6)
	move.l	-12(a6),d2
	move.l	.L1575,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,d0
	move.l	8(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	-12(a6),d2
	move.l	.L1578,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-16(a6)
	move.w	#2,-(sp)
	pea.l	TC__SYSATARI$$_EXP_P
	lea.l	-16(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.w	#3,-(sp)
	pea.l	TC__SYSATARI$$_EXP_Q
	lea.l	-16(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,d0
	move.l	-8(a6),d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,8(a6)
	move.w	#1,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	8(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,8(a6)
	move.w	-2(a6),-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	8(a6),d2
	move.l	d2,-20(a6)
.L1561:
.L1555:
.L1548:
	move.l	-20(a6),d0
.L1549:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ROUND$REAL
_SYSATARI$$_ROUND$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#12,sp
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_FRAC$REAL
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-8(a6)
	move.l	-4(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1623
	jmp	.L1624
.L1623:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	add.l	#1,d2
	move.l	d2,-12(a6)
	jmp	.L1629
.L1624:
	move.l	-4(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1630
	jmp	.L1631
.L1630:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,-12(a6)
	jmp	.L1636
.L1631:
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bge	.L1637
	jmp	.L1638
.L1637:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	add.l	#1,d2
	move.l	d2,-12(a6)
	jmp	.L1643
.L1638:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,-12(a6)
.L1643:
.L1636:
.L1629:
.L1613:
	move.l	-12(a6),d0
.L1614:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_LN$REAL
_SYSATARI$$_LN$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#16,sp
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	ble	.L1651
	jmp	.L1652
.L1651:
	move.w	#207,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L1652:
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_FREXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,8(a6)
	move.w	-2(a6),d2
	ext.l	d2
	cmp.l	#2,d2
	bgt	.L1661
	jmp	.L1663
.L1663:
	move.w	-2(a6),d2
	ext.l	d2
	cmp.l	#-2,d2
	blt	.L1661
	jmp	.L1662
.L1661:
	move.l	8(a6),d2
	move.l	.L1666,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1664
	jmp	.L1665
.L1664:
	moveq.l	#1,d6
	move.l	d6,-(sp)
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DEC$INTEGER$LONGINT
	move.l	8(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-12(a6)
	jmp	.L1675
.L1665:
	move.l	8(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	8(a6),d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	.L403,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-12(a6)
.L1675:
	move.l	-8(a6),d2
	move.l	-12(a6),d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,8(a6)
	move.l	8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.w	#2,-(sp)
	pea.l	TC__SYSATARI$$_LN_R
	lea.l	-8(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.w	#3,-(sp)
	pea.l	TC__SYSATARI$$_LN_S
	lea.l	-8(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_P1EVL$REAL$TABCOEF$INTEGER
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-8(a6)
	jmp	.L1650
.L1662:
	move.l	8(a6),d2
	move.l	.L1702,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1700
	jmp	.L1701
.L1700:
	moveq.l	#1,d6
	move.l	d6,-(sp)
	lea.l	-2(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DEC$INTEGER$LONGINT
	move.w	#1,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,8(a6)
	jmp	.L1713
.L1701:
	move.l	8(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,8(a6)
.L1713:
	move.l	8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.w	#6,-(sp)
	pea.l	TC__SYSATARI$$_LN_P
	lea.l	8(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.w	#6,-(sp)
	pea.l	TC__SYSATARI$$_LN_Q
	lea.l	8(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_P1EVL$REAL$TABCOEF$INTEGER
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-12(a6)
	move.w	#-1,-(sp)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,d0
	move.l	-12(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-12(a6)
	move.l	8(a6),d2
	move.l	-12(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-8(a6)
.L1650:
	move.w	-2(a6),d2
	ext.l	d2
	tst.l	d2
	bne	.L1740
	jmp	.L1741
.L1740:
	move.w	-2(a6),d6
	ext.l	d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-12(a6)
	move.l	-12(a6),d2
	move.l	.L1746,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,d0
	move.l	-8(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-12(a6),d2
	move.l	.L1575,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-8(a6)
.L1741:
	move.l	-8(a6),d2
	move.l	d2,-16(a6)
.L1648:
	move.l	-16(a6),d0
.L1649:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SIN$REAL
_SYSATARI$$_SIN$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#20,sp
	move.w	#1,-16(a6)
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1755
	jmp	.L1756
.L1755:
	move.l	8(a6),d2
	bchg.l	#31,d2
	move.l	d2,8(a6)
	move.w	#-1,-16(a6)
.L1756:
	move.l	8(a6),d2
	move.l	.L1763,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1761
	jmp	.L1762
.L1761:
	move.l	.L353,d2
	move.l	d2,-20(a6)
	jmp	.L1751
.L1762:
	move.l	8(a6),d2
	move.l	.L1770,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-4(a6)
	move.w	#-4,-(sp)
	move.l	-4(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-8(a6)
	move.w	#4,-(sp)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,d0
	move.l	-4(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.w	d2,-14(a6)
	move.w	-14(a6),d2
	ext.l	d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_ODD$LONGINT
	move.b	d0,d2
	tst.b	d2
	bne	.L1791
	jmp	.L1792
.L1791:
	addq.w	#1,-14(a6)
	move.l	-4(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1792:
	move.w	-14(a6),d2
	ext.l	d2
	and.l	#7,d2
	move.w	d2,-14(a6)
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#3,d2
	bgt	.L1799
	jmp	.L1800
.L1799:
	move.w	-16(a6),d2
	ext.l	d2
	neg.l	d2
	move.w	d2,-16(a6)
	moveq.l	#4,d6
	move.l	d6,-(sp)
	lea.l	-14(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DEC$INTEGER$LONGINT
.L1800:
	move.l	-4(a6),d2
	move.l	.L1809,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,d0
	move.l	8(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	-4(a6),d3
	move.l	.L1810,d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	-4(a6),d4
	move.l	.L1811,d0
	move.l	d4,d1
	jsr	SINGLE_MUL
	move.l	d0,d4
	move.l	d4,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-12(a6)
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#1,d2
	beq	.L1814
	jmp	.L1816
.L1816:
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#2,d2
	beq	.L1814
	jmp	.L1815
.L1814:
	move.w	#-1,-(sp)
	move.l	-12(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,d0
	move.l	.L395,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	-12(a6),d3
	move.l	-12(a6),d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	d2,-(sp)
	move.l	d3,-(sp)
	move.w	#5,-(sp)
	pea.l	TC__SYSATARI$$_COSCOF
	lea.l	-12(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d4
	move.l	(sp)+,d3
	move.l	(sp)+,d2
	move.l	d4,d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
	jmp	.L1829
.L1815:
	move.l	-8(a6),d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.w	#5,-(sp)
	pea.l	TC__SYSATARI$$_SINCOF
	lea.l	-12(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1829:
	move.w	-16(a6),d2
	ext.l	d2
	tst.l	d2
	blt	.L1838
	jmp	.L1839
.L1838:
	move.l	-4(a6),d2
	bchg.l	#31,d2
	move.l	d2,-4(a6)
.L1839:
	move.l	-4(a6),d2
	move.l	d2,-20(a6)
.L1751:
	move.l	-20(a6),d0
.L1752:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_COS$REAL
_SYSATARI$$_COS$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#24,sp
	move.w	#1,-16(a6)
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1848
	jmp	.L1849
.L1848:
	move.l	8(a6),d2
	bchg.l	#31,d2
	move.l	d2,8(a6)
.L1849:
	move.l	8(a6),d2
	move.l	.L1763,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1852
	jmp	.L1853
.L1852:
	move.l	.L353,d2
	move.l	d2,-24(a6)
	jmp	.L1844
.L1853:
	move.l	8(a6),d2
	move.l	.L1860,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-4(a6)
	move.w	#-4,-(sp)
	move.l	-4(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	move.l	d2,-8(a6)
	move.w	#4,-(sp)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,d0
	move.l	-4(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_TRUNC$REAL
	move.l	d0,d2
	move.l	d2,-20(a6)
	move.l	-20(a6),-(sp)
	jsr	_SYSATARI$$_ODD$LONGINT
	move.b	d0,d2
	tst.b	d2
	bne	.L1881
	jmp	.L1882
.L1881:
	addq.l	#1,-20(a6)
	move.l	-4(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1882:
	move.l	-20(a6),d2
	and.l	#7,d2
	move.w	d2,-14(a6)
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#3,d2
	bgt	.L1889
	jmp	.L1890
.L1889:
	moveq.l	#4,d6
	move.l	d6,-(sp)
	lea.l	-14(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DEC$INTEGER$LONGINT
	move.w	-16(a6),d2
	ext.l	d2
	neg.l	d2
	move.w	d2,-16(a6)
.L1890:
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#1,d2
	bgt	.L1897
	jmp	.L1898
.L1897:
	move.w	-16(a6),d2
	ext.l	d2
	neg.l	d2
	move.w	d2,-16(a6)
.L1898:
	move.l	-4(a6),d2
	move.l	.L1809,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,d0
	move.l	8(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	-4(a6),d3
	move.l	.L1810,d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	-4(a6),d4
	move.l	.L1903,d0
	move.l	d4,d1
	jsr	SINGLE_MUL
	move.l	d0,d4
	move.l	d4,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-8(a6),d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-12(a6)
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#1,d2
	beq	.L1906
	jmp	.L1908
.L1908:
	move.w	-14(a6),d2
	ext.l	d2
	cmp.l	#2,d2
	beq	.L1906
	jmp	.L1907
.L1906:
	move.l	-8(a6),d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.w	#5,-(sp)
	pea.l	TC__SYSATARI$$_SINCOF
	lea.l	-12(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
	jmp	.L1917
.L1907:
	move.w	#-1,-(sp)
	move.l	-12(a6),-(sp)
	jsr	_SYSATARI$$_LDEXP$REAL$INTEGER
	move.l	d0,d2
	move.l	d2,d0
	move.l	.L395,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	-12(a6),d3
	move.l	-12(a6),d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	d2,-(sp)
	move.l	d3,-(sp)
	move.w	#5,-(sp)
	pea.l	TC__SYSATARI$$_COSCOF
	lea.l	-12(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d4
	move.l	(sp)+,d3
	move.l	(sp)+,d2
	move.l	d4,d0
	move.l	d3,d1
	jsr	SINGLE_MUL
	move.l	d0,d3
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1917:
	move.w	-16(a6),d2
	ext.l	d2
	tst.l	d2
	blt	.L1930
	jmp	.L1931
.L1930:
	move.l	-4(a6),d2
	bchg.l	#31,d2
	move.l	d2,-4(a6)
.L1931:
	move.l	-4(a6),d2
	move.l	d2,-24(a6)
.L1844:
	move.l	-24(a6),d0
.L1845:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ARCTAN$REAL
_SYSATARI$$_ARCTAN$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#14,sp
	move.w	#1,-10(a6)
	move.l	8(a6),d2
	move.l	.L353,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	blt	.L1940
	jmp	.L1941
.L1940:
	move.w	#-1,-10(a6)
	move.l	8(a6),d2
	bchg.l	#31,d2
	move.l	d2,8(a6)
.L1941:
	move.l	8(a6),d2
	move.l	.L1948,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1946
	jmp	.L1947
.L1946:
	move.l	.L1951,d2
	move.l	d2,-4(a6)
	move.l	8(a6),d2
	move.l	d2,d0
	move.l	.L395,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	bchg.l	#31,d2
	move.l	d2,8(a6)
	jmp	.L1954
.L1947:
	move.l	8(a6),d2
	move.l	.L1957,d0
	move.l	d2,d1
	jsr	SINGLE_CMP
	bgt	.L1955
	jmp	.L1956
.L1955:
	move.l	.L1960,d2
	move.l	d2,-4(a6)
	move.l	8(a6),d2
	move.l	.L395,d0
	move.l	d2,d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	8(a6),d3
	move.l	.L395,d0
	move.l	d3,d1
	jsr	SINGLE_ADD
	move.l	d0,d3
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	d2,8(a6)
	jmp	.L1963
.L1956:
	move.l	.L353,d2
	move.l	d2,-4(a6)
.L1963:
.L1954:
	move.l	8(a6),d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.w	#3,-(sp)
	pea.l	TC__SYSATARI$$_ARCTAN_P
	lea.l	-8(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_POLEVL$REAL$TABCOEF$INTEGER
	move.l	d0,d2
	move.l	d2,-(sp)
	move.w	#4,-(sp)
	pea.l	TC__SYSATARI$$_ARCTAN_Q
	lea.l	-8(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_P1EVL$REAL$TABCOEF$INTEGER
	move.l	d0,d3
	move.l	(sp)+,d2
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_DIV
	move.l	d0,d2
	move.l	-8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	move.l	-4(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	8(a6),d0
	move.l	d2,d1
	jsr	SINGLE_ADD
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.w	-10(a6),d2
	ext.l	d2
	tst.l	d2
	blt	.L1982
	jmp	.L1983
.L1982:
	move.l	-4(a6),d2
	bchg.l	#31,d2
	move.l	d2,-4(a6)
.L1983:
	move.l	-4(a6),d2
	move.l	d2,-14(a6)
.L1936:
	move.l	-14(a6),d0
.L1937:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FRAC$REAL
_SYSATARI$$_FRAC$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_INT$REAL
	move.l	d0,d2
	move.l	d2,d0
	move.l	8(a6),d1
	jsr	SINGLE_SUB
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1988:
	move.l	-4(a6),d0
.L1989:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_POWER$REAL$REAL
_SYSATARI$$_POWER$REAL$REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_LN$REAL
	move.l	d0,d2
	move.l	12(a6),d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_EXP$REAL
	move.l	d0,d2
	move.l	d2,-4(a6)
.L1994:
	move.l	-4(a6),d0
.L1995:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_POWER$LONGINT$LONGINT
_SYSATARI$$_POWER$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d2
	addq.l	#4,sp
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_LN$REAL
	move.l	d0,d2
	move.l	12(a6),d6
	move.l	d6,-(sp)
	move.l	(sp),d0
	jsr	LONG2SINGLE
	move.l	d0,d3
	addq.l	#4,sp
	move.l	d3,d0
	move.l	d2,d1
	jsr	SINGLE_MUL
	move.l	d0,d2
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_EXP$REAL
	move.l	d0,d2
	subq.l	#4,sp
	move.l	d2,(sp)
	jsr	_SYSATARI$$_ROUND$REAL
	move.l	d0,d2
	move.l	d2,-4(a6)
.L2002:
	move.l	-4(a6),d0
.L2003:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_PTR$LONGINT$LONGINT
_SYSATARI$$_PTR$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	#0,8(a6)
	move.l	12(a6),d2
	move.l	d2,-4(a6)
.L2012:
	move.l	-4(a6),d0
.L2013:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ADDR$$$$
_SYSATARI$$_ADDR$$$$:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-4(a6)
.L2018:
	move.l	-4(a6),d0
.L2019:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_CSEG
_SYSATARI$$_CSEG:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	#0,-2(a6)
.L2022:
	move.w	-2(a6),d0
.L2023:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DSEG
_SYSATARI$$_DSEG:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	#0,-2(a6)
.L2026:
	move.w	-2(a6),d0
.L2027:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SSEG
_SYSATARI$$_SSEG:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	#0,-2(a6)
.L2030:
	move.w	-2(a6),d0
.L2031:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_IORESULT
_SYSATARI$$_IORESULT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	U_SYSATARI_INOUTRES,d2
	move.w	d2,-2(a6)
	move.w	#0,U_SYSATARI_INOUTRES
.L2034:
	move.w	-2(a6),d0
.L2035:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FILLCHAR$$$$$LONGINT$CHAR
_SYSATARI$$_FILLCHAR$$$$$LONGINT$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.b	16(a6),d2
	lsl.w	#8,d2
	move.w	d2,-(sp)
	move.l	12(a6),-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$BYTE
.L2040:
.L2041:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RUNERROR
_SYSATARI$$_RUNERROR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	#0,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L2048:
.L2049:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_HALT
_SYSATARI$$_HALT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	#0,-(sp)
	jsr	_SYSATARI$$_HALT$BYTE
.L2052:
.L2053:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_DUMP_STACK_$DUMP_FRAME$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#260,sp
	lea.l	U_SYSATARI_STDERR,a0
	move.l	a0,-4(a6)
	pea.l	.L2062
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	#2048,-(sp)
	move.l	12(a6),-(sp)
	lea.l	-260(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_HEXSTR$LONGINT$BYTE
	lea.l	-260(a6),a1
	move.l	a1,-(sp)
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-4(a6),-(sp)
	jsr	WRITELN_TEXT
	pea.l	U_SYSATARI_STDERR
	jsr	_SYSATARI$$_FLUSH$TEXT
.L2058:
.L2059:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DUMP_STACK$LONGINT
_SYSATARI$$_DUMP_STACK$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	8(a6),d2
	sub.l	#1,d2
	move.l	d2,-8(a6)
	move.l	#0,-4(a6)
	jmp	.L2076
.L2075:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_GET_ADDR$LONGINT
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_DUMP_STACK_$DUMP_FRAME$LONGINT
	addq.l	#1,-4(a6)
	move.w	TC__SYSATARI$$_MAX_FRAME_DUMP,d2
	and.l	#65535,d2
	cmp.l	-4(a6),d2
	blt	.L2082
	jmp	.L2083
.L2082:
	jmp	.L2056
.L2083:
	move.l	8(a6),d2
	move.l	d2,-8(a6)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_GET_NEXT_FRAME$LONGINT
	move.l	d0,d2
	move.l	d2,8(a6)
.L2076:
	move.l	8(a6),d2
	cmp.l	-8(a6),d2
	bgt	.L2075
	jmp	.L2077
.L2077:
.L2056:
.L2057:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DO_EXIT
_SYSATARI$$_DO_EXIT:
	XDEF __EXIT
__EXIT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#264,sp
	jmp	.L2093
.L2092:
	move.w	#0,U_SYSATARI_INOUTRES
	move.l	TC__SYSATARI$$_EXITPROC,d2
	move.l	d2,-4(a6)
	move.l	#0,d2
	move.l	d2,TC__SYSATARI$$_EXITPROC
	move.l	-4(a6),a1
	jsr	(a1)
.L2093:
	move.l	TC__SYSATARI$$_EXITPROC,d2
	cmp.l	#0,d2
	bne	.L2092
	jmp	.L2094
.L2094:
	tst.b	TC__SYSATARI$$_DOERROR
	bne	.L2101
	jmp	.L2102
.L2101:
	lea.l	U_SYSATARI_OUTPUT,a0
	move.l	a0,-8(a6)
	pea.l	.L2105
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	TC__SYSATARI$$_ERRORCODE,d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_LONGINT
	pea.l	.L103
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	#2048,-(sp)
	move.l	TC__SYSATARI$$_ERRORADDR,-(sp)
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_HEXSTR$LONGINT$BYTE
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	move.l	-8(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-8(a6),-(sp)
	jsr	WRITELN_TEXT
	jsr	FLUSH_STDOUT
	move.l	TC__SYSATARI$$_ERRORBASE,-(sp)
	jsr	_SYSATARI$$_DUMP_STACK$LONGINT
.L2102:
	pea.l	U_SYSATARI_STDERR
	jsr	_SYSATARI$$_FLUSH$TEXT
.L2090:
.L2091:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_DOEXITPROC:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	TC__SYSATARI$$_EXITPROCLIST,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),a2
	move.l	(a2),d2
	move.l	d2,TC__SYSATARI$$_EXITPROCLIST
	move.l	-4(a6),a2
	move.l	4(a2),d2
	move.l	d2,TC__SYSATARI$$_EXITPROC
	move.l	-4(a6),a2
	move.l	8(a2),d2
	move.l	d2,-8(a6)
	moveq.l	#12,d6
	move.l	d6,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	jsr	FREEMEM
	move.l	-8(a6),a1
	jsr	(a1)
.L2120:
.L2121:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ADDEXITPROC$TPROCEDURE
_SYSATARI$$_ADDEXITPROC$TPROCEDURE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	moveq.l	#12,d6
	move.l	d6,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	jsr	GETMEM
	move.l	-4(a6),a2
	move.l	TC__SYSATARI$$_EXITPROCLIST,d2
	move.l	d2,(a2)
	move.l	-4(a6),a2
	move.l	TC__SYSATARI$$_EXITPROC,d2
	move.l	d2,4(a2)
	move.l	-4(a6),a2
	move.l	8(a6),d2
	move.l	d2,8(a2)
	move.l	-4(a6),d2
	move.l	d2,TC__SYSATARI$$_EXITPROCLIST
	lea.l	_SYSATARI$$_DOEXITPROC,a0
	move.l	a0,d2
	move.l	d2,TC__SYSATARI$$_EXITPROC
.L2130:
.L2131:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_DO_ASSERT$STRING$STRING$LONGINT
_SYSATARI$$_DO_ASSERT$STRING$STRING$LONGINT:
	XDEF FPC_DO_ASSERT
FPC_DO_ASSERT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	tst.b	(a2)
	beq	.L2144
	jmp	.L2145
.L2144:
	lea.l	U_SYSATARI_STDERR,a0
	move.l	a0,-4(a6)
	pea.l	.L2148
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	jmp	.L2149
.L2145:
	lea.l	U_SYSATARI_STDERR,a0
	move.l	a0,-4(a6)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
.L2149:
	lea.l	U_SYSATARI_STDERR,a0
	move.l	a0,-4(a6)
	pea.l	.L2154
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	pea.l	.L2159
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	16(a6),-(sp)
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_LONGINT
	move.w	#11776,-(sp)
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_CHAR
	move.l	-4(a6),-(sp)
	jsr	WRITELN_TEXT
	pea.l	U_SYSATARI_STDERR
	jsr	_SYSATARI$$_FLUSH$TEXT
	move.l	#227,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L2142:
.L2143:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SETJMP$JMP_BUF
_SYSATARI$$_SETJMP$JMP_BUF:
	XDEF FPC_SETJMP
FPC_SETJMP:
	move.l	a6,-(sp)
	move.l	sp,a6
.L2168:
.L2169:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_LONGJMP$JMP_BUF$LONGINT
_SYSATARI$$_LONGJMP$JMP_BUF$LONGINT:
	XDEF FPC_LONGJMP
FPC_LONGJMP:
	move.l	a6,-(sp)
	move.l	sp,a6
.L2170:
.L2171:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_SINGLE_NORM:
	tst.l	d4
	bne	.L2174
	tst.b	d1
	beq	.L2175
.L2174:
	clr.b	d2
.L2176:
	move.l	#-16777216,d5
.L2177:
	tst.w	d0
	ble	.L2178
	move.l	d4,d3
	and.l	d5,d3
	beq	.L2179
.L2178:
	addq.w	#1,d0
	lsr.l	#1,d4
	or.b	d1,d2
	roxr.b	#1,d1
	bra	.L2177
.L2179:
	and.b	#1,d2
	or.b	d2,d1
	asr.l	#1,d5
.L2180:
	move.l	d4,d3
	and.l	d5,d3
	bne	.L2181
	subq.w	#1,d0
	beq	.L2181
	add.b	d1,d1
	addx.l	d4,d4
	bra	.L2180
.L2181:
	tst.b	d1
	bge	.L2182
	neg.b	d1
	bvc	.L2183
	move.w	d4,d1
	and.w	#1,d1
	beq	.L2182
.L2183:
	clr.w	d1
	add.l	#1,d4
	tst.w	d0
	bne	.L2184
	add.w	#1,d0
	bra	.L2176
.L2184:
	move.l	d4,d3
	asl.l	#1,d5
	and.l	d5,d3
	bne	.L2177
.L2182:
	tst.l	d4
	beq	.L2185
	tst.w	d0
	blt	.L2185
	cmp.w	#255,d0
	bge	.L2186
	lsl.w	#8,d0
	lsl.w	#1,d2
	roxr.w	#1,d0
	swap	d0
	clr.w	d0
	and.l	#8388607,d4
	or.l	d4,d0
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2185:
.L2175:
	moveq.l	#0,d0
	lsl.w	#1,d2
	roxr.l	#1,d0
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2186:
	move.l	#2139095040,d0
	tst.w	d2
	bge	.L2187
	bset	#31,d0
.L2187:
	or.b	#2,ccr
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2172:
.L2173:
	rts
	CNOP 0,2
_SYSATARI$$_SINGLE_ADDSUB:
	XDEF SINGLE_SUB
SINGLE_SUB:
	eor.l	#-2147483648,d0
	XDEF SINGLE_ADD
SINGLE_ADD:
	movem.l	d2/d3/d4/d5,-(sp)
	move.l	d0,d4
	move.l	d1,d5
	move.l	#8388607,d3
	move.l	d5,d0
	move.l	d5,d2
	swap	d0
	move.w	d0,d2
	and.l	d3,d5
	move.l	d4,d1
	and.l	d3,d4
	swap	d1
	eor.w	d1,d2
	clr.b	d2
	moveq.l	#15,d3
	bclr	d3,d1
	bclr	d3,d0
	btst	d3,d2
	beq	.L2190
	cmp.l	d0,d1
	seq	d2
.L2190:
	lsr.w	#7,d0
	lsr.w	#7,d1
	moveq.l	#-1,d3
	cmp.b	d3,d0
	beq	.L2191
	cmp.b	d3,d1
	bne	.L2192
	bra	.L2193
.L2191:
	tst.b	d2
	bne	.L2194
	tst.l	d5
	bne	.L2194
	addq.w	#4,a0
	cmp.b	d3,d1
	bne	.L2195
.L2193:
	tst.l	d4
	bne	.L2194
.L2195:
	move.l	(a0),d0
	bra	.L2196
.L2194:
	moveq.l	#-1,d0
	lsr.l	#1,d0
	bra	.L2196
.L2192:
	tst.b	d2
	beq	.L2197
	moveq.l	#0,d0
.L2196:
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2197:
	moveq.l	#23,d3
	bset	d3,d5
	tst.w	d0
	bne	.L2198
	bclr	d3,d5
	addq.w	#1,d0
.L2198:
	bset	d3,d4
	tst.w	d1
	bne	.L2199
	bclr	d3,d4
	addq.w	#1,d1
.L2199:
	moveq.l	#0,d3
	neg.w	d1
	add.w	d0,d1
	beq	.L2200
	bgt	.L2201
	exg	d4,d5
	sub.w	d1,d0
	neg.w	d1
	tst.w	d2
	bpl	.L2201
	bchg	#31,d2
.L2201:
	cmp.w	#26,d1
	bge	.L2202
	moveq.l	#1,d3
.L2203:
	add.l	d5,d5
	subq.w	#1,d0
	subq.w	#1,d1
	dbeq	D3,.L2203
	moveq.l	#0,d3
	cmp.w	#16,d1
	blt	.L2204
	or.w	d4,d3
	clr.w	d4
	swap	d4
	subq.w	#8,d1
	subq.w	#8,d1
	bra	.L2204
.L2205:
	move.b	d4,d2
	and.b	#1,d2
	or.b	d2,d3
	lsr.l	#1,d4
.L2204:
	dbra	D1,.L2205
.L2200:
	tst.w	d2
	bpl	.L2206
	tst.w	d3
	beq	.L2207
	addq.l	#1,d4
.L2207:
	neg.l	d4
.L2206:
	add.l	d4,d5
	bcs	.L2202
	tst.w	d2
	bpl	.L2202
	neg.l	d5
	not.l	d2
.L2202:
	move.l	d5,d4
	clr.l	d1
	tst.l	d3
	beq	.L2208
	moveq.l	#-1,d1
.L2208:
	swap	d2
	jmp	_SYSATARI$$_SINGLE_NORM
.L2188:
.L2189:
	rts
	CNOP 0,2
_SYSATARI$$_SINGLE_MUL:
	XDEF SINGLE_MUL
SINGLE_MUL:
	movem.l	d2/d3/d4/d5,-(sp)
	move.l	d0,d4
	move.l	d1,d5
	move.l	#8388607,d3
	move.l	d5,d0
	and.l	d3,d5
	swap	d0
	move.w	d0,d2
	move.l	d4,d1
	and.l	d3,d4
	swap	d1
	eor.w	d1,d2
	moveq.l	#15,d3
	bclr	d3,d0
	bclr	d3,d1
	tst.l	d0
	beq	.L2211
	tst.l	d1
.L2211:
	seq	d2
	lsr.w	#7,d0
	lsr.w	#7,d1
	moveq.l	#-1,d3
	cmp.b	d3,d0
	beq	.L2212
	cmp.b	d3,d1
	bne	.L2213
	bra	.L2214
.L2212:
	tst.l	d5
	bne	.L2215
.L2214:
	tst.b	d2
	bne	.L2215
	cmp.b	d3,d1
	beq	.L2216
.L2217:
	move.l	#-16777216,d0
	lsl.w	#1,d2
	roxr.l	#1,d0
.L2218:
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2216:
	tst.l	d4
	beq	.L2217
.L2215:
	moveq.l	#-1,d0
	lsr.l	#1,d0
	bra	.L2218
.L2213:
	tst.b	d2
	bne	.L2219
	moveq.l	#23,d3
	bset	d3,d5
	subq.w	#8,sp
	tst.w	d0
	bne	.L2220
	bclr	d3,d5
	addq.w	#1,d0
.L2220:
	tst.l	d5
	beq	.L2221
	moveq.l	#23,d3
	bset	d3,d4
	tst.w	d1
	bne	.L2222
	bclr	d3,d4
	addq.w	#1,d1
.L2222:
	tst.l	d4
	beq	.L2221
	add.w	d1,d0
	sub.w	#134,d0
	clr.l	(sp)
	clr.l	4(sp)
	move.w	d4,d3
	mulu.w	d5,d3
	move.l	d3,4(sp)
	move.l	d4,d3
	swap	d3
	mulu.w	d5,d3
	add.l	d3,2(sp)
	swap	d5
	move.w	d4,d3
	mulu.w	d5,d3
	add.l	d3,2(sp)
	move.l	d4,d3
	swap	d3
	mulu.w	d5,d3
	add.l	d3,(sp)
	movem.l	2(sp),d4/d5
	clr.w	d5
	move.l	#65535,d3
.L2223:
	cmp.l	d3,d4
	bhi	.L2224
	cmp.w	#9,d0
	ble	.L2224
	swap	d4
	swap	d5
	move.w	d5,d4
	clr.w	d5
	subq.w	#8,d0
	subq.w	#8,d0
	bra	.L2223
.L2224:
	move.l	d5,d1
	rol.l	#8,d1
	move.l	d1,d3
	and.l	#-256,d3
	beq	.L2225
	or.b	#1,d1
.L2225:
	addq.w	#8,sp
	jmp	_SYSATARI$$_SINGLE_NORM
.L2221:
	addq.w	#8,sp
.L2219:
	moveq.l	#0,d0
	lsl.w	#1,d2
	roxr.l	#1,d0
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2209:
.L2210:
	rts
	CNOP 0,2
_SYSATARI$$_SINGLE_DIV:
	XDEF SINGLE_DIV
SINGLE_DIV:
	tst.l	d0
	bne	.L2228
	move.l	#2139095040,d0
	btst	#31,d1
	beq	.L2229
	bset	#31,d0
.L2229:
	rts
.L2228:
	move.l	d1,d4
	move.l	d0,d5
	movem.l	d2/d3/d4/d5,-(sp)
	move.l	#8388607,d3
	move.l	d4,d0
	and.l	d3,d4
	swap	d0
	move.w	d0,d2
	move.l	d5,d1
	and.l	d3,d5
	swap	d1
	eor.w	d1,d2
	moveq.l	#15,d3
	bclr	d3,d0
	bclr	d3,d1
	lsr.w	#7,d0
	lsr.w	#7,d1
	moveq.l	#-1,d3
	cmp.b	d3,d0
	beq	.L2230
	cmp.b	d3,d1
	beq	.L2231
	tst.b	d0
	bne	.L2232
	tst.l	d4
	beq	.L2233
.L2232:
	tst.w	d1
	bne	.L2234
	tst.l	d5
	bne	.L2234
	bra	.L2235
.L2230:
	tst.l	d4
	bne	.L2236
	cmp.b	d3,d1
	beq	.L2236
.L2235:
	move.l	#-16777216,d0
	lsl.w	#1,d2
	roxr.l	#1,d0
.L2237:
	movem.l	(sp)+,d2/d3/d4/d5
	rts
.L2231:
	tst.l	d5
	bne	.L2236
.L2238:
	moveq.l	#0,d0
	lsl.w	#1,d2
	roxr.l	#1,d0
	bra	.L2237
.L2233:
	tst.w	d1
	bne	.L2238
	tst.l	d4
	bne	.L2238
.L2236:
	move.l	d3,d0
	lsr.l	#1,d0
	bra	.L2237
.L2234:
	moveq.l	#23,d3
	bset	d3,d4
	tst.w	d0
	bne	.L2239
	bclr	d3,d4
	add.w	#1,d0
.L2239:
	tst.l	d4
	beq	.L2238
	bset	d3,d5
	tst.w	d1
	bne	.L2240
	bclr	d3,d5
	add.w	#1,d1
.L2240:
	sub.w	d1,d0
	add.w	#119,d0
	add.w	#34,d0
	move.w	#27,d1
	moveq.l	#-1,d3
	sub.l	d5,d4
.L2241:
	btst	d1,d3
	beq	.L2242
	add.l	d4,d4
	bcs	.L2243
	addx.l	d3,d3
	sub.l	d5,d4
	dbra	D0,.L2241
	bra	.L2242
.L2243:
	addx.l	d3,d3
	add.l	d5,d4
	dbra	D0,.L2241
.L2242:
	subq.w	#2,d0
	not.l	d3
	clr.l	d1
	tst.l	d4
	beq	.L2244
	moveq.l	#-1,d1
.L2244:
	move.l	d3,d4
	jmp	_SYSATARI$$_SINGLE_NORM
.L2226:
.L2227:
	rts
	CNOP 0,2
_SYSATARI$$_SINGLE_CMP:
	XDEF SINGLE_CMP
SINGLE_CMP:
	tst.l	d0
	bpl	.L2247
	neg.l	d0
	bchg	#31,d0
.L2247:
	tst.l	d1
	bpl	.L2248
	neg.l	d1
	bchg	#31,d1
.L2248:
	cmp.l	d0,d1
	rts
.L2245:
.L2246:
	rts
	CNOP 0,2
_SYSATARI$$_LONGMUL:
	XDEF LONGMUL
LONGMUL:
	cmp.b	#2,TC__SYSATARI$$_TEST68000
	blt	.L2251
	muls.l	d1,d0
	rts
.L2251:
	move.l	d2,a0
	move.l	d3,a1
	move.l	d0,-(sp)
	move.l	d1,-(sp)
	movem.w	(sp)+,d0/d1/d2/d3
	move.w	d0,-(sp)
	bpl	.L2252
	neg.w	d1
	negx.w	d0
.L2252:
	tst.w	d2
	bpl	.L2253
	neg.w	d3
	negx.w	d2
	not.w	(sp)
.L2253:
	ext.l	d0
	beq	.L2254
	mulu.w	d3,d0
.L2254:
	tst.w	d2
	beq	.L2255
	mulu.w	d1,d2
	add.w	d2,d0
.L2255:
	swap	d0
	clr.w	d0
	mulu.w	d3,d1
	add.l	d1,d0
	move.l	a1,d3
	move.l	a0,d2
	tst.w	(sp)+
	bpl	.L2256
	neg.l	d0
.L2256:
	rts
.L2249:
.L2250:
	rts
	CNOP 0,2
_SYSATARI$$_LONG2SINGLE:
	XDEF LONG2SINGLE
LONG2SINGLE:
	movem.l	d2/d3/d4/d5,-(sp)
	move.l	d0,d4
	move.w	#150,d0
	move.l	d4,d2
	bge	.L2259
	neg.l	d4
.L2259:
	swap	d2
	clr.w	d1
	jmp	_SYSATARI$$_SINGLE_NORM
.L2257:
.L2258:
	rts
	CNOP 0,2
_SYSATARI$$_LONGDIV:
	XDEF LONGDIV
LONGDIV:
	cmp.b	#2,TC__SYSATARI$$_TEST68000
	blt	.L2262
	tst.l	d1
	beq	.L2263
	move.l	d1,d6
	clr.l	d1
	tst.l	d0
	bpl	.L2264
	move.l	#-1,d1
.L2264:
	divsl.l	d6,d1:d0
	rts
.L2262:
	move.l	d2,a0
	move.l	d3,a1
	move.l	d4,-(sp)
	move.l	d5,-(sp)
	move.l	d1,d4
	move.l	d0,d5
	clr.w	-(sp)
	clr.l	d0
	move.l	d4,d2
	beq	.L2265
	bpl	.L2266
	neg.l	d2
	not.w	(sp)
.L2266:
	move.l	d5,d1
	bpl	.L2267
	neg.l	d1
	not.w	(sp)
.L2267:
	cmp.l	d2,d1
	bcs	.L2268
	move.l	d4,d6
	lsr.l	#8,d6
	lsr.l	#8,d6
	tst.l	d6
	bne	.L2269
	move.w	d1,d3
	clr.w	d1
	swap	d1
	beq	.L2270
	divu	d2,d1
.L2270:
	move.w	d1,d0
	swap	d0
	move.w	d3,d1
	divu	d2,d1
	move.w	d1,d0
	clr.w	d1
	swap	d1
	bra	.L2268
.L2269:
	moveq.l	#31,d3
.L2271:
	add.l	d1,d1
	addx.l	d0,d0
	cmp.l	d2,d0
	bcs	.L2272
	sub.l	d2,d0
	addq.w	#1,d1
.L2272:
	dbra	D3,.L2271
	exg	d0,d1
.L2268:
	tst.l	d5
	bpl	.L2273
	neg.l	d1
.L2273:
	tst.w	(sp)+
	bpl	.L2274
	neg.l	d0
.L2274:
	move.l	a1,d3
	move.l	a0,d2
	move.l	(sp)+,d5
	move.l	(sp)+,d4
	rts
.L2265:
	move.l	a1,d3
	move.l	a0,d2
	move.w	(sp)+,d1
	move.l	(sp)+,d5
	move.l	(sp)+,d4
.L2263:
	move.l	#200,d0
	jsr	HALT_ERROR
	rts
.L2260:
.L2261:
	rts
	CNOP 0,2
_SYSATARI$$_LONGMOD:
	XDEF LONGMOD
LONGMOD:
	jsr	_SYSATARI$$_LONGDIV
	move.l	d1,d0
	rts
.L2275:
.L2276:
	rts
	CNOP 0,2
_SYSATARI$$_STACK_CHECK:
	XDEF STACKCHECK
STACKCHECK:
	move.l	sp,d1
	sub.l	d0,d1
	sub.l	#2048,d1
	cmp.l	__BREAK,d1
	bgt	.L2279
	move.l	#202,d0
	jsr	HALT_ERROR
.L2279:
.L2277:
.L2278:
	rts
	CNOP 0,2
_SYSATARI$$_ERROR2INOUT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	_ERRNO,d2
	ext.l	d2
	cmp.l	#-2,d2
	ble	.L2308
	jmp	.L2307
.L2308:
	move.w	_ERRNO,d2
	ext.l	d2
	cmp.l	#-11,d2
	bge	.L2306
	jmp	.L2307
.L2306:
	move.w	_ERRNO,d2
	ext.l	d2
	move.l	#150,d6
	sub.l	d2,d6
	move.l	d6,d2
	move.w	d2,U_SYSATARI_INOUTRES
	jmp	.L2311
.L2307:
	move.w	_ERRNO,d2
	sub.w	#-68,d2
	ble	.L2313
	sub.w	#4,d2
	ble	.L2300
	sub.w	#18,d2
	beq	.L2298
	subq.w	#6,d2
	beq	.L2296
	subq.w	#1,d2
	beq	.L2294
	subq.w	#2,d2
	beq	.L2292
	subq.w	#1,d2
	beq	.L2290
	subq.w	#1,d2
	beq	.L2288
	subq.w	#1,d2
	beq	.L2286
	subq.w	#1,d2
	beq	.L2284
	subq.w	#1,d2
	beq	.L2282
	sub.w	#17,d2
	beq	.L2302
	subq.w	#2,d2
	beq	.L2304
	jmp	.L2313
.L2304:
	move.w	#150,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2302:
	move.w	#151,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2300:
	move.w	#153,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2298:
	move.w	#15,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2296:
	move.w	#9,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2294:
	move.w	#8,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2292:
	move.w	#8,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2290:
	move.w	#5,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2288:
	move.w	#4,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2286:
	move.w	#3,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2284:
	move.w	#2,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2282:
	move.w	#1,U_SYSATARI_INOUTRES
	jmp	.L2312
.L2313:
	move.w	_ERRNO,d2
	move.w	d2,U_SYSATARI_INOUTRES
.L2312:
.L2311:
	move.w	#0,_ERRNO
.L2280:
.L2281:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_HALT$BYTE
_SYSATARI$$_HALT$BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	jsr	_SYSATARI$$_DO_EXIT
	pea.l	U_SYSATARI_STDERR
	jsr	_SYSATARI$$_FLUSH$TEXT
	clr.l	d0
	move.b	8(a6),d0
	move.w	d0,-(sp)
	move.w	#76,-(sp)
	trap	#1
.L2342:
.L2343:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_ARGS:
	move.l	__ARGS,d0
.L2346:
.L2347:
	rts
	CNOP 0,2
_SYSATARI$$_GETENVPTR:
	move.l	__ENVP,d0
.L2348:
.L2349:
	rts
	CNOP 0,2
_SYSATARI$$_STRCOPY$PCHAR$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	#0,-4(a6)
	jmp	.L2355
.L2354:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.l	12(a6),a3
	move.l	-4(a6),d3
	move.b	0(a3,d3.l),d4
	move.b	d4,0(a2,d2.l)
	addq.l	#1,-4(a6)
.L2355:
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2354
	jmp	.L2356
.L2356:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	#0,0(a2,d2.l)
	move.l	8(a6),d2
	move.l	d2,-8(a6)
.L2350:
	move.l	-8(a6),d0
.L2351:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_SETUP_ENVIRONMENT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#12,sp
	move.l	#0,-12(a6)
	jsr	_SYSATARI$$_GETENVPTR
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	#0,-4(a6)
	jmp	.L2372
.L2371:
	addq.l	#1,-4(a6)
	jmp	.L2375
.L2374:
	addq.l	#1,-12(a6)
.L2375:
	move.l	-8(a6),a2
	move.l	-12(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2374
	jmp	.L2376
.L2376:
	addq.l	#1,-12(a6)
.L2372:
	move.l	-8(a6),a2
	move.l	-12(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2371
	jmp	.L2373
.L2373:
	move.l	-4(a6),d2
	add.l	#1,d2
	asl.l	#2,d2
	move.l	d2,-(sp)
	pea.l	U_SYSATARI_ENVP
	jsr	_SYSATARI$$_GETMEM$POINTER$LONGINT
	move.l	U_SYSATARI_ENVP,d2
	cmp.l	#0,d2
	beq	.L2381
	jmp	.L2382
.L2381:
	jmp	.L2363
.L2382:
	jsr	_SYSATARI$$_GETENVPTR
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	#0,-4(a6)
	move.l	#0,-12(a6)
	jmp	.L2390
.L2389:
	move.l	-8(a6),-(sp)
	jsr	_SYSATARI$$_STRLEN$PCHAR
	move.l	d0,d2
	add.l	#1,d2
	move.l	d2,-(sp)
	move.l	U_SYSATARI_ENVP,a2
	move.l	-4(a6),d2
	lsl.l	#2,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_GETMEM$POINTER$LONGINT
	move.l	-8(a6),-(sp)
	move.l	U_SYSATARI_ENVP,a2
	move.l	-4(a6),d2
	lsl.l	#2,d2
	move.l	0(a2,d2.l),-(sp)
	jsr	_SYSATARI$$_STRCOPY$PCHAR$PCHAR
	move.l	d0,d2
	addq.l	#1,-4(a6)
	jmp	.L2403
.L2402:
	addq.l	#1,-12(a6)
.L2403:
	move.l	-8(a6),a2
	move.l	-12(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2402
	jmp	.L2404
.L2404:
	addq.l	#1,-12(a6)
.L2390:
	move.l	-8(a6),a2
	move.l	-12(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2389
	jmp	.L2391
.L2391:
	move.l	U_SYSATARI_ENVP,a2
	move.l	-4(a6),d2
	lsl.l	#2,d2
	move.l	#0,d3
	move.l	d3,0(a2,d2.l)
	move.l	-8(a6),d2
	add.l	#3,d2
	move.l	d2,-8(a6)
.L2363:
.L2364:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_GETPARAMCOUNT$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.w	#0,-2(a6)
	move.w	#0,-4(a6)
	jmp	.L2416
.L2415:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#32,d2
	bne	.L2421
	jmp	.L2419
.L2421:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#9,d2
	bne	.L2420
	jmp	.L2419
.L2420:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2418
	jmp	.L2419
.L2418:
	move.w	-2(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-2(a6)
	jmp	.L2425
.L2424:
	move.w	-4(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-4(a6)
.L2425:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#32,d2
	bne	.L2430
	jmp	.L2426
.L2430:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#9,d2
	bne	.L2429
	jmp	.L2426
.L2429:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2424
	jmp	.L2426
.L2426:
.L2419:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	beq	.L2431
	jmp	.L2432
.L2431:
	jmp	.L2417
.L2432:
	move.w	-4(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-4(a6)
.L2416:
	move.l	8(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2415
	jmp	.L2417
.L2417:
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.l	d2,-8(a6)
.L2409:
	move.l	-8(a6),d0
.L2410:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_GETPARAM$WORD$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#776,sp
	move.b	#0,-264(a6)
	move.w	#0,-2(a6)
	move.w	#1,-4(a6)
	move.b	#0,-6(a6)
	jmp	.L2448
.L2447:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#32,d2
	bne	.L2452
	jmp	.L2451
.L2452:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#9,d2
	bne	.L2450
	jmp	.L2451
.L2450:
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.w	12(a6),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	beq	.L2453
	jmp	.L2454
.L2453:
	jmp	.L2456
.L2455:
	lea.l	-520(a6),a1
	lea.l	-264(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	move.b	#1,-776(a6)
	move.b	d0,-775(a6)
	lea.l	-776(a6),a1
	move.l	a1,-(sp)
	lea.l	-520(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-264(a6),a1
	lea.l	-520(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.b	-6(a6),d2
	and.l	#255,d2
	add.l	#1,d2
	move.b	d2,-6(a6)
	move.w	-2(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-2(a6)
.L2456:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2466
	jmp	.L2457
.L2466:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#32,d2
	bne	.L2465
	jmp	.L2457
.L2465:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#9,d2
	bne	.L2464
	jmp	.L2457
.L2464:
	move.b	-6(a6),d2
	and.l	#255,d2
	cmp.l	#256,d2
	blt	.L2455
	jmp	.L2457
.L2457:
	move.b	-6(a6),d2
	move.b	d2,-264(a6)
	movea.l	8(a6),a2
	lea.l	(a2),a1
	lea.l	-264(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	jmp	.L2437
.L2454:
	jmp	.L2472
.L2471:
	move.w	-2(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-2(a6)
.L2472:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2477
	jmp	.L2473
.L2477:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#32,d2
	bne	.L2476
	jmp	.L2473
.L2476:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#9,d2
	bne	.L2471
	jmp	.L2473
.L2473:
	move.w	-4(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-4(a6)
.L2451:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	beq	.L2480
	jmp	.L2481
.L2480:
	jmp	.L2449
.L2481:
	move.w	-2(a6),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.w	d2,-2(a6)
.L2448:
	move.l	14(a6),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#0,d2
	bne	.L2447
	jmp	.L2449
.L2449:
	movea.l	8(a6),a2
	lea.l	(a2),a1
	lea.l	-264(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
.L2437:
.L2438:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_PARAMSTR$LONGINT
_SYSATARI$$_PARAMSTR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#516,sp
	move.l	12(a6),d2
	tst.l	d2
	beq	.L2488
	jmp	.L2489
.L2488:
	move.b	#0,-260(a6)
	jmp	.L2492
.L2489:
	move.l	12(a6),d2
	tst.l	d2
	bgt	.L2495
	jmp	.L2494
.L2495:
	jsr	_SYSATARI$$_PARAMCOUNT
	move.l	d0,d2
	cmp.l	12(a6),d2
	bge	.L2493
	jmp	.L2494
.L2493:
	jsr	_SYSATARI$$_ARGS
	move.l	d0,d2
	move.l	d2,-4(a6)
	movea.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),-(sp)
	move.l	12(a6),d2
	move.w	d2,-(sp)
	lea.l	-516(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_GETPARAM$WORD$PCHAR
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-516(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	jmp	.L2504
.L2494:
	movea.l	8(a6),a2
	move.b	#0,(a2)
.L2504:
.L2492:
.L2486:
.L2487:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_PARAMCOUNT
_SYSATARI$$_PARAMCOUNT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	TC__SYSATARI$$_ARGC,d2
	move.l	d2,-4(a6)
.L2507:
	move.l	-4(a6),d0
.L2508:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RANDOMIZE
_SYSATARI$$_RANDOMIZE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	movem.l	d2/d3/a2/a3,-(sp)
	move.w	#17,-(sp)
	trap	#14
	add.l	#2,sp
	movem.l	(sp)+,d2/d3/a2/a3
	move.l	d0,-4(a6)
	move.l	-4(a6),d2
	move.l	d2,U_SYSATARI_RANDSEED
.L2511:
.L2512:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_SBRK$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	movem.l	d2/d3/a2/a3,-(sp)
	move.l	8(a6),-(sp)
	move.w	#72,-(sp)
	trap	#1
	addq.l	#6,sp
	move.l	d0,-4(a6)
	movem.l	(sp)+,d2/d3/a2/a3
	move.l	-4(a6),d2
	tst.l	d2
	beq	.L2517
	jmp	.L2518
.L2517:
	move.l	#-1,-8(a6)
	jmp	.L2521
.L2518:
	move.l	-4(a6),d2
	move.l	d2,-8(a6)
.L2521:
.L2515:
	move.l	-8(a6),d0
.L2516:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_GETHEAPSTART:
	lea.l	HEAP,a0
	move.l	a0,d0
.L2524:
.L2525:
	rts
	CNOP 0,2
_SYSATARI$$_GETHEAPSIZE:
	move.l	HEAP_SIZE,d0
.L2526:
.L2527:
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_HEAPSIZE
_SYSATARI$$_HEAPSIZE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	__INTERNAL_HEAPSIZE,d2
	move.l	d2,-4(a6)
.L2528:
	move.l	-4(a6),d0
.L2529:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_CAL_MEMAVAIL
_SYSATARI$$_CAL_MEMAVAIL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#16,sp
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,-12(a6)
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,-4(a6)
	jmp	.L2539
.L2538:
	move.l	-4(a6),a2
	move.l	4(a2),d2
	add.l	-12(a6),d2
	move.l	d2,-12(a6)
	move.l	-4(a6),a2
	move.l	(a2),d2
	move.l	d2,-4(a6)
.L2539:
	tst.l	-4(a6)
	bne	.L2538
	jmp	.L2540
.L2540:
	move.l	-12(a6),d2
	move.l	d2,-16(a6)
.L2532:
	move.l	-16(a6),d0
.L2533:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MEMAVAIL
_SYSATARI$$_MEMAVAIL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	__MEMAVAIL,d2
	move.l	d2,-4(a6)
.L2547:
	move.l	-4(a6),d0
.L2548:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MAXAVAIL
_SYSATARI$$_MAXAVAIL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,-8(a6)
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,-4(a6)
	jmp	.L2558
.L2557:
	move.l	-4(a6),a2
	move.l	4(a2),d2
	cmp.l	-8(a6),d2
	bgt	.L2560
	jmp	.L2561
.L2560:
	move.l	-4(a6),a2
	move.l	4(a2),d2
	move.l	d2,-8(a6)
.L2561:
	move.l	-4(a6),a2
	move.l	(a2),d2
	move.l	d2,-4(a6)
.L2558:
	tst.l	-4(a6)
	bne	.L2557
	jmp	.L2559
.L2559:
.L2551:
	move.l	-8(a6),d0
.L2552:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_GETMEM_$CALL_HEAPERROR$POINTER$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	16(a6),-(sp)
	move.l	12(a6),a0
	jsr	(a0)
	move.w	d0,-2(a6)
.L2568:
	move.w	-2(a6),d0
.L2569:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_GETMEM$POINTER$LONGINT
_SYSATARI$$_GETMEM$POINTER$LONGINT:
	XDEF GETMEM
GETMEM:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#16,sp
	move.l	12(a6),d2
	tst.l	d2
	beq	.L2576
	jmp	.L2577
.L2576:
	move.l	8(a6),a2
	move.l	U_SYSATARI_HEAPEND,d2
	move.l	d2,(a2)
	jmp	.L2566
.L2577:
	move.l	12(a6),d2
	move.l	#8,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	tst.l	d2
	bne	.L2580
	jmp	.L2581
.L2580:
	move.l	12(a6),d2
	move.l	#8,d1
	move.l	d2,d0
	jsr	LONGMOD
	move.l	d0,d2
	move.l	#8,d6
	sub.l	d2,d6
	move.l	d6,d2
	add.l	12(a6),d2
	move.l	d2,12(a6)
.L2581:
	move.l	12(a6),-(sp)
	pea.l	__MEMAVAIL
	jsr	_SYSATARI$$_DEC$LONGINT$LONGINT
.L2588:
	move.b	#0,-10(a6)
	tst.l	U_SYSATARI_FREELIST
	bne	.L2592
	jmp	.L2593
.L2592:
	move.l	#0,d2
	move.l	d2,-4(a6)
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,-8(a6)
	jmp	.L2599
.L2598:
	move.l	-8(a6),a2
	move.l	4(a2),d2
	cmp.l	12(a6),d2
	bge	.L2601
	jmp	.L2602
.L2601:
	move.l	8(a6),a2
	move.l	-8(a6),d2
	move.l	d2,(a2)
	move.l	-8(a6),a2
	move.l	4(a2),d2
	cmp.l	12(a6),d2
	bgt	.L2605
	jmp	.L2606
.L2605:
	move.l	-8(a6),d2
	add.l	12(a6),d2
	move.l	d2,a2
	move.l	-8(a6),a3
	move.l	4(a3),d2
	sub.l	12(a6),d2
	move.l	d2,4(a2)
	move.l	-8(a6),d2
	add.l	12(a6),d2
	move.l	d2,a2
	move.l	-8(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	tst.l	-4(a6)
	bne	.L2611
	jmp	.L2612
.L2611:
	move.l	-4(a6),a2
	move.l	-8(a6),d2
	add.l	12(a6),d2
	move.l	d2,(a2)
	jmp	.L2615
.L2612:
	move.l	-8(a6),d2
	add.l	12(a6),d2
	move.l	d2,U_SYSATARI_FREELIST
.L2615:
	jmp	.L2618
.L2606:
	tst.l	-4(a6)
	bne	.L2619
	jmp	.L2620
.L2619:
	move.l	-4(a6),a2
	move.l	-8(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	jmp	.L2623
.L2620:
	move.l	-8(a6),a2
	move.l	(a2),d2
	move.l	d2,U_SYSATARI_FREELIST
.L2623:
.L2618:
	jmp	.L2566
.L2602:
	move.l	-8(a6),d2
	move.l	d2,-4(a6)
	move.l	-8(a6),a2
	move.l	(a2),d2
	move.l	d2,-8(a6)
.L2599:
	tst.l	-8(a6)
	bne	.L2598
	jmp	.L2600
.L2600:
.L2593:
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPPTR,d2
	cmp.l	12(a6),d2
	blt	.L2630
	jmp	.L2631
.L2630:
	tst.l	U_SYSATARI_HEAPERROR
	bne	.L2632
	jmp	.L2633
.L2632:
	move.l	12(a6),-(sp)
	move.l	U_SYSATARI_HEAPERROR,-(sp)
	move.l	a6,-(sp)
	jsr	_SYSATARI$$_GETMEM_$CALL_HEAPERROR$POINTER$LONGINT
	move.w	d0,d2
	tst.w	d2
	beq	.L2570
	subq.w	#1,d2
	beq	.L2572
	subq.w	#1,d2
	beq	.L2574
	jmp	.L2635
.L2574:
	move.b	#1,-10(a6)
	jmp	.L2634
.L2572:
	move.l	8(a6),a2
	move.l	#0,d2
	move.l	d2,(a2)
	jmp	.L2634
.L2570:
	move.w	#203,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
	jmp	.L2634
.L2635:
.L2634:
	jmp	.L2646
.L2633:
	move.w	#203,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L2646:
	jmp	.L2649
.L2631:
	move.l	8(a6),a2
	move.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,(a2)
	move.l	U_SYSATARI_HEAPPTR,d2
	add.l	12(a6),d2
	move.l	d2,U_SYSATARI_HEAPPTR
.L2649:
	move.b	-10(a6),d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L2589
	jmp	.L2588
.L2589:
.L2566:
.L2567:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FREEMEM$POINTER$LONGINT
_SYSATARI$$_FREEMEM$POINTER$LONGINT:
	XDEF FREEMEM
FREEMEM:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#268,sp
	move.l	12(a6),d2
	tst.l	d2
	beq	.L2657
	jmp	.L2658
.L2657:
	move.l	8(a6),a2
	move.l	#0,d2
	move.l	d2,(a2)
	jmp	.L2654
.L2658:
	move.l	8(a6),a2
	move.l	(a2),d2
	cmp.l	#0,d2
	beq	.L2661
	jmp	.L2662
.L2661:
	move.w	#204,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L2662:
	move.l	12(a6),d2
	add.l	#7,d2
	and.l	#-8,d2
	move.l	d2,12(a6)
	move.l	__MEMAVAIL,d2
	add.l	12(a6),d2
	move.l	d2,__MEMAVAIL
	move.l	8(a6),a2
	move.l	(a2),d2
	add.l	12(a6),d2
	cmp.l	U_SYSATARI_HEAPPTR,d2
	bcc	.L2669
	jmp	.L2670
.L2669:
	move.l	8(a6),a2
	move.l	(a2),d2
	move.l	d2,U_SYSATARI_HEAPPTR
	jmp	.L2673
.L2670:
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	12(a6),d2
	move.l	d2,4(a2)
	tst.l	U_SYSATARI_FREELIST
	beq	.L2676
	jmp	.L2677
.L2676:
	move.l	8(a6),a2
	move.l	(a2),d2
	move.l	d2,U_SYSATARI_FREELIST
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	#0,d2
	move.l	d2,(a2)
	jmp	.L2656
.L2677:
	move.l	8(a6),a2
	move.l	(a2),d2
	add.l	12(a6),d2
	cmp.l	U_SYSATARI_FREELIST,d2
	bcs	.L2682
	jmp	.L2683
.L2682:
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,(a2)
	move.l	8(a6),a2
	move.l	(a2),d2
	move.l	d2,U_SYSATARI_FREELIST
	jmp	.L2656
	jmp	.L2688
.L2683:
	move.l	8(a6),a2
	move.l	(a2),d2
	add.l	12(a6),d2
	cmp.l	U_SYSATARI_FREELIST,d2
	beq	.L2689
	jmp	.L2690
.L2689:
	move.l	U_SYSATARI_FREELIST,a2
	move.l	4(a2),-(sp)
	move.l	8(a6),a2
	move.l	(a2),a2
	lea.l	4(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	U_SYSATARI_FREELIST,a3
	move.l	(a3),d2
	move.l	d2,(a2)
	move.l	8(a6),a2
	move.l	(a2),d2
	move.l	d2,U_SYSATARI_FREELIST
	move.l	8(a6),a2
	move.l	8(a6),a3
	move.l	(a3),a3
	move.l	(a2),d2
	add.l	4(a3),d2
	move.l	8(a6),a2
	move.l	(a2),a2
	cmp.l	(a2),d2
	beq	.L2699
	jmp	.L2700
.L2699:
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	(a2),a2
	move.l	4(a2),-(sp)
	move.l	8(a6),a2
	move.l	(a2),a2
	lea.l	4(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	U_SYSATARI_FREELIST,a3
	move.l	(a3),a3
	move.l	(a3),d2
	move.l	d2,(a2)
.L2700:
	jmp	.L2656
.L2690:
.L2688:
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,-4(a6)
	jmp	.L2710
.L2709:
	move.l	8(a6),a2
	move.l	-4(a6),a3
	move.l	4(a3),d2
	add.l	-4(a6),d2
	cmp.l	(a2),d2
	bhi	.L2712
	jmp	.L2713
.L2712:
	lea.l	U_SYSATARI_OUTPUT,a0
	move.l	a0,-12(a6)
	pea.l	.L2716
	move.l	-12(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	#2048,-(sp)
	move.l	8(a6),a2
	move.l	(a2),-(sp)
	lea.l	-268(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_HEXSTR$LONGINT$BYTE
	lea.l	-268(a6),a1
	move.l	a1,-(sp)
	move.l	-12(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	pea.l	.L2725
	move.l	-12(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-12(a6),-(sp)
	jsr	WRITELN_TEXT
	jsr	FLUSH_STDOUT
	move.w	#204,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L2713:
	move.l	-4(a6),a2
	move.l	4(a2),d2
	add.l	-4(a6),d2
	move.l	8(a6),a2
	cmp.l	(a2),d2
	beq	.L2728
	jmp	.L2729
.L2728:
	move.l	12(a6),-(sp)
	move.l	-4(a6),a2
	lea.l	4(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	-4(a6),a2
	move.l	4(a2),d2
	add.l	-4(a6),d2
	move.l	-4(a6),a2
	cmp.l	(a2),d2
	beq	.L2734
	jmp	.L2735
.L2734:
	move.l	-4(a6),a2
	move.l	(a2),a2
	move.l	4(a2),-(sp)
	move.l	-4(a6),a2
	lea.l	4(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	-4(a6),a2
	move.l	-4(a6),a3
	move.l	(a3),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	jmp	.L2742
.L2735:
	move.l	-4(a6),a2
	move.l	(a2),d2
	cmp.l	#0,d2
	bne	.L2745
	jmp	.L2744
.L2745:
	move.l	-4(a6),a2
	move.l	4(a2),d2
	add.l	-4(a6),d2
	move.l	-4(a6),a2
	cmp.l	(a2),d2
	bhi	.L2743
	jmp	.L2744
.L2743:
	lea.l	U_SYSATARI_OUTPUT,a0
	move.l	a0,-12(a6)
	pea.l	.L2716
	move.l	-12(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.w	#2048,-(sp)
	move.l	8(a6),a2
	move.l	(a2),-(sp)
	lea.l	-268(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_HEXSTR$LONGINT$BYTE
	lea.l	-268(a6),a1
	move.l	a1,-(sp)
	move.l	-12(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	pea.l	.L2756
	move.l	-12(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-12(a6),-(sp)
	jsr	WRITELN_TEXT
	jsr	FLUSH_STDOUT
	move.w	#204,-(sp)
	jsr	_SYSATARI$$_RUNERROR$WORD
.L2744:
.L2742:
	jmp	.L2711
	jmp	.L2759
.L2729:
	move.l	-4(a6),a2
	move.l	(a2),d2
	cmp.l	#0,d2
	beq	.L2760
	jmp	.L2761
.L2760:
	move.l	-4(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	#0,d2
	move.l	d2,(a2)
	jmp	.L2711
	jmp	.L2766
.L2761:
	move.l	-4(a6),a2
	move.l	8(a6),a3
	move.l	(a2),d2
	cmp.l	(a3),d2
	bhi	.L2767
	jmp	.L2768
.L2767:
	move.l	8(a6),a2
	move.l	(a2),d2
	add.l	12(a6),d2
	move.l	-4(a6),a2
	cmp.l	(a2),d2
	beq	.L2769
	jmp	.L2770
.L2769:
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	-4(a6),a3
	move.l	(a3),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	move.l	-4(a6),a2
	move.l	(a2),a2
	move.l	4(a2),-(sp)
	move.l	8(a6),a2
	move.l	(a2),a2
	lea.l	4(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	-4(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	jmp	.L2779
.L2770:
	move.l	8(a6),a2
	move.l	(a2),a2
	move.l	-4(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	move.l	-4(a6),a2
	move.l	8(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
.L2779:
	jmp	.L2711
.L2768:
.L2766:
.L2759:
	move.l	-4(a6),a2
	move.l	(a2),d2
	move.l	d2,-4(a6)
.L2710:
	tst.l	-4(a6)
	bne	.L2709
	jmp	.L2711
.L2711:
.L2673:
.L2656:
	move.l	8(a6),a2
	move.l	#0,d2
	move.l	d2,(a2)
.L2654:
.L2655:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RELEASE$POINTER
_SYSATARI$$_RELEASE$POINTER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	(a2),d2
	move.l	d2,U_SYSATARI_HEAPPTR
	move.l	#0,d2
	move.l	d2,U_SYSATARI_FREELIST
	jsr	_SYSATARI$$_CAL_MEMAVAIL
	move.l	d0,d2
	move.l	d2,__MEMAVAIL
.L2788:
.L2789:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MARK$POINTER
_SYSATARI$$_MARK$POINTER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,(a2)
.L2796:
.L2797:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MARKHEAP$POINTER$POINTER
_SYSATARI$$_MARKHEAP$POINTER$POINTER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	12(a6),a2
	move.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,(a2)
	move.l	8(a6),a2
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,(a2)
	move.l	#0,d2
	move.l	d2,U_SYSATARI_FREELIST
	jsr	_SYSATARI$$_CAL_MEMAVAIL
	move.l	d0,d2
	move.l	d2,__MEMAVAIL
.L2800:
.L2801:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RELEASEHEAP$POINTER$POINTER
_SYSATARI$$_RELEASEHEAP$POINTER$POINTER:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	12(a6),d2
	move.l	d2,U_SYSATARI_HEAPPTR
	move.l	U_SYSATARI_FREELIST,d2
	cmp.l	U_SYSATARI_HEAPPTR,d2
	blt	.L2814
	jmp	.L2815
.L2814:
.L2815:
	move.l	8(a6),d2
	move.l	d2,U_SYSATARI_FREELIST
	jsr	_SYSATARI$$_CAL_MEMAVAIL
	move.l	d0,d2
	move.l	d2,__MEMAVAIL
.L2810:
.L2811:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_GROWHEAP$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#18,sp
	move.l	8(a6),d2
	move.l	d2,-8(a6)
	move.l	8(a6),d2
	add.l	#65535,d2
	move.l	d2,8(a6)
	move.l	8(a6),d2
	and.l	#-65536,d2
	move.l	d2,8(a6)
	move.l	#1048576,-(sp)
	jsr	_SYSATARI$$_SBRK$LONGINT
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),d2
	cmp.l	#-1,d2
	beq	.L2832
	jmp	.L2833
.L2832:
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_SBRK$LONGINT
	move.l	d0,d2
	move.l	d2,-4(a6)
	jmp	.L2838
.L2833:
	move.l	#1048576,8(a6)
.L2838:
	move.l	-4(a6),d2
	cmp.l	#-1,d2
	beq	.L2841
	jmp	.L2842
.L2841:
	move.w	#0,-18(a6)
	jmp	.L2820
	jmp	.L2845
.L2842:
	move.w	#0,-(sp)
	move.l	8(a6),-(sp)
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$CHAR
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,-12(a6)
	tst.l	-12(a6)
	beq	.L2854
	jmp	.L2855
.L2854:
	move.l	-4(a6),d2
	cmp.l	U_SYSATARI_HEAPEND,d2
	beq	.L2856
	jmp	.L2857
.L2856:
	move.l	-4(a6),d2
	add.l	8(a6),d2
	move.l	d2,U_SYSATARI_HEAPEND
	jmp	.L2860
.L2857:
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPPTR,d2
	tst.l	d2
	bgt	.L2861
	jmp	.L2862
.L2861:
	move.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,U_SYSATARI_FREELIST
	move.l	U_SYSATARI_FREELIST,d2
	move.l	d2,-12(a6)
	move.l	-12(a6),a2
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,4(a2)
	move.l	-12(a6),a2
	move.l	#0,d2
	move.l	d2,(a2)
.L2862:
	move.l	-4(a6),d2
	move.l	d2,U_SYSATARI_HEAPPTR
	move.l	-4(a6),d2
	add.l	8(a6),d2
	move.l	d2,U_SYSATARI_HEAPEND
.L2860:
	jmp	.L2875
.L2855:
	move.l	-4(a6),d2
	cmp.l	U_SYSATARI_HEAPEND,d2
	beq	.L2876
	jmp	.L2877
.L2876:
	move.l	-4(a6),d2
	add.l	8(a6),d2
	move.l	d2,U_SYSATARI_HEAPEND
	jmp	.L2880
.L2877:
	jmp	.L2882
.L2881:
	move.l	-12(a6),a2
	move.l	(a2),d2
	move.l	d2,-12(a6)
.L2882:
	move.l	-12(a6),a2
	tst.l	(a2)
	bne	.L2886
	jmp	.L2883
.L2886:
	move.l	-12(a6),a2
	move.l	(a2),d2
	cmp.l	-4(a6),d2
	blt	.L2881
	jmp	.L2883
.L2883:
	move.l	-12(a6),a2
	move.l	(a2),d2
	cmp.l	#0,d2
	beq	.L2887
	jmp	.L2888
.L2887:
	move.l	-12(a6),a2
	move.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,(a2)
	move.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,-12(a6)
	move.l	-12(a6),a2
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPPTR,d2
	move.l	d2,4(a2)
	move.l	-12(a6),a2
	move.l	#0,d2
	move.l	d2,(a2)
	move.l	-4(a6),d2
	move.l	d2,U_SYSATARI_HEAPPTR
	move.l	-4(a6),d2
	add.l	8(a6),d2
	move.l	d2,U_SYSATARI_HEAPEND
	jmp	.L2901
.L2888:
	move.l	-4(a6),a2
	move.l	8(a6),d2
	move.l	d2,4(a2)
	move.l	-4(a6),a2
	move.l	-12(a6),a3
	move.l	(a3),d2
	move.l	d2,(a2)
	move.l	-12(a6),a2
	move.l	-4(a6),d2
	move.l	d2,(a2)
.L2901:
.L2880:
.L2875:
	jsr	_SYSATARI$$_CAL_MEMAVAIL
	move.l	d0,d2
	sub.l	-8(a6),d2
	move.l	d2,__MEMAVAIL
	move.l	8(a6),d0
	move.l	HEAP_SIZE,d1
	add.l	d0,d1
	move.l	d1,HEAP_SIZE
	move.w	#2,-18(a6)
	move.l	8(a6),d2
	add.l	__INTERNAL_HEAPSIZE,d2
	move.l	d2,__INTERNAL_HEAPSIZE
	jmp	.L2820
.L2845:
.L2820:
	move.w	-18(a6),d0
.L2821:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_INITHEAP:
	move.l	a6,-(sp)
	move.l	sp,a6
	lea.l	_BASEHEAP,a0
	move.l	a0,d2
	move.l	d2,_CURHEAP
	jsr	_SYSATARI$$_GETHEAPSTART
	move.l	d0,d2
	move.l	d2,U_SYSATARI_HEAPORG
	move.l	U_SYSATARI_HEAPORG,d2
	move.l	d2,U_SYSATARI_HEAPPTR
	jsr	_SYSATARI$$_GETHEAPSIZE
	move.l	d0,d2
	move.l	d2,__MEMAVAIL
	move.l	U_SYSATARI_HEAPORG,d2
	add.l	__MEMAVAIL,d2
	move.l	d2,U_SYSATARI_HEAPEND
	lea.l	_SYSATARI$$_GROWHEAP$LONGINT,a0
	move.l	a0,d2
	move.l	d2,U_SYSATARI_HEAPERROR
	move.l	U_SYSATARI_HEAPEND,d2
	sub.l	U_SYSATARI_HEAPORG,d2
	move.l	d2,__INTERNAL_HEAPSIZE
	move.l	#0,d2
	move.l	d2,U_SYSATARI_FREELIST
.L2914:
.L2915:
	unlk	a6
	rts
	CNOP 0,2
_SYSATARI$$_ALLOWSLASH$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	#0,-4(a6)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_STRLEN$PCHAR
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-4(a6),d2
	cmp.l	-8(a6),d2
	bgt	.L2935
.L2936:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	0(a2,d2.l),d2
	cmp.b	#47,d2
	beq	.L2941
	jmp	.L2942
.L2941:
	move.l	8(a6),a2
	move.l	-4(a6),d2
	move.b	#92,0(a2,d2.l)
.L2942:
.L2934:
	move.l	-4(a6),d2
	cmp.l	-8(a6),d2
	bge	.L2935
	add.l	#1,-4(a6)
	jmp	.L2936
.L2935:
.L2932:
.L2933:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_CLOSE$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	movem.l	d2/d3/a2/a3,-(sp)
	move.l	8(a6),d0
	move.w	d0,-(sp)
	move.w	#62,-(sp)
	trap	#1
	add.l	#4,sp
	movem.l	(sp)+,d2/d3/a2/a3
.L2945:
.L2946:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_ERASE$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_ALLOWSLASH$PCHAR
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.l	8(a6),-(sp)
	move.w	#65,-(sp)
	trap	#1
	add.l	#6,sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	tst.w	d0
	beq	.L2949
	move.w	d0,_ERRNO
.L2949:
	move.w	_ERRNO,d2
	ext.l	d2
	tst.l	d2
	bne	.L2952
	jmp	.L2953
.L2952:
	jsr	_SYSATARI$$_ERROR2INOUT
.L2953:
.L2947:
.L2948:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_RENAME$PCHAR$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_ALLOWSLASH$PCHAR
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_ALLOWSLASH$PCHAR
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.l	8(a6),-(sp)
	move.l	12(a6),-(sp)
	clr.w	-(sp)
	move.w	#86,-(sp)
	trap	#1
	lea	12(sp),sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	tst.w	d0
	beq	.L2956
	move.w	d0,_ERRNO
.L2956:
	move.w	_ERRNO,d2
	ext.l	d2
	tst.l	d2
	bne	.L2961
	jmp	.L2962
.L2961:
	jsr	_SYSATARI$$_ERROR2INOUT
.L2962:
.L2954:
.L2955:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_ISDEVICE$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	8(a6),d2
	and.l	#65535,d2
	cmp.l	#1,d2
	beq	.L2965
	jmp	.L2968
.L2968:
	move.w	8(a6),d2
	and.l	#65535,d2
	tst.l	d2
	beq	.L2965
	jmp	.L2967
.L2967:
	move.w	8(a6),d2
	and.l	#65535,d2
	cmp.l	#65535,d2
	beq	.L2965
	jmp	.L2966
.L2965:
	move.b	#0,-1(a6)
	jmp	.L2971
.L2966:
	move.b	#1,-1(a6)
.L2971:
.L2963:
	move.b	-1(a6),d0
.L2964:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#2,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_WRITE$LONGINT$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.l	12(a6),-(sp)
	move.l	16(a6),-(sp)
	move.l	8(a6),d0
	move.w	d0,-(sp)
	move.w	#64,-(sp)
	trap	#1
	lea	12(sp),sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	tst.l	d0
	bpl	.L2976
	move.w	d0,_ERRNO
.L2976:
	move.l	d0,-4(a6)
	move.w	_ERRNO,d2
	ext.l	d2
	tst.l	d2
	bne	.L2977
	jmp	.L2978
.L2977:
	jsr	_SYSATARI$$_ERROR2INOUT
.L2978:
.L2974:
	move.l	-4(a6),d0
.L2975:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_READ$LONGINT$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.l	12(a6),-(sp)
	move.l	16(a6),-(sp)
	move.l	8(a6),d0
	move.w	d0,-(sp)
	move.w	#63,-(sp)
	trap	#1
	lea	12(sp),sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	tst.l	d0
	bpl	.L2981
	move.w	d0,_ERRNO
.L2981:
	move.l	d0,-4(a6)
	move.w	_ERRNO,d2
	ext.l	d2
	tst.l	d2
	bne	.L2982
	jmp	.L2983
.L2982:
	jsr	_SYSATARI$$_ERROR2INOUT
.L2983:
.L2979:
	move.l	-4(a6),d0
.L2980:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_FILEPOS$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.w	#1,-(sp)
	move.l	8(a6),d0
	move.w	d0,-(sp)
	move.l	#0,-(sp)
	move.w	#66,-(sp)
	trap	#1
	lea	10(sp),sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	move.l	d0,-4(a6)
.L2984:
	move.l	-4(a6),d0
.L2985:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_SEEK$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.w	#0,-(sp)
	move.l	8(a6),d0
	move.w	d0,-(sp)
	move.l	12(a6),-(sp)
	move.w	#66,-(sp)
	trap	#1
	lea	10(sp),sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
.L2986:
.L2987:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_SEEKEND$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.w	#2,-(sp)
	move.l	8(a6),d0
	move.w	d0,-(sp)
	move.l	#0,-(sp)
	move.w	#66,-(sp)
	trap	#1
	lea	10(sp),sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	move.l	d0,-4(a6)
	move.l	-4(a6),d2
	move.l	d2,-8(a6)
.L2988:
	move.l	-8(a6),d0
.L2989:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_FILESIZE$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_DO_FILEPOS$LONGINT
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_DO_SEEKEND$LONGINT
	move.l	d0,d2
	move.l	d2,-8(a6)
	move.l	-4(a6),-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_DO_SEEK$LONGINT$LONGINT
.L2992:
	move.l	-8(a6),d0
.L2993:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_TRUNCATE$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	12(a6),-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_DO_SEEK$LONGINT$LONGINT
.L3006:
.L3007:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DO_OPEN$$$$$PCHAR$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#8,sp
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_ALLOWSLASH$PCHAR
	move.l	16(a6),d2
	and.l	#4096,d2
	tst.l	d2
	beq	.L3037
	jmp	.L3038
.L3037:
	move.l	8(a6),a2
	move.w	2(a2),d2
	sub.w	#55216,d2
	beq	.L3018
	subq.w	#1,d2
	beq	.L3014
	subq.w	#1,d2
	beq	.L3014
	subq.w	#1,d2
	beq	.L3014
	jmp	.L3040
.L3018:
	jmp	.L3039
.L3014:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_CLOSE$LONGINT
	jmp	.L3039
.L3040:
	move.w	#102,U_SYSATARI_INOUTRES
	jmp	.L3012
.L3039:
.L3038:
	move.l	8(a6),a2
	move.w	#65535,(a2)
	move.l	#2,-8(a6)
	move.l	16(a6),d2
	and.l	#3,d2
	tst.l	d2
	beq	.L3020
	subq.l	#1,d2
	beq	.L3022
	subq.l	#1,d2
	beq	.L3024
	jmp	.L3050
.L3024:
	move.l	8(a6),a2
	move.w	#55219,2(a2)
	jmp	.L3049
.L3022:
	move.l	8(a6),a2
	move.w	#55218,2(a2)
	jmp	.L3049
.L3020:
	move.l	8(a6),a2
	move.w	#55217,2(a2)
	move.l	#0,-8(a6)
	jmp	.L3049
.L3050:
.L3049:
	move.l	16(a6),d2
	and.l	#256,d2
	tst.l	d2
	bne	.L3059
	jmp	.L3060
.L3059:
	move.l	8(a6),a2
	move.w	#55218,2(a2)
	move.l	#4,-8(a6)
	jmp	.L3065
.L3060:
	move.l	16(a6),d2
	and.l	#16,d2
	tst.l	d2
	bne	.L3066
	jmp	.L3067
.L3066:
	move.l	8(a6),a2
	move.w	#55218,2(a2)
	move.l	#2,-8(a6)
.L3067:
.L3065:
	move.l	12(a6),a2
	move.b	(a2),d2
	cmp.b	#0,d2
	beq	.L3072
	jmp	.L3073
.L3072:
	move.l	8(a6),a2
	move.w	2(a2),d2
	sub.w	#55217,d2
	beq	.L3026
	subq.w	#1,d2
	beq	.L3028
	subq.w	#2,d2
	beq	.L3028
	jmp	.L3075
.L3028:
	move.l	8(a6),a2
	move.w	#1,(a2)
	move.l	8(a6),a2
	move.w	#55218,2(a2)
	jmp	.L3074
.L3026:
	move.l	8(a6),a2
	move.w	#0,(a2)
	jmp	.L3074
.L3075:
.L3074:
	jmp	.L3012
.L3073:
	movem.l	d2/d3/a2/a3,-(sp)
	cmp.l	#4,-8(a6)
	bne	.L3031
	move.w	#0,-(sp)
	move.l	12(a6),-(sp)
	move.w	#60,-(sp)
	trap	#1
	add.l	#8,sp
	bra	.L3032
.L3031:
	move.l	-8(a6),d0
.L3033:
	move.w	d0,-(sp)
	move.l	12(a6),-(sp)
	move.w	#61,-(sp)
	trap	#1
	add.l	#8,sp
.L3032:
	movem.l	(sp)+,d2/d3/a2/a3
	tst.w	d0
	bpl	.L3034
	cmp.w	#-1,d0
	beq	.L3034
	cmp.w	#-2,d0
	beq	.L3034
	cmp.w	#-3,d0
	beq	.L3034
	move.w	d0,_ERRNO
.L3034:
	move.w	d0,-2(a6)
	move.w	_ERRNO,d2
	ext.l	d2
	tst.l	d2
	bne	.L3082
	jmp	.L3083
.L3082:
	jsr	_SYSATARI$$_ERROR2INOUT
.L3083:
	move.l	8(a6),a2
	move.w	-2(a6),d2
	move.w	d2,(a2)
	move.l	16(a6),d2
	and.l	#16,d2
	tst.l	d2
	bne	.L3086
	jmp	.L3087
.L3086:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_SEEKEND$LONGINT
	move.l	d0,d2
.L3087:
.L3012:
.L3013:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$FILE$STRING
_SYSATARI$$_ASSIGN$FILE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	#0,-(sp)
	move.l	#128,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$BYTE
	move.l	8(a6),a2
	move.w	#65535,(a2)
	move.l	8(a6),a2
	move.w	#55216,2(a2)
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L3090:
.L3091:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$FILE$PCHAR
_SYSATARI$$_ASSIGN$FILE$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.l	12(a6),-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_STRPAS$PCHAR
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$FILE$STRING
.L3108:
.L3109:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$FILE$CHAR
_SYSATARI$$_ASSIGN$FILE$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.b	12(a6),d0
	move.b	#1,-256(a6)
	move.b	d0,-255(a6)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$FILE$STRING
.L3116:
.L3117:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_REWRITE$FILE$WORD
_SYSATARI$$_REWRITE$FILE$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3124
	jmp	.L3125
.L3124:
	jmp	.L3122
.L3125:
	move.w	12(a6),d2
	and.l	#65535,d2
	tst.l	d2
	beq	.L3126
	jmp	.L3127
.L3126:
	move.w	#2,U_SYSATARI_INOUTRES
	jmp	.L3130
.L3127:
	move.l	#257,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_DO_OPEN$$$$$PCHAR$LONGINT
	move.l	8(a6),a2
	move.w	12(a6),d2
	move.w	d2,4(a2)
.L3130:
.L3122:
.L3123:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RESET$FILE$WORD
_SYSATARI$$_RESET$FILE$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3141
	jmp	.L3142
.L3141:
	jmp	.L3139
.L3142:
	move.w	12(a6),d2
	and.l	#65535,d2
	tst.l	d2
	beq	.L3143
	jmp	.L3144
.L3143:
	move.w	#2,U_SYSATARI_INOUTRES
	jmp	.L3147
.L3144:
	move.b	TC__SYSATARI$$_FILEMODE,d2
	and.l	#255,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_DO_OPEN$$$$$PCHAR$LONGINT
	move.l	8(a6),a2
	move.w	12(a6),d2
	move.w	d2,4(a2)
.L3147:
.L3139:
.L3140:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_REWRITE$FILE
_SYSATARI$$_REWRITE$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3158
	jmp	.L3159
.L3158:
	jmp	.L3156
.L3159:
	move.w	#128,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_REWRITE$FILE$WORD
.L3156:
.L3157:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RESET$FILE
_SYSATARI$$_RESET$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3166
	jmp	.L3167
.L3166:
	jmp	.L3164
.L3167:
	move.w	#128,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_RESET$FILE$WORD
.L3164:
.L3165:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT$LONGINT
_SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3174
	jmp	.L3175
.L3174:
	jmp	.L3172
.L3175:
	move.l	20(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	16(a6),d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_WRITE$LONGINT$LONGINT$LONGINT
	move.l	d0,d2
	move.l	(sp)+,a2
	move.l	8(a6),a3
	move.w	4(a3),d3
	and.l	#65535,d3
	move.l	d3,d1
	move.l	d2,d0
	jsr	LONGDIV
	move.l	d0,d2
	move.l	d2,(a2)
.L3172:
.L3173:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKWRITE$FILE$$$$$WORD$WORD
_SYSATARI$$_BLOCKWRITE$FILE$$$$$WORD$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3186
	jmp	.L3187
.L3186:
	jmp	.L3184
.L3187:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.w	16(a6),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT$LONGINT
	move.l	18(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L3184:
.L3185:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#14,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKWRITE$FILE$$$$$WORD$INTEGER
_SYSATARI$$_BLOCKWRITE$FILE$$$$$WORD$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3200
	jmp	.L3201
.L3200:
	jmp	.L3198
.L3201:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.w	16(a6),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT$LONGINT
	move.l	18(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L3198:
.L3199:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#14,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT
_SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3214
	jmp	.L3215
.L3214:
	jmp	.L3212
.L3215:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	16(a6),-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_BLOCKWRITE$FILE$$$$$LONGINT$LONGINT
	move.l	-4(a6),d2
	tst.l	d2
	beq	.L3226
	jmp	.L3225
.L3226:
	move.l	16(a6),d2
	tst.l	d2
	bgt	.L3224
	jmp	.L3225
.L3224:
	move.w	#101,U_SYSATARI_INOUTRES
.L3225:
.L3212:
.L3213:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT$LONGINT
_SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	20(a6),a2
	move.l	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3233
	jmp	.L3234
.L3233:
	jmp	.L3229
.L3234:
	move.l	20(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	16(a6),d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_READ$LONGINT$LONGINT$LONGINT
	move.l	d0,d2
	move.l	(sp)+,a2
	move.l	8(a6),a3
	move.w	4(a3),d3
	and.l	#65535,d3
	move.l	d3,d1
	move.l	d2,d0
	jsr	LONGDIV
	move.l	d0,d2
	move.l	d2,(a2)
.L3229:
.L3230:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKREAD$FILE$$$$$WORD$WORD
_SYSATARI$$_BLOCKREAD$FILE$$$$$WORD$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	18(a6),a2
	move.w	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3247
	jmp	.L3248
.L3247:
	jmp	.L3243
.L3248:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.w	16(a6),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT$LONGINT
	move.l	18(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L3243:
.L3244:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#14,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKREAD$FILE$$$$$WORD$INTEGER
_SYSATARI$$_BLOCKREAD$FILE$$$$$WORD$INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	18(a6),a2
	move.w	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3263
	jmp	.L3264
.L3263:
	jmp	.L3259
.L3264:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.w	16(a6),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT$LONGINT
	move.l	18(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L3259:
.L3260:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#14,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT
_SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3277
	jmp	.L3278
.L3277:
	jmp	.L3275
.L3278:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	16(a6),-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_BLOCKREAD$FILE$$$$$LONGINT$LONGINT
	move.l	-4(a6),d2
	tst.l	d2
	beq	.L3289
	jmp	.L3288
.L3289:
	move.l	16(a6),d2
	tst.l	d2
	bgt	.L3287
	jmp	.L3288
.L3287:
	move.w	#100,U_SYSATARI_INOUTRES
.L3288:
.L3275:
.L3276:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FILEPOS$FILE
_SYSATARI$$_FILEPOS$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3294
	jmp	.L3295
.L3294:
	jmp	.L3292
.L3295:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_FILEPOS$LONGINT
	move.l	d0,d2
	move.l	8(a6),a2
	move.w	4(a2),d3
	and.l	#65535,d3
	move.l	d3,d1
	move.l	d2,d0
	jsr	LONGDIV
	move.l	d0,d2
	move.l	d2,-4(a6)
.L3292:
	move.l	-4(a6),d0
.L3293:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FILESIZE$FILE
_SYSATARI$$_FILESIZE$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3302
	jmp	.L3303
.L3302:
	jmp	.L3300
.L3303:
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	tst.l	d2
	beq	.L3304
	jmp	.L3305
.L3304:
	move.l	#0,-4(a6)
	jmp	.L3308
.L3305:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_FILESIZE$LONGINT
	move.l	d0,d2
	move.l	8(a6),a2
	move.w	4(a2),d3
	and.l	#65535,d3
	move.l	d3,d1
	move.l	d2,d0
	jsr	LONGDIV
	move.l	d0,d2
	move.l	d2,-4(a6)
.L3308:
.L3300:
	move.l	-4(a6),d0
.L3301:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_EOF$FILE
_SYSATARI$$_EOF$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3315
	jmp	.L3316
.L3315:
	jmp	.L3313
.L3316:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILESIZE$FILE
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILEPOS$FILE
	move.l	d0,d3
	move.l	(sp)+,d2
	cmp.l	d2,d3
	sge.b	-1(a6)
	neg.b	-1(a6)
.L3313:
	move.b	-1(a6),d0
.L3314:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SEEK$FILE$LONGINT
_SYSATARI$$_SEEK$FILE$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3325
	jmp	.L3326
.L3325:
	jmp	.L3323
.L3326:
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	12(a6),d1
	move.l	d2,d0
	jsr	LONGMUL
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_SEEK$LONGINT$LONGINT
.L3323:
.L3324:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_TRUNCATE$FILE
_SYSATARI$$_TRUNCATE$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3333
	jmp	.L3334
.L3333:
	jmp	.L3331
.L3334:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILEPOS$FILE
	move.l	d0,d2
	move.l	8(a6),a2
	move.w	4(a2),d3
	and.l	#65535,d3
	move.l	d2,d0
	move.l	d3,d1
	jsr	LONGMUL
	move.l	d0,d3
	move.l	d3,-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_TRUNCATE$LONGINT$LONGINT
.L3331:
.L3332:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_CLOSE$FILE
_SYSATARI$$_CLOSE$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3343
	jmp	.L3344
.L3343:
	jmp	.L3341
.L3344:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55216,d2
	bne	.L3345
	jmp	.L3346
.L3345:
	move.l	8(a6),a2
	move.w	#55216,2(a2)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_CLOSE$LONGINT
.L3346:
.L3341:
.L3342:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ERASE$FILE
_SYSATARI$$_ERASE$FILE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3353
	jmp	.L3354
.L3353:
	jmp	.L3351
.L3354:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55216,d2
	beq	.L3355
	jmp	.L3356
.L3355:
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_ERASE$PCHAR
.L3356:
.L3351:
.L3352:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RENAME$FILE$PCHAR
_SYSATARI$$_RENAME$FILE$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3361
	jmp	.L3362
.L3361:
	jmp	.L3359
.L3362:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55216,d2
	beq	.L3363
	jmp	.L3364
.L3363:
	move.l	12(a6),-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_RENAME$PCHAR$PCHAR
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_STRLEN$PCHAR
	move.l	d0,d2
	add.l	#1,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L3364:
.L3359:
.L3360:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RENAME$FILE$STRING
_SYSATARI$$_RENAME$FILE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3379
	jmp	.L3380
.L3379:
	jmp	.L3377
.L3380:
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	sub.l	#256,d2
	move.b	#0,0(a6,d2.l)
	lea.l	-256(a6),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_RENAME$FILE$PCHAR
.L3377:
.L3378:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RENAME$FILE$CHAR
_SYSATARI$$_RENAME$FILE$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3395
	jmp	.L3396
.L3395:
	jmp	.L3393
.L3396:
	move.b	12(a6),d2
	move.b	d2,-2(a6)
	move.b	#0,-1(a6)
	lea.l	-2(a6),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_RENAME$FILE$PCHAR
.L3393:
.L3394:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$TYPEDFILE$STRING
_SYSATARI$$_ASSIGN$TYPEDFILE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	#0,-(sp)
	move.l	#128,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$BYTE
	move.l	8(a6),a2
	move.w	#65535,(a2)
	move.l	8(a6),a2
	move.w	#55216,2(a2)
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L3405:
.L3406:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$TYPEDFILE$PCHAR
_SYSATARI$$_ASSIGN$TYPEDFILE$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.l	12(a6),-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_STRPAS$PCHAR
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$TYPEDFILE$STRING
.L3423:
.L3424:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$TYPEDFILE$CHAR
_SYSATARI$$_ASSIGN$TYPEDFILE$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.b	12(a6),d0
	move.b	#1,-256(a6)
	move.b	d0,-255(a6)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$TYPEDFILE$STRING
.L3431:
.L3432:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_TYPED_RESET$TYPEDFILE$LONGINT
_SYSATARI$$_INT_TYPED_RESET$TYPEDFILE$LONGINT:
	XDEF RESET_TYPED
RESET_TYPED:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3439
	jmp	.L3440
.L3439:
	jmp	.L3437
.L3440:
	move.l	12(a6),d2
	move.w	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_RESET$FILE$WORD
.L3437:
.L3438:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_TYPED_REWRITE$TYPEDFILE$LONGINT
_SYSATARI$$_INT_TYPED_REWRITE$TYPEDFILE$LONGINT:
	XDEF REWRITE_TYPED
REWRITE_TYPED:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3447
	jmp	.L3448
.L3447:
	jmp	.L3445
.L3448:
	move.l	12(a6),d2
	move.w	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_REWRITE$FILE$WORD
.L3445:
.L3446:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_TYPED_WRITE$LONGINT$TYPEDFILE$$$$
_SYSATARI$$_INT_TYPED_WRITE$LONGINT$TYPEDFILE$$$$:
	XDEF TYPED_WRITE
TYPED_WRITE:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3455
	jmp	.L3456
.L3455:
	jmp	.L3453
.L3456:
	move.l	8(a6),-(sp)
	move.l	16(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_WRITE$LONGINT$LONGINT$LONGINT
	move.l	d0,d2
.L3453:
.L3454:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_INT_TYPED_READ$LONGINT$TYPEDFILE$$$$
_SYSATARI$$_INT_TYPED_READ$LONGINT$TYPEDFILE$$$$:
	XDEF TYPED_READ
TYPED_READ:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3465
	jmp	.L3466
.L3465:
	jmp	.L3463
.L3466:
	move.l	8(a6),-(sp)
	move.l	16(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_READ$LONGINT$LONGINT$LONGINT
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),d2
	cmp.l	8(a6),d2
	blt	.L3475
	jmp	.L3476
.L3475:
	move.w	#100,U_SYSATARI_INOUTRES
.L3476:
.L3463:
.L3464:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_FILECLOSEFUNC$TEXTREC:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_CLOSE$LONGINT
	move.l	8(a6),a2
	move.w	#65535,(a2)
.L3479:
.L3480:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_FILEREADFUNC$TEXTREC:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	12(a2),-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_READ$LONGINT$LONGINT$LONGINT
	move.l	d0,d2
	move.l	(sp)+,a2
	move.w	d2,10(a2)
	move.l	8(a6),a2
	move.w	#0,8(a2)
.L3485:
.L3486:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_FILEWRITEFUNC$TEXTREC:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	12(a2),-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_WRITE$LONGINT$LONGINT$LONGINT
	move.l	d0,d2
	move.l	8(a6),a2
	move.w	#0,8(a2)
.L3497:
.L3498:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_FILEOPENFUNC$TEXTREC:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),a2
	move.w	2(a2),d2
	sub.w	#55217,d2
	beq	.L3509
	subq.w	#1,d2
	beq	.L3511
	subq.w	#2,d2
	beq	.L3513
	jmp	.L3516
.L3513:
	move.l	#4113,-4(a6)
	jmp	.L3515
.L3511:
	move.l	#4353,-4(a6)
	jmp	.L3515
.L3509:
	move.l	#4096,-4(a6)
	jmp	.L3515
.L3516:
	moveq.l	#102,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L3515:
	move.l	-4(a6),-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_DO_OPEN$$$$$PCHAR$LONGINT
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILECLOSEFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,28(a2)
	move.l	8(a6),a2
	move.l	#0,d2
	move.l	d2,24(a2)
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55217,d2
	beq	.L3535
	jmp	.L3536
.L3535:
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEREADFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,20(a2)
	jmp	.L3539
.L3536:
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEWRITEFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,20(a2)
	move.l	8(a6),a2
	move.w	(a2),-(sp)
	jsr	_SYSATARI$$_DO_ISDEVICE$WORD
	move.b	d0,d2
	tst.b	d2
	bne	.L3542
	jmp	.L3543
.L3542:
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEWRITEFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,24(a2)
.L3543:
.L3539:
.L3507:
.L3508:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$TEXT$STRING
_SYSATARI$$_ASSIGN$TEXT$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	#0,-(sp)
	move.l	#256,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$BYTE
	move.l	8(a6),a2
	move.w	#65535,(a2)
	move.l	8(a6),a2
	move.w	#55216,2(a2)
	move.l	8(a6),a2
	move.w	#128,4(a2)
	move.l	8(a6),a2
	move.l	8(a6),a3
	lea.l	128(a3),a0
	move.l	a0,d2
	move.l	d2,12(a2)
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEOPENFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,16(a2)
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L3548:
.L3549:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$TEXT$PCHAR
_SYSATARI$$_ASSIGN$TEXT$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.l	12(a6),-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_STRPAS$PCHAR
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$TEXT$STRING
.L3572:
.L3573:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ASSIGN$TEXT$CHAR
_SYSATARI$$_ASSIGN$TEXT$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.b	12(a6),d0
	move.b	#1,-256(a6)
	move.b	d0,-255(a6)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$TEXT$STRING
.L3580:
.L3581:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_CLOSE$TEXT
_SYSATARI$$_CLOSE$TEXT:
	XDEF CLOSE_TEXT
CLOSE_TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3588
	jmp	.L3589
.L3588:
	jmp	.L3586
.L3589:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55216,d2
	bne	.L3590
	jmp	.L3591
.L3590:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	8(a6),a2
	move.w	#55216,2(a2)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3596
	jmp	.L3599
.L3599:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	cmp.l	#1,d2
	bne	.L3596
	jmp	.L3598
.L3598:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	cmp.l	#65535,d2
	bne	.L3596
	jmp	.L3597
.L3596:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	28(a2),a1
	jsr	(a1)
.L3597:
.L3591:
.L3586:
.L3587:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_OPENTEXT$TEXT$LONGINT$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.w	2(a2),d2
	sub.w	#55216,d2
	beq	.L3608
	subq.w	#1,d2
	beq	.L3604
	subq.w	#1,d2
	beq	.L3604
	subq.w	#1,d2
	beq	.L3604
	jmp	.L3611
.L3608:
	jmp	.L3610
.L3604:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_CLOSE$TEXT
	jmp	.L3610
.L3611:
	move.w	#102,U_SYSATARI_INOUTRES
	jmp	.L3602
.L3610:
	move.l	8(a6),a2
	move.l	12(a6),d2
	move.w	d2,2(a2)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	16(a2),a1
	jsr	(a1)
.L3602:
.L3603:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_REWRITE$TEXT
_SYSATARI$$_REWRITE$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3622
	jmp	.L3623
.L3622:
	jmp	.L3620
.L3623:
	moveq.l	#1,d6
	move.l	d6,-(sp)
	move.l	#55218,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENTEXT$TEXT$LONGINT$LONGINT
.L3620:
.L3621:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RESET$TEXT
_SYSATARI$$_RESET$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3632
	jmp	.L3633
.L3632:
	jmp	.L3630
.L3633:
	moveq.l	#0,d6
	move.l	d6,-(sp)
	move.l	#55217,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENTEXT$TEXT$LONGINT$LONGINT
.L3630:
.L3631:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_APPEND$TEXT
_SYSATARI$$_APPEND$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3642
	jmp	.L3643
.L3642:
	jmp	.L3640
.L3643:
	moveq.l	#1,d6
	move.l	d6,-(sp)
	move.l	#55220,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENTEXT$TEXT$LONGINT$LONGINT
.L3640:
.L3641:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_FLUSH$TEXT
_SYSATARI$$_FLUSH$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3652
	jmp	.L3653
.L3652:
	jmp	.L3650
.L3653:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55218,d2
	bne	.L3654
	jmp	.L3655
.L3654:
	jmp	.L3650
.L3655:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L3650:
.L3651:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_ERASE$TEXT
_SYSATARI$$_ERASE$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3660
	jmp	.L3661
.L3660:
	jmp	.L3658
.L3661:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55216,d2
	beq	.L3662
	jmp	.L3663
.L3662:
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_ERASE$PCHAR
.L3663:
.L3658:
.L3659:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RENAME$TEXT$PCHAR
_SYSATARI$$_RENAME$TEXT$PCHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3668
	jmp	.L3669
.L3668:
	jmp	.L3666
.L3669:
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55216,d2
	beq	.L3670
	jmp	.L3671
.L3670:
	move.l	12(a6),-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_RENAME$PCHAR$PCHAR
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_STRLEN$PCHAR
	move.l	d0,d2
	add.l	#1,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	lea.l	48(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L3671:
.L3666:
.L3667:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RENAME$TEXT$STRING
_SYSATARI$$_RENAME$TEXT$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3686
	jmp	.L3687
.L3686:
	jmp	.L3684
.L3687:
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.l	12(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	sub.l	#256,d2
	move.b	#0,0(a6,d2.l)
	lea.l	-256(a6),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_RENAME$TEXT$PCHAR
.L3684:
.L3685:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RENAME$TEXT$CHAR
_SYSATARI$$_RENAME$TEXT$CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3702
	jmp	.L3703
.L3702:
	jmp	.L3700
.L3703:
	move.b	12(a6),d2
	move.b	d2,-2(a6)
	move.b	#0,-1(a6)
	lea.l	-2(a6),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_RENAME$TEXT$PCHAR
.L3700:
.L3701:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_EOF$TEXT
_SYSATARI$$_EOF$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3714
	jmp	.L3715
.L3714:
	jmp	.L3712
.L3715:
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_FILESIZE$LONGINT
	move.l	d0,d2
	move.l	d2,-(sp)
	move.l	8(a6),a2
	move.w	(a2),d2
	and.l	#65535,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_DO_FILEPOS$LONGINT
	move.l	d0,d3
	move.l	(sp)+,d2
	cmp.l	d2,d3
	sge.b	-1(a6)
	neg.b	-1(a6)
	tst.b	-1(a6)
	bne	.L3722
	jmp	.L3723
.L3722:
	move.l	8(a6),a2
	move.w	10(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	sge.b	-1(a6)
	neg.b	-1(a6)
.L3723:
.L3712:
	move.b	-1(a6),d0
.L3713:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_EOF
_SYSATARI$$_EOF:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	pea.l	U_SYSATARI_INPUT
	jsr	_SYSATARI$$_EOF$TEXT
	move.b	d0,d2
	move.b	d2,-1(a6)
.L3726:
	move.b	-1(a6),d0
.L3727:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SEEKEOF$TEXT
_SYSATARI$$_SEEKEOF$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#10,sp
	move.l	8(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55217,d2
	bne	.L3736
	jmp	.L3737
.L3736:
	move.b	#1,d0
	jmp	.L3733
.L3737:
	move.b	#1,-9(a6)
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	-4(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L3742
	jmp	.L3743
.L3742:
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L3743:
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	d2,-8(a6)
	jmp	.L3749
.L3748:
	move.l	-4(a6),a2
	move.l	12(a2),a2
	move.l	-8(a6),d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#9,d0
	beq	.L3753
	cmp.w	#10,d0
	beq	.L3753
.L3754:
	cmp.w	#13,d0
	beq	.L3753
	cmp.w	#32,d0
	beq	.L3753
.L3753:
	beq	.L3751
	jmp	.L3752
.L3751:
	addq.l	#1,-8(a6)
	jmp	.L3755
.L3752:
	move.b	#0,-9(a6)
	move.l	-4(a6),a2
	move.l	-8(a6),d2
	move.w	d2,8(a2)
	jmp	.L3732
.L3755:
	move.l	-4(a6),a2
	move.w	10(a2),d2
	and.l	#65535,d2
	cmp.l	-8(a6),d2
	ble	.L3760
	jmp	.L3761
.L3760:
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.l	d2,-8(a6)
.L3761:
.L3749:
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	-4(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L3748
	jmp	.L3750
.L3750:
.L3732:
	move.b	-9(a6),d0
.L3733:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SEEKEOF
_SYSATARI$$_SEEKEOF:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	pea.l	U_SYSATARI_INPUT
	jsr	_SYSATARI$$_SEEKEOF$TEXT
	move.b	d0,d2
	move.b	d2,-1(a6)
.L3766:
	move.b	-1(a6),d0
.L3767:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_EOLN$TEXT
_SYSATARI$$_EOLN$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L3774
	jmp	.L3775
.L3774:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L3775:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_EOF$TEXT
	move.b	d0,d2
	tst.b	d2
	bne	.L3778
	jmp	.L3780
.L3780:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#10,d0
	beq	.L3783
	cmp.w	#13,d0
	beq	.L3783
.L3783:
	beq	.L3778
	jmp	.L3779
.L3778:
	move.b	#1,-1(a6)
	jmp	.L3784
.L3779:
	move.b	#0,-1(a6)
.L3784:
.L3772:
	move.b	-1(a6),d0
.L3773:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_EOLN
_SYSATARI$$_EOLN:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	pea.l	U_SYSATARI_INPUT
	jsr	_SYSATARI$$_EOLN$TEXT
	move.b	d0,d2
	move.b	d2,-1(a6)
.L3785:
	move.b	-1(a6),d0
.L3786:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SEEKEOLN$TEXT
_SYSATARI$$_SEEKEOLN$TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#10,sp
	move.l	8(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-4(a6)
	move.l	-4(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55217,d2
	bne	.L3800
	jmp	.L3801
.L3800:
	move.b	#1,d0
	jmp	.L3792
.L3801:
	move.b	#1,-9(a6)
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	-4(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L3806
	jmp	.L3807
.L3806:
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L3807:
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	d2,-8(a6)
	jmp	.L3813
.L3812:
	move.l	-4(a6),a2
	move.l	12(a2),a2
	move.l	-8(a6),d2
	move.b	0(a2,d2.l),d2
	sub.b	#9,d2
	beq	.L3795
	subq.b	#1,d2
	beq	.L3793
	sub.b	#22,d2
	beq	.L3795
	jmp	.L3816
.L3795:
	addq.l	#1,-8(a6)
	jmp	.L3815
.L3793:
	jmp	.L3791
	jmp	.L3815
.L3816:
	move.b	#0,-9(a6)
	move.l	-4(a6),a2
	move.l	-8(a6),d2
	move.w	d2,8(a2)
	jmp	.L3791
.L3815:
	move.l	-4(a6),a2
	move.w	10(a2),d2
	and.l	#65535,d2
	cmp.l	-8(a6),d2
	ble	.L3821
	jmp	.L3822
.L3821:
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	move.l	-4(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.l	d2,-8(a6)
.L3822:
.L3813:
	move.l	-4(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	-4(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L3812
	jmp	.L3814
.L3814:
.L3791:
	move.b	-9(a6),d0
.L3792:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SEEKEOLN
_SYSATARI$$_SEEKEOLN:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	pea.l	U_SYSATARI_INPUT
	jsr	_SYSATARI$$_SEEKEOLN$TEXT
	move.b	d0,d2
	move.b	d2,-1(a6)
.L3827:
	move.b	-1(a6),d0
.L3828:
	unlk	a6
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_SETTEXTBUF$TEXT$$$$$WORD
_SYSATARI$$_SETTEXTBUF$TEXT$$$$$WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	12(a6),a3
	lea.l	(a3),a0
	move.l	a0,d2
	move.l	d2,12(a2)
	move.l	8(a6),a2
	move.w	16(a6),d2
	move.w	d2,4(a2)
	move.l	8(a6),a2
	move.w	#0,8(a2)
	move.l	8(a6),a2
	move.w	#0,10(a2)
.L3833:
.L3834:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_WRITEBUFFER$TEXTREC$$$$$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#12,sp
	move.l	12(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-4(a6)
	move.l	#0,-12(a6)
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-8(a6)
	jmp	.L3852
.L3851:
	move.l	-8(a6),-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	move.l	-4(a6),a2
	move.l	-12(a6),d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.l	-8(a6),-(sp)
	lea.l	16(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DEC$LONGINT$LONGINT
	move.l	-8(a6),-(sp)
	lea.l	-12(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	-8(a6),-(sp)
	move.l	8(a6),a2
	lea.l	8(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$WORD$LONGINT
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-8(a6)
.L3852:
	move.l	16(a6),d2
	cmp.l	-8(a6),d2
	bgt	.L3851
	jmp	.L3853
.L3853:
	move.l	16(a6),-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	move.l	-4(a6),a2
	move.l	-12(a6),d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.l	16(a6),-(sp)
	move.l	8(a6),a2
	lea.l	8(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$WORD$LONGINT
.L3843:
.L3844:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_WRITEBLANKS$TEXTREC$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-4(a6)
	jmp	.L3891
.L3890:
	move.w	#8192,-(sp)
	move.l	-4(a6),-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$CHAR
	move.l	-4(a6),-(sp)
	lea.l	12(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_DEC$LONGINT$LONGINT
	move.l	-4(a6),-(sp)
	move.l	8(a6),a2
	lea.l	8(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$WORD$LONGINT
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	8(a6),a2
	move.w	4(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-4(a6)
.L3891:
	move.l	12(a6),d2
	cmp.l	-4(a6),d2
	bgt	.L3890
	jmp	.L3892
.L3892:
	move.w	#8192,-(sp)
	move.l	12(a6),-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_FILLCHAR$$$$$LONGINT$CHAR
	move.l	12(a6),-(sp)
	move.l	8(a6),a2
	lea.l	8(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$WORD$LONGINT
.L3886:
.L3887:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_END$TEXTREC
_SYSATARI$$_WRITE_END$TEXTREC:
	XDEF WRITE_END
WRITE_END:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	24(a2),d2
	cmp.l	#0,d2
	bne	.L3923
	jmp	.L3924
.L3923:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	24(a2),a1
	jsr	(a1)
.L3924:
.L3921:
.L3922:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITELN_END$TEXTREC
_SYSATARI$$_WRITELN_END$TEXTREC:
	XDEF WRITELN_END
WRITELN_END:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3929
	jmp	.L3930
.L3929:
	jmp	.L3927
.L3930:
	moveq.l	#2,d6
	move.l	d6,-(sp)
	pea.l	TC__SYSATARI$$_WRITELN_END_EOL
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBUFFER$TEXTREC$$$$$LONGINT
	move.l	8(a6),a2
	move.l	24(a2),d2
	cmp.l	#0,d2
	bne	.L3937
	jmp	.L3938
.L3937:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	24(a2),a1
	jsr	(a1)
.L3938:
.L3927:
.L3928:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING:
	XDEF WRITE_TEXT_STRING
WRITE_TEXT_STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3943
	jmp	.L3944
.L3943:
	jmp	.L3941
.L3944:
	move.l	12(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55218,d2
	bne	.L3945
	jmp	.L3946
.L3945:
	jmp	.L3941
.L3946:
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	cmp.l	8(a6),d2
	blt	.L3947
	jmp	.L3948
.L3947:
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	8(a6),d6
	sub.l	d2,d6
	move.l	d6,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBLANKS$TEXTREC$LONGINT
.L3948:
	move.l	16(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	move.l	16(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBUFFER$TEXTREC$$$$$LONGINT
.L3941:
.L3942:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_ARRAY$LONGINT$TEXTREC$ARRAY00
_SYSATARI$$_WRITE_ARRAY$LONGINT$TEXTREC$ARRAY00:
	XDEF WRITE_TEXT_PCHAR_AS_ARRAY
WRITE_TEXT_PCHAR_AS_ARRAY:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3961
	jmp	.L3962
.L3961:
	jmp	.L3959
.L3962:
	move.l	12(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55218,d2
	bne	.L3963
	jmp	.L3964
.L3963:
	jmp	.L3959
.L3964:
	move.l	16(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_STRLEN$PCHAR
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	8(a6),d2
	cmp.l	-4(a6),d2
	bgt	.L3969
	jmp	.L3970
.L3969:
	move.l	8(a6),d2
	sub.l	-4(a6),d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBLANKS$TEXTREC$LONGINT
.L3970:
	move.l	-4(a6),-(sp)
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBUFFER$TEXTREC$$$$$LONGINT
.L3959:
.L3960:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_PCHAR$LONGINT$TEXTREC$PCHAR
_SYSATARI$$_WRITE_PCHAR$LONGINT$TEXTREC$PCHAR:
	XDEF WRITE_TEXT_PCHAR_AS_POINTER
WRITE_TEXT_PCHAR_AS_POINTER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L3983
	jmp	.L3984
.L3983:
	jmp	.L3981
.L3984:
	move.l	12(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55218,d2
	bne	.L3985
	jmp	.L3986
.L3985:
	jmp	.L3981
.L3986:
	move.l	16(a6),-(sp)
	jsr	_SYSATARI$$_STRLEN$PCHAR
	move.l	d0,d2
	move.l	d2,-4(a6)
	move.l	8(a6),d2
	cmp.l	-4(a6),d2
	bgt	.L3991
	jmp	.L3992
.L3991:
	move.l	8(a6),d2
	sub.l	-4(a6),d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBLANKS$TEXTREC$LONGINT
.L3992:
	move.l	-4(a6),-(sp)
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBUFFER$TEXTREC$$$$$LONGINT
.L3981:
.L3982:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_LONGINT$LONGINT$TEXTREC$LONGINT
_SYSATARI$$_WRITE_LONGINT$LONGINT$TEXTREC$LONGINT:
	XDEF WRITE_TEXT_LONGINT
WRITE_TEXT_LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4005
	jmp	.L4006
.L4005:
	jmp	.L4003
.L4006:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	moveq.l	#-1,d6
	move.l	d6,-(sp)
	move.l	16(a6),-(sp)
	jsr	STR_LONGINT
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
.L4003:
.L4004:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_REAL$LONGINT$LONGINT$TEXTREC$REAL
_SYSATARI$$_WRITE_REAL$LONGINT$LONGINT$TEXTREC$REAL:
	XDEF WRITE_TEXT_REAL
WRITE_TEXT_REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4019
	jmp	.L4020
.L4019:
	jmp	.L4017
.L4020:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	moveq.l	#1,d6
	move.l	d6,-(sp)
	move.l	20(a6),-(sp)
	move.l	8(a6),-(sp)
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_STR_REAL$LONGINT$LONGINT$BESTREAL$TREAL_TYPE$STRING
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	16(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),-(sp)
	jsr	_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
.L4017:
.L4018:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#16,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_CARDINAL$LONGINT$TEXTREC$CARDINAL
_SYSATARI$$_WRITE_CARDINAL$LONGINT$TEXTREC$CARDINAL:
	XDEF WRITE_TEXT_CARDINAL
WRITE_TEXT_CARDINAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4039
	jmp	.L4040
.L4039:
	jmp	.L4037
.L4040:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	moveq.l	#-1,d6
	move.l	d6,-(sp)
	move.l	16(a6),-(sp)
	jsr	STR_CARDINAL
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
.L4037:
.L4038:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_BOOLEAN$LONGINT$TEXTREC$BOOLEAN
_SYSATARI$$_WRITE_BOOLEAN$LONGINT$TEXTREC$BOOLEAN:
	XDEF WRITE_TEXT_BOOLEAN
WRITE_TEXT_BOOLEAN:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4053
	jmp	.L4054
.L4053:
	jmp	.L4051
.L4054:
	tst.b	16(a6)
	bne	.L4055
	jmp	.L4056
.L4055:
	pea.l	.L4059
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
	jmp	.L4064
.L4056:
	pea.l	.L4067
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),-(sp)
	jsr	_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
.L4064:
.L4051:
.L4052:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_WRITE_CHAR$LONGINT$TEXTREC$CHAR
_SYSATARI$$_WRITE_CHAR$LONGINT$TEXTREC$CHAR:
	XDEF WRITE_TEXT_CHAR
WRITE_TEXT_CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4074
	jmp	.L4075
.L4074:
	jmp	.L4072
.L4075:
	move.l	12(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55218,d2
	bne	.L4076
	jmp	.L4077
.L4076:
	jmp	.L4072
.L4077:
	move.l	8(a6),d2
	cmp.l	#1,d2
	bgt	.L4078
	jmp	.L4079
.L4078:
	move.l	8(a6),d2
	sub.l	#1,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_WRITEBLANKS$TEXTREC$LONGINT
.L4079:
	move.l	12(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	add.l	#1,d2
	move.l	12(a6),a2
	move.w	4(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4084
	jmp	.L4085
.L4084:
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4085:
	move.l	12(a6),a2
	move.l	12(a2),a2
	move.l	12(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	16(a6),d3
	move.b	d3,0(a2,d2.l)
	move.l	12(a6),a2
	addq.w	#1,8(a2)
.L4072:
.L4073:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_W$TEXTREC
_SYSATARI$$_W$TEXTREC:
	XDEF WRITELN_TEXT
WRITELN_TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#256,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4092
	jmp	.L4093
.L4092:
	jmp	.L4090
.L4093:
	lea.l	-256(a6),a1
	lea.l	.L4096,a0
	move.l	#255,d0
	jsr	STRCOPY
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_WRITE_STR$LONGINT$TEXTREC$STRING
.L4090:
.L4091:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_OPENINPUT$TEXTREC:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	8(a6),a2
	move.w	2(a2),d2
	and.l	#65535,d2
	cmp.l	#55217,d2
	beq	.L4105
	jmp	.L4106
.L4105:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4107
	jmp	.L4108
.L4107:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4108:
	move.b	#1,-1(a6)
	jmp	.L4113
.L4106:
	move.b	#0,-1(a6)
.L4113:
.L4103:
	move.b	-1(a6),d0
.L4104:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_NEXTCHAR$TEXTREC$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#514,sp
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4118
	jmp	.L4119
.L4118:
	move.l	12(a6),a2
	move.l	12(a6),a3
	move.l	a2,-(sp)
	lea.l	-258(a6),a1
	lea.l	(a3),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	(sp)+,a2
	move.l	8(a6),a3
	move.l	12(a3),a3
	move.l	8(a6),a4
	move.w	8(a4),d2
	and.l	#65535,d2
	move.b	0(a3,d2.l),d0
	move.b	#1,-514(a6)
	move.b	d0,-513(a6)
	move.l	a2,-(sp)
	lea.l	-514(a6),a1
	move.l	a1,-(sp)
	lea.l	-258(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-258(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	8(a6),a2
	addq.w	#1,8(a2)
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4122
	jmp	.L4123
.L4122:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4123:
	move.b	#1,-1(a6)
	jmp	.L4128
.L4119:
	move.b	#0,-1(a6)
.L4128:
.L4116:
	move.b	-1(a6),d0
.L4117:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_IGNORESPACES$TEXTREC:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#258,sp
	move.b	#0,-256(a6)
	move.b	#0,-257(a6)
	jmp	.L4138
.L4137:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_NEXTCHAR$TEXTREC$STRING
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4140
	jmp	.L4141
.L4140:
	jmp	.L4131
.L4141:
.L4138:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#9,d0
	beq	.L4146
	cmp.w	#10,d0
	beq	.L4146
.L4147:
	cmp.w	#13,d0
	beq	.L4146
	cmp.w	#32,d0
	beq	.L4146
.L4146:
	beq	.L4137
	jmp	.L4139
.L4139:
	move.b	#1,-257(a6)
.L4131:
	move.b	-257(a6),d0
.L4132:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_READSIGN$TEXTREC$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#43,d0
	beq	.L4155
	cmp.w	#45,d0
	beq	.L4155
.L4155:
	bne	.L4152
	jmp	.L4154
.L4154:
	move.l	d2,-(sp)
	move.l	a2,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_NEXTCHAR$TEXTREC$STRING
	move.b	d0,d3
	move.l	(sp)+,a2
	move.l	(sp)+,d2
	tst.b	d3
	bne	.L4152
	jmp	.L4153
.L4152:
	move.b	#1,-1(a6)
	jmp	.L4160
.L4153:
	move.b	#0,-1(a6)
.L4160:
.L4150:
	move.b	-1(a6),d0
.L4151:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_READBASE$TEXTREC$STRING$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	sub.b	#36,d2
	beq	.L4163
	subq.b	#1,d2
	beq	.L4165
	jmp	.L4168
.L4165:
	move.l	16(a6),a2
	move.l	#2,(a2)
	jmp	.L4167
.L4163:
	move.l	16(a6),a2
	move.l	#16,(a2)
	jmp	.L4167
.L4168:
	move.l	16(a6),a2
	move.l	#10,(a2)
.L4167:
	move.l	16(a6),a2
	move.l	(a2),d2
	cmp.l	#10,d2
	beq	.L4175
	jmp	.L4177
.L4177:
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_NEXTCHAR$TEXTREC$STRING
	move.b	d0,d2
	tst.b	d2
	bne	.L4175
	jmp	.L4176
.L4175:
	move.b	#1,-1(a6)
	jmp	.L4182
.L4176:
	move.b	#0,-1(a6)
.L4182:
.L4161:
	move.b	-1(a6),d0
.L4162:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_READNUMERIC$TEXTREC$STRING$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.b	#0,-3(a6)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d3
	move.b	d3,-2(a6)
	jmp	.L4190
.L4189:
	move.l	12(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_NEXTCHAR$TEXTREC$STRING
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4192
	jmp	.L4193
.L4192:
	jmp	.L4183
.L4193:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d3
	move.b	d3,-2(a6)
.L4190:
	move.l	16(a6),d2
	cmp.l	#10,d2
	bge	.L4202
	jmp	.L4201
.L4202:
	move.b	-2(a6),d0
	and.l	#255,d0
	cmp.w	#48,d0
	bcs	.L4204
	cmp.w	#58,d0
	bcs	.L4203
.L4204:
	and.b	#254,ccr
.L4203:
	bcs	.L4189
	jmp	.L4201
.L4201:
	move.l	16(a6),d2
	cmp.l	#16,d2
	beq	.L4205
	jmp	.L4200
.L4205:
	move.b	-2(a6),d0
	and.l	#255,d0
	cmp.w	#65,d0
	bcs	.L4207
	cmp.w	#71,d0
	bcs	.L4206
.L4207:
	cmp.w	#97,d0
	bcs	.L4208
	cmp.w	#103,d0
	bcs	.L4206
.L4208:
	and.b	#254,ccr
.L4206:
	bcs	.L4189
	jmp	.L4200
.L4200:
	move.l	16(a6),d2
	cmp.l	#2,d2
	beq	.L4209
	jmp	.L4191
.L4209:
	move.b	-2(a6),d0
	and.l	#255,d0
	cmp.w	#48,d0
	beq	.L4210
	cmp.w	#49,d0
	beq	.L4210
.L4211:
.L4210:
	beq	.L4189
	jmp	.L4191
.L4191:
	move.b	#1,-3(a6)
.L4183:
	move.b	-3(a6),d0
.L4184:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#12,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_END$TEXTREC
_SYSATARI$$_READ_END$TEXTREC:
	XDEF READ_END
READ_END:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	8(a6),a2
	move.l	24(a2),d2
	cmp.l	#0,d2
	bne	.L4216
	jmp	.L4217
.L4216:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	24(a2),a1
	jsr	(a1)
.L4217:
.L4214:
.L4215:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READLN_END$TEXTREC
_SYSATARI$$_READLN_END$TEXTREC:
	XDEF READLN_END
READLN_END:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4222
	jmp	.L4223
.L4222:
	jmp	.L4220
.L4223:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4224
	jmp	.L4225
.L4224:
	jmp	.L4220
.L4225:
	jmp	.L4229
.L4228:
	move.l	8(a6),a2
	addq.w	#1,8(a2)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	sub.l	#1,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	beq	.L4231
	jmp	.L4232
.L4231:
	jmp	.L4220
.L4232:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4233
	jmp	.L4234
.L4233:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4234:
.L4229:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4228
	jmp	.L4230
.L4230:
	move.l	8(a6),a2
	move.l	24(a2),d2
	cmp.l	#0,d2
	bne	.L4237
	jmp	.L4238
.L4237:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	24(a2),a1
	jsr	(a1)
.L4238:
.L4220:
.L4221:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_STRING$TEXTREC$STRING
_SYSATARI$$_READ_STRING$TEXTREC$STRING:
	XDEF READ_TEXT_STRING
READ_TEXT_STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4245
	jmp	.L4246
.L4245:
	jmp	.L4241
.L4246:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4247
	jmp	.L4248
.L4247:
	jmp	.L4241
.L4248:
	move.l	8(a6),a2
	move.w	8(a2),d2
	move.w	d2,-2(a6)
	move.w	#1,-4(a6)
	jmp	.L4256
.L4255:
	jmp	.L4259
.L4258:
	addq.w	#1,-2(a6)
.L4259:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	bne	.L4261
	jmp	.L4260
.L4261:
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4258
	jmp	.L4260
.L4260:
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.w	-2(a6),d3
	and.l	#65535,d3
	add.l	d2,d3
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	sub.l	d2,d3
	cmp.l	#255,d3
	ble	.L4262
	jmp	.L4263
.L4262:
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.w	-2(a6),d3
	and.l	#65535,d3
	add.l	d2,d3
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	sub.l	d2,d3
	move.w	d3,-4(a6)
	move.l	12(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	sub.l	#1,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#13,d2
	beq	.L4272
	jmp	.L4273
.L4272:
	subq.w	#1,-4(a6)
.L4273:
	jmp	.L4274
.L4263:
	move.w	-4(a6),d2
	and.l	#65535,d2
	cmp.l	#255,d2
	ble	.L4275
	jmp	.L4276
.L4275:
	move.w	-4(a6),d2
	and.l	#65535,d2
	move.l	#256,d6
	sub.l	d2,d6
	move.l	d6,d2
	move.l	d2,-(sp)
	move.l	12(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
.L4276:
	move.w	#256,-4(a6)
.L4274:
	move.l	8(a6),a2
	move.w	-2(a6),d2
	move.w	d2,8(a2)
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4287
	jmp	.L4288
.L4287:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	8(a6),a2
	move.w	8(a2),d2
	move.w	d2,-2(a6)
.L4288:
.L4256:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4293
	jmp	.L4257
.L4293:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.w	-2(a6),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	bne	.L4255
	jmp	.L4257
.L4257:
	move.l	12(a6),a2
	move.w	-4(a6),d2
	and.l	#65535,d2
	sub.l	#1,d2
	move.b	d2,(a2)
.L4241:
.L4242:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_CHAR$TEXTREC$CHAR
_SYSATARI$$_READ_CHAR$TEXTREC$CHAR:
	XDEF READ_TEXT_CHAR
READ_TEXT_CHAR:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4300
	jmp	.L4301
.L4300:
	jmp	.L4296
.L4301:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4302
	jmp	.L4303
.L4302:
	jmp	.L4296
.L4303:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4306
	jmp	.L4307
.L4306:
	move.l	12(a6),a2
	move.b	#26,(a2)
	jmp	.L4310
.L4307:
	move.l	12(a6),a2
	move.l	8(a6),a3
	move.l	12(a3),a3
	move.l	8(a6),a4
	move.w	8(a4),d2
	and.l	#65535,d2
	move.b	0(a3,d2.l),d3
	move.b	d3,(a2)
.L4310:
	move.l	8(a6),a2
	addq.w	#1,8(a2)
.L4296:
.L4297:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_PCHAR$TEXTREC$PCHAR
_SYSATARI$$_READ_PCHAR$TEXTREC$PCHAR:
	XDEF READ_TEXT_PCHAR_AS_POINTER
READ_TEXT_PCHAR_AS_POINTER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#6,sp
	move.l	12(a6),a2
	move.l	(a2),a2
	move.b	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4317
	jmp	.L4318
.L4317:
	jmp	.L4313
.L4318:
	move.l	12(a6),a2
	move.l	(a2),d2
	move.l	d2,-4(a6)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4321
	jmp	.L4322
.L4321:
	jmp	.L4313
.L4322:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.b	d2,-6(a6)
	jmp	.L4328
.L4327:
	jmp	.L4331
.L4330:
	addq.b	#1,-6(a6)
.L4331:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.b	-6(a6),d2
	and.l	#255,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	bne	.L4333
	jmp	.L4332
.L4333:
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4330
	jmp	.L4332
.L4332:
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-(sp)
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	-4(a6),d2
	sub.l	#1,d2
	move.l	d2,a2
	move.b	(a2),d2
	cmp.b	#13,d2
	beq	.L4344
	jmp	.L4345
.L4344:
	subq.l	#1,-4(a6)
.L4345:
	move.l	8(a6),a2
	move.b	-6(a6),d2
	and.w	#255,d2
	move.w	d2,8(a2)
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4348
	jmp	.L4349
.L4348:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.b	d2,-6(a6)
.L4349:
.L4328:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4354
	jmp	.L4329
.L4354:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.b	-6(a6),d2
	and.l	#255,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	bne	.L4327
	jmp	.L4329
.L4329:
	move.l	-4(a6),a2
	move.b	#0,(a2)
.L4313:
.L4314:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_ARRAY$TEXTREC$ARRAY00
_SYSATARI$$_READ_ARRAY$TEXTREC$ARRAY00:
	XDEF READ_TEXT_PCHAR_AS_ARRAY
READ_TEXT_PCHAR_AS_ARRAY:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#6,sp
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4361
	jmp	.L4362
.L4361:
	jmp	.L4357
.L4362:
	move.l	12(a6),a2
	lea.l	(a2),a0
	move.l	a0,d2
	move.l	d2,-4(a6)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4365
	jmp	.L4366
.L4365:
	jmp	.L4357
.L4366:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.b	d2,-6(a6)
	jmp	.L4372
.L4371:
	jmp	.L4375
.L4374:
	addq.b	#1,-6(a6)
.L4375:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.b	-6(a6),d2
	and.l	#255,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	bne	.L4377
	jmp	.L4376
.L4377:
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4374
	jmp	.L4376
.L4376:
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-(sp)
	move.l	-4(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	lea.l	0(a2,d2.l),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	8(a2),d3
	and.l	#65535,d3
	sub.l	d3,d2
	move.l	d2,-(sp)
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_INC$LONGINT$LONGINT
	move.l	-4(a6),d2
	sub.l	#1,d2
	move.l	d2,a2
	move.b	(a2),d2
	cmp.b	#13,d2
	beq	.L4388
	jmp	.L4389
.L4388:
	subq.l	#1,-4(a6)
.L4389:
	move.l	8(a6),a2
	move.b	-6(a6),d2
	and.w	#255,d2
	move.w	d2,8(a2)
	move.b	-6(a6),d2
	and.l	#255,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4392
	jmp	.L4393
.L4392:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.b	d2,-6(a6)
.L4393:
.L4372:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4398
	jmp	.L4373
.L4398:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.b	-6(a6),d2
	and.l	#255,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	bne	.L4371
	jmp	.L4373
.L4373:
	move.l	-4(a6),a2
	move.b	#0,(a2)
.L4357:
.L4358:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_LONGINT$TEXTREC$LONGINT
_SYSATARI$$_READ_LONGINT$TEXTREC$LONGINT:
	XDEF READ_TEXT_LONGINT
READ_TEXT_LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#264,sp
	move.l	12(a6),a2
	move.l	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4405
	jmp	.L4406
.L4405:
	jmp	.L4401
.L4406:
	move.b	#0,-256(a6)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4409
	jmp	.L4410
.L4409:
	jmp	.L4401
.L4410:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_IGNORESPACES$TEXTREC
	move.b	d0,d2
	tst.b	d2
	bne	.L4416
	jmp	.L4414
.L4416:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READSIGN$TEXTREC$STRING
	move.b	d0,d2
	tst.b	d2
	bne	.L4415
	jmp	.L4414
.L4415:
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READBASE$TEXTREC$STRING$LONGINT
	move.b	d0,d2
	tst.b	d2
	bne	.L4413
	jmp	.L4414
.L4413:
	move.l	-264(a6),-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READNUMERIC$TEXTREC$STRING$LONGINT
	move.b	d0,d2
.L4414:
	lea.l	-258(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$LONGINT$WORD
	move.w	-258(a6),d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4441
	jmp	.L4442
.L4441:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4442:
.L4401:
.L4402:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_INTEGER$TEXTREC$INTEGER
_SYSATARI$$_READ_INTEGER$TEXTREC$INTEGER:
	XDEF READ_TEXT_INTEGER
READ_TEXT_INTEGER:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	move.w	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4449
	jmp	.L4450
.L4449:
	jmp	.L4445
.L4450:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READ_LONGINT$TEXTREC$LONGINT
	move.l	-4(a6),d2
	cmp.l	#-32768,d2
	blt	.L4455
	jmp	.L4457
.L4457:
	move.l	-4(a6),d2
	cmp.l	#32767,d2
	bgt	.L4455
	jmp	.L4456
.L4455:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4456:
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L4445:
.L4446:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_WORD$TEXTREC$WORD
_SYSATARI$$_READ_WORD$TEXTREC$WORD:
	XDEF READ_TEXT_WORD
READ_TEXT_WORD:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	move.w	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4466
	jmp	.L4467
.L4466:
	jmp	.L4462
.L4467:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READ_LONGINT$TEXTREC$LONGINT
	move.l	-4(a6),d2
	tst.l	d2
	blt	.L4472
	jmp	.L4474
.L4474:
	move.l	-4(a6),d2
	cmp.l	#65535,d2
	bgt	.L4472
	jmp	.L4473
.L4472:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4473:
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.w	d2,(a2)
.L4462:
.L4463:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_BYTE$TEXTREC$BYTE
_SYSATARI$$_READ_BYTE$TEXTREC$BYTE:
	XDEF READ_TEXT_BYTE
READ_TEXT_BYTE:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4483
	jmp	.L4484
.L4483:
	jmp	.L4479
.L4484:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READ_LONGINT$TEXTREC$LONGINT
	move.l	-4(a6),d2
	tst.l	d2
	blt	.L4489
	jmp	.L4491
.L4491:
	move.l	-4(a6),d2
	cmp.l	#255,d2
	bgt	.L4489
	jmp	.L4490
.L4489:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4490:
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	d2,(a2)
.L4479:
.L4480:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_SHORTINT$TEXTREC$SHORTINT
_SYSATARI$$_READ_SHORTINT$TEXTREC$SHORTINT:
	XDEF READ_TEXT_SHORTINT
READ_TEXT_SHORTINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	12(a6),a2
	move.b	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4500
	jmp	.L4501
.L4500:
	jmp	.L4496
.L4501:
	lea.l	-4(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READ_LONGINT$TEXTREC$LONGINT
	move.l	-4(a6),d2
	cmp.l	#-128,d2
	blt	.L4506
	jmp	.L4508
.L4508:
	move.l	-4(a6),d2
	cmp.l	#127,d2
	bgt	.L4506
	jmp	.L4507
.L4506:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4507:
	move.l	12(a6),a2
	move.l	-4(a6),d2
	move.b	d2,(a2)
.L4496:
.L4497:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_CARDINAL$TEXTREC$CARDINAL
_SYSATARI$$_READ_CARDINAL$TEXTREC$CARDINAL:
	XDEF READ_TEXT_CARDINAL
READ_TEXT_CARDINAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#264,sp
	move.l	12(a6),a2
	move.l	#0,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4517
	jmp	.L4518
.L4517:
	jmp	.L4513
.L4518:
	move.b	#0,-256(a6)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4521
	jmp	.L4522
.L4521:
	jmp	.L4513
.L4522:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_IGNORESPACES$TEXTREC
	move.b	d0,d2
	tst.b	d2
	bne	.L4528
	jmp	.L4526
.L4528:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READSIGN$TEXTREC$STRING
	move.b	d0,d2
	tst.b	d2
	bne	.L4527
	jmp	.L4526
.L4527:
	lea.l	-264(a6),a1
	move.l	a1,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READBASE$TEXTREC$STRING$LONGINT
	move.b	d0,d2
	tst.b	d2
	bne	.L4525
	jmp	.L4526
.L4525:
	move.l	-264(a6),-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READNUMERIC$TEXTREC$STRING$LONGINT
	move.b	d0,d2
.L4526:
	lea.l	-258(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$CARDINAL$WORD
	move.w	-258(a6),d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4553
	jmp	.L4554
.L4553:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4554:
.L4513:
.L4514:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_READ_REAL$TEXTREC$REAL
_SYSATARI$$_READ_REAL$TEXTREC$REAL:
	XDEF READ_TEXT_REAL
READ_TEXT_REAL:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#514,sp
	move.l	12(a6),a2
	move.l	.L353,d2
	move.l	d2,(a2)
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4561
	jmp	.L4562
.L4561:
	jmp	.L4557
.L4562:
	move.b	#0,-256(a6)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4565
	jmp	.L4566
.L4565:
	jmp	.L4557
.L4566:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_IGNORESPACES$TEXTREC
	move.b	d0,d2
	tst.b	d2
	bne	.L4572
	jmp	.L4570
.L4572:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READSIGN$TEXTREC$STRING
	move.b	d0,d2
	tst.b	d2
	bne	.L4571
	jmp	.L4570
.L4571:
	moveq.l	#10,d6
	move.l	d6,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READNUMERIC$TEXTREC$STRING$LONGINT
	move.b	d0,d2
	tst.b	d2
	bne	.L4569
	jmp	.L4570
.L4569:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#46,d2
	beq	.L4587
	jmp	.L4586
.L4587:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4585
	jmp	.L4586
.L4585:
	lea.l	-514(a6),a1
	lea.l	-256(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	pea.l	.L467
	lea.l	-514(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-256(a6),a1
	lea.l	-514(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	8(a6),a2
	addq.w	#1,8(a2)
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4590
	jmp	.L4591
.L4590:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4591:
	moveq.l	#10,d6
	move.l	d6,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READNUMERIC$TEXTREC$STRING$LONGINT
	move.b	d0,d2
.L4586:
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	move.b	0(a2,d2.l),d0
	and.l	#255,d0
	cmp.w	#69,d0
	beq	.L4603
	cmp.w	#101,d0
	beq	.L4603
.L4603:
	beq	.L4602
	jmp	.L4601
.L4602:
	move.l	8(a6),a3
	move.w	8(a3),d3
	and.l	#65535,d3
	move.l	8(a6),a3
	move.w	10(a3),d4
	and.l	#65535,d4
	cmp.l	d3,d4
	bgt	.L4600
	jmp	.L4601
.L4600:
	lea.l	-514(a6),a1
	lea.l	-256(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	pea.l	.L495
	lea.l	-514(a6),a1
	move.l	a1,-(sp)
	jsr	STRCONCAT
	lea.l	-256(a6),a1
	lea.l	-514(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.l	8(a6),a2
	addq.w	#1,8(a2)
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4606
	jmp	.L4607
.L4606:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4607:
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READSIGN$TEXTREC$STRING
	move.b	d0,d2
	tst.b	d2
	bne	.L4610
	jmp	.L4611
.L4610:
	moveq.l	#10,d6
	move.l	d6,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_READNUMERIC$TEXTREC$STRING$LONGINT
	move.b	d0,d2
.L4611:
.L4601:
.L4570:
	lea.l	-258(a6),a1
	move.l	a1,-(sp)
	move.l	12(a6),a2
	move.l	a2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_VAL$STRING$VALREAL$WORD
	move.w	-258(a6),d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4628
	jmp	.L4629
.L4628:
	moveq.l	#106,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4629:
.L4557:
.L4558:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#8,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_R$TEXTREC
_SYSATARI$$_R$TEXTREC:
	XDEF READLN_TEXT
READLN_TEXT:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4634
	jmp	.L4635
.L4634:
	jmp	.L4632
.L4635:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_OPENINPUT$TEXTREC
	move.b	d0,d2
	eor.b	#1,d2
	tst.b	d2
	bne	.L4636
	jmp	.L4637
.L4636:
	jmp	.L4632
.L4637:
	jmp	.L4641
.L4640:
	move.l	8(a6),a2
	addq.w	#1,8(a2)
	move.l	8(a6),a2
	move.l	12(a2),a2
	move.l	8(a6),a3
	move.w	8(a3),d2
	and.l	#65535,d2
	sub.l	#1,d2
	move.b	0(a2,d2.l),d2
	cmp.b	#10,d2
	beq	.L4643
	jmp	.L4644
.L4643:
	jmp	.L4632
.L4644:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	ble	.L4645
	jmp	.L4646
.L4645:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.l	8(a6),a2
	move.l	20(a2),a1
	jsr	(a1)
.L4646:
.L4641:
	move.l	8(a6),a2
	move.w	8(a2),d2
	and.l	#65535,d2
	move.l	8(a6),a2
	move.w	10(a2),d3
	and.l	#65535,d3
	cmp.l	d2,d3
	bgt	.L4640
	jmp	.L4642
.L4642:
.L4632:
.L4633:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_OPENSTDIO$TEXT$WORD$LONGINT:
	move.l	a6,-(sp)
	move.l	sp,a6
	pea.l	.L150
	move.l	8(a6),a2
	move.l	a2,-(sp)
	jsr	_SYSATARI$$_ASSIGN$TEXT$STRING
	move.l	8(a6),a2
	move.l	14(a6),d2
	move.w	d2,(a2)
	move.l	8(a6),a2
	move.w	12(a6),d2
	move.w	d2,2(a2)
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILECLOSEFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,28(a2)
	move.w	12(a6),d2
	sub.w	#55217,d2
	beq	.L4651
	subq.w	#1,d2
	beq	.L4653
	jmp	.L4666
.L4653:
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEWRITEFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,20(a2)
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEWRITEFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,24(a2)
	jmp	.L4665
.L4651:
	move.l	8(a6),a2
	lea.l	_SYSATARI$$_FILEREADFUNC$TEXTREC,a0
	move.l	a0,d2
	move.l	d2,20(a2)
	jmp	.L4665
.L4666:
	moveq.l	#102,d6
	move.l	d6,-(sp)
	jsr	_SYSATARI$$_HANDLEERROR$LONGINT
.L4665:
.L4649:
.L4650:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#10,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_DOSDIR$BYTE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#258,sp
	move.l	10(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	move.l	d2,-(sp)
	lea.l	-256(a6),a1
	move.l	a1,-(sp)
	move.l	10(a6),a2
	lea.l	1(a2),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_MOVE$$$$$$$$$LONGINT
	move.l	10(a6),a2
	move.b	(a2),d2
	and.l	#255,d2
	sub.l	#256,d2
	move.b	#0,0(a6,d2.l)
	lea.l	-256(a6),a0
	move.l	a0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_ALLOWSLASH$PCHAR
	move.b	8(a6),d2
	and.w	#255,d2
	move.w	d2,-258(a6)
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	pea	-256(a6)
	move.w	-258(a6),-(sp)
	trap	#1
	add.l	#6,sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	tst.w	d0
	beq	.L4677
	move.w	d0,_ERRNO
.L4677:
	move.w	_ERRNO,d2
	ext.l	d2
	tst.l	d2
	bne	.L4690
	jmp	.L4691
.L4690:
	jsr	_SYSATARI$$_ERROR2INOUT
.L4691:
.L4675:
.L4676:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_MKDIR$STRING
_SYSATARI$$_MKDIR$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4694
	jmp	.L4695
.L4694:
	jmp	.L4692
.L4695:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.w	#14592,-(sp)
	jsr	_SYSATARI$$_DOSDIR$BYTE$STRING
.L4692:
.L4693:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_RMDIR$STRING
_SYSATARI$$_RMDIR$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4702
	jmp	.L4703
.L4702:
	jmp	.L4700
.L4703:
	move.l	8(a6),a2
	move.l	a2,-(sp)
	move.w	#14848,-(sp)
	jsr	_SYSATARI$$_DOSDIR$BYTE$STRING
.L4700:
.L4701:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_CHDIR$STRING
_SYSATARI$$_CHDIR$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#260,sp
	move.w	U_SYSATARI_INOUTRES,d2
	and.l	#65535,d2
	tst.l	d2
	bne	.L4710
	jmp	.L4711
.L4710:
	jmp	.L4708
.L4711:
	move.l	8(a6),a2
	lea.l	-260(a6),a1
	lea.l	(a2),a0
	move.l	#255,d0
	jsr	STRCOPY
	lea.l	-260(a6),a1
	move.l	a1,-(sp)
	move.w	#15104,-(sp)
	jsr	_SYSATARI$$_DOSDIR$BYTE$STRING
.L4708:
.L4709:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#4,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
	XDEF _SYSATARI$$_GETDIR$BYTE$STRING
_SYSATARI$$_GETDIR$BYTE$STRING:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#520,sp
	move.b	8(a6),d2
	and.w	#255,d2
	move.w	d2,-264(a6)
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.w	-264(a6),-(sp)
	pea	-256(a6)
	move.w	#71,-(sp)
	trap	#1
	add.l	#8,sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	move.l	#0,-260(a6)
	jmp	.L4725
.L4724:
	move.l	-260(a6),d2
	sub.l	#256,d2
	move.b	0(a6,d2.l),d2
	cmp.b	#47,d2
	beq	.L4727
	jmp	.L4728
.L4727:
	move.l	-260(a6),d2
	sub.l	#256,d2
	move.b	#92,0(a6,d2.l)
.L4728:
	move.l	10(a6),a2
	move.l	-260(a6),d2
	add.l	#3,d2
	move.l	-260(a6),d3
	sub.l	#256,d3
	move.b	0(a6,d3.l),d4
	move.b	d4,0(a2,d2.l)
	addq.l	#1,-260(a6)
.L4725:
	move.l	-260(a6),d2
	sub.l	#256,d2
	move.b	0(a6,d2.l),d2
	cmp.b	#0,d2
	bne	.L4724
	jmp	.L4726
.L4726:
	move.l	10(a6),a2
	move.b	#58,2(a2)
	move.l	10(a6),a2
	move.b	#92,3(a2)
	move.l	10(a6),a2
	move.l	-260(a6),d2
	add.l	#2,d2
	move.b	d2,(a2)
	move.l	10(a6),a2
	move.l	a2,-(sp)
	move.l	10(a6),a2
	move.l	a2,-(sp)
	lea.l	-520(a6),a1
	move.l	a1,-(sp)
	jsr	_SYSATARI$$_UPCASE$STRING
	move.l	(sp)+,a2
	lea.l	(a2),a1
	lea.l	-520(a6),a0
	move.l	#255,d0
	jsr	STRCOPY
	move.b	8(a6),d2
	and.l	#255,d2
	tst.l	d2
	bne	.L4743
	jmp	.L4744
.L4743:
	move.l	10(a6),a2
	move.b	8(a6),d2
	and.l	#255,d2
	add.l	#65,d2
	sub.l	#1,d2
	move.b	d2,1(a2)
	jmp	.L4747
.L4744:
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.w	#25,-(sp)
	trap	#1
	add.l	#2,sp
	move.w	d0,-264(a6)
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	move.l	10(a6),a2
	move.w	-264(a6),d2
	and.l	#65535,d2
	and.l	#255,d2
	add.l	#65,d2
	move.b	d2,1(a2)
.L4747:
.L4718:
.L4719:
	unlk	a6
	move.l	(sp)+,a0
	add.l	#6,sp
	move.l	a0,-(sp)
	rts
	CNOP 0,2
_SYSATARI$$_GETMINORVERSION:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#2,sp
	move.l	d2,d6
	movem.l	d3/a2/a3,-(sp)
	move.w	#48,-(sp)
	trap	#1
	add.l	#2,sp
	move.l	d6,d2
	movem.l	(sp)+,d3/a2/a3
	move.w	d0,-2(a6)
	move.w	-2(a6),d2
	lsr.w	#8,d2
	move.b	d2,_MINORVERSION
.L4750:
.L4751:
	unlk	a6
	rts
	CNOP 0,2
	XDEF INIT$$SYSATARI
INIT$$SYSATARI:
	XDEF SYSATARI_init
SYSATARI_init:
	move.l	a6,-(sp)
	move.l	sp,a6
	sub.l	#4,sp
	move.l	#0,d2
	move.l	d2,TC__SYSATARI$$_EXITPROC
	move.l	#2147483647,U_SYSATARI_LOWESTSTACK
	jsr	_SYSATARI$$_INITHEAP
	moveq.l	#0,d6
	move.l	d6,-(sp)
	move.w	#55217,-(sp)
	pea.l	U_SYSATARI_INPUT
	jsr	_SYSATARI$$_OPENSTDIO$TEXT$WORD$LONGINT
	moveq.l	#1,d6
	move.l	d6,-(sp)
	move.w	#55218,-(sp)
	pea.l	U_SYSATARI_OUTPUT
	jsr	_SYSATARI$$_OPENSTDIO$TEXT$WORD$LONGINT
	move.l	#65535,-(sp)
	move.w	#55218,-(sp)
	pea.l	U_SYSATARI_STDERR
	jsr	_SYSATARI$$_OPENSTDIO$TEXT$WORD$LONGINT
	move.w	#0,U_SYSATARI_INOUTRES
	move.w	#0,_ERRNO
	jsr	_SYSATARI$$_ARGS
	move.l	d0,d2
	move.l	d2,-(sp)
	jsr	_SYSATARI$$_GETPARAMCOUNT$PCHAR
	move.l	d0,d2
	move.l	d2,TC__SYSATARI$$_ARGC
	jsr	_SYSATARI$$_SETUP_ENVIRONMENT
	jsr	_SYSATARI$$_GETMINORVERSION
	move.b	_MINORVERSION,d2
	and.l	#255,d2
	cmp.l	#15,d2
	blt	.L4784
	jmp	.L4785
.L4784:
	lea.l	U_SYSATARI_OUTPUT,a0
	move.l	a0,-4(a6)
	pea.l	.L4788
	move.l	-4(a6),-(sp)
	moveq.l	#0,d6
	move.l	d6,-(sp)
	jsr	WRITE_TEXT_STRING
	move.l	-4(a6),-(sp)
	jsr	WRITELN_TEXT
	jsr	FLUSH_STDOUT
.L4785:
.L1:
.L2:
	unlk	a6
	rts

	SECTION _DATA,DATA
	CNOP 0,4
	CNOP 0,4
	XDEF TC__SYSATARI$$_TEST68000
TC__SYSATARI$$_TEST68000		DC.B	0
	CNOP 0,4
	XDEF TC__SYSATARI$$_TEST68881
TC__SYSATARI$$_TEST68881		DC.B	0
	CNOP 0,4
	XDEF TC__SYSATARI$$_MAX_FRAME_DUMP
TC__SYSATARI$$_MAX_FRAME_DUMP		DC.W	8
	CNOP 0,4
	XDEF TC__SYSATARI$$_EXITPROC
TC__SYSATARI$$_EXITPROC		DC.L	0
	CNOP 0,4
	XDEF TC__SYSATARI$$_ERRORADDR
TC__SYSATARI$$_ERRORADDR		DC.L	0
	CNOP 0,4
	XDEF TC__SYSATARI$$_ERRORCODE
TC__SYSATARI$$_ERRORCODE		DC.W	0
	CNOP 0,4
	XDEF TC__SYSATARI$$_FILEMODE
TC__SYSATARI$$_FILEMODE		DC.B	2
	CNOP 0,4
	XDEF TC__SYSATARI$$_ERRORPROC
TC__SYSATARI$$_ERRORPROC		DC.L	0
	CNOP 0,4
	XDEF TC__SYSATARI$$_ALLOW_SPECIAL
TC__SYSATARI$$_ALLOW_SPECIAL		DC.B	1
	CNOP 0,4
	XDEF TC__SYSATARI$$_HEAPBLOCKS
TC__SYSATARI$$_HEAPBLOCKS		DC.B	0
	CNOP 0,4
TC__SYSATARI$$_OLDRANDSEED		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_INITIALSEED		DC.B	1
	CNOP 0,4
TC__SYSATARI$$_SEED1		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_SEED2		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_SEED3		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_DOERROR		DC.B	0
	CNOP 0,4
TC__SYSATARI$$_ERRORBASE		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_HEXSTR_HEXTBL		DC.B	48
		DC.B	49
		DC.B	50
		DC.B	51
		DC.B	52
		DC.B	53
		DC.B	54
		DC.B	55
		DC.B	56
		DC.B	57
		DC.B	65
		DC.B	66
		DC.B	67
		DC.B	68
		DC.B	69
		DC.B	70
	CNOP 0,4
TC__SYSATARI$$_SINCOF		DC.S	 1.58962301655130E-0010
		DC.S	-2.50507472543404E-0008
		DC.S	 2.75573142971552E-0006
		DC.S	-1.98412701138295E-0004
		DC.S	 8.33333376795053E-0003
		DC.S	-1.66666671633720E-0001
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_COSCOF		DC.S	-1.13585365071889E-0011
		DC.S	 2.08757011677108E-0009
		DC.S	-2.75573142971552E-0007
		DC.S	 2.48015876422869E-0005
		DC.S	-1.38888892251998E-0003
		DC.S	 4.16666679084301E-0002
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_EXP_P		DC.S	 1.26183091197163E-0004
		DC.S	 3.02996896207333E-0002
		DC.S	 1.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_EXP_Q		DC.S	 3.00227952720888E-0006
		DC.S	 2.52453656867146E-0003
		DC.S	 2.27266043424606E-0001
		DC.S	 2.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_LN_P		DC.S	 4.58482936664950E-0005
		DC.S	 4.98531073331833E-0001
		DC.S	 6.56312084197998E+0000
		DC.S	 2.97877426147461E+0001
		DC.S	 6.06127128601074E+0001
		DC.S	 5.67349281311035E+0001
		DC.S	 1.98892440795898E+0001
	CNOP 0,4
TC__SYSATARI$$_LN_Q		DC.S	 1.50314178466797E+0001
		DC.S	 8.27410430908203E+0001
		DC.S	 2.20664382934570E+0002
		DC.S	 3.07254180908203E+0002
		DC.S	 2.14955581665039E+0002
		DC.S	 5.96677322387695E+0001
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_LN_R		DC.S	-7.89580285549164E-0001
		DC.S	 1.63866653442383E+0001
		DC.S	-6.41409988403320E+0001
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_LN_S		DC.S	-3.56722793579102E+0001
		DC.S	 3.12093780517578E+0002
		DC.S	-7.69691955566406E+0002
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_ARCTAN_P		DC.S	-8.40980887413025E-0001
		DC.S	-8.83860874176025E+0000
		DC.S	-2.18476219177246E+0001
		DC.S	-1.48307046890259E+0001
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_ARCTAN_Q		DC.S	 1.54974126815796E+0001
		DC.S	 6.27906570434570E+0001
		DC.S	 9.22381362915039E+0001
		DC.S	 4.44921150207520E+0001
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
TC__SYSATARI$$_EXITPROCLIST		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_ARGC		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_HEAP_SPLIT		DC.B	0
	CNOP 0,4
TC__SYSATARI$$_FREERECORD_LIST_LENGTH		DC.L	0
	CNOP 0,4
TC__SYSATARI$$_WRITELN_END_EOL		DC.B	13
		DC.B	10
	CNOP 0,4
.L4788		DC.B	31,"GemDOS 0.15 or higher required.",0
	CNOP 0,4
.L4096		DC.B	2,13,10,0
	CNOP 0,4
.L4067		DC.B	5,"FALSE",0
	CNOP 0,4
.L4059		DC.B	4,"TRUE",0
	CNOP 0,4
.L2756		DC.B	14," is too big !!",0
	CNOP 0,4
.L2725		DC.B	26," has already been disposed",0
	CNOP 0,4
.L2716		DC.B	22,"pointer to dispose at ",0
	CNOP 0,4
.L2159		DC.B	7,", line ",0
	CNOP 0,4
.L2154		DC.B	8,"(File : ",0
	CNOP 0,4
.L2148		DC.B	18,"Assertion failed. ",0
	CNOP 0,4
.L2105		DC.B	16,"Run time error  ",0
	CNOP 0,4
.L2062		DC.B	4,"  0x",0
	CNOP 0,4
.L1960:
		DC.S	 7.85398185253143E-0001
	CNOP 0,4
.L1957:
		DC.S	 4.14213567972183E-0001
	CNOP 0,4
.L1951:
		DC.S	 1.57079637050629E+0000
	CNOP 0,4
.L1948:
		DC.S	 2.41421365737915E+0000
	CNOP 0,4
.L1903:
		DC.S	 2.69515147673712E-0015
	CNOP 0,4
.L1860:
		DC.S	 7.85398185253143E-0001
	CNOP 0,4
.L1811:
		DC.S	 2.69515147673712E-0015
	CNOP 0,4
.L1810:
		DC.S	 3.77489470793080E-0008
	CNOP 0,4
.L1809:
		DC.S	 7.85398125648499E-0001
	CNOP 0,4
.L1770:
		DC.S	 7.85398185253143E-0001
	CNOP 0,4
.L1763:
		DC.S	 1.07374182400000E+0009
	CNOP 0,4
.L1746:
		DC.S	 2.12194441701286E-0004
	CNOP 0,4
.L1702:
		DC.S	 7.07106769084930E-0001
	CNOP 0,4
.L1666:
		DC.S	 7.07106769084930E-0001
	CNOP 0,4
.L1578:
		DC.S	 2.12194441701286E-0004
	CNOP 0,4
.L1575:
		DC.S	 6.93359375000000E-0001
	CNOP 0,4
.L1564:
		DC.S	 1.44269502162933E+0000
	CNOP 0,4
.L1558:
		DC.S	-8.87228393554688E+0001
	CNOP 0,4
.L1552:
		DC.S	 8.80296936035156E+0001
	CNOP 0,4
.L1526:
		DC.S	 1.41421353816986E+0000
	CNOP 0,4
.L1519:
		DC.S	 4.17307585477829E-0001
	CNOP 0,4
.L1518:
		DC.S	 5.90162038803101E-0001
	CNOP 0,4
.L1496:
		DC.S	 3.14159274101257E+0000
	CNOP 0,4
.L1430:
		DC.S	 2.00000000000000E+0000
	CNOP 0,4
.L1349:
		DC.S	 7.65241000000000E+0005
	CNOP 0,4
.L1348:
		DC.S	 6.00011000000000E+0005
	CNOP 0,4
.L1347:
		DC.S	 5.00009000000000E+0005
	CNOP 0,4
.L1074:
		DC.S	 1.00000001490116E-0001
	CNOP 0,4
.L1056:
		DC.S	-1.00000000000000E+0000
	CNOP 0,4
.L495		DC.B	1,"E",0
	CNOP 0,4
.L492		DC.B	1,"+",0
	CNOP 0,4
.L484		DC.B	"(0000000000000000000000000000000000000000",0
	CNOP 0,4
.L467		DC.B	1,".",0
	CNOP 0,4
.L460:
		DC.S	 1.00000004091848E+0035
	CNOP 0,4
.L403:
		DC.S	 5.00000000000000E-0001
	CNOP 0,4
.L395:
		DC.S	 1.00000000000000E+0000
	CNOP 0,4
.L385:
		DC.S	 1.00000000000000E+0001
	CNOP 0,4
.L370:
		DC.S	 1.00000001800251E-0035
	CNOP 0,4
.L369:
		DC.S	 1.00000004091848E+0035
	CNOP 0,4
.L353:
		DC.S	 0.00000000000000E+0000
	CNOP 0,4
.L243		DC.B	1,"-",0
	CNOP 0,4
.L216		DC.B	11,"-2147483648",0
	CNOP 0,4
.L150		DC.B	0,0
	CNOP 0,4
.L116		DC.B	14,"Overflow at 0x",0
	CNOP 0,4
.L103		DC.B	6," at 0x",0
	CNOP 0,4
.L98		DC.B	9,"IO-Error ",0

	SECTION _BSS,BSS
	CNOP 0,4
	XDEF	U_SYSATARI_OUTPUT
U_SYSATARI_OUTPUT		DS.B 256
	CNOP 0,4
	XDEF	U_SYSATARI_INPUT
U_SYSATARI_INPUT		DS.B 256
	CNOP 0,4
	XDEF	U_SYSATARI_STDERR
U_SYSATARI_STDERR		DS.B 256
	CNOP 0,4
	XDEF	U_SYSATARI_EXITCODE
U_SYSATARI_EXITCODE		DS.B 2
	CNOP 0,4
	XDEF	U_SYSATARI_INOUTRES
U_SYSATARI_INOUTRES		DS.B 2
	CNOP 0,4
	XDEF	U_SYSATARI_STACKBOTTOM
U_SYSATARI_STACKBOTTOM		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_LOWESTSTACK
U_SYSATARI_LOWESTSTACK		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_RANDSEED
U_SYSATARI_RANDSEED		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_HEAPORG
U_SYSATARI_HEAPORG		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_HEAPPTR
U_SYSATARI_HEAPPTR		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_HEAPEND
U_SYSATARI_HEAPEND		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_HEAPERROR
U_SYSATARI_HEAPERROR		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_FREELIST
U_SYSATARI_FREELIST		DS.B 4
	CNOP 0,4
	XDEF	U_SYSATARI_ENVP
U_SYSATARI_ENVP		DS.B 4
	CNOP 0,4
_ERRNO		DS.B 2
_MINORVERSION		DS.B 1
	CNOP 0,4
__MEMAVAIL		DS.B 4
	CNOP 0,4
__INTERNAL_HEAPSIZE		DS.B 4
	CNOP 0,4
_BASEHEAP		DS.B 24
	CNOP 0,4
_CURHEAP		DS.B 4

	END
