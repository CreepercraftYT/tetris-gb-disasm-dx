SECTION "Sprite Data", ROMX[$4000], BANK[$1]

; last data table byte == $fd - x flip next tile
; last data table byte == $fe - skip next coords
; last data table byte == $ff - end
; last data table byte == others - specifies the tile index


SpriteData:
	dw SpriteSpec_00
	dw SpriteSpec_01
	dw SpriteSpec_02
	dw SpriteSpec_03
	dw SpriteSpec_04
	dw SpriteSpec_05
	dw SpriteSpec_06
	dw SpriteSpec_07
	dw SpriteSpec_08
	dw SpriteSpec_09
	dw SpriteSpec_0a
	dw SpriteSpec_0b
	dw SpriteSpec_0c
	dw SpriteSpec_0d
	dw SpriteSpec_0e
	dw SpriteSpec_0f
	dw SpriteSpec_10
	dw SpriteSpec_11
	dw SpriteSpec_12
	dw SpriteSpec_13
	dw SpriteSpec_14
	dw SpriteSpec_15
	dw SpriteSpec_16
	dw SpriteSpec_17
	dw SpriteSpec_18
	dw SpriteSpec_19
	dw SpriteSpec_1a
	dw SpriteSpec_1b
	dw SpriteSpec_1c
	dw SpriteSpec_1d
	dw SpriteSpec_1e
	dw SpriteSpec_1f
	dw SpriteSpec_20
	dw SpriteSpec_21
	dw SpriteSpec_22
	dw SpriteSpec_23
	dw SpriteSpec_24
	dw SpriteSpec_25
	dw SpriteSpec_26
	dw SpriteSpec_27
	dw SpriteSpec_28
	dw SpriteSpec_29
	dw SpriteSpec_2a
	dw SpriteSpec_2b
	dw SpriteSpec_2c
	dw SpriteSpec_2d
	dw SpriteSpec_2e
	dw SpriteSpec_2f
	dw SpriteSpec_30
	dw SpriteSpec_31
	dw SpriteSpec_32
	dw SpriteSpec_33
	dw SpriteSpec_34
	dw SpriteSpec_35
	dw SpriteSpec_36
	dw SpriteSpec_37
	dw SpriteSpec_38
	dw SpriteSpec_39
	dw SpriteSpec_3a
	dw SpriteSpec_3b
	dw SpriteSpec_3c
	dw SpriteSpec_3d
	dw SpriteSpec_3e
	dw SpriteSpec_3f
	dw SpriteSpec_40
	dw SpriteSpec_41
	dw SpriteSpec_42
	dw SpriteSpec_43
	dw SpriteSpec_44
	dw SpriteSpec_45
	dw SpriteSpec_46
	dw SpriteSpec_47
	dw SpriteSpec_48
	dw SpriteSpec_49
	dw SpriteSpec_4a
	dw SpriteSpec_4b
	dw SpriteSpec_4c
	dw SpriteSpec_4d
	dw SpriteSpec_4e
	dw SpriteSpec_4f
	dw SpriteSpec_50
	dw SpriteSpec_51
	dw SpriteSpec_52
	dw SpriteSpec_53
	dw SpriteSpec_54
	dw SpriteSpec_55
	dw SpriteSpec_56
	dw SpriteSpec_57
	dw SpriteSpec_58
	dw SpriteSpec_59
	dw SpriteSpec_5a
	dw SpriteSpec_5b
	dw SpriteSpec_5c
	dw SpriteSpec_5d

SpriteSpec_00:
	dw SpriteTiles_00
	db $ef, $f0

SpriteSpec_01:
	dw SpriteTiles_01
	db $ef, $f0

SpriteSpec_02:
	dw SpriteTiles_02
	db $ef, $f0

SpriteSpec_03:
	dw SpriteTiles_03
	db $ef, $f0

SpriteSpec_04:
	dw SpriteTiles_04
	db $ef, $f0

SpriteSpec_05:
	dw SpriteTiles_05
	db $ef, $f0

SpriteSpec_06:
	dw SpriteTiles_06
	db $ef, $f0

SpriteSpec_07:
	dw SpriteTiles_07
	db $ef, $f0

SpriteSpec_08:
	dw SpriteTiles_08
	db $ef, $f0

SpriteSpec_09:
	dw SpriteTiles_09
	db $ef, $f0

SpriteSpec_0a:
	dw SpriteTiles_0a
	db $ef, $f0

SpriteSpec_0b:
	dw SpriteTiles_0b
	db $ef, $f0

SpriteSpec_0c:
	dw SpriteTiles_0c
	db $ef, $f0

SpriteSpec_0d:
	dw SpriteTiles_0d
	db $ef, $f0

SpriteSpec_0e:
	dw SpriteTiles_0e
	db $ef, $f0

SpriteSpec_0f:
	dw SpriteTiles_0f
	db $ef, $f0

SpriteSpec_10:
	dw SpriteTiles_10
	db $ef, $f0

SpriteSpec_11:
	dw SpriteTiles_11
	db $ef, $f0

SpriteSpec_12:
	dw SpriteTiles_12
	db $ef, $f0

SpriteSpec_13:
	dw SpriteTiles_13
	db $ef, $f0

SpriteSpec_14:
	dw SpriteTiles_14
	db $ef, $f0

SpriteSpec_15:
	dw SpriteTiles_15
	db $ef, $f0

SpriteSpec_16:
	dw SpriteTiles_16
	db $ef, $f0

SpriteSpec_17:
	dw SpriteTiles_17
	db $ef, $f0

SpriteSpec_18:
	dw SpriteTiles_18
	db $ef, $f0

SpriteSpec_19:
	dw SpriteTiles_19
	db $ef, $f0

SpriteSpec_1a:
	dw SpriteTiles_1a
	db $ef, $f0

SpriteSpec_1b:
	dw SpriteTiles_1b
	db $ef, $f0

SpriteSpec_1c:
	dw SpriteTiles_1c
	db $00, $e8

SpriteSpec_1d:
	dw SpriteTiles_1d
	db $00, $e8

SpriteSpec_1e:
	dw SpriteTiles_1e
	db $00, $e8

SpriteSpec_1f:
	dw SpriteTiles_1f
	db $00, $e8

SpriteSpec_20:
	dw SpriteTiles_20
	db $00, $00

SpriteSpec_21:
	dw SpriteTiles_21
	db $00, $00

SpriteSpec_22:
	dw SpriteTiles_22
	db $00, $00

SpriteSpec_23:
	dw SpriteTiles_23
	db $00, $00

SpriteSpec_24:
	dw SpriteTiles_24
	db $00, $00

SpriteSpec_25:
	dw SpriteTiles_25
	db $00, $00

SpriteSpec_26:
	dw SpriteTiles_26
	db $00, $00

SpriteSpec_27:
	dw SpriteTiles_27
	db $00, $00

SpriteSpec_28:
	dw SpriteTiles_28
	db $00, $00

SpriteSpec_29:
	dw SpriteTiles_29
	db $00, $00

SpriteSpec_2a:
	dw SpriteTiles_2a
	db $f0, $f8

SpriteSpec_2b:
SpriteSpec_2d:
	dw SpriteTiles_2d
	db $f0, $f8

SpriteSpec_2e:
	dw SpriteTiles_2e
	db $f0, $f0

SpriteSpec_2f:
	dw SpriteTiles_2f
	db $f0, $f0

SpriteSpec_30:
	dw SpriteTiles_30
	db $f8, $f8

SpriteSpec_31:
	dw SpriteTiles_31
	db $f8, $f8

SpriteSpec_32:
	dw SpriteTiles_32
	db $f8, $f8

SpriteSpec_33:
	dw SpriteTiles_33
	db $f8, $f8

SpriteSpec_36:
	dw SpriteTiles_36
	db $f0, $f8

SpriteSpec_37:
	dw SpriteTiles_37
	db $f0, $f8

SpriteSpec_3a:
	dw SpriteTiles_3a
	db $f0, $f0

SpriteSpec_3b:
	dw SpriteTiles_3b
	db $f0, $f0

SpriteSpec_3c:
	dw SpriteTiles_3c
	db $f8, $f8

SpriteSpec_3d:
	dw SpriteTiles_3d
	db $f8, $f8

SpriteSpec_3e:
	dw SpriteTiles_3e
	db $f8, $f8

SpriteSpec_3f:
SpriteSpec_42:
	dw SpriteTiles_42
	db $f8, $f8

SpriteSpec_43:
SpriteSpec_44:
	dw SpriteTiles_44
	db $f8, $f8

SpriteSpec_45:
	dw SpriteTiles_45
	db $f8, $f8

SpriteSpec_46:
	dw SpriteTiles_46
	db $f8, $f8

SpriteSpec_47:
	dw SpriteTiles_47
	db $f8, $f8

SpriteSpec_48:
	dw SpriteTiles_48
	db $f8, $f8

SpriteSpec_49:
	dw SpriteTiles_49
	db $f8, $f8

SpriteSpec_4a:
	dw SpriteTiles_4a
	db $f8, $f8

SpriteSpec_4b:
	dw SpriteTiles_4b
	db $f8, $f8

SpriteSpec_4c:
	dw SpriteTiles_4c
	db $f8, $f8

SpriteSpec_4d:
	dw SpriteTiles_4d
	db $f8, $f8

SpriteSpec_4e:
	dw SpriteTiles_4e
	db $f8, $f8

SpriteSpec_4f:
	dw SpriteTiles_4f
	db $f8, $f8

SpriteSpec_50:
	dw SpriteTiles_50
	db $f8, $f8

SpriteSpec_51:
	dw SpriteTiles_51
	db $f8, $f8

SpriteSpec_52:
	dw SpriteTiles_52
	db $f8, $f8

SpriteSpec_53:
	dw SpriteTiles_53
	db $f8, $f8

SpriteSpec_54:
	dw SpriteTiles_54
	db $f8, $f8

SpriteSpec_55:
	dw SpriteTiles_55
	db $f8, $f8

SpriteSpec_56:
	dw SpriteTiles_56
	db $f0, $f0

SpriteSpec_57:
	dw SpriteTiles_57
	db $f8, $f8

SpriteTiles_00:
	dw SpriteCoords_00
	db $fe, $fe, $fe, $fe 
	db $fe, $fe, $fe, $fe
	db $84, $84, $84, $fe
	db $84, $ff

SpriteTiles_01:
	dw SpriteCoords_01
	db $fe, $fe, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $84, $ff

SpriteTiles_02:
	dw SpriteCoords_02
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $84, $fe
	db $84, $84, $84, $fe
	db $ff

SpriteTiles_03:
	dw SpriteCoords_03
	db $fe, $fe, $fe, $fe
	db $84, $84, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $ff

SpriteTiles_04:
	dw SpriteCoords_04
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $81, $81, $81, $fe
	db $fe, $fe, $81, $ff

SpriteTiles_05:
	dw SpriteCoords_05
	db $fe, $fe, $fe, $fe
	db $fe, $81, $81, $fe
	db $fe, $81, $fe, $fe
	db $fe, $81, $ff

SpriteTiles_06:
	dw SpriteCoords_06
	db $fe, $fe, $fe, $fe
	db $81, $fe, $fe, $fe
	db $81, $81, $81, $ff

SpriteTiles_07:
	dw SpriteCoords_07
	db $fe, $fe, $fe, $fe
	db $fe, $81, $fe, $fe
	db $fe, $81, $fe, $fe
	db $81, $81, $ff

SpriteTiles_08:
	dw SpriteCoords_08
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $8a, $8b, $8b, $8f
	db $ff

