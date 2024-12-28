SECTION "Rosy Retrospection Rotation Systems Data", ROMX, BANK[$04]
SRS_KICKS:: ; L, J, T, S, Z
    ; Y,X
    ; +Y = Down, +X = Right
    db 0,-8, -8,-8, 16,0, 16,-8 ; N -> E
    db 8,0, 8,8 -16,0, -16,8 ; E -> S
    db 0,8, -8,8, 16,0, 16,8 ; S -> W
    db 0,-8, 8,-8, -16,0, -16-8 ; W -> N
    ; CW Kicks, Invert for CCW
SRS_KICKS_I::
    ; Y,X
    ; +Y = Down, +X = Right
    db 0,-16, 0,8, 8,-16, -16,8 ; N -> E
    db 0,-8, 0,16, -16,-8, 8,16 ; E -> S
    db 0,16, 0,-8, -8,16, 16,-8 ; S -> W
    db 0,8, 0,-16, 16,8, -8,-16 ; W -> N
    ; CW Kicks, Invert for CCW

SRS_ClockWise::
    ; Set The Amount Of Tests Performed to 0
    xor a
    ld [sPlaceholder], a
    ; Check the Piece type
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    sra a
    sra a
    cp a, 2
    jr z, .iPiece
    ; Get The Offset
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    and a, 3
    ld de, SRSKickOffsetTableCW
    add a, e
    ld e, a
    ld a, [de]
    ld hl, SRS_KICKS
    ld d, 0
    ld e, a
    add hl, de
    jr .applyKicks
.iPiece
    ; Get The Offset
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    and a, 3
    ld de, SRSKickOffsetTableCW
    add a, e
    ld e, a
    ld a, [de]
    ld hl, SRS_KICKS_I
    ld d, 0
    ld e, a
    add hl, de
.applyKicks
    ld de, wSpriteSpecs+SPR_SPEC_BaseYOffset
    ld a, [de]
;    ld [sPlaceholder], a
    ld b, a
    inc de
    ld a, [de]
;    ld [sPlaceholder+1], a
    dec de
    ld c, a
.nextKick
    ld de, wSpriteSpecs+SPR_SPEC_BaseYOffset
    push bc
    ldi a, [hl]
    add a, b
    ld [de], a
    inc de
    ldi a, [hl]
    add a, c
    ld [de], a
    dec de
    ; Check for collision
    push hl
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop hl
    pop bc
    ret z
    ld a, [sPlaceholder]
    inc a
    ld [sPlaceholder], a
    cp a, 4
    jp z, NoKick
    jr .nextKick

SRS_CounterClockWise::
    ; Set The Amount Of Tests Performed to 0
    xor a
    ld [sPlaceholder], a
    ; Check the Piece type
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    sra a
    sra a
    cp a, 2
    jr z, .iPiece
    ; Get The Offset
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    and a, 3
    ld de, SRSKickOffsetTableCCW
    add a, e
    ld e, a
    ld a, [de]
    ld hl, SRS_KICKS
    ld d, 0
    ld e, a
    add hl, de
    jr .applyKicks
.iPiece
    ; Get The Offset
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    and a, 3
    ld de, SRSKickOffsetTableCCW
    add a, e
    ld e, a
    ld a, [de]
    ld hl, SRS_KICKS_I
    ld d, 0
    ld e, a
    add hl, de
.applyKicks
    ld de, wSpriteSpecs+SPR_SPEC_BaseYOffset
    ld a, [de]
;    ld [sPlaceholder], a
    ld b, a
    inc de
    ld a, [de]
;    ld [sPlaceholder+1], a
    dec de
    ld c, a
.nextKick
    ld de, wSpriteSpecs+SPR_SPEC_BaseYOffset
    push bc
    ldi a, [hl]
    cpl
    add a, b
    ld [de], a
    inc de
    ldi a, [hl]
    cpl
    add a, c
    ld [de], a
    dec de
    ; Check for collision
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop hl
    pop bc
    ret z
    ld a, [sPlaceholder]
    inc a
    ld [sPlaceholder], a
    cp a, 4
    jp z, NoKick
    jr .nextKick


ARS_Tests::
    ld de, wSpriteSpecs+SPR_SPEC_BaseYOffset
    ld a, [de]
;    ld [sPlaceholder], a
    ld b, a
    inc de
    ld a, [de]
;    ld [sPlaceholder+1], a
    ld c, a
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    sra a
    sra a
    cp a, 2
    jr z, .iPiece
.tryRight
    ld a, 8
    add a, c
    ld [de], a
    ; Check for collision
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop bc
    ret z
.tryLeft
    push bc
    ld a, -8
    add a, c
    ld [de], a
    ; Check for collision
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop bc
    ret z
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    sra a
    sra a
    cp a, 6
    jr z, .tryUpT
    jp NoKick
.tryUpT
    push bc
    dec de
    ld a, -8
    add a, c
    ld [de], a
    ; Check for collision
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop bc
    ret z
    jp NoKick
.iPiece
    ld hl, wSpriteSpecs+SPR_SPEC_SpecIdx
    ld a, [hl]
    and a
    jr z, .verticalKicks
.horizontalKicks
    push bc
    inc de
    ld a, -8
    add a, c
    ld [de], a
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    ret z
    ld a, 24
    add a, c
    ld [de], a
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop bc
    ret z
    jp NoKick
.verticalKicks
    push bc
    ld a, 8
    add a, b
    ld [de], a
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    ret z
    ld a, 8
    add a, b
    ld [de], a
    call Copy1stSpriteSpecToSprite4                             
    call RetZIfNoCollisionForPiece                               
    and  a
    pop bc
    ret z
    jp NoKick


SRSKickOffsetTableCW: ; yes, i need to do this :skull:
    db 24, 0, 8, 16
SRSKickOffsetTableCCW:
    db 0, 8, 16, 24