SpriteTiles_09:
	dw SpriteCoords_09
	db $fe, $80, $fe, $fe
	db $fe, $88, $fe, $fe
	db $fe, $88, $fe, $fe
	db $fe, $89, $ff

SpriteTiles_0a:
	dw SpriteCoords_0a
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $8a, $8b, $8b, $8f
	db $ff

SpriteTiles_0b:
	dw SpriteCoords_0b
	db $fe, $80, $fe, $fe
	db $fe, $88, $fe, $fe
	db $fe, $88, $fe, $fe
	db $fe, $89, $ff

SpriteTiles_0c:
	dw SpriteCoords_0c
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SpriteTiles_0d:
	dw SpriteCoords_0d
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SpriteTiles_0e:
	dw SpriteCoords_0e
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SpriteTiles_0f:
	dw SpriteCoords_0f
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SpriteTiles_10:
	dw SpriteCoords_10
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $82, $82, $fe, $fe
	db $fe, $82, $82, $ff

SpriteTiles_11:
	dw SpriteCoords_11
	db $fe, $fe, $fe, $fe
	db $fe, $82, $fe, $fe
	db $82, $82, $fe, $fe
	db $82, $ff

SpriteTiles_12:
	dw SpriteCoords_12
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $82, $82, $fe, $fe
	db $fe, $82, $82, $ff

SpriteTiles_13:
	dw SpriteCoords_13
	db $fe, $fe, $fe, $fe
	db $fe, $82, $fe, $fe
	db $82, $82, $fe, $fe
	db $82, $ff

SpriteTiles_14:
	dw SpriteCoords_14
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $86, $86, $fe
	db $86, $86, $ff

SpriteTiles_15:
	dw SpriteCoords_15
	db $fe, $fe, $fe, $fe
	db $86, $fe, $fe, $fe
	db $86, $86, $fe, $fe
	db $fe, $86, $ff

SpriteTiles_16:
	dw SpriteCoords_16
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $86, $86, $fe
	db $86, $86, $ff

SpriteTiles_17:
	dw SpriteCoords_17
	db $fe, $fe, $fe, $fe
	db $86, $fe, $fe, $fe
	db $86, $86, $fe, $fe
	db $fe, $86, $ff

SpriteTiles_1a:
	dw SpriteCoords_1a
	db $fe, $fe, $fe, $fe
	db $fe, $85, $fe, $fe
	db $85, $85, $85, $ff

SpriteTiles_1b:
	dw SpriteCoords_1b
	db $fe, $fe, $fe, $fe,
    db $fe, $85, $fe, $fe, 
	db $85, $85, $fe, $fe, 
	db $fe, $85, $ff

SpriteTiles_18:
	dw SpriteCoords_18
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $85, $85, $85, $fe
	db $fe, $85, $ff

SpriteTiles_19:
	dw SpriteCoords_19
	db $fe, $fe, $fe, $fe
	db $fe, $85, $fe, $fe
	db $fe, $85, $85, $fe
	db $fe, $85, $ff

SpriteTiles_1c:
	dw SpriteCoords_1c
	db "A-TYPE", $ff

SpriteTiles_1d:
	dw SpriteCoords_1d
	db "B-TYPE", $ff

SpriteTiles_1e:
	dw SpriteCoords_1e
	db "C-TYPE", $ff

SpriteTiles_1f:
	dw SpriteCoords_1f
	db " OFF  ", $ff

SpriteTiles_20:
	dw SpriteCoords_20
	db "0", $ff

SpriteTiles_21:
	dw SpriteCoords_21
	db "1", $ff

SpriteTiles_22:
	dw SpriteCoords_22
	db "2", $ff

SpriteTiles_23:
	dw SpriteCoords_23
	db "3", $ff

SpriteTiles_24:
	dw SpriteCoords_24
	db "4", $ff

SpriteTiles_25:
	dw SpriteCoords_25
	db "5", $ff

SpriteTiles_26:
	dw SpriteCoords_26
	db "6", $ff

SpriteTiles_27:
	dw SpriteCoords_27
	db "7", $ff

SpriteTiles_28:
	dw SpriteCoords_28
	db "8", $ff

SpriteTiles_29:
	dw SpriteCoords_29
	db "9", $ff

SpriteTiles_2a:
	dw SpriteCoords_2a
	db $2f, $01, $2f, $11, $20, $21, $30, $31, $ff

SpriteTiles_2b:
SpriteTiles_2d:
	dw SpriteCoords_2d
	db $2f, $03, $12, $13, $22, $23, $32, $33, $ff

SpriteTiles_2e:
	dw SpriteCoords_2e
	db $2f, $05, $fd, $05, $2f, $2f, $15, $04, $17, $24, $25, $26, $27, $34, $35, $36, $2f, $ff

SpriteTiles_2f:
	dw SpriteCoords_2f
	db $08, $37, $fd, $37, $fd, $08, $18, $19, $14, $1b, $28, $29, $2a, $2b, $60, $70, $36, $2f, $ff

SpriteTiles_30:
	dw SpriteCoords_30
	db $b9, $fd, $b9, $ba, $fd, $ba, $ff

SpriteTiles_31:
	dw SpriteCoords_31
	db $82, $fd, $82, $83, $fd, $83, $ff

SpriteTiles_32:
	dw SpriteCoords_32
	db $09, $0a, $3a, $3b, $ff

SpriteTiles_33:
	dw SpriteCoords_33
	db $0b, $40, $7c, $6f, $ff

SpriteTiles_36:
	dw SpriteCoords_36
	db $2f, $0f, $2f, $1f, $5f, $2c, $2f, $3f, $ff

SpriteTiles_37:
	dw SpriteCoords_37
	db $6c, $3c, $4b, $4c, $5b, $5c, $6b, $2f, $ff

SpriteTiles_3a:
	dw SpriteCoords_3a
	db $2f, $4d, $fd, $4d, $2f, $2f, $5d, $5e, $4e, $5f, $6d, $6e, $2f, $2f, $7d, $fd, $7d, $2f, $ff

SpriteTiles_3b:
	dw SpriteCoords_3b
	db $08, $77, $fd, $77, $fd, $08, $18, $78, $43, $53, $7a, $7b, $50, $2f, $2f, $02, $fd, $7d, $2f, $ff

SpriteTiles_3c:
	dw SpriteCoords_3c
	db $b9, $fd, $b9, $ba, $fd, $ba, $ff

SpriteTiles_3d:
	dw SpriteCoords_3d
	db $82, $fd, $82, $83, $fd, $83, $ff

SpriteTiles_3e:
	dw SpriteCoords_3e
	db $09, $0a, $3a, $3b, $ff

SpriteTiles_3f:
SpriteTiles_42:
	dw SpriteCoords_42
	db $0b, $40, $7c, $6f, $ff

SpriteTiles_43:
SpriteTiles_44:
	dw SpriteCoords_44
	db $dc, $dd, $e0, $e1, $ff

SpriteTiles_45:
	dw SpriteCoords_45
	db $de, $df, $e0, $e1, $ff

SpriteTiles_46:
	dw SpriteCoords_46
	db $de, $e2, $e0, $e4, $ff

SpriteTiles_47:
	dw SpriteCoords_47
	db $dc, $ee, $e0, $e3, $ff

SpriteTiles_48:
	dw SpriteCoords_48
	db $e5, $e6, $e7, $e8, $ff

SpriteTiles_49:
	dw SpriteCoords_49
	db $fd, $e6, $fd, $e5, $fd, $e8, $fd, $e7, $ff

SpriteTiles_4a:
	dw SpriteCoords_4a
	db $e9, $ea, $eb, $ec, $ff

SpriteTiles_4b:
	dw SpriteCoords_4b
	db $ed, $ea, $eb, $ec, $ff

SpriteTiles_4c:
	dw SpriteCoords_4c
	db $f2, $f4, $f3, $bf, $ff

SpriteTiles_4d:
	dw SpriteCoords_4d
	db $f4, $f2, $bf, $f3, $ff

SpriteTiles_4e:
	dw SpriteCoords_4e
	db $c2, $fd, $c2, $c3, $fd, $c3, $ff

SpriteTiles_4f:
	dw SpriteCoords_4f
	db $c4, $fd, $c4, $c5, $fd, $c5, $ff

SpriteTiles_50:
	dw SpriteCoords_50
	db $dc, $fd, $dc, $ef, $fd, $ef, $ff

SpriteTiles_51:
	dw SpriteCoords_51
	db $f0, $fd, $f0, $f1, $fd, $f1, $ff

SpriteTiles_52:
	dw SpriteCoords_52
	db $dc, $fd, $f0, $f1, $fd, $ef, $ff

SpriteTiles_53:
	dw SpriteCoords_53
	db $f0, $fd, $dc, $ef, $fd, $f1, $ff

SpriteTiles_54:
	dw SpriteCoords_54
	db $bd, $be, $bb, $bc, $ff

SpriteTiles_55:
	dw SpriteCoords_55
	db $b9, $ba, $da, $db, $ff

SpriteSpec_2c:
	dw SpriteTiles_2c
	db $e0, $f0

SpriteTiles_2c:
	dw SpriteCoords_2c
	db $c0, $c1, $c5, $c6, $cc, $cd, $75, $76, $a4, $a5, $a6, $a7, $54, $55, $56, $57, $44, $45, $46, $47, $a0, $a1, $a2, $a3, $9c, $9d, $9e, $9f, $ff

SpriteSpec_34:
	dw SpriteTiles_34
	db $f8, $e8

SpriteSpec_35:
	dw SpriteTiles_35
	db $f0, $e8

SpriteSpec_38:
	dw SpriteTiles_38
	db $00, $00

SpriteSpec_39:
	dw SpriteTiles_39
	db $00, $00

SpriteSpec_40:
	dw SpriteTiles_40
	db $00, $00

SpriteSpec_41:
	dw SpriteTiles_41
	db $00, $00

SpriteSpec_5c:
	dw SpriteTiles_5c
	db $00, $00

SpriteSpec_5d:
	dw SpriteTiles_5d
	db $00, $00

SpriteSpec_58:
	dw SpriteTiles_58
	db $d8, $f8

SpriteSpec_59:
	dw SpriteTiles_59
	db $e8, $f8

SpriteSpec_5a:
SpriteSpec_5b:
	dw SpriteTiles_5b
	db $f0, $f8

SpriteTiles_34:
	dw SpriteCoords_34
	db $63, $64, $65, $ff

SpriteTiles_35:
	dw SpriteCoords_35
	db $63, $64, $65, $66, $67, $68, $ff

SpriteTiles_38:
	dw SpriteCoords_38
	db $41, $41, $41, $ff

SpriteTiles_39:
	dw SpriteCoords_39
	db $42, $42, $42, $ff

SpriteTiles_40:
	dw SpriteCoords_40
	db $52, $52, $52, $62, $62, $62, $ff

SpriteTiles_41:
	dw SpriteCoords_41
	db $51, $51, $51, $61, $61, $61, $71, $71, $71, $ff

SpriteTiles_56:
	dw SpriteCoords_56
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $63, $64, $fd, $64, $fd, $63, $66, $67, $fd, $67, $fd, $66, $ff

SpriteTiles_57:
	dw SpriteCoords_57
	db $2f, $2f, $63, $64, $ff

SpriteTiles_58:
	dw SpriteCoords_58
	db $00, $fd, $00, $10, $fd, $10, $4f, $fd, $4f, $80, $fd, $80, $80, $fd, $80, $81, $fd, $81, $97, $fd, $97, $ff

SpriteTiles_59:
	dw SpriteCoords_59
	db $98, $fd, $98, $99, $fd, $99, $80, $fd, $80, $9a, $fd, $9a, $9b, $fd, $9b, $ff

SpriteTiles_5a:
SpriteTiles_5b:
	dw SpriteCoords_5b
	db $a8, $fd, $a8, $a9, $fd, $a9, $aa, $fd, $aa, $ab, $fd, $ab, $ff

SpriteTiles_5c:
	dw SpriteCoords_5c
	db $41, $da, $da, $ff

SpriteTiles_5d:
	dw SpriteCoords_5d
	db $52, $da, $62, $ff

SpriteCoords_00:
SpriteCoords_01:
SpriteCoords_02:
SpriteCoords_03:
SpriteCoords_04:
SpriteCoords_05:
SpriteCoords_06:
SpriteCoords_07:
SpriteCoords_08:
SpriteCoords_09:
SpriteCoords_0a:
SpriteCoords_0b:
SpriteCoords_0c:
SpriteCoords_0d:
SpriteCoords_0e:
SpriteCoords_0f:
SpriteCoords_10:
SpriteCoords_11:
SpriteCoords_12:
SpriteCoords_13:
SpriteCoords_14:
SpriteCoords_15:
SpriteCoords_16:
SpriteCoords_17:
SpriteCoords_18:
SpriteCoords_19:
SpriteCoords_1a:
SpriteCoords_1b:
SpriteCoords_2e:
SpriteCoords_2f:
SpriteCoords_3a:
SpriteCoords_3b:
SpriteCoords_56:
	db $00, $00, $00, $08, $00, $10, $00, $18, $08, $00, $08, $08, $08, $10, $08, $18, $10, $00, $10, $08, $10, $10, $10, $18, $18, $00, $18, $08, $18, $10, $18, $18

SpriteCoords_1c:
SpriteCoords_1d:
SpriteCoords_1e:
SpriteCoords_1f:
SpriteCoords_20:
SpriteCoords_21:
SpriteCoords_22:
SpriteCoords_23:
SpriteCoords_24:
SpriteCoords_25:
SpriteCoords_26:
SpriteCoords_27:
SpriteCoords_28:
SpriteCoords_29:
	db $00, $00, $00, $08, $00, $10, $00, $18, $00, $20, $00, $28, $00, $30, $00, $38

SpriteCoords_2a:
SpriteCoords_2b:
SpriteCoords_2d:
SpriteCoords_30:
SpriteCoords_31:
SpriteCoords_32:
SpriteCoords_33:
SpriteCoords_36:
SpriteCoords_37:
SpriteCoords_3c:
SpriteCoords_3d:
SpriteCoords_3e:
SpriteCoords_3f:
SpriteCoords_42:
SpriteCoords_43:
SpriteCoords_44:
SpriteCoords_45:
SpriteCoords_46:
SpriteCoords_47:
SpriteCoords_48:
SpriteCoords_49:
SpriteCoords_4a:
SpriteCoords_4b:
SpriteCoords_4c:
SpriteCoords_4d:
SpriteCoords_4e:
SpriteCoords_4f:
SpriteCoords_50:
SpriteCoords_51:
SpriteCoords_52:
SpriteCoords_53:
SpriteCoords_54:
SpriteCoords_55:
SpriteCoords_57:
SpriteCoords_58:
SpriteCoords_59:
SpriteCoords_5a:
SpriteCoords_5b:
SpriteCoords_5c:
SpriteCoords_5d:
	db $00, $00, $00, $08, $08, $00, $08, $08, $10, $00, $10, $08, $18, $00, $18, $08, $20, $00, $20, $08, $28, $00, $28, $08, $30, $00, $30, $08

SpriteCoords_2c:
	db $00, $08, $00, $10, $08, $08, $08, $10, $10, $00, $10, $08, $10, $10, $10, $18, $18, $00, $18, $08, $18, $10, $18, $18, $20, $00, $20, $08, $20, $10, $20, $18, $28, $00, $28, $08, $28, $10, $28, $18, $30, $00, $30, $08, $30, $10, $30, $18, $38, $00, $38, $08, $38, $10, $38, $18

SpriteCoords_34:
SpriteCoords_35:
SpriteCoords_38:
SpriteCoords_39:
SpriteCoords_40:
SpriteCoords_41:
	db $00, $00, $00, $08, $00, $10, $08, $00, $08, $08, $08, $10, $10, $00, $10, $08, $10, $10

SECTION "Rosy Retrospection Data", ROMX, BANK[$4]
SRS_SpriteData:
	dw SRS_SpriteSpec_00
	dw SRS_SpriteSpec_01
	dw SRS_SpriteSpec_02
	dw SRS_SpriteSpec_03
	dw SRS_SpriteSpec_04
	dw SRS_SpriteSpec_05
	dw SRS_SpriteSpec_06
	dw SRS_SpriteSpec_07
	dw SRS_SpriteSpec_08
	dw SRS_SpriteSpec_09
	dw SRS_SpriteSpec_0a
	dw SRS_SpriteSpec_0b
	dw SRS_SpriteSpec_0c
	dw SRS_SpriteSpec_0d
	dw SRS_SpriteSpec_0e
	dw SRS_SpriteSpec_0f
	dw SRS_SpriteSpec_10
	dw SRS_SpriteSpec_11
	dw SRS_SpriteSpec_12
	dw SRS_SpriteSpec_13
	dw SRS_SpriteSpec_14
	dw SRS_SpriteSpec_15
	dw SRS_SpriteSpec_16
	dw SRS_SpriteSpec_17
	dw SRS_SpriteSpec_18
	dw SRS_SpriteSpec_19
	dw SRS_SpriteSpec_1a
	dw SRS_SpriteSpec_1b
	dw SRS_SpriteSpec_1c
	dw SRS_SpriteSpec_1d
	dw SRS_SpriteSpec_1e
	dw SRS_SpriteSpec_1f
	dw SRS_SpriteSpec_20
	dw SRS_SpriteSpec_21
	dw SRS_SpriteSpec_22
	dw SRS_SpriteSpec_23
	dw SRS_SpriteSpec_24
	dw SRS_SpriteSpec_25
	dw SRS_SpriteSpec_26
	dw SRS_SpriteSpec_27
	dw SRS_SpriteSpec_28
	dw SRS_SpriteSpec_29
	dw SRS_SpriteSpec_2a
	dw SRS_SpriteSpec_2b
	dw SRS_SpriteSpec_2c
	dw SRS_SpriteSpec_2d
	dw SRS_SpriteSpec_2e
	dw SRS_SpriteSpec_2f
	dw SRS_SpriteSpec_30
	dw SRS_SpriteSpec_31
	dw SRS_SpriteSpec_32
	dw SRS_SpriteSpec_33
	dw SRS_SpriteSpec_34
	dw SRS_SpriteSpec_35
	dw SRS_SpriteSpec_36
	dw SRS_SpriteSpec_37
	dw SRS_SpriteSpec_38
	dw SRS_SpriteSpec_39
	dw SRS_SpriteSpec_3a
	dw SRS_SpriteSpec_3b
	dw SRS_SpriteSpec_3c
	dw SRS_SpriteSpec_3d
	dw SRS_SpriteSpec_3e
	dw SRS_SpriteSpec_3f
	dw SRS_SpriteSpec_40
	dw SRS_SpriteSpec_41
	dw SRS_SpriteSpec_42
	dw SRS_SpriteSpec_43
	dw SRS_SpriteSpec_44
	dw SRS_SpriteSpec_45
	dw SRS_SpriteSpec_46
	dw SRS_SpriteSpec_47
	dw SRS_SpriteSpec_48
	dw SRS_SpriteSpec_49
	dw SRS_SpriteSpec_4a
	dw SRS_SpriteSpec_4b
	dw SRS_SpriteSpec_4c
	dw SRS_SpriteSpec_4d
	dw SRS_SpriteSpec_4e
	dw SRS_SpriteSpec_4f
	dw SRS_SpriteSpec_50
	dw SRS_SpriteSpec_51
	dw SRS_SpriteSpec_52
	dw SRS_SpriteSpec_53
	dw SRS_SpriteSpec_54
	dw SRS_SpriteSpec_55
	dw SRS_SpriteSpec_56
	dw SRS_SpriteSpec_57
	dw SRS_SpriteSpec_58
	dw SRS_SpriteSpec_59
	dw SRS_SpriteSpec_5a
	dw SRS_SpriteSpec_5b
	dw SRS_SpriteSpec_5c
	dw SRS_SpriteSpec_5d

SRS_SpriteSpec_00:
	dw SRS_SpriteTiles_00
	db $f7, $f0

SRS_SpriteSpec_01:
	dw SRS_SpriteTiles_01
	db $f7, $f0

SRS_SpriteSpec_02:
	dw SRS_SpriteTiles_02
	db $f7, $f0

SRS_SpriteSpec_03:
	dw SRS_SpriteTiles_03
	db $f7, $f0

SRS_SpriteSpec_04:
	dw SRS_SpriteTiles_04
	db $f7, $f0

SRS_SpriteSpec_05:
	dw SRS_SpriteTiles_05
	db $f7, $f0

SRS_SpriteSpec_06:
	dw SRS_SpriteTiles_06
	db $f7, $f0

SRS_SpriteSpec_07:
	dw SRS_SpriteTiles_07
	db $f7, $f0

SRS_SpriteSpec_08:
	dw SRS_SpriteTiles_08
	db $f7, $f0

SRS_SpriteSpec_09:
	dw SRS_SpriteTiles_09
	db $f7, $f0

SRS_SpriteSpec_0a:
	dw SRS_SpriteTiles_0a
	db $f7, $f0

SRS_SpriteSpec_0b:
	dw SRS_SpriteTiles_0b
	db $f7, $f0

SRS_SpriteSpec_0c:
	dw SRS_SpriteTiles_0c
	db $f7, $f0

SRS_SpriteSpec_0d:
	dw SRS_SpriteTiles_0d
	db $f7, $f0

SRS_SpriteSpec_0e:
	dw SRS_SpriteTiles_0e
	db $f7, $f0

SRS_SpriteSpec_0f:
	dw SRS_SpriteTiles_0f
	db $f7, $f0

SRS_SpriteSpec_10:
	dw SRS_SpriteTiles_10
	db $f7, $f0

SRS_SpriteSpec_11:
	dw SRS_SpriteTiles_11
	db $f7, $f0

SRS_SpriteSpec_12:
	dw SRS_SpriteTiles_12
	db $f7, $f0

SRS_SpriteSpec_13:
	dw SRS_SpriteTiles_13
	db $f7, $f0

SRS_SpriteSpec_14:
	dw SRS_SpriteTiles_14
	db $f7, $f0

SRS_SpriteSpec_15:
	dw SRS_SpriteTiles_15
	db $f7, $f0

SRS_SpriteSpec_16:
	dw SRS_SpriteTiles_16
	db $f7, $f0

SRS_SpriteSpec_17:
	dw SRS_SpriteTiles_17
	db $f7, $f0

SRS_SpriteSpec_18:
	dw SRS_SpriteTiles_18
	db $f7, $f0

SRS_SpriteSpec_19:
	dw SRS_SpriteTiles_19
	db $f7, $f0

SRS_SpriteSpec_1a:
	dw SRS_SpriteTiles_1a
	db $f7, $f0

SRS_SpriteSpec_1b:
	dw SRS_SpriteTiles_1b
	db $f7, $f0

SRS_SpriteSpec_1c:
	dw SRS_SpriteTiles_1c
	db $00, $e8

SRS_SpriteSpec_1d:
	dw SRS_SpriteTiles_1d
	db $00, $e8

SRS_SpriteSpec_1e:
	dw SRS_SpriteTiles_1e
	db $00, $e8

SRS_SpriteSpec_1f:
	dw SRS_SpriteTiles_1f
	db $00, $e8

SRS_SpriteSpec_20:
	dw SRS_SpriteTiles_20
	db $00, $00

SRS_SpriteSpec_21:
	dw SRS_SpriteTiles_21
	db $00, $00

SRS_SpriteSpec_22:
	dw SRS_SpriteTiles_22
	db $00, $00

SRS_SpriteSpec_23:
	dw SRS_SpriteTiles_23
	db $00, $00

SRS_SpriteSpec_24:
	dw SRS_SpriteTiles_24
	db $00, $00

SRS_SpriteSpec_25:
	dw SRS_SpriteTiles_25
	db $00, $00

SRS_SpriteSpec_26:
	dw SRS_SpriteTiles_26
	db $00, $00

SRS_SpriteSpec_27:
	dw SRS_SpriteTiles_27
	db $00, $00

SRS_SpriteSpec_28:
	dw SRS_SpriteTiles_28
	db $00, $00

SRS_SpriteSpec_29:
	dw SRS_SpriteTiles_29
	db $00, $00

SRS_SpriteSpec_2a:
	dw SRS_SpriteTiles_2a
	db $f0, $f8

SRS_SpriteSpec_2b:
SRS_SpriteSpec_2d:
	dw SRS_SpriteTiles_2d
	db $f0, $f8

SRS_SpriteSpec_2e:
	dw SRS_SpriteTiles_2e
	db $f0, $f0

SRS_SpriteSpec_2f:
	dw SRS_SpriteTiles_2f
	db $f0, $f0

SRS_SpriteSpec_30:
	dw SRS_SpriteTiles_30
	db $f8, $f8

SRS_SpriteSpec_31:
	dw SRS_SpriteTiles_31
	db $f8, $f8

SRS_SpriteSpec_32:
	dw SRS_SpriteTiles_32
	db $f8, $f8

SRS_SpriteSpec_33:
	dw SRS_SpriteTiles_33
	db $f8, $f8

SRS_SpriteSpec_36:
	dw SRS_SpriteTiles_36
	db $f0, $f8

SRS_SpriteSpec_37:
	dw SRS_SpriteTiles_37
	db $f0, $f8

SRS_SpriteSpec_3a:
	dw SRS_SpriteTiles_3a
	db $f0, $f0

SRS_SpriteSpec_3b:
	dw SRS_SpriteTiles_3b
	db $f0, $f0

SRS_SpriteSpec_3c:
	dw SRS_SpriteTiles_3c
	db $f8, $f8

SRS_SpriteSpec_3d:
	dw SRS_SpriteTiles_3d
	db $f8, $f8

SRS_SpriteSpec_3e:
	dw SRS_SpriteTiles_3e
	db $f8, $f8

SRS_SpriteSpec_3f:
SRS_SpriteSpec_42:
	dw SRS_SpriteTiles_42
	db $f8, $f8

SRS_SpriteSpec_43:
SRS_SpriteSpec_44:
	dw SRS_SpriteTiles_44
	db $f8, $f8

SRS_SpriteSpec_45:
	dw SRS_SpriteTiles_45
	db $f8, $f8

SRS_SpriteSpec_46:
	dw SRS_SpriteTiles_46
	db $f8, $f8

SRS_SpriteSpec_47:
	dw SRS_SpriteTiles_47
	db $f8, $f8

SRS_SpriteSpec_48:
	dw SRS_SpriteTiles_48
	db $f8, $f8

SRS_SpriteSpec_49:
	dw SRS_SpriteTiles_49
	db $f8, $f8

SRS_SpriteSpec_4a:
	dw SRS_SpriteTiles_4a
	db $f8, $f8

SRS_SpriteSpec_4b:
	dw SRS_SpriteTiles_4b
	db $f8, $f8

SRS_SpriteSpec_4c:
	dw SRS_SpriteTiles_4c
	db $f8, $f8

SRS_SpriteSpec_4d:
	dw SRS_SpriteTiles_4d
	db $f8, $f8

SRS_SpriteSpec_4e:
	dw SRS_SpriteTiles_4e
	db $f8, $f8

SRS_SpriteSpec_4f:
	dw SRS_SpriteTiles_4f
	db $f8, $f8

SRS_SpriteSpec_50:
	dw SRS_SpriteTiles_50
	db $f8, $f8

SRS_SpriteSpec_51:
	dw SRS_SpriteTiles_51
	db $f8, $f8

SRS_SpriteSpec_52:
	dw SRS_SpriteTiles_52
	db $f8, $f8

SRS_SpriteSpec_53:
	dw SRS_SpriteTiles_53
	db $f8, $f8

SRS_SpriteSpec_54:
	dw SRS_SpriteTiles_54
	db $f8, $f8

SRS_SpriteSpec_55:
	dw SRS_SpriteTiles_55
	db $f8, $f8

SRS_SpriteSpec_56:
	dw SRS_SpriteTiles_56
	db $f0, $f0

SRS_SpriteSpec_57:
	dw SRS_SpriteTiles_57
	db $f8, $f8

SRS_SpriteTiles_00:
	dw SRS_SpriteCoords_00
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $84, $fe
	db $84, $84, $84, $fe
	db $ff

SRS_SpriteTiles_01:
	dw SRS_SpriteCoords_01
	db $fe, $fe, $fe, $fe
	db $84, $84, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $ff

SRS_SpriteTiles_02:
	dw SRS_SpriteCoords_02
	db $fe, $fe, $fe, $fe 
	db $fe, $fe, $fe, $fe
	db $84, $84, $84, $fe
	db $84, $ff
	
SRS_SpriteTiles_03:
	dw SRS_SpriteCoords_03
	db $fe, $fe, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $84, $ff
	

SRS_SpriteTiles_04:
	dw SRS_SpriteCoords_04
	db $fe, $fe, $fe, $fe
	db $81, $fe, $fe, $fe
	db $81, $81, $81, $ff

SRS_SpriteTiles_05:
	dw SRS_SpriteCoords_05
	db $fe, $fe, $fe, $fe
	db $fe, $81, $fe, $fe
	db $fe, $81, $fe, $fe
	db $81, $81, $ff

SRS_SpriteTiles_06:
	dw SRS_SpriteCoords_06
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $81, $81, $81, $fe
	db $fe, $fe, $81, $ff

SRS_SpriteTiles_07:
	dw SRS_SpriteCoords_07
	db $fe, $fe, $fe, $fe
	db $fe, $81, $81, $fe
	db $fe, $81, $fe, $fe
	db $fe, $81, $ff

SRS_SpriteTiles_08:
	dw SRS_SpriteCoords_08
	db $fe, $fe, $fe, $fe
	db $8a, $8b, $8b, $8f
	db $ff

SRS_SpriteTiles_09:
	dw SRS_SpriteCoords_09
	db $fe, $80, $fe, $fe
	db $fe, $88, $fe, $fe
	db $fe, $88, $fe, $fe
	db $fe, $89, $ff

SRS_SpriteTiles_0a:
	dw SRS_SpriteCoords_0a
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $8a, $8b, $8b, $8f
	db $ff

SRS_SpriteTiles_0b:
	dw SRS_SpriteCoords_0b
	db $fe, $fe, $80, $fe
	db $fe, $fe, $88, $fe
	db $fe, $fe, $88, $fe
	db $fe, $fe, $89, $ff

SRS_SpriteTiles_0c:
	dw SRS_SpriteCoords_0c
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SRS_SpriteTiles_0d:
	dw SRS_SpriteCoords_0d
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SRS_SpriteTiles_0e:
	dw SRS_SpriteCoords_0e
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SRS_SpriteTiles_0f:
	dw SRS_SpriteCoords_0f
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

SRS_SpriteTiles_10:
	dw SRS_SpriteCoords_10
	db $fe, $fe, $fe, $fe
	db $82, $82, $fe, $fe
	db $fe, $82, $82, $ff

SRS_SpriteTiles_11:
	dw SRS_SpriteCoords_11
	db $fe, $fe, $fe, $fe
	db $fe, $82, $fe, $fe
	db $82, $82, $fe, $fe
	db $82, $ff

SRS_SpriteTiles_12:
	dw SRS_SpriteCoords_12
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $82, $82, $fe, $fe
	db $fe, $82, $82, $ff

SRS_SpriteTiles_13:
	dw SRS_SpriteCoords_13
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $82, $fe
	db $fe, $82, $82, $fe
	db $fe, $82, $ff

SRS_SpriteTiles_14:
	dw SRS_SpriteCoords_14
	db $fe, $fe, $fe, $fe
	db $fe, $86, $86, $fe
	db $86, $86, $ff

SRS_SpriteTiles_15:
	dw SRS_SpriteCoords_15
	db $fe, $fe, $fe, $fe
	db $86, $fe, $fe, $fe
	db $86, $86, $fe, $fe
	db $fe, $86, $ff

SRS_SpriteTiles_16:
	dw SRS_SpriteCoords_16
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $86, $86, $fe
	db $86, $86, $ff

SRS_SpriteTiles_17:
	dw SRS_SpriteCoords_17
	db $fe, $fe, $fe, $fe
	db $fe, $86, $fe, $fe
	db $fe, $86, $86, $fe
	db $fe, $fe, $86, $ff

SRS_SpriteTiles_1a:
	dw SRS_SpriteCoords_1a
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $85, $85, $85, $fe
	db $fe, $85, $ff

SRS_SpriteTiles_1b:
	dw SRS_SpriteCoords_1b
	db $fe, $fe, $fe, $fe
	db $fe, $85, $fe, $fe
	db $fe, $85, $85, $fe
	db $fe, $85, $ff

SRS_SpriteTiles_18:
	dw SRS_SpriteCoords_18
	db $fe, $fe, $fe, $fe
	db $fe, $85, $fe, $fe
	db $85, $85, $85, $ff

SRS_SpriteTiles_19:
	dw SRS_SpriteCoords_19
	db $fe, $fe, $fe, $fe,
    db $fe, $85, $fe, $fe, 
	db $85, $85, $fe, $fe, 
	db $fe, $85, $ff

SRS_SpriteTiles_1c:
	dw SRS_SpriteCoords_1c
	db "A-TYPE", $ff

SRS_SpriteTiles_1d:
	dw SRS_SpriteCoords_1d
	db "B-TYPE", $ff

SRS_SpriteTiles_1e:
	dw SRS_SpriteCoords_1e
	db "C-TYPE", $ff

SRS_SpriteTiles_1f:
	dw SRS_SpriteCoords_1f
	db " OFF  ", $ff

SRS_SpriteTiles_20:
	dw SRS_SpriteCoords_20
	db "0", $ff

SRS_SpriteTiles_21:
	dw SRS_SpriteCoords_21
	db "1", $ff

SRS_SpriteTiles_22:
	dw SRS_SpriteCoords_22
	db "2", $ff

SRS_SpriteTiles_23:
	dw SRS_SpriteCoords_23
	db "3", $ff

SRS_SpriteTiles_24:
	dw SRS_SpriteCoords_24
	db "4", $ff

SRS_SpriteTiles_25:
	dw SRS_SpriteCoords_25
	db "5", $ff

SRS_SpriteTiles_26:
	dw SRS_SpriteCoords_26
	db "6", $ff

SRS_SpriteTiles_27:
	dw SRS_SpriteCoords_27
	db "7", $ff

SRS_SpriteTiles_28:
	dw SRS_SpriteCoords_28
	db "8", $ff

SRS_SpriteTiles_29:
	dw SRS_SpriteCoords_29
	db "9", $ff

SRS_SpriteTiles_2a:
	dw SRS_SpriteCoords_2a
	db $2f, $01, $2f, $11, $20, $21, $30, $31, $ff

SRS_SpriteTiles_2b:
SRS_SpriteTiles_2d:
	dw SRS_SpriteCoords_2d
	db $2f, $03, $12, $13, $22, $23, $32, $33, $ff

SRS_SpriteTiles_2e:
	dw SRS_SpriteCoords_2e
	db $2f, $05, $fd, $05, $2f, $2f, $15, $04, $17, $24, $25, $26, $27, $34, $35, $36, $2f, $ff

SRS_SpriteTiles_2f:
	dw SRS_SpriteCoords_2f
	db $08, $37, $fd, $37, $fd, $08, $18, $19, $14, $1b, $28, $29, $2a, $2b, $60, $70, $36, $2f, $ff

SRS_SpriteTiles_30:
	dw SRS_SpriteCoords_30
	db $b9, $fd, $b9, $ba, $fd, $ba, $ff

SRS_SpriteTiles_31:
	dw SRS_SpriteCoords_31
	db $82, $fd, $82, $83, $fd, $83, $ff

SRS_SpriteTiles_32:
	dw SRS_SpriteCoords_32
	db $09, $0a, $3a, $3b, $ff

SRS_SpriteTiles_33:
	dw SRS_SpriteCoords_33
	db $0b, $40, $7c, $6f, $ff

SRS_SpriteTiles_36:
	dw SRS_SpriteCoords_36
	db $2f, $0f, $2f, $1f, $5f, $2c, $2f, $3f, $ff

SRS_SpriteTiles_37:
	dw SRS_SpriteCoords_37
	db $6c, $3c, $4b, $4c, $5b, $5c, $6b, $2f, $ff

SRS_SpriteTiles_3a:
	dw SRS_SpriteCoords_3a
	db $2f, $4d, $fd, $4d, $2f, $2f, $5d, $5e, $4e, $5f, $6d, $6e, $2f, $2f, $7d, $fd, $7d, $2f, $ff

SRS_SpriteTiles_3b:
	dw SRS_SpriteCoords_3b
	db $08, $77, $fd, $77, $fd, $08, $18, $78, $43, $53, $7a, $7b, $50, $2f, $2f, $02, $fd, $7d, $2f, $ff

SRS_SpriteTiles_3c:
	dw SRS_SpriteCoords_3c
	db $b9, $fd, $b9, $ba, $fd, $ba, $ff

SRS_SpriteTiles_3d:
	dw SRS_SpriteCoords_3d
	db $82, $fd, $82, $83, $fd, $83, $ff

SRS_SpriteTiles_3e:
	dw SRS_SpriteCoords_3e
	db $09, $0a, $3a, $3b, $ff

SRS_SpriteTiles_3f:
SRS_SpriteTiles_42:
	dw SRS_SpriteCoords_42
	db $0b, $40, $7c, $6f, $ff

SRS_SpriteTiles_43:
SRS_SpriteTiles_44:
	dw SRS_SpriteCoords_44
	db $dc, $dd, $e0, $e1, $ff

SRS_SpriteTiles_45:
	dw SRS_SpriteCoords_45
	db $de, $df, $e0, $e1, $ff

SRS_SpriteTiles_46:
	dw SRS_SpriteCoords_46
	db $de, $e2, $e0, $e4, $ff

SRS_SpriteTiles_47:
	dw SRS_SpriteCoords_47
	db $dc, $ee, $e0, $e3, $ff

SRS_SpriteTiles_48:
	dw SRS_SpriteCoords_48
	db $e5, $e6, $e7, $e8, $ff

SRS_SpriteTiles_49:
	dw SRS_SpriteCoords_49
	db $fd, $e6, $fd, $e5, $fd, $e8, $fd, $e7, $ff

SRS_SpriteTiles_4a:
	dw SRS_SpriteCoords_4a
	db $e9, $ea, $eb, $ec, $ff

SRS_SpriteTiles_4b:
	dw SRS_SpriteCoords_4b
	db $ed, $ea, $eb, $ec, $ff

SRS_SpriteTiles_4c:
	dw SRS_SpriteCoords_4c
	db $f2, $f4, $f3, $bf, $ff

SRS_SpriteTiles_4d:
	dw SRS_SpriteCoords_4d
	db $f4, $f2, $bf, $f3, $ff

SRS_SpriteTiles_4e:
	dw SRS_SpriteCoords_4e
	db $c2, $fd, $c2, $c3, $fd, $c3, $ff

SRS_SpriteTiles_4f:
	dw SRS_SpriteCoords_4f
	db $c4, $fd, $c4, $c5, $fd, $c5, $ff

SRS_SpriteTiles_50:
	dw SRS_SpriteCoords_50
	db $dc, $fd, $dc, $ef, $fd, $ef, $ff

SRS_SpriteTiles_51:
	dw SRS_SpriteCoords_51
	db $f0, $fd, $f0, $f1, $fd, $f1, $ff

SRS_SpriteTiles_52:
	dw SRS_SpriteCoords_52
	db $dc, $fd, $f0, $f1, $fd, $ef, $ff

SRS_SpriteTiles_53:
	dw SRS_SpriteCoords_53
	db $f0, $fd, $dc, $ef, $fd, $f1, $ff

SRS_SpriteTiles_54:
	dw SRS_SpriteCoords_54
	db $bd, $be, $bb, $bc, $ff

SRS_SpriteTiles_55:
	dw SRS_SpriteCoords_55
	db $b9, $ba, $da, $db, $ff

SRS_SpriteSpec_2c:
	dw SRS_SpriteTiles_2c
	db $e0, $f0

SRS_SpriteTiles_2c:
	dw SRS_SpriteCoords_2c
	db $c0, $c1, $c5, $c6, $cc, $cd, $75, $76, $a4, $a5, $a6, $a7, $54, $55, $56, $57, $44, $45, $46, $47, $a0, $a1, $a2, $a3, $9c, $9d, $9e, $9f, $ff

SRS_SpriteSpec_34:
	dw SRS_SpriteTiles_34
	db $f8, $e8

SRS_SpriteSpec_35:
	dw SRS_SpriteTiles_35
	db $f0, $e8

SRS_SpriteSpec_38:
	dw SRS_SpriteTiles_38
	db $00, $00

SRS_SpriteSpec_39:
	dw SRS_SpriteTiles_39
	db $00, $00

SRS_SpriteSpec_40:
	dw SRS_SpriteTiles_40
	db $00, $00

SRS_SpriteSpec_41:
	dw SRS_SpriteTiles_41
	db $00, $00

SRS_SpriteSpec_5c:
	dw SRS_SpriteTiles_5c
	db $00, $00

SRS_SpriteSpec_5d:
	dw SRS_SpriteTiles_5d
	db $00, $00

SRS_SpriteSpec_58:
	dw SRS_SpriteTiles_58
	db $d8, $f8

SRS_SpriteSpec_59:
	dw SRS_SpriteTiles_59
	db $e8, $f8

SRS_SpriteSpec_5a:
SRS_SpriteSpec_5b:
	dw SRS_SpriteTiles_5b
	db $f0, $f8

SRS_SpriteTiles_34:
	dw SRS_SpriteCoords_34
	db $63, $64, $65, $ff

SRS_SpriteTiles_35:
	dw SRS_SpriteCoords_35
	db $63, $64, $65, $66, $67, $68, $ff

SRS_SpriteTiles_38:
	dw SRS_SpriteCoords_38
	db $41, $41, $41, $ff

SRS_SpriteTiles_39:
	dw SRS_SpriteCoords_39
	db $42, $42, $42, $ff

SRS_SpriteTiles_40:
	dw SRS_SpriteCoords_40
	db $52, $52, $52, $62, $62, $62, $ff

SRS_SpriteTiles_41:
	dw SRS_SpriteCoords_41
	db $51, $51, $51, $61, $61, $61, $71, $71, $71, $ff

SRS_SpriteTiles_56:
	dw SRS_SpriteCoords_56
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $63, $64, $fd, $64, $fd, $63, $66, $67, $fd, $67, $fd, $66, $ff

SRS_SpriteTiles_57:
	dw SRS_SpriteCoords_57
	db $2f, $2f, $63, $64, $ff

SRS_SpriteTiles_58:
	dw SRS_SpriteCoords_58
	db $00, $fd, $00, $10, $fd, $10, $4f, $fd, $4f, $80, $fd, $80, $80, $fd, $80, $81, $fd, $81, $97, $fd, $97, $ff

SRS_SpriteTiles_59:
	dw SRS_SpriteCoords_59
	db $98, $fd, $98, $99, $fd, $99, $80, $fd, $80, $9a, $fd, $9a, $9b, $fd, $9b, $ff

SRS_SpriteTiles_5a:
SRS_SpriteTiles_5b:
	dw SRS_SpriteCoords_5b
	db $a8, $fd, $a8, $a9, $fd, $a9, $aa, $fd, $aa, $ab, $fd, $ab, $ff

SRS_SpriteTiles_5c:
	dw SRS_SpriteCoords_5c
	db $41, $da, $da, $ff

SRS_SpriteTiles_5d:
	dw SRS_SpriteCoords_5d
	db $52, $da, $62, $ff

SRS_SpriteCoords_00:
SRS_SpriteCoords_01:
SRS_SpriteCoords_02:
SRS_SpriteCoords_03:
SRS_SpriteCoords_04:
SRS_SpriteCoords_05:
SRS_SpriteCoords_06:
SRS_SpriteCoords_07:
SRS_SpriteCoords_08:
SRS_SpriteCoords_09:
SRS_SpriteCoords_0a:
SRS_SpriteCoords_0b:
SRS_SpriteCoords_0c:
SRS_SpriteCoords_0d:
SRS_SpriteCoords_0e:
SRS_SpriteCoords_0f:
SRS_SpriteCoords_10:
SRS_SpriteCoords_11:
SRS_SpriteCoords_12:
SRS_SpriteCoords_13:
SRS_SpriteCoords_14:
SRS_SpriteCoords_15:
SRS_SpriteCoords_16:
SRS_SpriteCoords_17:
SRS_SpriteCoords_18:
SRS_SpriteCoords_19:
SRS_SpriteCoords_1a:
SRS_SpriteCoords_1b:
SRS_SpriteCoords_2e:
SRS_SpriteCoords_2f:
SRS_SpriteCoords_3a:
SRS_SpriteCoords_3b:
SRS_SpriteCoords_56:
	db $00, $00, $00, $08, $00, $10, $00, $18, $08, $00, $08, $08, $08, $10, $08, $18, $10, $00, $10, $08, $10, $10, $10, $18, $18, $00, $18, $08, $18, $10, $18, $18

SRS_SpriteCoords_1c:
SRS_SpriteCoords_1d:
SRS_SpriteCoords_1e:
SRS_SpriteCoords_1f:
SRS_SpriteCoords_20:
SRS_SpriteCoords_21:
SRS_SpriteCoords_22:
SRS_SpriteCoords_23:
SRS_SpriteCoords_24:
SRS_SpriteCoords_25:
SRS_SpriteCoords_26:
SRS_SpriteCoords_27:
SRS_SpriteCoords_28:
SRS_SpriteCoords_29:
	db $00, $00, $00, $08, $00, $10, $00, $18, $00, $20, $00, $28, $00, $30, $00, $38

SRS_SpriteCoords_2a:
SRS_SpriteCoords_2b:
SRS_SpriteCoords_2d:
SRS_SpriteCoords_30:
SRS_SpriteCoords_31:
SRS_SpriteCoords_32:
SRS_SpriteCoords_33:
SRS_SpriteCoords_36:
SRS_SpriteCoords_37:
SRS_SpriteCoords_3c:
SRS_SpriteCoords_3d:
SRS_SpriteCoords_3e:
SRS_SpriteCoords_3f:
SRS_SpriteCoords_42:
SRS_SpriteCoords_43:
SRS_SpriteCoords_44:
SRS_SpriteCoords_45:
SRS_SpriteCoords_46:
SRS_SpriteCoords_47:
SRS_SpriteCoords_48:
SRS_SpriteCoords_49:
SRS_SpriteCoords_4a:
SRS_SpriteCoords_4b:
SRS_SpriteCoords_4c:
SRS_SpriteCoords_4d:
SRS_SpriteCoords_4e:
SRS_SpriteCoords_4f:
SRS_SpriteCoords_50:
SRS_SpriteCoords_51:
SRS_SpriteCoords_52:
SRS_SpriteCoords_53:
SRS_SpriteCoords_54:
SRS_SpriteCoords_55:
SRS_SpriteCoords_57:
SRS_SpriteCoords_58:
SRS_SpriteCoords_59:
SRS_SpriteCoords_5a:
SRS_SpriteCoords_5b:
SRS_SpriteCoords_5c:
SRS_SpriteCoords_5d:
	db $00, $00, $00, $08, $08, $00, $08, $08, $10, $00, $10, $08, $18, $00, $18, $08, $20, $00, $20, $08, $28, $00, $28, $08, $30, $00, $30, $08

SRS_SpriteCoords_2c:
	db $00, $08, $00, $10, $08, $08, $08, $10, $10, $00, $10, $08, $10, $10, $10, $18, $18, $00, $18, $08, $18, $10, $18, $18, $20, $00, $20, $08, $20, $10, $20, $18, $28, $00, $28, $08, $28, $10, $28, $18, $30, $00, $30, $08, $30, $10, $30, $18, $38, $00, $38, $08, $38, $10, $38, $18

SRS_SpriteCoords_34:
SRS_SpriteCoords_35:
SRS_SpriteCoords_38:
SRS_SpriteCoords_39:
SRS_SpriteCoords_40:
SRS_SpriteCoords_41:
	db $00, $00, $00, $08, $00, $10, $08, $00, $08, $08, $08, $10, $10, $00, $10, $08, $10, $10
SECTION "Rosy Retrospection Data CR", ROMX, BANK[$5]
ARS_SpriteData:
	dw ARS_SpriteSpec_00
	dw ARS_SpriteSpec_01
	dw ARS_SpriteSpec_02
	dw ARS_SpriteSpec_03
	dw ARS_SpriteSpec_04
	dw ARS_SpriteSpec_05
	dw ARS_SpriteSpec_06
	dw ARS_SpriteSpec_07
	dw ARS_SpriteSpec_08
	dw ARS_SpriteSpec_09
	dw ARS_SpriteSpec_0a
	dw ARS_SpriteSpec_0b
	dw ARS_SpriteSpec_0c
	dw ARS_SpriteSpec_0d
	dw ARS_SpriteSpec_0e
	dw ARS_SpriteSpec_0f
	dw ARS_SpriteSpec_10
	dw ARS_SpriteSpec_11
	dw ARS_SpriteSpec_12
	dw ARS_SpriteSpec_13
	dw ARS_SpriteSpec_14
	dw ARS_SpriteSpec_15
	dw ARS_SpriteSpec_16
	dw ARS_SpriteSpec_17
	dw ARS_SpriteSpec_18
	dw ARS_SpriteSpec_19
	dw ARS_SpriteSpec_1a
	dw ARS_SpriteSpec_1b
	dw ARS_SpriteSpec_1c
	dw ARS_SpriteSpec_1d
	dw ARS_SpriteSpec_1e
	dw ARS_SpriteSpec_1f
	dw ARS_SpriteSpec_20
	dw ARS_SpriteSpec_21
	dw ARS_SpriteSpec_22
	dw ARS_SpriteSpec_23
	dw ARS_SpriteSpec_24
	dw ARS_SpriteSpec_25
	dw ARS_SpriteSpec_26
	dw ARS_SpriteSpec_27
	dw ARS_SpriteSpec_28
	dw ARS_SpriteSpec_29
	dw ARS_SpriteSpec_2a
	dw ARS_SpriteSpec_2b
	dw ARS_SpriteSpec_2c
	dw ARS_SpriteSpec_2d
	dw ARS_SpriteSpec_2e
	dw ARS_SpriteSpec_2f
	dw ARS_SpriteSpec_30
	dw ARS_SpriteSpec_31
	dw ARS_SpriteSpec_32
	dw ARS_SpriteSpec_33
	dw ARS_SpriteSpec_34
	dw ARS_SpriteSpec_35
	dw ARS_SpriteSpec_36
	dw ARS_SpriteSpec_37
	dw ARS_SpriteSpec_38
	dw ARS_SpriteSpec_39
	dw ARS_SpriteSpec_3a
	dw ARS_SpriteSpec_3b
	dw ARS_SpriteSpec_3c
	dw ARS_SpriteSpec_3d
	dw ARS_SpriteSpec_3e
	dw ARS_SpriteSpec_3f
	dw ARS_SpriteSpec_40
	dw ARS_SpriteSpec_41
	dw ARS_SpriteSpec_42
	dw ARS_SpriteSpec_43
	dw ARS_SpriteSpec_44
	dw ARS_SpriteSpec_45
	dw ARS_SpriteSpec_46
	dw ARS_SpriteSpec_47
	dw ARS_SpriteSpec_48
	dw ARS_SpriteSpec_49
	dw ARS_SpriteSpec_4a
	dw ARS_SpriteSpec_4b
	dw ARS_SpriteSpec_4c
	dw ARS_SpriteSpec_4d
	dw ARS_SpriteSpec_4e
	dw ARS_SpriteSpec_4f
	dw ARS_SpriteSpec_50
	dw ARS_SpriteSpec_51
	dw ARS_SpriteSpec_52
	dw ARS_SpriteSpec_53
	dw ARS_SpriteSpec_54
	dw ARS_SpriteSpec_55
	dw ARS_SpriteSpec_56
	dw ARS_SpriteSpec_57
	dw ARS_SpriteSpec_58
	dw ARS_SpriteSpec_59
	dw ARS_SpriteSpec_5a
	dw ARS_SpriteSpec_5b
	dw ARS_SpriteSpec_5c
	dw ARS_SpriteSpec_5d

ARS_SpriteSpec_00:
	dw ARS_SpriteTiles_00
	db $ef, $f0

ARS_SpriteSpec_01:
	dw ARS_SpriteTiles_01
	db $ef, $f0

ARS_SpriteSpec_02:
	dw ARS_SpriteTiles_02
	db $ef, $f0

ARS_SpriteSpec_03:
	dw ARS_SpriteTiles_03
	db $ef, $f0

ARS_SpriteSpec_04:
	dw ARS_SpriteTiles_04
	db $ef, $f0

ARS_SpriteSpec_05:
	dw ARS_SpriteTiles_05
	db $ef, $f0

ARS_SpriteSpec_06:
	dw ARS_SpriteTiles_06
	db $ef, $f0

ARS_SpriteSpec_07:
	dw ARS_SpriteTiles_07
	db $ef, $f0

ARS_SpriteSpec_08:
	dw ARS_SpriteTiles_08
	db $f7, $f0

ARS_SpriteSpec_09:
	dw ARS_SpriteTiles_09
	db $f7, $f0

ARS_SpriteSpec_0a:
	dw ARS_SpriteTiles_0a
	db $f7, $f0

ARS_SpriteSpec_0b:
	dw ARS_SpriteTiles_0b
	db $f7, $f0

ARS_SpriteSpec_0c:
	dw ARS_SpriteTiles_0c
	db $ef, $f0

ARS_SpriteSpec_0d:
	dw ARS_SpriteTiles_0d
	db $ef, $f0

ARS_SpriteSpec_0e:
	dw ARS_SpriteTiles_0e
	db $ef, $f0

ARS_SpriteSpec_0f:
	dw ARS_SpriteTiles_0f
	db $ef, $f0

ARS_SpriteSpec_10:
	dw ARS_SpriteTiles_10
	db $ef, $f0

ARS_SpriteSpec_11:
	dw ARS_SpriteTiles_11
	db $ef, $f0

ARS_SpriteSpec_12:
	dw ARS_SpriteTiles_12
	db $ef, $f0

ARS_SpriteSpec_13:
	dw ARS_SpriteTiles_13
	db $ef, $f0

ARS_SpriteSpec_14:
	dw ARS_SpriteTiles_14
	db $ef, $f0

ARS_SpriteSpec_15:
	dw ARS_SpriteTiles_15
	db $ef, $f0

ARS_SpriteSpec_16:
	dw ARS_SpriteTiles_16
	db $ef, $f0

ARS_SpriteSpec_17:
	dw ARS_SpriteTiles_17
	db $ef, $f0

ARS_SpriteSpec_18:
	dw ARS_SpriteTiles_18
	db $ef, $f0

ARS_SpriteSpec_19:
	dw ARS_SpriteTiles_19
	db $ef, $f0

ARS_SpriteSpec_1a:
	dw ARS_SpriteTiles_1a
	db $ef, $f0

ARS_SpriteSpec_1b:
	dw ARS_SpriteTiles_1b
	db $ef, $f0

ARS_SpriteSpec_1c:
	dw ARS_SpriteTiles_1c
	db $00, $e8

ARS_SpriteSpec_1d:
	dw ARS_SpriteTiles_1d
	db $00, $e8

ARS_SpriteSpec_1e:
	dw ARS_SpriteTiles_1e
	db $00, $e8

ARS_SpriteSpec_1f:
	dw ARS_SpriteTiles_1f
	db $00, $e8

ARS_SpriteSpec_20:
	dw ARS_SpriteTiles_20
	db $00, $00

ARS_SpriteSpec_21:
	dw ARS_SpriteTiles_21
	db $00, $00

ARS_SpriteSpec_22:
	dw ARS_SpriteTiles_22
	db $00, $00

ARS_SpriteSpec_23:
	dw ARS_SpriteTiles_23
	db $00, $00

ARS_SpriteSpec_24:
	dw ARS_SpriteTiles_24
	db $00, $00

ARS_SpriteSpec_25:
	dw ARS_SpriteTiles_25
	db $00, $00

ARS_SpriteSpec_26:
	dw ARS_SpriteTiles_26
	db $00, $00

ARS_SpriteSpec_27:
	dw ARS_SpriteTiles_27
	db $00, $00

ARS_SpriteSpec_28:
	dw ARS_SpriteTiles_28
	db $00, $00

ARS_SpriteSpec_29:
	dw ARS_SpriteTiles_29
	db $00, $00

ARS_SpriteSpec_2a:
	dw ARS_SpriteTiles_2a
	db $f0, $f8

ARS_SpriteSpec_2b:
ARS_SpriteSpec_2d:
	dw ARS_SpriteTiles_2d
	db $f0, $f8

ARS_SpriteSpec_2e:
	dw ARS_SpriteTiles_2e
	db $f0, $f0

ARS_SpriteSpec_2f:
	dw ARS_SpriteTiles_2f
	db $f0, $f0

ARS_SpriteSpec_30:
	dw ARS_SpriteTiles_30
	db $f8, $f8

ARS_SpriteSpec_31:
	dw ARS_SpriteTiles_31
	db $f8, $f8

ARS_SpriteSpec_32:
	dw ARS_SpriteTiles_32
	db $f8, $f8

ARS_SpriteSpec_33:
	dw ARS_SpriteTiles_33
	db $f8, $f8

ARS_SpriteSpec_36:
	dw ARS_SpriteTiles_36
	db $f0, $f8

ARS_SpriteSpec_37:
	dw ARS_SpriteTiles_37
	db $f0, $f8

ARS_SpriteSpec_3a:
	dw ARS_SpriteTiles_3a
	db $f0, $f0

ARS_SpriteSpec_3b:
	dw ARS_SpriteTiles_3b
	db $f0, $f0

ARS_SpriteSpec_3c:
	dw ARS_SpriteTiles_3c
	db $f8, $f8

ARS_SpriteSpec_3d:
	dw ARS_SpriteTiles_3d
	db $f8, $f8

ARS_SpriteSpec_3e:
	dw ARS_SpriteTiles_3e
	db $f8, $f8

ARS_SpriteSpec_3f:
ARS_SpriteSpec_42:
	dw ARS_SpriteTiles_42
	db $f8, $f8

ARS_SpriteSpec_43:
ARS_SpriteSpec_44:
	dw ARS_SpriteTiles_44
	db $f8, $f8

ARS_SpriteSpec_45:
	dw ARS_SpriteTiles_45
	db $f8, $f8

ARS_SpriteSpec_46:
	dw ARS_SpriteTiles_46
	db $f8, $f8

ARS_SpriteSpec_47:
	dw ARS_SpriteTiles_47
	db $f8, $f8

ARS_SpriteSpec_48:
	dw ARS_SpriteTiles_48
	db $f8, $f8

ARS_SpriteSpec_49:
	dw ARS_SpriteTiles_49
	db $f8, $f8

ARS_SpriteSpec_4a:
	dw ARS_SpriteTiles_4a
	db $f8, $f8

ARS_SpriteSpec_4b:
	dw ARS_SpriteTiles_4b
	db $f8, $f8

ARS_SpriteSpec_4c:
	dw ARS_SpriteTiles_4c
	db $f8, $f8

ARS_SpriteSpec_4d:
	dw ARS_SpriteTiles_4d
	db $f8, $f8

ARS_SpriteSpec_4e:
	dw ARS_SpriteTiles_4e
	db $f8, $f8

ARS_SpriteSpec_4f:
	dw ARS_SpriteTiles_4f
	db $f8, $f8

ARS_SpriteSpec_50:
	dw ARS_SpriteTiles_50
	db $f8, $f8

ARS_SpriteSpec_51:
	dw ARS_SpriteTiles_51
	db $f8, $f8

ARS_SpriteSpec_52:
	dw ARS_SpriteTiles_52
	db $f8, $f8

ARS_SpriteSpec_53:
	dw ARS_SpriteTiles_53
	db $f8, $f8

ARS_SpriteSpec_54:
	dw ARS_SpriteTiles_54
	db $f8, $f8

ARS_SpriteSpec_55:
	dw ARS_SpriteTiles_55
	db $f8, $f8

ARS_SpriteSpec_56:
	dw ARS_SpriteTiles_56
	db $f0, $f0

ARS_SpriteSpec_57:
	dw ARS_SpriteTiles_57
	db $f8, $f8

ARS_SpriteTiles_00:
	dw ARS_SpriteCoords_00
	db $fe, $fe, $fe, $fe 
	db $fe, $fe, $fe, $fe
	db $84, $84, $84, $fe
	db $84, $ff

ARS_SpriteTiles_01:
	dw ARS_SpriteCoords_01
	db $fe, $fe, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $84, $ff

ARS_SpriteTiles_02:
	dw ARS_SpriteCoords_02
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $84, $fe
	db $84, $84, $84, $fe
	db $ff

ARS_SpriteTiles_03:
	dw ARS_SpriteCoords_03
	db $fe, $fe, $fe, $fe
	db $84, $84, $fe, $fe
	db $fe, $84, $fe, $fe
	db $fe, $84, $ff

ARS_SpriteTiles_04:
	dw ARS_SpriteCoords_04
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $81, $81, $81, $fe
	db $fe, $fe, $81, $ff

ARS_SpriteTiles_05:
	dw ARS_SpriteCoords_05
	db $fe, $fe, $fe, $fe
	db $fe, $81, $81, $fe
	db $fe, $81, $fe, $fe
	db $fe, $81, $ff

ARS_SpriteTiles_06:
	dw ARS_SpriteCoords_06
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $81, $fe, $fe, $fe
	db $81, $81, $81, $ff

ARS_SpriteTiles_07:
	dw ARS_SpriteCoords_07
	db $fe, $fe, $fe, $fe
	db $fe, $81, $fe, $fe
	db $fe, $81, $fe, $fe
	db $81, $81, $ff

ARS_SpriteTiles_08:
	dw ARS_SpriteCoords_08
	db $fe, $fe, $fe, $fe
	db $8a, $8b, $8b, $8f
	db $ff

ARS_SpriteTiles_09:
	dw ARS_SpriteCoords_09
	db $fe, $fe, $80, $fe
	db $fe, $fe, $88, $fe
	db $fe, $fe, $88, $fe
	db $fe, $fe, $89, $ff

ARS_SpriteTiles_0a:
	dw ARS_SpriteCoords_0a
	db $fe, $fe, $fe, $fe
	db $8a, $8b, $8b, $8f
	db $ff

ARS_SpriteTiles_0b:
	dw ARS_SpriteCoords_0b
	db $fe, $fe, $80, $fe
	db $fe, $fe, $88, $fe
	db $fe, $fe, $88, $fe
	db $fe, $fe, $89, $ff

ARS_SpriteTiles_0c:
	dw ARS_SpriteCoords_0c
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

ARS_SpriteTiles_0d:
	dw ARS_SpriteCoords_0d
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

ARS_SpriteTiles_0e:
	dw ARS_SpriteCoords_0e
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

ARS_SpriteTiles_0f:
	dw ARS_SpriteCoords_0f
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $83, $83, $fe
	db $fe, $83, $83, $ff

ARS_SpriteTiles_10:
	dw ARS_SpriteCoords_10
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $82, $82, $fe, $fe
	db $fe, $82, $82, $ff

ARS_SpriteTiles_11:
	dw ARS_SpriteCoords_11
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $82, $fe
	db $fe, $82, $82, $fe
	db $fe, $82, $ff

ARS_SpriteTiles_12:
	dw ARS_SpriteCoords_12
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $82, $82, $fe, $fe
	db $fe, $82, $82, $ff

ARS_SpriteTiles_13:
	dw ARS_SpriteCoords_13
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $82, $fe
	db $fe, $82, $82, $fe
	db $fe, $82, $ff

ARS_SpriteTiles_14:
	dw ARS_SpriteCoords_14
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $86, $86, $fe
	db $86, $86, $ff

ARS_SpriteTiles_15:
	dw ARS_SpriteCoords_15
	db $fe, $fe, $fe, $fe
	db $86, $fe, $fe, $fe
	db $86, $86, $fe, $fe
	db $fe, $86, $ff

ARS_SpriteTiles_16:
	dw ARS_SpriteCoords_16
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $86, $86, $fe
	db $86, $86, $ff

ARS_SpriteTiles_17:
	dw ARS_SpriteCoords_17
	db $fe, $fe, $fe, $fe
	db $86, $fe, $fe, $fe
	db $86, $86, $fe, $fe
	db $fe, $86, $ff

ARS_SpriteTiles_1a:
	dw ARS_SpriteCoords_1a
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $fe, $85, $fe, $fe
	db $85, $85, $85, $ff

ARS_SpriteTiles_1b:
	dw ARS_SpriteCoords_1b
	db $fe, $fe, $fe, $fe,
    db $fe, $85, $fe, $fe, 
	db $85, $85, $fe, $fe, 
	db $fe, $85, $ff

ARS_SpriteTiles_18:
	dw ARS_SpriteCoords_18
	db $fe, $fe, $fe, $fe
	db $fe, $fe, $fe, $fe
	db $85, $85, $85, $fe
	db $fe, $85, $ff

ARS_SpriteTiles_19:
	dw ARS_SpriteCoords_19
	db $fe, $fe, $fe, $fe
	db $fe, $85, $fe, $fe
	db $fe, $85, $85, $fe
	db $fe, $85, $ff

ARS_SpriteTiles_1c:
	dw ARS_SpriteCoords_1c
	db "A-TYPE", $ff

ARS_SpriteTiles_1d:
	dw ARS_SpriteCoords_1d
	db "B-TYPE", $ff

ARS_SpriteTiles_1e:
	dw ARS_SpriteCoords_1e
	db "C-TYPE", $ff

ARS_SpriteTiles_1f:
	dw ARS_SpriteCoords_1f
	db " OFF  ", $ff

ARS_SpriteTiles_20:
	dw ARS_SpriteCoords_20
	db "0", $ff

ARS_SpriteTiles_21:
	dw ARS_SpriteCoords_21
	db "1", $ff

ARS_SpriteTiles_22:
	dw ARS_SpriteCoords_22
	db "2", $ff

ARS_SpriteTiles_23:
	dw ARS_SpriteCoords_23
	db "3", $ff

ARS_SpriteTiles_24:
	dw ARS_SpriteCoords_24
	db "4", $ff

ARS_SpriteTiles_25:
	dw ARS_SpriteCoords_25
	db "5", $ff

ARS_SpriteTiles_26:
	dw ARS_SpriteCoords_26
	db "6", $ff

ARS_SpriteTiles_27:
	dw ARS_SpriteCoords_27
	db "7", $ff

ARS_SpriteTiles_28:
	dw ARS_SpriteCoords_28
	db "8", $ff

ARS_SpriteTiles_29:
	dw ARS_SpriteCoords_29
	db "9", $ff

ARS_SpriteTiles_2a:
	dw ARS_SpriteCoords_2a
	db $2f, $01, $2f, $11, $20, $21, $30, $31, $ff

ARS_SpriteTiles_2b:
ARS_SpriteTiles_2d:
	dw ARS_SpriteCoords_2d
	db $2f, $03, $12, $13, $22, $23, $32, $33, $ff

ARS_SpriteTiles_2e:
	dw ARS_SpriteCoords_2e
	db $2f, $05, $fd, $05, $2f, $2f, $15, $04, $17, $24, $25, $26, $27, $34, $35, $36, $2f, $ff

ARS_SpriteTiles_2f:
	dw ARS_SpriteCoords_2f
	db $08, $37, $fd, $37, $fd, $08, $18, $19, $14, $1b, $28, $29, $2a, $2b, $60, $70, $36, $2f, $ff

ARS_SpriteTiles_30:
	dw ARS_SpriteCoords_30
	db $b9, $fd, $b9, $ba, $fd, $ba, $ff

ARS_SpriteTiles_31:
	dw ARS_SpriteCoords_31
	db $82, $fd, $82, $83, $fd, $83, $ff

ARS_SpriteTiles_32:
	dw ARS_SpriteCoords_32
	db $09, $0a, $3a, $3b, $ff

ARS_SpriteTiles_33:
	dw ARS_SpriteCoords_33
	db $0b, $40, $7c, $6f, $ff

ARS_SpriteTiles_36:
	dw ARS_SpriteCoords_36
	db $2f, $0f, $2f, $1f, $5f, $2c, $2f, $3f, $ff

ARS_SpriteTiles_37:
	dw ARS_SpriteCoords_37
	db $6c, $3c, $4b, $4c, $5b, $5c, $6b, $2f, $ff

ARS_SpriteTiles_3a:
	dw ARS_SpriteCoords_3a
	db $2f, $4d, $fd, $4d, $2f, $2f, $5d, $5e, $4e, $5f, $6d, $6e, $2f, $2f, $7d, $fd, $7d, $2f, $ff

ARS_SpriteTiles_3b:
	dw ARS_SpriteCoords_3b
	db $08, $77, $fd, $77, $fd, $08, $18, $78, $43, $53, $7a, $7b, $50, $2f, $2f, $02, $fd, $7d, $2f, $ff

ARS_SpriteTiles_3c:
	dw ARS_SpriteCoords_3c
	db $b9, $fd, $b9, $ba, $fd, $ba, $ff

ARS_SpriteTiles_3d:
	dw ARS_SpriteCoords_3d
	db $82, $fd, $82, $83, $fd, $83, $ff

ARS_SpriteTiles_3e:
	dw ARS_SpriteCoords_3e
	db $09, $0a, $3a, $3b, $ff

ARS_SpriteTiles_3f:
ARS_SpriteTiles_42:
	dw ARS_SpriteCoords_42
	db $0b, $40, $7c, $6f, $ff

ARS_SpriteTiles_43:
ARS_SpriteTiles_44:
	dw ARS_SpriteCoords_44
	db $dc, $dd, $e0, $e1, $ff

ARS_SpriteTiles_45:
	dw ARS_SpriteCoords_45
	db $de, $df, $e0, $e1, $ff

ARS_SpriteTiles_46:
	dw ARS_SpriteCoords_46
	db $de, $e2, $e0, $e4, $ff

ARS_SpriteTiles_47:
	dw ARS_SpriteCoords_47
	db $dc, $ee, $e0, $e3, $ff

ARS_SpriteTiles_48:
	dw ARS_SpriteCoords_48
	db $e5, $e6, $e7, $e8, $ff

ARS_SpriteTiles_49:
	dw ARS_SpriteCoords_49
	db $fd, $e6, $fd, $e5, $fd, $e8, $fd, $e7, $ff

ARS_SpriteTiles_4a:
	dw ARS_SpriteCoords_4a
	db $e9, $ea, $eb, $ec, $ff

ARS_SpriteTiles_4b:
	dw ARS_SpriteCoords_4b
	db $ed, $ea, $eb, $ec, $ff

ARS_SpriteTiles_4c:
	dw ARS_SpriteCoords_4c
	db $f2, $f4, $f3, $bf, $ff

ARS_SpriteTiles_4d:
	dw ARS_SpriteCoords_4d
	db $f4, $f2, $bf, $f3, $ff

ARS_SpriteTiles_4e:
	dw ARS_SpriteCoords_4e
	db $c2, $fd, $c2, $c3, $fd, $c3, $ff

ARS_SpriteTiles_4f:
	dw ARS_SpriteCoords_4f
	db $c4, $fd, $c4, $c5, $fd, $c5, $ff

ARS_SpriteTiles_50:
	dw ARS_SpriteCoords_50
	db $dc, $fd, $dc, $ef, $fd, $ef, $ff

ARS_SpriteTiles_51:
	dw ARS_SpriteCoords_51
	db $f0, $fd, $f0, $f1, $fd, $f1, $ff

ARS_SpriteTiles_52:
	dw ARS_SpriteCoords_52
	db $dc, $fd, $f0, $f1, $fd, $ef, $ff

ARS_SpriteTiles_53:
	dw ARS_SpriteCoords_53
	db $f0, $fd, $dc, $ef, $fd, $f1, $ff

ARS_SpriteTiles_54:
	dw ARS_SpriteCoords_54
	db $bd, $be, $bb, $bc, $ff

ARS_SpriteTiles_55:
	dw ARS_SpriteCoords_55
	db $b9, $ba, $da, $db, $ff

ARS_SpriteSpec_2c:
	dw ARS_SpriteTiles_2c
	db $e0, $f0

ARS_SpriteTiles_2c:
	dw ARS_SpriteCoords_2c
	db $c0, $c1, $c5, $c6, $cc, $cd, $75, $76, $a4, $a5, $a6, $a7, $54, $55, $56, $57, $44, $45, $46, $47, $a0, $a1, $a2, $a3, $9c, $9d, $9e, $9f, $ff

ARS_SpriteSpec_34:
	dw ARS_SpriteTiles_34
	db $f8, $e8

ARS_SpriteSpec_35:
	dw ARS_SpriteTiles_35
	db $f0, $e8

ARS_SpriteSpec_38:
	dw ARS_SpriteTiles_38
	db $00, $00

ARS_SpriteSpec_39:
	dw ARS_SpriteTiles_39
	db $00, $00

ARS_SpriteSpec_40:
	dw ARS_SpriteTiles_40
	db $00, $00

ARS_SpriteSpec_41:
	dw ARS_SpriteTiles_41
	db $00, $00

ARS_SpriteSpec_5c:
	dw ARS_SpriteTiles_5c
	db $00, $00

ARS_SpriteSpec_5d:
	dw ARS_SpriteTiles_5d
	db $00, $00

ARS_SpriteSpec_58:
	dw ARS_SpriteTiles_58
	db $d8, $f8

ARS_SpriteSpec_59:
	dw ARS_SpriteTiles_59
	db $e8, $f8

ARS_SpriteSpec_5a:
ARS_SpriteSpec_5b:
	dw ARS_SpriteTiles_5b
	db $f0, $f8

ARS_SpriteTiles_34:
	dw ARS_SpriteCoords_34
	db $63, $64, $65, $ff

ARS_SpriteTiles_35:
	dw ARS_SpriteCoords_35
	db $63, $64, $65, $66, $67, $68, $ff

ARS_SpriteTiles_38:
	dw ARS_SpriteCoords_38
	db $41, $41, $41, $ff

ARS_SpriteTiles_39:
	dw ARS_SpriteCoords_39
	db $42, $42, $42, $ff

ARS_SpriteTiles_40:
	dw ARS_SpriteCoords_40
	db $52, $52, $52, $62, $62, $62, $ff

ARS_SpriteTiles_41:
	dw ARS_SpriteCoords_41
	db $51, $51, $51, $61, $61, $61, $71, $71, $71, $ff

ARS_SpriteTiles_56:
	dw ARS_SpriteCoords_56
	db $2f, $2f, $2f, $2f, $2f, $2f, $2f, $2f, $63, $64, $fd, $64, $fd, $63, $66, $67, $fd, $67, $fd, $66, $ff

ARS_SpriteTiles_57:
	dw ARS_SpriteCoords_57
	db $2f, $2f, $63, $64, $ff

ARS_SpriteTiles_58:
	dw ARS_SpriteCoords_58
	db $00, $fd, $00, $10, $fd, $10, $4f, $fd, $4f, $80, $fd, $80, $80, $fd, $80, $81, $fd, $81, $97, $fd, $97, $ff

ARS_SpriteTiles_59:
	dw ARS_SpriteCoords_59
	db $98, $fd, $98, $99, $fd, $99, $80, $fd, $80, $9a, $fd, $9a, $9b, $fd, $9b, $ff

ARS_SpriteTiles_5a:
ARS_SpriteTiles_5b:
	dw ARS_SpriteCoords_5b
	db $a8, $fd, $a8, $a9, $fd, $a9, $aa, $fd, $aa, $ab, $fd, $ab, $ff

ARS_SpriteTiles_5c:
	dw ARS_SpriteCoords_5c
	db $41, $da, $da, $ff

ARS_SpriteTiles_5d:
	dw ARS_SpriteCoords_5d
	db $52, $da, $62, $ff

ARS_SpriteCoords_00:
ARS_SpriteCoords_01:
ARS_SpriteCoords_02:
ARS_SpriteCoords_03:
ARS_SpriteCoords_04:
ARS_SpriteCoords_05:
ARS_SpriteCoords_06:
ARS_SpriteCoords_07:
ARS_SpriteCoords_08:
ARS_SpriteCoords_09:
ARS_SpriteCoords_0a:
ARS_SpriteCoords_0b:
ARS_SpriteCoords_0c:
ARS_SpriteCoords_0d:
ARS_SpriteCoords_0e:
ARS_SpriteCoords_0f:
ARS_SpriteCoords_10:
ARS_SpriteCoords_11:
ARS_SpriteCoords_12:
ARS_SpriteCoords_13:
ARS_SpriteCoords_14:
ARS_SpriteCoords_15:
ARS_SpriteCoords_16:
ARS_SpriteCoords_17:
ARS_SpriteCoords_18:
ARS_SpriteCoords_19:
ARS_SpriteCoords_1a:
ARS_SpriteCoords_1b:
ARS_SpriteCoords_2e:
ARS_SpriteCoords_2f:
ARS_SpriteCoords_3a:
ARS_SpriteCoords_3b:
ARS_SpriteCoords_56:
	db $00, $00, $00, $08, $00, $10, $00, $18, $08, $00, $08, $08, $08, $10, $08, $18, $10, $00, $10, $08, $10, $10, $10, $18, $18, $00, $18, $08, $18, $10, $18, $18

ARS_SpriteCoords_1c:
ARS_SpriteCoords_1d:
ARS_SpriteCoords_1e:
ARS_SpriteCoords_1f:
ARS_SpriteCoords_20:
ARS_SpriteCoords_21:
ARS_SpriteCoords_22:
ARS_SpriteCoords_23:
ARS_SpriteCoords_24:
ARS_SpriteCoords_25:
ARS_SpriteCoords_26:
ARS_SpriteCoords_27:
ARS_SpriteCoords_28:
ARS_SpriteCoords_29:
	db $00, $00, $00, $08, $00, $10, $00, $18, $00, $20, $00, $28, $00, $30, $00, $38

ARS_SpriteCoords_2a:
ARS_SpriteCoords_2b:
ARS_SpriteCoords_2d:
ARS_SpriteCoords_30:
ARS_SpriteCoords_31:
ARS_SpriteCoords_32:
ARS_SpriteCoords_33:
ARS_SpriteCoords_36:
ARS_SpriteCoords_37:
ARS_SpriteCoords_3c:
ARS_SpriteCoords_3d:
ARS_SpriteCoords_3e:
ARS_SpriteCoords_3f:
ARS_SpriteCoords_42:
ARS_SpriteCoords_43:
ARS_SpriteCoords_44:
ARS_SpriteCoords_45:
ARS_SpriteCoords_46:
ARS_SpriteCoords_47:
ARS_SpriteCoords_48:
ARS_SpriteCoords_49:
ARS_SpriteCoords_4a:
ARS_SpriteCoords_4b:
ARS_SpriteCoords_4c:
ARS_SpriteCoords_4d:
ARS_SpriteCoords_4e:
ARS_SpriteCoords_4f:
ARS_SpriteCoords_50:
ARS_SpriteCoords_51:
ARS_SpriteCoords_52:
ARS_SpriteCoords_53:
ARS_SpriteCoords_54:
ARS_SpriteCoords_55:
ARS_SpriteCoords_57:
ARS_SpriteCoords_58:
ARS_SpriteCoords_59:
ARS_SpriteCoords_5a:
ARS_SpriteCoords_5b:
ARS_SpriteCoords_5c:
ARS_SpriteCoords_5d:
	db $00, $00, $00, $08, $08, $00, $08, $08, $10, $00, $10, $08, $18, $00, $18, $08, $20, $00, $20, $08, $28, $00, $28, $08, $30, $00, $30, $08

ARS_SpriteCoords_2c:
	db $00, $08, $00, $10, $08, $08, $08, $10, $10, $00, $10, $08, $10, $10, $10, $18, $18, $00, $18, $08, $18, $10, $18, $18, $20, $00, $20, $08, $20, $10, $20, $18, $28, $00, $28, $08, $28, $10, $28, $18, $30, $00, $30, $08, $30, $10, $30, $18, $38, $00, $38, $08, $38, $10, $38, $18

ARS_SpriteCoords_34:
ARS_SpriteCoords_35:
ARS_SpriteCoords_38:
ARS_SpriteCoords_39:
ARS_SpriteCoords_40:
ARS_SpriteCoords_41:
	db $00, $00, $00, $08, $00, $10, $08, $00, $08, $08, $08, $10, $10, $00, $10, $08, $10, $10
