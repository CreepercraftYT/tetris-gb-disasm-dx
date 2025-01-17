PlayNextPieceLoadNextAndHiddenPiece:
    ld a, 2
    ld [rROMB0], a
; visible
    ld   hl, wSpriteSpecs                                        ; $2007
    ld   [hl], $00                                               ; $200a

; Y depends on settings
    inc  l 
    ld a, [sOptionRosyRetroMode]
	cp a, 1
	jr nz, .normal
.rosyRetro
    ld a, [sOptionColors]
	cp a, 1
	jr z, .ARS
    ld   [hl], PIECE_SPAWN_Y_SRS
	jr .continue
.ARS 
    ld   [hl], PIECE_SPAWN_Y_ARS
    jr .continue
.normal 
    ld   [hl], PIECE_SPAWN_Y                                                      ; $2108
.continue                                                      ; $200c                                              ; $200d
    ld a, [wPieceManips]
    xor a
    ld [wPieceManips], a
    ld [wIsHardDrop], a
; X of $3f
    inc  l                                                       ; $200f
    ld   [hl], $3f                                               ; $2010

; Spec Idx from sprite spec 2 spec idx
    inc  l                                                       ; $2012
    ld   a, [wSpriteSpecs+SPR_SPEC_SIZEOF+SPR_SPEC_SpecIdx]      ; $2013
    ld   [hl], a      
    push af        
    push hl                                   ; $2016
    sra a
    sra a
    ld hl, PieceColorLookUpTable
    add a, l
    ld l, a
    ld a, [hl]
; Color
    pop hl
    inc l
    ld [hl], a
    pop af
; store piece type in C
    and  $fc                                                     ; $2017
    ld   c, a                                                   ; $2019

    ldh  a, [hPrevOrCurrDemoPlayed]                              ; $201a
    and  a                                                       ; $201c
    jr   nz, .inDemoOr2Player                                    ; $201d

    ldh  a, [hIs2Player]                                         ; $201f
    and  a                                                       ; $2021
    jr   z, .only1player  
    ; reset times held for new press
    ld   hl, hNumTimesHoldingDownEvery3Frames                    ; $20a4
    ld   [hl], $00                                       ; $2022
.inDemoOr2Player:
; get next piece
    ld   h, HIGH(wDemoOrMultiplayerPieces)                       ; $2024
    ldh  a, [hLowByteOfCurrDemoStepAddress]                      ; $2026
    ld   l, a                                                    ; $2028
    ld   e, [hl]                                                 ; $2029

; check if done
    inc  hl                                                      ; $202a
    ld   a, h                                                    ; $202b
    cp   HIGH(wDemoOrMultiplayerPieces.end)                      ; $202c
    jr   nz, .setNextDemoStep                                    ; $202e

    ld   hl, wDemoOrMultiplayerPieces                            ; $2030

.setNextDemoStep:
    ld   a, l                                                    ; $2033
    ldh  [hLowByteOfCurrDemoStepAddress], a                      ; $2034

; with piece played, set bit 7 of this var
    ldh  a, [hOtherPlayersMultiplierToProcess]                   ; $2036
    and  a                                                       ; $2038
    jr   z, .skipDIV                                             ; $2039

    or   $80                                                     ; $203b
    ldh  [hOtherPlayersMultiplierToProcess], a                   ; $203d
    jr   .skipDIV                                                ; $203f

.only1player:
; if Rosy Retrospection mode is on, use 7 Bag generator
    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .random
    ld a, [wPiecesLeftInTheBag]
    cp a, $ff
    jr nz, .afterInit
    call Generate_7_Bag
.afterInit 
    call Generate_7_Bag
    jr .skipDIV
.random
; try 3 times to gen a new random piece
    ld   h, $03                                                  ; $2041

.upToDIV:
    ldh  a, [rDIV]                                               ; $2043
    ld   b, a                                                    ; $2045

.xorAloop:
    xor  a                                                       ; $2046

.nextB:
    dec  b                                                       ; $2047
    jr   z, .bEqu0                                               ; $2048

; loop A up to $1c and back while b isn't 0
    inc  a                                                       ; $204a
    inc  a                                                       ; $204b
    inc  a                                                       ; $204c
    inc  a                                                       ; $204d
    cp   $1c                                                     ; $204e
    jr   z, .xorAloop                                            ; $2050

    jr   .nextB                                                  ; $2052

.bEqu0:
; final A (multiple of 4) into D
    ld   d, a                                                    ; $2054

; hidden random val to go into loaded piece
    ldh  a, [hHiddenLoadedPiece]                                 ; $2055
    ld   e, a                                                    ; $2057
    dec  h                                                       ; $2058
    jr   z, .hDone                                               ; $2059

; h not 0 yet, | last random val, curr random val, and loaded piece
; loaded piece -> played piece
; last random val -> loaded piece
; curr random val -> last random val
; re-randomize if upper 6 bits not changed from last spec idx
    or   d                                                       ; $205b
    or   c                                                       ; $205c
    and  $fc                                                     ; $205d
    cp   c                                                       ; $205f
    jr   z, .upToDIV                                             ; $2060

.hDone:
; store multiple of 4
    ld   a, d                                                    ; $2062
    ldh  [hHiddenLoadedPiece], a                                 ; $2063

.skipDIV:
    ld   a, e   
    ld   [wSpriteSpecs+SPR_SPEC_SIZEOF+SPR_SPEC_SpecIdx], a    
    push af                                           ; $2016
    sra a
    sra a
    ld hl, PieceColorLookUpTable
    add a, l
    ld l, a
    ld a, [hl]
; Color
    ld   [wSpriteSpecs+SPR_SPEC_SIZEOF+SPR_SPEC_SpecIdx+1], a
    pop af                                             ; $2065      ; $2066
    call Copy2ndSpriteSpecToSprite8                              ; $2069


; update frames to move down for piece
    ldh  a, [hNumFramesUntilPiecesMoveDown]                      ; $206c
    ldh  [hNumFramesUntilCurrPieceMovesDown], a                  ; $206e
    ld c, a
; check if Rosy Retro mode is on
    ld a, [sOptionRosyRetroMode]
    and a
    ld a, c
    jr z, .dontCheckGameOver
    ; send active piece to oam and continue if no collision
    call Copy1stSpriteSpecToSprite4                              ; $20cb
    call RetZIfNoCollisionForPiece
    jr z, .dontCheckGameOver
    jp GameOver
.dontCheckGameOver
    ld a, [wHoldUsed]
    and a
    jr z, .alreadyZero
    dec a
    ld [wHoldUsed], a
.alreadyZero
    ; Update The Ghost Piece
    xor a
    ld [wIsHardDrop], a
    ld   [wSpriteSpecs+SPR_SPEC_SIZEOF*2], a
;    push af
;    push bc
;    push de
;    push hl
    call AdjustGhostPiece
;    pop hl
;    pop de
;    pop bc
;    pop af 
    ret                                                          ; $2070


InGameHandlePieceFalling:
.holdingDown:
; check if pressing down if we can press
    ld   a, [wCanPressDownToMakePieceFall]                       ; $2071
    and  a                                                       ; $2074
    jr   z, .afterCheckingIfPressedDown                          ; $2075

    ldh  a, [hButtonsPressed]                                    ; $2077
    and  PADF_DOWN|PADF_LEFT|PADF_RIGHT                          ; $2079
    cp   PADF_DOWN                                               ; $207b
    jr   nz, .afterPressedDown                                   ; $207d

; just pressed
    xor  a                                                       ; $207f
    ld   [wCanPressDownToMakePieceFall], a                       ; $2080

.afterCheckingIfPressedDown:
; proceed when timer 2 is 0
    ldh  a, [hTimer2]                                            ; $2083
    and  a                                                       ; $2085
    jr   nz, .sendActivePieceToOam                               ; $2086

; proceed if piece falling state = 0, and rows aren't shifting down
;    ldh  a, [hPieceFallingState]                                 ; $2088
;    and  a                                                       ; $208a
;    jr   nz, .sendActivePieceToOam                               ; $208b

; FALLING_PIECE_NONE
    ldh  a, [hRowsShiftingDownState]                             ; $208d
    and  a                                                       ; $208f
    jr   nz, .sendActivePieceToOam                               ; $2090

; process down every 3 frames
; or every frame in Classic Rule
    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .noClassicRule
    ld a, [sOptionColors]
    and a
    jr z, .noClassicRule
    ld   a, $01                                                  ; $2092
    ldh  [hTimer2], a
; and set it as hard drop too
    ld [wIsHardDrop], a
    jr .continue
.noClassicRule
    ld   a, $03                                                  ; $2092
    ldh  [hTimer2], a                                            ; $2094
.continue
; inc times held without lifting down
    ld   hl, hNumTimesHoldingDownEvery3Frames                    ; $2096
    inc  [hl]                                                    ; $2099
    jr   .afterIncTimesHoldingDownForPiece                       ; $209a

.start:
    ldh  a, [hButtonsHeld]                                       ; $209c
    and  PADF_DOWN|PADF_LEFT|PADF_RIGHT                          ; $209e
    cp   PADF_DOWN                                               ; $20a0
    jr   z, .holdingDown                                         ; $20a2

.afterPressedDown:                                               ; $20a7

; dec frames, and return if > 0
    ldh  a, [hNumFramesUntilCurrPieceMovesDown]                  ; $20a9
    and  a                                                       ; $20ab
    jr   z, .currScoreEqu0                                       ; $20ac

    dec  a                                                       ; $20ae
    ldh  [hNumFramesUntilCurrPieceMovesDown], a                  ; $20af

.sendActivePieceToOam:
    call Copy1stSpriteSpecToSprite4
    call Copy3rdSpriteSpecToSprite12                              ; $20b1
    ret                                                          ; $20b4

.currScoreEqu0:
; dont proceed if rows are flashing
    ldh  a, [hPieceFallingState]                                 ; $20b5
    cp   FALLING_PIECE_ALL_ROWS_PROCESSED_AFTER_DROP             ; $20b7
    ret  z                                                       ; $20b9

; dont proceed if rows are being shifted down
    ldh  a, [hRowsShiftingDownState]                             ; $20ba
    and  a                                                       ; $20bc
    ret  nz                                                      ; $20bd

; update score for piece, ie keep looping in range of top score
    ldh  a, [hNumFramesUntilPiecesMoveDown]                      ; $20be
    ldh  [hNumFramesUntilCurrPieceMovesDown], a                  ; $20c0

.afterIncTimesHoldingDownForPiece:
; move piece down, and store prev Y
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20c2
    ld   a, [hl]                                                 ; $20c5
    ldh  [hNumCompletedTetrisRows], a                            ; $20c6
    add  $08                                                     ; $20c8
    ld   [hl], a
    push af
    ld a, [hButtonsHeld]
    bit PADB_DOWN, a
    jr nz, .stillHoldingDown
    xor a
    ld [wIsHardDrop], a
.stillHoldingDown
    pop af                                                 ; $20ca

; send active piece to oam and ret if no collision
    call Copy1stSpriteSpecToSprite4                              ; $20cb
    call RetZIfNoCollisionForPiece                               ; $20ce
    and  a
;    jr z, .collision
;    ld a, LOCK_DELAY
;    ld [wLockDelay], a                                                        ; $20d1
    jp z, StepResetLockDelay                                                       ; $20d2
;.collision
; collision detected, reset Y to previous, and send to oam
    ldh  a, [hNumCompletedTetrisRows]                            ; $20d3
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20d5
    ld   [hl], a                                                 ; $20d8
    call Copy1stSpriteSpecToSprite4                              ; $20d9

; set hit bottom state, and allow pressing down without releasing
    ld   a, FALLING_PIECE_HIT_BOTTOM                             ; $20dc
    ldh  [hPieceFallingState], a                                 ; $20de
    ld   [wCanPressDownToMakePieceFall], a                       ; $20e0

    ldh  a, [hNumTimesHoldingDownEvery3Frames]                   ; $20e3
    and  a                                                       ; $20e5
    jr   z, .fromNotHoldingDown                                  ; $20e6

; held down for piece until now
    ld   c, a                                                    ; $20e8
    ldh  a, [hGameType]                                          ; $20e9
    cp   GAME_TYPE_A_TYPE                                        ; $20eb
    jr   z, .isAType                                             ; $20ed

; is B type, get num drops in HL
    ld   de, wNumDrops                                           ; $20ef
    ld   a, [de]                                                 ; $20f2
    ld   l, a                                                    ; $20f3
    inc  de                                                      ; $20f4
    ld   a, [de]                                                 ; $20f5
    ld   h, a                                                    ; $20f6

; add times holding down to num drops
    ld   b, $00                                                  ; $20f7
    dec  c                                                       ; $20f9
    add  hl, bc                                                  ; $20fa

; store back num drops
    ld   a, h                                                    ; $20fb
    ld   [de], a                                                 ; $20fc
    ld   a, l                                                    ; $20fd
    dec  de                                                      ; $20fe
    ld   [de], a                                                 ; $20ff

.clearTimesHoldingDown:
    xor  a                                                       ; $2100
    ldh  [hNumTimesHoldingDownEvery3Frames], a                   ; $2101

.fromNotHoldingDown:
; check if orig coords when active piece loaded
    ld   a, [wSpriteSpecs+SPR_SPEC_BaseYOffset]
    ld b, a
    ld a, [sOptionRosyRetroMode]
	cp a, 1
	jr nz, .normal
.rosyRetro
    ld a, [sOptionColors]
	cp a, 1
	jr z, .ARS
    ld a, b
	cp PIECE_SPAWN_Y_SRS
    ret nz
	jr .continueb
.ARS 
    ld a, b   
	cp PIECE_SPAWN_Y_ARS
    ret nz
    jr .continueb
.normal 
    ld a, b                ; $2103
    cp   PIECE_SPAWN_Y                                           ; $2106
    ret  nz                                                      ; $2108
.continueb
    ld   a, [wSpriteSpecs+SPR_SPEC_BaseXOffset]                  ; $2109
    cp   $3f                                                     ; $210c
    ret  nz                                                      ; $210e

; give a change to move piece left and right, but skipping game over once
; while in orig coords

; Unless Rosy Retro mode is enabled, if so, check for collision
    ld a, [sOptionRosyRetroMode]
    and a
    jp z, .og
    call RetZIfNoCollisionForPiece
    ret z
    jp GameOver
.og
    ld   hl, hIsPieceStuckOnTopRow                               ; $210f
    ld   a, [hl]                                                 ; $2112
    cp   $01                                                     ; $2113
    jr   nz, .skipGameOver                                       ; $2115
    jp GameOver

.skipGameOver:
    inc  [hl]                                                    ; $2124
    ret                                                          ; $2125

.isAType:
; add num drops to score
    xor  a                                                       ; $2126

.keepAdding:
    dec  c                                                       ; $2127
    jr   z, .addDropsToScore                                     ; $2128

    inc  a                                                       ; $212a
    daa                                                          ; $212b
    jr   .keepAdding                                             ; $212c

.addDropsToScore:
    ld   e, a                                                    ; $212e
    ld   d, $00                                                  ; $212f
    ld   hl, wScoreBCD                                           ; $2131
    call AddScoreValueDEontoBaseScoreHL                          ; $2134

; set that we've added to score, for vblank interrupt
    ld   a, $01                                                  ; $2137
    ld   [wATypeJustAddedDropsToScore], a                        ; $2139
    jr   .clearTimesHoldingDown                                  ; $213c


InGameCheckIfAnyTetrisRowsComplete:
; ret if wrong state
    ldh  a, [hPieceFallingState]                                 ; $213e
    cp   FALLING_PIECE_CHECK_COMPLETED_ROWS                      ; $2140
    ret  nz                                                      ; $2142

; play sound
    ld   a, NOISE_PIECE_HIT_FLOOR                                ; $2143
    ld   [wNoiseSoundToPlay], a                                  ; $2145

; clear counter
    xor  a                                                       ; $2148
    ldh  [hNumCompletedTetrisRows], a                            ; $2149

; check every row 
    ld   de, wRamBufferAddressesForCompletedRows                 ; $214b
    ld   hl, wGameScreenBuffer+2                 ; $214e
    ld   b, GAME_SCREEN_ROWS                                   ; $2151

.nextRow:
    ld   c, GAME_SQUARE_WIDTH                                    ; $2153
    push hl                                                      ; $2155

.nextCol:
    ld   a, [hl+]                                                ; $2156
    cp   TILE_FLASHING_PIECE+1                                             ; $2157
    jp   z, .emptyTileFoundInRow                                 ; $2159

    dec  c                                                       ; $215c
    jr   nz, .nextCol                                            ; $215d

; no empty tiles in row, add row to completed rows list
    pop  hl                                                      ; $215f
    ld   a, h                                                    ; $2160
    ld   [de], a                                                 ; $2161
    inc  de                                                      ; $2162
    ld   a, l                                                    ; $2163
    ld   [de], a                                                 ; $2164
    inc  de                                                      ; $2165

; inc num completed rows
    ldh  a, [hNumCompletedTetrisRows]                            ; $2166
    inc  a                                                       ; $2168
    ldh  [hNumCompletedTetrisRows], a                            ; $2169

.toNextRow:
    push de                                                      ; $216b
    ld   de, GB_TILE_WIDTH                                       ; $216c
    add  hl, de                                                  ; $216f
    pop  de                                                      ; $2170
    dec  b                                                       ; $2171
    jr   nz, .nextRow                                            ; $2172

; all rows processed, set state
    ld   a, FALLING_PIECE_ALL_ROWS_PROCESSED_AFTER_DROP          ; $2174
    ldh  [hPieceFallingState], a                                 ; $2176
    dec  a                                                       ; $2178
    ldh  [hTimer1], a                                            ; $2179

; proceed if any rows completed, and put that num in B
    ldh  a, [hNumCompletedTetrisRows]                            ; $217b
    and  a                                                       ; $217d
    ret  z                                                       ; $217e

    ld   b, a                                                    ; $217f

; process line count for game type
    ld   hl, hNumLinesCompletedBCD                               ; $2180
    ldh  a, [hGameType]                                          ; $2183
    cp   GAME_TYPE_B_TYPE                                        ; $2185
    jr   z, .gameTypeB                                           ; $2187

; game type A, add to num lines word
    ld   a, b                                                    ; $2189
    add  [hl]                                                    ; $218a
    daa                                                          ; $218b
    ld   [hl+], a                                                ; $218c
    ld   a, $00                                                  ; $218d
    adc  [hl]                                                    ; $218f
    daa                                                          ; $2190
    ld   [hl], a                                                 ; $2191
    jr   nc, .afterGameTypeNumLinesProcessing                    ; $2192

; if carry out of high byte, score is 9999
    ld   [hl], $99                                               ; $2194
    dec  hl                                                      ; $2196
    ld   [hl], $99                                               ; $2197
    jr   .afterGameTypeNumLinesProcessing                        ; $2199

.gameTypeB:
; get current lines - lines just completed, with min of 0
    ld   a, [hl]                                                 ; $219b
    or   a                                                       ; $219c
    sub  b                                                       ; $219d
    jr   z, .clearNumLinesCompleted                              ; $219e

    jr   c, .clearNumLinesCompleted                              ; $21a0

; store back in ram
    daa                                                          ; $21a2
    ld   [hl], a                                                 ; $21a3

; if subbed all the way down to 9x, set to 0 instead
    and  $f0                                                     ; $21a4
    cp   $90                                                     ; $21a6
    jr   z, .clearNumLinesCompleted                              ; $21a8

.afterGameTypeNumLinesProcessing:
; num lines just completed in A
    ld   a, b                                                    ; $21aa

; based on lines cleared..
    ld   c, SND_NON_4_LINES_CLEARED                              ; $21ab
    ld   hl, wLinesClearedStructs                                ; $21ad
    ld   b, $00                                                  ; $21b0
    cp   $01                                                     ; $21b2
    jr   z, .end                                                 ; $21b4

    ld   hl, wLinesClearedStructs+LINES_CLEARED_SIZEOF           ; $21b6
    ld   b, $01                                                  ; $21b9
    cp   $02                                                     ; $21bb
    jr   z, .end                                                 ; $21bd

    ld   hl, wLinesClearedStructs+LINES_CLEARED_SIZEOF*2         ; $21bf
    ld   b, $02                                                  ; $21c2
    cp   $03                                                     ; $21c4
    jr   z, .end                                                 ; $21c6

    ld   hl, wLinesClearedStructs+LINES_CLEARED_SIZEOF*3         ; $21c8
    ld   b, $04                                                  ; $21cb
    ld   c, SND_4_LINES_CLEARED                                  ; $21cd

.end:
; inc its counter
    inc  [hl]                                                    ; $21cf

; store B
    ld   a, b                                                    ; $21d0
    ldh  [h2toThePowerOf_LinesClearedMinus1], a                  ; $21d1

; and play relevant sound
    ld   a, c                                                    ; $21d3
    ld   [wSquareSoundToPlay], a                                 ; $21d4
    ret                                                          ; $21d7

.emptyTileFoundInRow:
    pop  hl                                                      ; $21d8
    jr   .toNextRow                                              ; $21d9

.clearNumLinesCompleted:
    xor  a                                                       ; $21db
    ldh  [hNumLinesCompletedBCD], a                              ; $21dc
    jr   .afterGameTypeNumLinesProcessing                        ; $21de


FlashCompletedTetrisRows:
; ret if not in right state, or timer still ticking
    ldh  a, [hPieceFallingState]                                 ; $21e0
    cp   FALLING_PIECE_ALL_ROWS_PROCESSED_AFTER_DROP             ; $21e2
    ret  nz                                                      ; $21e4

    ldh  a, [hTimer1]                                            ; $21e5
    and  a                                                       ; $21e7
    ret  nz                                                      ; $21e8

; process each completed row
    ld   de, wRamBufferAddressesForCompletedRows                 ; $21e9

; alternate contents of row based on counter
    ldh  a, [hTetrisFlashCount]                                  ; $21ec
    bit  0, a                                                    ; $21ee
    jr   nz, .flashRowsWithOrigTile                              ; $21f0

    ld   a, [de]                                                 ; $21f2
    and  a                                                       ; $21f3
    jr   z, .doneWithFallingPiecePlayNextPiece                   ; $21f4

.upperOuterLoop:
; get vram dest address for row
    sub  HIGH(wGameScreenBuffer-_SCRN0)                          ; $21f6
    ld   h, a
                                                        ; $21f8
    inc  de                                                      ; $21f9
    ld   a, [de]                                                ; $21fa
    ld   l, a                                                    ; $21fb

; when counter = 6, use an empty tile to clear
    ldh  a, [hTetrisFlashCount]                                  ; $21fc
    cp   $06                                                     ; $21fe
    ld   a, TILE_FLASHING_PIECE                                  ; $2200
    jr   nz, .flashRow                                           ; $2202

    ld   a, TILE_FLASHING_PIECE+1                                          ; $2204

; set for entire row
.flashRow:
    ld   c, GAME_SQUARE_WIDTH                                    ; $2206

.flashRowLoop:
    ld   [hl+], a                                                ; $2208
    dec  c                                                       ; $2209
    jr   nz, .flashRowLoop                                       ; $220a

; continue if more rows
    inc  de                                                      ; $220c
    ld   a, [de]                                                 ; $220d
    and  a                                                       ; $220e
    jr   nz, .upperOuterLoop                                     ; $220f

.incFlashCount:
; inc flash counter
    ldh  a, [hTetrisFlashCount]                                  ; $2211
    inc  a                                                       ; $2213
    ldh  [hTetrisFlashCount], a                                  ; $2214

    cp   $05                                                     ; $2216
    jr   z, .flashed5times                                       ; $2218

; 10 frames until next flash
    ld   a, $0a                                                  ; $221a
    ldh  [hTimer1], a                                            ; $221c
    ret                                                          ; $221e

.flashed5times:
; clear counter, set timer until shift
    xor  a                                                       ; $221f
    ldh  [hTetrisFlashCount], a                                  ; $2220
    
    ld   a, $0d                                                  ; $2222
    ldh  [hTimer1], a                                            ; $2224

; shift ram buffer, then later on vram rows display
    ld   a, ROWS_SHIFTING_DOWN_SHIFT_RAM_BUFFER                  ; $2226
    ldh  [hRowsShiftingDownState], a                             ; $2228

.finishedHandlingPieceFalling:
    lda FALLING_PIECE_NONE                                       ; $222a
    ldh  [hPieceFallingState], a                                 ; $222b
    ret                                                          ; $222d

.flashRowsWithOrigTile:
; get vram row address from screen buffer, with high byte into C
; ram buffer high byte in H
    ld   a, [de]                                                 ; $222e
    ld   h, a                                                    ; $222f
    sub  HIGH(wGameScreenBuffer-_SCRN0)                          ; $2230
    ld   c, a                                                    ; $2232
    inc  de                                                      ; $2233
    ld   a, [de]                                                ; $2234
    ld   l, a                                                    ; $2235

; set for entire row
    ld   b, GAME_SQUARE_WIDTH                                    ; $2236

.origTileCopyLoop:
    ld   a, [hl]                                                 ; $2238
    push hl                                                      ; $2239
    ld   h, c                                                    ; $223a
    ld   [hl], a                                                 ; $223b
    pop  hl                                                      ; $223c
    inc  hl                                                      ; $223d
    dec  b                                                       ; $223e
    jr   nz, .origTileCopyLoop                                   ; $223f

; try more rows
    inc  de                                                      ; $2241
    ld   a, [de]                                                 ; $2242
    and  a                                                       ; $2243
    jr   nz, .flashRowsWithOrigTile                              ; $2244

    jr   .incFlashCount                                          ; $2246

.doneWithFallingPiecePlayNextPiece:
    call PlayNextPieceLoadNextAndHiddenPiece                     ; $2248
    jr   .finishedHandlingPieceFalling                           ; $224b


ShiftEntireGameRamBufferDownARow:
; ret if timer still ticking, or not in right state
    ldh  a, [hTimer1]                                            ; $224d
    and  a                                                       ; $224f
    ret  nz                                                      ; $2250

    ldh  a, [hRowsShiftingDownState]                             ; $2251
    cp   ROWS_SHIFTING_DOWN_SHIFT_RAM_BUFFER                     ; $2253
    ret  nz                                                      ; $2255

; get ram addresses into hl
    ld   de, wRamBufferAddressesForCompletedRows                 ; $2256
    ld   a, [de]                                                 ; $2259

.nextCompletedRow:
    ld   h, a                                                    ; $225a
    inc  de                                                      ; $225b
    ld   a, [de]                                                 ; $225c
    ld   l, a                                                    ; $225d

; push pointers to completed rows, and ram buffer address
    push de                                                      ; $225e
    push hl                                                      ; $225f

; prev ram buffer row in hl, curr in de
    ld   bc, -GB_TILE_WIDTH                                      ; $2260
    add  hl, bc                                                  ; $2263
    pop  de                                                      ; $2264

.nextRow:
    push hl                                                      ; $2265
    ld   b, GAME_SQUARE_WIDTH                                    ; $2266

; copy entire prev row into current
.rowShiftCopy:
    ld   a, [hl+]                                                ; $2268
    ld   [de], a                                                 ; $2269
    inc  de                                                      ; $226a
    dec  b                                                       ; $226b
    jr   nz, .rowShiftCopy                                       ; $226c

; pop start of row, get into de, hl = prev ram buffer row
    pop  hl                                                      ; $226e
    push hl                                                      ; $226f
    pop  de                                                      ; $2270
    ld   bc, -GB_TILE_WIDTH                                      ; $2271
    add  hl, bc                                                  ; $2274

; stop when about to copy from top of screen, fix pointer if past the top
    ld a, h
    cp a, $c7
    jr nz, .dontFixPointer
    ld a, $cb
    ld h, a
    ld a, d
    cp a, $c7
    jr nz, .dontFixPointer
    ld a, $cb
    ld d, a
.dontFixPointer
    ld a, h                                                    ; $2275
    cp   HIGH(wGameScreenBuffer.end-$80)                             ; $2276
    jr   nz, .nextRow
    ld a, l
    cp   LOW(wGameScreenBuffer.end-$7e)                             ; $2276
    jr   nz, .nextRow                                             ; $2278

    pop  de                                                      ; $227a
    inc  de                                                      ; $227b
    ld   a, [de]                                                 ; $227c
    and  a                                                       ; $227d
    jr   nz, .nextCompletedRow                                   ; $227e

; clear top row
    ld   hl, wGameScreenBuffer+2                                 ; $2280
    ld   a, TILE_FLASHING_PIECE+1                                            ; $2283
    ld   b, GAME_SQUARE_WIDTH                                    ; $2285

.clearTopRow:
    ld   [hl+], a                                                ; $2287
    dec  b                                                       ; $2288
    jr   nz, .clearTopRow                                        ; $2289                          ; $2290                                               ; $229b

; do Palettes too   
                                                          ; $229d
ShiftEntireGameRamBufferDownARow2:
; ret if timer still ticking, or not in right state
    ldh  a, [hTimer1]                                            ; $224d
    and  a                                                       ; $224f
    ret  nz                                                      ; $2250

    ldh  a, [hRowsShiftingDownState]                             ; $2251
    cp   ROWS_SHIFTING_DOWN_SHIFT_RAM_BUFFER                     ; $2253
    ret  nz                                                      ; $2255
    ld a, 1
    ld [rVBK], a
; get ram addresses into hl
    ld   de, wRamBufferAddressesForCompletedRows                 ; $2256
    ld hl, wGameScreenBuffer - sGameScreenBufferAttr
    ld   a, [de]                                                 ; $2259
    sub a, h
.nextCompletedRow:
    ld   h, a                                                    ; $225a
    inc  de                                                      ; $225b
    ld   a, [de]                                                 ; $225c
    ld   l, a                                                    ; $225d

; push pointers to completed rows, and ram buffer address
    push de                                                      ; $225e
    push hl                                                      ; $225f

; prev ram buffer row in hl, curr in de
    ld   bc, -GB_TILE_WIDTH                                      ; $2260
    add  hl, bc                                                  ; $2263
    pop  de                                                      ; $2264

.nextRow:
    push hl                                                      ; $2265
    ld   b, GAME_SQUARE_WIDTH                                    ; $2266

; copy entire prev row into current
.rowShiftCopy:
    ld   a, [hl+]                                                ; $2268
    ld   [de], a                                                 ; $2269
    inc  de                                                      ; $226a
    dec  b                                                       ; $226b
    jr   nz, .rowShiftCopy                                       ; $226c

; pop start of row, get into de, hl = prev ram buffer row
    pop  hl                                                      ; $226e
    push hl                                                      ; $226f
    pop  de                                                      ; $2270
    ld   bc, -GB_TILE_WIDTH                                      ; $2271
    add  hl, bc                                                  ; $2274

; stop when about to copy from top of screen
    ld   a, h       
    cp a, $9f
    jr nz, .dontFixPointer
    ld a, $a3
    ld h, a
    ld a, d       
    cp a, $9f
    jr nz, .dontFixPointer
    ld a, $a3
    ld d, a
.dontFixPointer 
    ld a, h                                             ; $2275
    cp   HIGH(sGameScreenBufferAttr.end-$80)                             ; $2276
    jr   nz, .nextRow
    ld a, l
    cp   LOW(sGameScreenBufferAttr.end-$7e)                             ; $2276
    jr   nz, .nextRow                                            ; $2278

    pop  de                                                      ; $227a
    inc  de                                                      ; $227b
    ld hl, wGameScreenBuffer - sGameScreenBufferAttr
    ld   a, [de]    
    ld b, a                                             ; $2259
    sub a, h 
    ld c, a
    ld a, b                                                ; $227c
    and  a 
    ld a, c                                                      ; $227d
    jr   nz, .nextCompletedRow                                   ; $227e

; clear top row
    ld   hl, sGameScreenBufferAttr+2                                 ; $2280
    ld   a, 3                                            ; $2283
    ld   b, GAME_SQUARE_WIDTH                                    ; $2285

.clearTopRow:
    ld   [hl+], a                                                ; $2287
    dec  b                                                       ; $2288
    jr   nz, .clearTopRow                                        ; $2289

; start to shift rows down
    call ClearPointersToCompletedTetrisRows                     ; $228b
    ld   a, ROWS_SHIFTING_DOWN_ROW_START                         ; $228e
    ldh  [hRowsShiftingDownState], a   
    xor a
    ld [rVBK], a                          ; $2290
    ret                                                          ; $2292


ClearPointersToCompletedTetrisRows:
    ld   hl, wRamBufferAddressesForCompletedRows                 ; $2293
    xor  a                                                       ; $2296
    ld   b, wRamBufferAddressesForCompletedRows.end-wRamBufferAddressesForCompletedRows ; $2297

.loop:
    ld   [hl+], a                                                ; $2299
    dec  b                                                       ; $229a
    jr   nz, .loop                                               ; $229b
    xor a
    ld [rVBK], a 
    ret
CopyRamBufferRow21ToVram:
    ; return if it's not time for this row to move down yet
    ldh  a, [hRowsShiftingDownState]                             ; $229e
    cp   ROWS_SHIFTING_DOWN_ROW_START                            ; $22a0
    ret  nz                                                      ; $22a2
    
    ld   hl, _SCRN0+GB_TILE_WIDTH*28+2                           ; $22a3
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*28+2                ; $22a6
    call CopyRamBufferRowToVram
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                                  ; $22a9
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*28+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*28+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                               ; $22a9
    ret   
CopyRamBufferRow20ToVram:
; return if it's not time for this row to move down yet
    ldh  a, [hRowsShiftingDownState]                             ; $229e
    cp   ROWS_SHIFTING_DOWN_ROW_START+1                            ; $22a0
    ret  nz                                                      ; $22a2

    ld   hl, _SCRN0+GB_TILE_WIDTH*29+2                           ; $22a3
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*29+2                ; $22a6
    call CopyRamBufferRowToVram
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                                  ; $22a9
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*29+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*29+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                               ; $22a9
    ret; $229d
CopyRamBufferRow19ToVram:
; return if it's not time for this row to move down yet
    ldh  a, [hRowsShiftingDownState]                             ; $229e
    cp   ROWS_SHIFTING_DOWN_ROW_START+2                            ; $22a0
    ret  nz                                                      ; $22a2

    ld   hl, _SCRN0+GB_TILE_WIDTH*30+2                           ; $22a3
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*30+2                ; $22a6
    call CopyRamBufferRowToVram
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                                  ; $22a9
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*30+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*30+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                               ; $22a9
    ret
CopyRamBufferRow18ToVram:
; return if it's not time for this row to move down yet
    ldh  a, [hRowsShiftingDownState]                             ; $229e
    cp   ROWS_SHIFTING_DOWN_ROW_START+3                            ; $22a0
    ret  nz                                                      ; $22a2

    ld   hl, _SCRN0+GB_TILE_WIDTH*31+2                           ; $22a3
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*31+2                ; $22a6
    call CopyRamBufferRowToVram
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                                  ; $22a9
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*31+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*31+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                               ; $22a9
    ret

CopyRamBufferRow17ToVram:
; return if it's not time for this row to move down yet
    ldh  a, [hRowsShiftingDownState]                             ; $229e
    cp   ROWS_SHIFTING_DOWN_ROW_START+4                            ; $22a0
    ret  nz                                                      ; $22a2

    ld   hl, _SCRN0+GB_TILE_WIDTH*17+2                           ; $22a3
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*17+2                ; $22a6
    call CopyRamBufferRowToVram
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                                  ; $22a9
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*17+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*17+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                               ; $22a9
    ret                                                          ; $22ac


CopyRamBufferRow16ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $22ad
    cp   ROWS_SHIFTING_DOWN_ROW_START+5                          ; $22af
    ret  nz                                                      ; $22b1

    ld   hl, _SCRN0+GB_TILE_WIDTH*16+2                           ; $22b2
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*16+2                ; $22b5
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*16+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*16+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                                 ; $22b8
    ret                                                          ; $22bb


CopyRamBufferRow15ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $22bc
    cp   ROWS_SHIFTING_DOWN_ROW_START+6                          ; $22be
    ret  nz                                                      ; $22c0

    ld   hl, _SCRN0+GB_TILE_WIDTH*15+2                           ; $22c1
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*15+2                ; $22c4
    call CopyRamBufferRowToVram     
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a         
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*15+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*15+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                           ; $22c7
    ret                                                          ; $22ca


CopyRamBufferRow14ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $22cb
    cp   ROWS_SHIFTING_DOWN_ROW_START+7                          ; $22cd
    ret  nz                                                      ; $22cf

    ld   hl, _SCRN0+GB_TILE_WIDTH*14+2                           ; $22d0
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*14+2                ; $22d3
    call CopyRamBufferRowToVram   
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*14+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*14+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                                 ; $22d6
    ret                                                          ; $22d9


CopyRamBufferRow13ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $22da
    cp   ROWS_SHIFTING_DOWN_ROW_START+8                          ; $22dc
    ret  nz                                                      ; $22de

    ld   hl, _SCRN0+GB_TILE_WIDTH*13+2                           ; $22df
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*13+2                ; $22e2
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*13+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*13+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                                 ; $22e5
    ret                                                          ; $22e8


CopyRamBufferRow12ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $22e9
    cp   ROWS_SHIFTING_DOWN_ROW_START+9                          ; $22eb
    ret  nz                                                      ; $22ed

    ld   hl, _SCRN0+GB_TILE_WIDTH*12+2                           ; $22ee
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*12+2                ; $22f1
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                     
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*12+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*12+2               ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                ; $22f4
    ret                                                          ; $22f7


CopyRamBufferRow11ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $22f8
    cp   ROWS_SHIFTING_DOWN_ROW_START+10                          ; $22fa
    ret  nz                                                      ; $22fc

    ld   hl, _SCRN0+GB_TILE_WIDTH*11+2                           ; $22fd
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*11+2                ; $2300
    call CopyRamBufferRowToVram   
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                          
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*11+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*11+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af           ; $2303

; check if still in-game
    ldh  a, [hIs2Player]                                         ; $2306
    and  a                                                       ; $2308
    ldh  a, [hGameState]                                         ; $2309
    jr   nz, .is2Player                                          ; $230b

; ret if 1 player and not in-game
    and  a                                                       ; $230d
    ret  nz                                                      ; $230e

.loop:
    ld   a, NOISE_TETRIS_ROWS_FELL                               ; $230f
    ld   [wNoiseSoundToPlay], a                                  ; $2311
    ret                                                          ; $2314

.is2Player:
; ret if not in-game
    cp   GS_2PLAYER_IN_GAME_MAIN                                 ; $2315
    ret  nz                                                      ; $2317

; if our rows moved up, play sound
    ldh  a, [hCurrPlayersRowsShiftedUpDueToOtherPlayer]          ; $2318
    and  a                                                       ; $231a
    jr   z, .loop                                                ; $231b

    ld   a, SND_TETRIS_ROWS_FELL                                 ; $231d
    ld   [wSquareSoundToPlay], a                                 ; $231f
    ret                                                          ; $2322


CopyRamBufferRow10ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $2323
    cp   ROWS_SHIFTING_DOWN_ROW_START+11                          ; $2325
    ret  nz                                                      ; $2327

    ld   hl, _SCRN0+GB_TILE_WIDTH*10+2                           ; $2328
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*10+2                ; $232b
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*10+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*10+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                                 ; $232e
    ret                                                          ; $2331


CopyRamBufferRow9ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $2332
    cp   ROWS_SHIFTING_DOWN_ROW_START+12                          ; $2334
    ret  nz                                                      ; $2336

    ld   hl, _SCRN0+GB_TILE_WIDTH*9+2                            ; $2337
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*9+2                 ; $233a
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a            
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*9+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*9+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                         ; $233d
    ret                                                          ; $2340


CopyRamBufferRow8ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $2341
    cp   ROWS_SHIFTING_DOWN_ROW_START+13                          ; $2343
    ret  nz                                                      ; $2345

    ld   hl, _SCRN0+GB_TILE_WIDTH*8+2                            ; $2346
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*8+2                 ; $2349
    call CopyRamBufferRowToVram  
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*8+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*8+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                                 ; $234c
    ret                                                          ; $234f


CopyRamBufferRow7ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $2350
    cp   ROWS_SHIFTING_DOWN_ROW_START+14                         ; $2352
    ret  nz                                                      ; $2354

    ld   hl, _SCRN0+GB_TILE_WIDTH*7+2                            ; $2355
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*7+2                 ; $2358
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a        
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*7+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*7+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                            ; $235b
    ret                                                          ; $235e


CopyRamBufferRow6ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $235f
    cp   ROWS_SHIFTING_DOWN_ROW_START+15                         ; $2361
    ret  nz                                                      ; $2363

    ld   hl, _SCRN0+GB_TILE_WIDTH*6+2                            ; $2364
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*6+2                 ; $2367
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*6+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*6+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                               ; $236a
    ret                                                          ; $236d


CopyRamBufferRow5ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $236e
    cp   ROWS_SHIFTING_DOWN_ROW_START+16                         ; $2370
    ret  nz                                                      ; $2372

    ld   hl, _SCRN0+GB_TILE_WIDTH*5+2                            ; $2373
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*5+2                 ; $2376
    call CopyRamBufferRowToVram       
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                  
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*5+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*5+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af               ; $2379
    ret                                                          ; $237c


CopyRamBufferRow4ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $237d
    cp   ROWS_SHIFTING_DOWN_ROW_START+17                         ; $237f
    ret  nz                                                      ; $2381

    ld   hl, _SCRN0+GB_TILE_WIDTH*4+2                            ; $2382
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*4+2                 ; $2385
    call CopyRamBufferRowToVram     
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a      
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*4+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*4+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                             ; $2388
    ret                                                          ; $238b


CopyRamBufferRow3ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $238c
    cp   ROWS_SHIFTING_DOWN_ROW_START+18                         ; $238e
    ret  nz                                                      ; $2390

    ld   hl, _SCRN0+GB_TILE_WIDTH*3+2                            ; $2391
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*3+2                 ; $2394
    call CopyRamBufferRowToVram       
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                  
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*3+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*3+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af              ; $2397

; check if level is updated
    call CheckIfATypeNextLevelReached                            ; $239a
    ret                                                          ; $239d


CopyRamBufferRow2ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $239e
    cp   ROWS_SHIFTING_DOWN_ROW_START+19                         ; $23a0
    ret  nz                                                      ; $23a2

    ld   hl, _SCRN0+GB_TILE_WIDTH*2+2                            ; $23a3
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH*2+2                 ; $23a6
    call CopyRamBufferRowToVram    
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a       
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH*2+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH*2+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                            ; $23a9

; update score in screen 1
    ld   hl, _SCRN1+$6d                                          ; $23ac
    call DisplayGameATypeScoreIfInGameAndForced                  ; $23af
    ld   a, $01                                                  ; $23b2
    ldh  [hFoundDisplayableScoreDigit], a                        ; $23b4
    ret                                                          ; $23b6


CopyRamBufferRow1ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $23b7
    cp   ROWS_SHIFTING_DOWN_ROW_START+20                         ; $23b9
    ret  nz                                                      ; $23bb

    ld   hl, _SCRN0+GB_TILE_WIDTH+2                              ; $23bc
    ld   de, wGameScreenBuffer+GB_TILE_WIDTH+2                   ; $23bf
    call CopyRamBufferRowToVram   
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a              
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+GB_TILE_WIDTH+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+GB_TILE_WIDTH+2                ; $22a6
    call CopyRamBufferRowToVram
    push af    
    xor a
    ld [rVBK], a       
    pop af               ; $23c2

; update score in screen 0
    ld   hl, _SCRN0+$6d                                          ; $23c5
    call DisplayGameATypeScoreIfInGameAndForced                  ; $23c8
    ret                                                          ; $23cb


CopyRamBufferRow0ToVram:
    ldh  a, [hRowsShiftingDownState]                             ; $23cc
    cp   ROWS_SHIFTING_DOWN_ROW_START+21                         ; $23ce
    ret  nz                                                      ; $23d0

; can make pieces fall again
    ld   [wCanPressDownToMakePieceFall], a                       ; $23d1

; display buffer with updated rows
    ld   hl, _SCRN0+2                                            ; $23d4
    ld   de, wGameScreenBuffer+2                                 ; $23d7
    call CopyRamBufferRowToVram  
    dec  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a    
    ld a, 1
    ld [rVBK], a
    ld   hl, _SCRN0+2                           ; $22a3
    ld   de, sGameScreenBufferAttr+2                ; $22a6
    call CopyRamBufferRowToVram    
    push af    
    xor a
    ld [rVBK], a       
    pop af                                ; $23da

; clear state of rows falling and check player
    lda ROWS_SHIFTING_DOWN_NONE                                  ; $23dd
    ldh  [hRowsShiftingDownState], a                             ; $23de

    ldh  a, [hIs2Player]                                         ; $23e0
    and  a                                                       ; $23e2
    ldh  a, [hGameState]                                         ; $23e3
    jr   nz, .is2player                                          ; $23e5

; is 1 player, ret if not GS_IN_GAME_MAIN
    and  a                                                       ; $23e7
    ret  nz                                                      ; $23e8

.getLinesToDisplay:
; below is for Type A
    ld   hl, _SCRN0+$14e                                         ; $23e9
    ld   de, hNumLinesCompletedBCD+1                             ; $23ec
    ld   c, $02                                                  ; $23ef

    ldh  a, [hGameType]                                          ; $23f1
    cp   GAME_TYPE_A_TYPE                                        ; $23f3
    jr   z, .displayLines                                        ; $23f5

; B type
    ld   hl, _SCRN0+$150                                         ; $23f7
    ld   de, hNumLinesCompletedBCD                               ; $23fa
    ld   c, $01                                                  ; $23fd

.displayLines:
    call DisplayBCDNum2CDigits                                   ; $23ff
    ldh  a, [hGameType]                                          ; $2402

; simply play next piece for type A game
    cp   GAME_TYPE_A_TYPE                                        ; $2404
    jr   z, .playNextPiece                                       ; $2406

; play next piece if type B and still outstanding lines to do
    ldh  a, [hNumLinesCompletedBCD]                              ; $2408
    and  a                                                       ; $240a
    jr   nz, .playNextPiece                                      ; $240b

; if B type level now done, set timer, and play song
    ld   a, $64                                                  ; $240d
    ldh  [hTimer1], a                                            ; $240f

    ld   a, MUS_B_TYPE_LEVEL_FINISHED                            ; $2411
    ld   [wSongToStart], a                                       ; $2413

; end of level updates
    ldh  a, [hIs2Player]                                         ; $2416
    and  a                                                       ; $2418
    jr   z, .is1playerEnd                                        ; $2419

; if 2 player, set that we finished the level
    ldh  [hCurrPlayerJustFinishedRequiredLines], a               ; $241b
    ret                                                          ; $241d

.is1playerEnd:
; set game state based on if max level
    ldh  a, [hBTypeLevel]                                        ; $241e
    cp   $09                                                     ; $2420
    ld   a, GS_B_TYPE_LEVEL_FINISHED                             ; $2422
    jr   nz, .setGameState                                       ; $2424

    ld   a, GS_DANCERS_INIT                                      ; $2426

.setGameState:
    ldh  [hGameState], a                                         ; $2428
    ret                                                          ; $242a

.playNextPiece:
    call PlayNextPieceLoadNextAndHiddenPiece                     ; $242b
    ret                                                          ; $242e

.is2player:
; ret if not in-game
    cp   GS_2PLAYER_IN_GAME_MAIN                                 ; $242f
    ret  nz                                                      ; $2431

; if our rows shifted up, unset that
    ldh  a, [hCurrPlayersRowsShiftedUpDueToOtherPlayer]          ; $2432
    and  a                                                       ; $2434
    jr   z, .getLinesToDisplay                                   ; $2435

    xor  a                                                       ; $2437
    ldh  [hCurrPlayersRowsShiftedUpDueToOtherPlayer], a          ; $2438
    ret                                                          ; $243a
    

DisplayGameATypeScoreIfInGameAndForced:
; ret if not in-game
    ldh  a, [hGameState]                                         ; $243b
    and  a                                                       ; $243d
    ret  nz                                                      ; $243e

; score is relevant for A-type
    ldh  a, [hGameType]                                          ; $243f
    cp   GAME_TYPE_A_TYPE                                        ; $2441
    ret  nz                                                      ; $2443

    ld   de, wScoreBCD+2                                         ; $2444
    call DisplayBCDNum6DigitsIfForced                            ; $2447
    ret                                                          ; $244a


; eg for level 0, must do 10 lines. For level 1, must do 20 lines, etc
CheckIfATypeNextLevelReached:
; ret if not in-game
    ldh  a, [hGameState]                                         ; $244b
    and  a                                                       ; $244d
    ret  nz                                                      ; $244e

; ret if not A-type
    ldh  a, [hGameType]                                          ; $244f
    cp   GAME_TYPE_A_TYPE                                        ; $2451
    ret  nz                                                      ; $2453

; ret if == $14 (max value of level 20)
    ld   hl, hATypeLinesThresholdToPassForNextLevel              ; $2454
    ld   a, [hl]                                                 ; $2457
    cp   $14                                                     ; $2458
    ret  z                                                       ; $245a

; a and b is level
    call ABisBCDofValInHL                                        ; $245b

; get num lines completed BCD+1, and ret if >= 1000
    ldh  a, [hNumLinesCompletedBCD+1]                            ; $245e
    ld   d, a                                                    ; $2460
    and  $f0                                                     ; $2461
    ret  nz                                                      ; $2463

; get num lines completed units digit, in tens spot in D
    ld   a, d                                                    ; $2464
    and  $0f                                                     ; $2465
    swap a                                                       ; $2467
    ld   d, a                                                    ; $2469

; get num lines completed low byte's tens digit in units spot in D
    ldh  a, [hNumLinesCompletedBCD]                              ; $246a
    and  $f0                                                     ; $246c
    swap a                                                       ; $246e
    or   d                                                       ; $2470

; return if that value is now less than or equal to the lines threshold for level
    cp   b                                                       ; $2471
    ret  c                                                       ; $2472

    ret  z                                                       ; $2473

; else inc that lines threshold, and put low digit in C
    inc  [hl]                                                    ; $2474
    ld a, [hl]
.lv5
    cp a, 5
    jr nz, .lv10
    ld a, 1
    ld [wBoardBackgroundColorTransitionState], a
    jr .continue
.lv10
    cp a, 10
    jr nz, .lv15
    ld a, 2
    ld [wBoardBackgroundColorTransitionState], a
    jr .continue
.lv15
    cp a, 15
    jr nz, .lv20
    ld a, 3
    ld [wBoardBackgroundColorTransitionState], a
    jr .continue
.lv20
    cp a, 20
    jr nz, .continue
    ld a, 4
    ld [wBoardBackgroundColorTransitionState], a
    jr .continue
.continue 
    call ABisBCDofValInHL                                        ; $2475
    and  $0f                                                     ; $2478
    ld   c, a                                                    ; $247a

; loop twice for units, then tens digit
    ld   hl, _SCRN0+$f1                                          ; $247b

.nextDigit:
; lines threshold in vram for both screens
    ld   [hl], c                                                 ; $247e
    ld   h, HIGH(_SCRN1+$f1)                                     ; $247f
    ld   [hl], c                                                 ; $2481

; get high digit in C
    ld   a, b                                                    ; $2482
    and  $f0                                                     ; $2483
    jr   z, .afterSendingNewLevelToVram                          ; $2485

    swap a                                                       ; $2487
    ld   c, a                                                    ; $2489

; end after next loop
    ld   a, l                                                    ; $248a
    cp   $f0                                                     ; $248b
    jr   z, .afterSendingNewLevelToVram                          ; $248d

    ld   hl, _SCRN0+$f0                                          ; $248f
    jr   .nextDigit                                              ; $2492

.afterSendingNewLevelToVram:
    ld   a, SND_REACHED_NEXT_LEVEL                               ; $2494
    ld   [wSquareSoundToPlay], a                                 ; $2496
    call SetNumFramesUntilPiecesMoveDown                         ; $2499
    ret                                                          ; $249c


ABisBCDofValInHL:
; ret if [hl] == 0, else put in B
    ld   a, [hl]                                                 ; $249d
    ld   b, a                                                    ; $249e
    and  a                                                       ; $249f
    ret  z                                                       ; $24a0

; with A = 0, += 1 with daa until B = 0
    xor  a                                                       ; $24a1

.loop:
    or   a                                                       ; $24a2
    inc  a                                                       ; $24a3
    daa                                                          ; $24a4
    dec  b                                                       ; $24a5
    jr   z, .copyAtoB                                            ; $24a6

    jr   .loop                                                   ; $24a8

.copyAtoB:
    ld   b, a                                                    ; $24aa
    ret                                                          ; $24ab


CopyRamBufferRowToVram:
    ld   b, GAME_SQUARE_WIDTH                                    ; $24ac

.loop:
    ld   a, [de]                                                 ; $24ae
    ld   [hl], a                                                 ; $24af
    inc  l                                                       ; $24b0
    inc  e                                                       ; $24b1
    dec  b                                                       ; $24b2
    jr   nz, .loop                                               ; $24b3

; copy next row next vblank
    ldh  a, [hRowsShiftingDownState]                             ; $24b5
    inc  a                                                       ; $24b7
    ldh  [hRowsShiftingDownState], a                             ; $24b8
    ret                                                          ; $24ba


InGameCheckButtonsPressed:
; return if piece not in play (hit bottom)
    ld   hl, wSpriteSpecs                                        ; $24bb
    ld   a, [hl]                                                 ; $24be
    cp   SPRITE_SPEC_HIDDEN                                      ; $24bf
    ret  z                                                       ; $24c1

    ld   l, SPR_SPEC_SpecIdx                                     ; $24c2
    ld   a, [hl]                                                 ; $24c4
    ldh  [hPreRotationSpecIdx], a                                ; $24c5

; check if rotating or hard dropping/sonic dropping
    ldh  a, [hButtonsPressed]                                    ; $24c7
    ld   b, a                                                    ; $24c9
    bit  PADB_B, b                                               ; $24ca
    jr   nz, .pressedB                                           ; $24cc

    bit  PADB_A, b                                               ; $24ce
    jr   nz, .pressedA                                ; $24d0

    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .notRosy

    bit PADB_UP, b
    jp nz, .hardDrop
.notRosy
    jr .afterCollisionCheck 
.pressedA
; pressed A, spec idx -= 1, wrapping 0 to 3
    ld   a, [hl]                                                 ; $24d2
    and  $03                                                     ; $24d3
    jr   z, .pressedAAnimation0                                  ; $24d5

    dec  [hl]
    ld a, -1 
    ld [sPlaceholder], a                                                   ; $24d7
    jr   .afterRotation                                          ; $24d8

.pressedAAnimation0:
    ld   a, [hl]                                                 ; $24da
    or   $03                                                     ; $24db
    ld   [hl], a    
    ld a, -1 
    ld [sPlaceholder], a                                             ; $24dd
    jr   .afterRotation                                          ; $24de

.pressedB:
; spec idx += 1, wrapping 3 to 0
    ld   a, [hl]                                                 ; $24e0
    and  $03                                                     ; $24e1
    cp   $03                                                     ; $24e3
    jr   z, .pressedBAnimation3                                  ; $24e5

    inc  [hl]   
    ld a, 1    
    ld [sPlaceholder], a                                             ; $24e7
    jr   .afterRotation                                          ; $24e8

.pressedBAnimation3:
    ld   a, [hl]                                                 ; $24ea
    and  $fc                                                     ; $24eb
    ld   [hl], a
    ld a, 1     
    ld [sPlaceholder], a                                          ; $24ed

.afterRotation:
; play rotate sound and send to oam
    ld   a, SND_PIECE_ROTATED                                    ; $24ee
    ld   [wSquareSoundToPlay], a                                 ; $24f0
    call Copy1stSpriteSpecToSprite4                              ; $24f3
    call RetZIfNoCollisionForPiece                               ; $24f6
    and  a
    jp z, MoveResetLockDelay
;    jr z, .collision
;    ld a, [sOptionRosyRetroMode]
;    and a
;    ret z
;    ld a, [sOptionColors]
;    and a
;    ret z
;    ld a, LOCK_DELAY
;    ld [wLockDelay], a                                                       ; $256f
;    ret                                                       ; $2570
;.collision                                                       ; $24f9
;    jr .afterCollisionCheck                                 ; $24fa

; collision detected, check for kicks and follow normal loop if successful (and if Rosy Retro mode is enabled), dont play sound, use orig spec idx and send to oam if failed
    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .notRosyRotation
    ld a, 4
    ld [rROMB0], a
    ld a, [sOptionColors]
    and a
    jp z, .srsTests
    call ARS_Tests
.result
    cp a, 1
    jr nz, .afterRotation
    jr .notRosyRotation
.srsTests
    ld a, [sPlaceholder]
    cp a, 1
    jr nz, .clockwise
    call SRS_CounterClockWise
    jr .result
.clockwise
    call SRS_ClockWise
    jr .result
.notRosyRotation
    lda SND_NONE                                                 ; $24fc
    ld   [wSquareSoundToPlay], a                                 ; $24fd
    ld   hl, wSpriteSpecs+SPR_SPEC_SpecIdx                       ; $2500
    ldh  a, [hPreRotationSpecIdx]                                ; $2503
    ld   [hl], a                                                 ; $2505
    call Copy1stSpriteSpecToSprite4                              ; $2506

.afterCollisionCheck:
; check horiz movement, buttons pressed in B, buttons held in C
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseXOffset                   ; $2509
    ldh  a, [hButtonsPressed]                                    ; $250c
    ld   b, a                                                    ; $250e
    ldh  a, [hButtonsHeld]                                       ; $250f
    ld   c, a                                                    ; $2511

; store orig X
    ld   a, [hl]                                                 ; $2512
    ldh  [hPreHorizMovementSpecIdx], a                           ; $2513
    bit  PADB_RIGHT, b                                           ; $2515

; orig sticky counter
    push af
    ld a, [sOptionRosyRetroMode]
    and a
    jr nz, .srs
.og
    pop af
    ld a, DAS
    jr .setDas 
.srs
    ld a, [sOptionColors]
    and a
    jr nz, .ars
    pop af
    ld a, DAS_SRS
    jr .setDas
.ars
    pop af
    ld   a, DAS_ARS
.setDas                                                  ; $2517
    jr   nz, .pressedRight                                       ; $2519

    bit  PADB_RIGHT, c                                           ; $251b
    jr   z, .notHeldRight                                        ; $251d

; held right, process when sticky counter at 0
    ldh  a, [hStickyButtonCounter]                               ; $251f
    dec  a                                                       ; $2521
    ldh  [hStickyButtonCounter], a                               ; $2522
    ret  nz                                                      ; $2524

    ld a, [sOptionRosyRetroMode]
    and a
    jr nz, .srs1
.og1
    ld a, ARR
    jr .setArr 
.srs1
    ld a, [sOptionColors]
    and a
    jr nz, .ars1
    ld a, ARR_SRS
    jr .setArr
.ars1
    ld   a, ARR_ARS
.setArr                                                  ; $2525

.pressedRight:
    ldh  [hStickyButtonCounter], a                               ; $2527

; add 8 to X, send to oam, play sound and check collision
    ld   a, [hl]                                                 ; $2529
    add  $08                                                     ; $252a
    ld   [hl], a                                                 ; $252c
    call Copy1stSpriteSpecToSprite4                              ; $252d
    ld   a, SND_PIECE_MOVED_HORIZ                                ; $2530
    ld   [wSquareSoundToPlay], a                                 ; $2532
;    push af
;    xor a
;    ld [hPieceFallingState], a
;    pop af
    call RetZIfNoCollisionForPiece                               ; $2535
    and  a
    jp  z, MoveResetLockDelay                                                        ; $2538
;    jr z, .afterHorizCollisionCheck
;    ld a, [sOptionRosyRetroMode]
;    and a
;    ret z
;    ld a, [sOptionColors]
;    and a
;    ret z
;    ld a, LOCK_DELAY
;    ld [wLockDelay], a                                                       ; $256f
;    ret                                                       ; $2570                                                       ; $2539

.afterHorizCollisionCheck:
; collision detected, dont play a sound, get back orig X,
; send to OAM and use lowest sticky counter to allow rotating if moving
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseXOffset                   ; $253a
    lda SND_NONE                                                 ; $253d
    ld   [wSquareSoundToPlay], a                                 ; $253e
    ldh  a, [hPreHorizMovementSpecIdx]                           ; $2541
    ld   [hl], a                                                 ; $2543
    call Copy1stSpriteSpecToSprite4                              ; $2544
    ld   a, $01                                                  ; $2547

.notHeldLeft:
; store highest val in sticky counter
    ldh  [hStickyButtonCounter], a                               ; $2549
    ret                                                          ; $254b

.notHeldRight:
    bit  PADB_LEFT, b                                            ; $254c

; sticky counter
    push af
    ld a, [sOptionRosyRetroMode]
    and a
    jr nz, .srsLeft
.ogLeft
    pop af
    ld a, DAS
    jr .setDasLeft 
.srsLeft
    ld a, [sOptionColors]
    and a
    jr nz, .arsLeft
    pop af
    ld a, DAS_SRS
    jr .setDasLeft
.arsLeft
    pop af
    ld   a, DAS_ARS
.setDasLeft                                                     ; $254e
    jr   nz, .pressedLeft                                        ; $2550

    bit  PADB_LEFT, c                                            ; $2552
    jr   z, .notHeldLeft                                         ; $2554

; process left when sticky counter is 0
    ldh  a, [hStickyButtonCounter]                               ; $2556
    dec  a                                                       ; $2558
    ldh  [hStickyButtonCounter], a                               ; $2559
    ret  nz                                                      ; $255b

    ld a, [sOptionRosyRetroMode]
    and a
    jr nz, .srs1Left
.og1Left
    ld a, ARR
    jr .setArrLeft 
.srs1Left
    ld a, [sOptionColors]
    and a
    jr nz, .ars1Left
    ld a, ARR_SRS
    jr .setArrLeft
.ars1Left
    ld   a, ARR_ARS
.setArrLeft                                                  ; $255c

.pressedLeft:
    ldh  [hStickyButtonCounter], a                               ; $255e

; X -= 8, play sound, send to oam, and check for collision
    ld   a, [hl]                                                 ; $2560
    sub  $08                                                     ; $2561
    ld   [hl], a                                                 ; $2563
    ld   a, SND_PIECE_MOVED_HORIZ                                ; $2564
    ld   [wSquareSoundToPlay], a                                 ; $2566
    call Copy1stSpriteSpecToSprite4                              ; $2569
    call RetZIfNoCollisionForPiece                               ; $256c
    and  a                                                       ; $256f
    jp  z, MoveResetLockDelay                                                       ; $2570

    jr   .afterHorizCollisionCheck                               ; $2571
                              ; $2571

.hardDrop:
; move piece down, and store prev Y
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20c2
    ld   a, [hl]                                                 ; $20c5
    ldh  [hNumCompletedTetrisRows], a                            ; $20c6
    add  $08                                                     ; $20c8
    ld   [hl], a
    ld hl, sPieceYandX
    ld a, [hl]
    add a, $08
    ldi [hl], a
    inc hl
    ld a, [hl]
    add a, $08
    ldi [hl], a
    inc hl
    ld a, [hl]
    add a, $08
    ldi [hl], a
    inc hl
    ld a, [hl]
    add a, $08
    ldi [hl], a 
    ld   hl, hNumTimesHoldingDownEvery3Frames                    ; $2096
    inc  [hl]
    inc [hl]                                              ; $20ca

; send active piece to oam and loop if no collision                              ; $20cb
    call RetZIfNoCollisionForPieceHardDrop                               ; $20ce
    and  a                                                       ; $20d1
    jr z, .hardDrop                                                      ; $20d2
; collision detected, reset Y to previous, and send to oam
    ldh  a, [hNumCompletedTetrisRows]
    ld   hl, hNumTimesHoldingDownEvery3Frames                    ; $2096
    dec  [hl] 
    dec [hl]                           ; $20d3
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20d5
    ld   [hl], a                       
    call Copy1stSpriteSpecToSprite4                          ; $20d8
; piece still sunk into another piece?
    call RetZIfNoCollisionForPiece
    and a
    jr z, .notSunk
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20d5
    ld   a, [hl]
    sub a, $08
    ld [hl], a
.notSunk
    call Copy1stSpriteSpecToSprite4                              ; $20d9

; set hit bottom state, and set wIsHardDrop to 1 if not Classic Rule
    ld   a, FALLING_PIECE_HIT_BOTTOM                             ; $20dc
    ldh  [hPieceFallingState], a  
    ld a, [sOptionColors]
    and a
    jp z, .isHardDrop
.isSonicDrop
    xor a
    ld [wIsHardDrop], a
    inc a
    ld   [wCanPressDownToMakePieceFall], a
    jp .afterCollisionCheck
.isHardDrop
    ld a, 1
    ld [wLockDelay], a
    ld [wIsHardDrop], a
    jp .afterCollisionCheck                               ; $20de
RetZIfNoCollisionForPiece:
; hl is 1st address for active piece
    ld   hl, wOam+OAM_SIZEOF*4                                  ; $2573
    ld   b, $04                                                  ; $2576

.nextSprite:
; get Y into A
    ld   a, [hl+]                                                ; $2578
    ldh  [hCurrPieceSquarePixelY], a                             ; $2579

; jump if X became 0 somehow
    ld   a, [hl+]                                                ; $257b
    and  a                                                       ; $257c
    jr   z, .fromXis0                                            ; $257d

    ldh  [hCurrPieceSquarePixelX], a                             ; $257f

; push oam address for tile idx, and num sprites left
    push hl                                                      ; $2581
    push bc                                                      ; $2582
    call GetScreen0AddressOfPieceSquare                          ; $2583

; get ram buffer address
    ld   a, h                                                    ; $2586
    add  HIGH(wGameScreenBuffer-_SCRN0)                          ; $2587
    ld   h, a                                                    ; $2589
    ld   a, [hl]                                                 ; $258a
    cp   TILE_FLASHING_PIECE+1                                               ; $258b                                             ; $258b
    jr   nz, .notEmpty                                           ; $258d
.empty
; is empty tile, get tile idx address and inc to next sprite Y
    pop  bc                                                      ; $258f
    pop  hl
    inc l
    inc l                                                      ; $2590                                                       ; $2592

; to next sprite
    dec  b                                                       ; $2593
    jr   nz, .nextSprite                                         ; $2594

; or num sprites left = 0 (ie all blanks at piece)
.fromXis0:
    xor  a                                                       ; $2596
    ldh  [hPieceCollisionDetected], a                            ; $2597
    ret                                                          ; $2599

.notEmpty:
    pop  bc                                                      ; $259a
    pop  hl                                                      ; $259b
    ld   a, $01                                                  ; $259c
    ldh  [hPieceCollisionDetected], a                            ; $259e
    ret                                                          ; $25a0

RetZIfNoCollisionForPieceHardDrop:
; hl is 1st address for active piece
    ld   hl, sPieceYandX                                  ; $2573
    ld   b, $04                                                  ; $2576

.nextSprite:
; get Y into A
    ld   a, [hl+]                                                ; $2578
    ldh  [hCurrPieceSquarePixelY], a                             ; $2579

; jump if X became 0 somehow
    ld   a, [hl+]                                                ; $257b
    and  a                                                       ; $257c
    jr   z, .fromXis0                                            ; $257d

    ldh  [hCurrPieceSquarePixelX], a                             ; $257f

; push oam address for tile idx, and num sprites left
    push hl                                                      ; $2581
    push bc                                                      ; $2582
    call GetScreen0AddressOfPieceSquare                          ; $2583

; get ram buffer address
    ld   a, h                                                    ; $2586
    add  HIGH(wGameScreenBuffer-_SCRN0)                          ; $2587
    ld   h, a                                                    ; $2589
    ld   a, [hl]                                                 ; $258a
    cp   TILE_FLASHING_PIECE+1                                               ; $258b                                             ; $258b
    jr   nz, .notEmpty                                           ; $258d
.empty
; is empty tile, get tile idx address and inc to next sprite Y
    pop  bc                                                      ; $258f
    pop  hl                                                      ; $2590                                                       ; $2592

; to next sprite
    dec  b                                                       ; $2593
    jr   nz, .nextSprite                                         ; $2594

; or num sprites left = 0 (ie all blanks at piece)
.fromXis0:
    xor  a                                                       ; $2596
    ldh  [hPieceCollisionDetected], a                            ; $2597
    ret                                                          ; $2599

.notEmpty:
    pop  bc                                                      ; $259a
    pop  hl                                                      ; $259b
    ld   a, $01                                                  ; $259c
    ldh  [hPieceCollisionDetected], a                            ; $259e
    ret                                                          ; $25a0

RetZIfNoCollisionForGhost:
; hl is 1st address for active piece
    ld   hl, wOam+OAM_SIZEOF*12                                  ; $2573
    ld   b, $04                                                  ; $2576

.nextSprite:
; get Y into A
    ld   a, [hl+]                                                ; $2578
    ldh  [hCurrPieceSquarePixelY], a                             ; $2579

; jump if X became 0 somehow
    ld   a, [hl+]                                                ; $257b
    and  a                                                       ; $257c
    jr   z, .fromXis0                                            ; $257d

    ldh  [hCurrPieceSquarePixelX], a                             ; $257f

; push oam address for tile idx, and num sprites left
    push hl                                                      ; $2581
    push bc                                                      ; $2582
    call GetScreen0AddressOfPieceSquare                          ; $2583

; get ram buffer address
    ld   a, h                                                    ; $2586
    add  HIGH(wGameScreenBuffer-_SCRN0)                          ; $2587
    ld   h, a                                                    ; $2589
    ld   a, [hl]                                                 ; $258a
    cp   TILE_FLASHING_PIECE+1                                               ; $258b                                             ; $258b
    jr   nz, .notEmpty                                           ; $258d
.empty
; is empty tile, get tile idx address and inc to next sprite Y
    pop  bc                                                      ; $258f
    pop  hl
    inc l
    inc l                                                      ; $2590                                                       ; $2592

; to next sprite
    dec  b                                                       ; $2593
    jr   nz, .nextSprite                                         ; $2594

; or num sprites left = 0 (ie all blanks at piece)
.fromXis0:
    xor  a                                                       ; $2596
    ldh  [hPieceCollisionDetected], a                            ; $2597
    ret                                                          ; $2599

.notEmpty:
    pop  bc                                                      ; $259a
    pop  hl                                                      ; $259b
    ld   a, $01                                                  ; $259c
    ldh  [hPieceCollisionDetected], a                            ; $259e
    ret                
InGameAddPieceToVram:
; ret if wrong state
    ldh  a, [hPieceFallingState]                                 ; $25a1
    cp   FALLING_PIECE_HIT_BOTTOM                                ; $25a3
    ret  nz
    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .noLockDelay
    ld a, [wIsHardDrop]
    and a
    jr nz, .noLockDelay
    ld a, [wLockDelay]
    and a
    jr nz, .skipLockDelaySet
    ld a, LOCK_DELAY
    ld [wLockDelay], a
    ret
.skipLockDelaySet
    ld a, [wLockDelay]
    dec a
    ld [wLockDelay], a
    ret nz
.noLockDelay; $25a5
; piece is 4 squares, get oam details for played piece
    ld   hl, wOam+OAM_SIZEOF*4                                   ; $25a6
    ld   b, $04                                                  ; $25a9

.nextSquareOfPiece:
; get square Y
    ld   a, [hl+]                                                ; $25ab
    ldh  [hCurrPieceSquarePixelY], a                             ; $25ac

; if square X = 0, we're done here
    ld   a, [hl+]                                                ; $25ae
    and  a                                                       ; $25af
    jr   z, .nextState                                           ; $25b0

    ldh  [hCurrPieceSquarePixelX], a                             ; $25b2

; preserve while getting screen addr of square
    push hl                                                      ; $25b4
    push bc                                                      ; $25b5
    call GetScreen0AddressOfPieceSquare                          ; $25b6
; screen 0 addr in de
    push hl                                                      ; $25b9
    pop  de                                                      ; $25ba
    pop  bc                                                      ; $25bb
    pop  hl                                                      ; $25bc

.waitUntilVramAndOamFree:
    ldh  a, [rSTAT]                                              ; $25bd
    and  STATF_LCD                                               ; $25bf
    jr   nz, .waitUntilVramAndOamFree                            ; $25c1

; store tile index into screen 0
    ld   a, [hl]
; convert from object tile to bg tile
    call ConvertFromObjectTileToBGTile 
    call WaitVRAM                                        ; $25c3
    ld   [de], a                                                ; $25c4

; as well as game screen buffer
    ld   a, d                                                    ; $25c5
    add  HIGH(wGameScreenBuffer-_SCRN0)                          ; $25c6
    ld   d, a
    ld   a, e    
    add  LOW(wGameScreenBuffer-_SCRN0)   
    ld   e, a                                             ; $25c8
    ld   a, [hl+]     
    call ConvertFromObjectTileToBGTile                                           ; $25c9
    ld   [de], a                                                 ; $25ca
    inc  l                                                       ; $25cb
    dec  b                                                       ; $25cc
    jr   nz, .nextSquareOfPiece                                  ; $25cd

.nextState:
    ld   a, 1                   ; $25cf
    ldh  [hPieceFallingState], a                                 ; $25d1

; hide active piece and ghost
    ld   hl, wSpriteSpecs                                        ; $25d3
    ld   [hl], SPRITE_SPEC_HIDDEN
    ld   hl, wSpriteSpecs+SPR_SPEC_SIZEOF*2
    ld   [hl], SPRITE_SPEC_HIDDEN                                ; $25d6
    ret                                                          ; $25d8
ConvertFromObjectTileToBGTile:
    push hl
    ld hl, PieceTileConversionLookUpTable
    cp a, $43
    jr nc, .subForFxValues
    sub a, $3f
    jr .getOffset
.subForFxValues
    sub a, $f1
.getOffset
    add a, l
    ld l, a
    ld a, [hl]
    pop hl
    ret

InGameAddPieceToVram1:
    ; ret if wrong state
    ldh  a, [hPieceFallingState]                                 ; $25a1
    cp   FALLING_PIECE_HIT_BOTTOM                                ; $25a3
    ret  nz                                                      ; $25a5
    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .noLockDelay
    ld a, [wIsHardDrop]
    and a
    jr nz, .noLockDelay
    ld a, [wLockDelay]
    and a
    ret nz
.noLockDelay
IgnoreLockDelay1:
    ld a, 1
    ld [rVBK], a
    ; piece is 4 squares, get oam details for played piece
    ld   hl, wOam+OAM_SIZEOF*4                                   ; $25a6
    ld   b, $04                                                  ; $25a9
    
.nextSquareOfPiece:
; get square Y
    ld   a, [hl+]                                                ; $25ab
    ldh  [hCurrPieceSquarePixelY], a                             ; $25ac

; if square X = 0, we're done here
    ld   a, [hl+]                                                ; $25ae
    and  a                                                       ; $25af
    jr   z, .nextState                                           ; $25b0

    ldh  [hCurrPieceSquarePixelX], a                             ; $25b2
    
; preserve while getting screen addr of square
    push hl                                                      ; $25b4
    push bc                                                      ; $25b5
    call GetScreen0AddressOfPieceSquare                          ; $25b6
; screen 0 addr in de
    push hl                                                      ; $25b9
    pop  de                                                      ; $25ba
    pop  bc                                                      ; $25bb
    pop  hl                                                      ; $25bc
    
.waitUntilVramAndOamFree:
    ldh  a, [rSTAT]                                              ; $25bd
    and  STATF_LCD                                               ; $25bf
    jr   nz, .waitUntilVramAndOamFree                            ; $25c1
    
; store attribute index into screen 0
    inc l
    ld   a, [hl]
; convert from object palette to bg palette
    push hl                                   ; $2016
    ld hl, PieceBGColorLookUpTable
    inc a
    add a, l
    ld l, a
    ld a, [hl]
; Color
    pop hl
    call WaitVRAM                                        ; $25c3
    ld   [de], a                                            ; $25c3                                                ; $25c4
    
; as well as game screen buffer
    ld c, a
    ld   a, d                                                    ; $25c5
    add  HIGH(sGameScreenBufferAttr-_SCRN0)                          ; $25c6
    ld   d, a 
    ld   a, e    
    add  LOW(sGameScreenBufferAttr-_SCRN0)   
    ld   e, a                                                    ; $25c8
    ld a, c                                               ; $25c9
    ld   [de], a                                                 ; $25ca
    inc  l                                                       ; $25cb
    dec  b                                                       ; $25cc
    jr   nz, .nextSquareOfPiece                                  ; $25cd
   
.nextState:
    ld   a, FALLING_PIECE_CHECK_COMPLETED_ROWS                   ; $25cf
    ldh  [hPieceFallingState], a                                 ; $25d1
    
; hide active piece
    ld   hl, wSpriteSpecs                                        ; $25d3
    ld   [hl], SPRITE_SPEC_HIDDEN    
    xor a
    ld [rVBK], a                            ; $25d6
    ret                                                          ; $25d8
PieceTileConversionLookUpTable:
    db $8f, $89, $8a, $8b, $80, $81, $82, $83, $84, $85, $86, $88
PieceBGColorLookUpTable:
    db $00, $00, $01, $02, $03, $04, $01
; Reset Lock Delay
MoveResetLockDelay::
    ; Adjust the ghost piece if Rosy Retro mode is enabled
    ld a, [sOptionRosyRetroMode]
    and a
    jr z, .reset
    call AdjustGhostPiece
    ld a, [wIsHardDrop]
    and a
    ret nz ; if hard dropping, don't move reset
.reset
    ; Only if the piece is touching the ground
    ld a, [hPieceFallingState]
    and a
    ret z
    ; Classic Rule doesn't have Move Reset
    ld a, [sOptionColors]
    and a
    jr nz, .pieceNoLongerTouchingTheGround
    ; no more than 15 resets
    ld a, [wPieceManips]
    cp a, 15
    ret z
    ld a, LOCK_DELAY
    ld [wLockDelay], a
    xor a
    ld [hPieceFallingState], a
    ld a, [wPieceManips]
    inc a
    ld [wPieceManips], a
.pieceNoLongerTouchingTheGround
    ;Check if the piece is now floating
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20d5
    ld   a, [hl]
    add a, $08
    ld [hl], a
    call Copy1stSpriteSpecToSprite4
    call RetZIfNoCollisionForPiece
    jr nz, .pieceStillTouchingTheGround
    xor a
    ld [hPieceFallingState], a
.pieceStillTouchingTheGround
    ld   hl, wSpriteSpecs+SPR_SPEC_BaseYOffset                   ; $20d5
    ld   a, [hl]
    sub a, $08
    ld [hl], a
    call Copy1stSpriteSpecToSprite4
    ret

StepResetLockDelay::
    ld a, [wIsHardDrop]
    and a
    ret nz ; if hard dropping, don't step reset
    ld a, LOCK_DELAY
    ld [wLockDelay], a
;    xor a
;    ld [hPieceFallingState], a
    ret

GameOver::
; clear sound, set game over state, and play game over wav sound
    call ThunkInitSound                                          ; $2117
    ld   a, GS_GAME_OVER_INIT                                    ; $211a
    ldh  [hGameState], a                                         ; $211c
    ld   a, WAV_GAME_OVER                                        ; $211e
    ld   [wWavSoundToPlay], a                                    ; $2120
    xor a
    dec a
    ld [wPiecesLeftInTheBag], a
    ret                                                          ; $2123

Generate_7_Bag::
    ld a, [wPiecesLeftInTheBag]
    cp a, 0
    jp z, .fillBagForTheFirstTime
    cp a, $ff
    jp z, .fillBagForTheFirstTime
.generate
    ld a, [rDIV]
    and a, 7
    cp a, 7
    jr nc, .generate
    ld hl, w7Bag
    ld d, 0
    ld e, a
    add hl, de
    ld a, [hl]
    cp a, $ff
    jr z, Generate_7_Bag
.pullPieceFromBag 
    ld b, a
    ld a, [wNextQueue]
    ld e, a
    ld a, [wNextQueue+1]
    ld [wNextQueue], a
    ld [_SCRN0+$192], a
    push hl
    sra a
    sra a
    ld hl, PiecePreviewColorLookUpTable
    add a, l
    ld l, a
    ld a, [hl]
    ld c, a
    ld a, 1
    ld [rVBK], a
    ld a, [sOptionColors]
    and a 
    ld a, c
    jr z, .noClassicRule1
    or a, %01100000
.noClassicRule1
    or a, 8
    ld [_SCRN0+$192], a
    xor a
    ld [rVBK], a
    ld a, b
    ld [wNextQueue+1], a
    ld [_SCRN0+$1B2], a
    sra a
    sra a
    ld hl, PiecePreviewColorLookUpTable
    add a, l
    ld l, a
    ld a, [hl]
    ld c, a
    ld a, 1
    ld [rVBK], a
    ld a, [sOptionColors]
    and a 
    ld a, c
    jr z, .noClassicRule2
    or a, %01100000
.noClassicRule2
    or a, 8
    ld [_SCRN0+$1B2], a
    xor a
    ld [rVBK], a
    pop hl
    ld [hl], $ff
    ld hl, wPiecesLeftInTheBag
    dec [hl] 
    ld a, [hl]
    cp a, 0
    ret nz
.refillBag
    ld b, 7
    ld hl, w7Bag
.refillLoop
    ldi [hl], a
    add a, 4
    dec b
    jr nz, .refillLoop
    ld [hl], 7
    ret
.fillBagForTheFirstTime
    ld b, 7
    ld hl, w7Bag
    xor a
.fillLoop
    ldi [hl], a
    add a, 4
    dec b
    jr nz, .fillLoop
    ld [hl], 7
    jp .generate

AdjustGhostPiece::
; No ghost piece in classic tetris
    ld a, [sOptionRosyRetroMode]
    and a
    ret z
; Return if ghost piece is hidden
    ld   a, [wSpriteSpecs+SPR_SPEC_SIZEOF*2]
    cp a, $80
    ret z
    call LoadPieceYandXPositionsToWram
    ld   hl, wSpriteSpecs+SPR_SPEC_SIZEOF*2+SPR_SPEC_BaseYOffset
    ld   de, wSpriteSpecs+SPR_SPEC_BaseYOffset
    ld   b,  5
.transferCurrentPieceToGhostPiece
    ld   a, [de]
    ldi  [hl], a 
    inc de
    dec b
    jr nz, .transferCurrentPieceToGhostPiece
.loop
; move ghost piece down, and store prev Y
    ld   hl, wSpriteSpecs+SPR_SPEC_SIZEOF*2+SPR_SPEC_BaseYOffset                   ; $20c2
    ld   a, [hl]                                                 ; $20c5
    ldh  [hNumCompletedTetrisRows], a                            ; $20c6
    add  a, 8                                                   ; $20c8
    ld   [hl], a
    ld hl, sPieceYandX
    ld a, [hl]
    add a, $08
    ldi [hl], a
    inc hl
    ld a, [hl]
    add a, $08
    ldi [hl], a
    inc hl
    ld a, [hl]
    add a, $08
    ldi [hl], a
    inc hl
    ld a, [hl]
    add a, $08
    ldi [hl], a
; send ghost piece to oam and loop if no collision                             ; $20cb
    call RetZIfNoCollisionForPieceHardDrop                             ; $20ce
    and  a                                                       ; $20d1
    jr z, .loop                                                   ; $20d2
; collision detected, reset Y to previous, and send to oam
    ldh  a, [hNumCompletedTetrisRows]                          ; $20d3
    ld   hl, wSpriteSpecs+SPR_SPEC_SIZEOF*2+SPR_SPEC_BaseYOffset                   ; $20d5
    ld   [hl], a                       
    call Copy3rdSpriteSpecToSprite12                         ; $20d8
; piece still sunk into another piece?
;    call RetZIfNoCollisionForGhost
;    and a
;    jr z, .notSunk
;.stillSunk
;    ld   hl, wSpriteSpecs+SPR_SPEC_SIZEOF*2+SPR_SPEC_BaseYOffset                   ; $20d5
;    ld   a, [hl]
;    sub a, $08
;    ld [hl], a
;    call Copy3rdSpriteSpecToSprite12 
;    call RetZIfNoCollisionForGhost
;    and a
;    jr nz, .stillSunk
.notSunk 
    call Copy3rdSpriteSpecToSprite12                           ; $20d9
    ret

HoldPiece::
    ld a, [wHoldUsed]
    and a
    ret nz
    ld a, [wSpriteSpecs+SPR_SPEC_SpecIdx]
    and a, %1111100
    ld [sPlaceholder], a
    ld a, [wSpriteSpecs+SPR_SPEC_SIZEOF*3+SPR_SPEC_SpecIdx]
    cp a, $fe
    jr nz, .holdFull
.holdEmpty
    ld a, [sPlaceholder]
    ld [wSpriteSpecs+SPR_SPEC_SIZEOF*3+SPR_SPEC_SpecIdx], a
    ld a, [wSpriteSpecs+SPR_SPEC_SpecIdx+1]
    ld [wSpriteSpecs+SPR_SPEC_SIZEOF*3+SPR_SPEC_SpecIdx+1], a
    xor a
    ld [wSpriteSpecs+SPR_SPEC_SIZEOF*3], a
    inc a
    inc a
    ld [wHoldUsed], a
    call Copy4thSpriteSpecToSprite16
    call PlayNextPieceLoadNextAndHiddenPiece
    call AdjustGhostPiece
    ret
.holdFull
    ld [wSpriteSpecs+SPR_SPEC_SpecIdx], a
    ld a, [sPlaceholder]
    ld [wSpriteSpecs+SPR_SPEC_SIZEOF*3+SPR_SPEC_SpecIdx], a
    ld a, [wSpriteSpecs+SPR_SPEC_SpecIdx+1]
    ld [sPlaceholder], a
    ld a, [wSpriteSpecs+SPR_SPEC_SIZEOF*3+SPR_SPEC_SpecIdx+1]
    ld [wSpriteSpecs+SPR_SPEC_SpecIdx+1], a
    ld a, [sPlaceholder]
    ld [wSpriteSpecs+SPR_SPEC_SIZEOF*3+SPR_SPEC_SpecIdx+1], a
    ld hl, wSpriteSpecs+SPR_SPEC_BaseYOffset
    ld a, [sOptionColors]
	cp a, 1
	jr z, .ARS
    ld   [hl], PIECE_SPAWN_Y_SRS
    inc hl
	jr .continue
.ARS 
    ld   [hl], PIECE_SPAWN_Y_ARS
    inc hl
.continue
    ld   [hl], $3f
    ld a, 1
    ld [wHoldUsed], a
    call Copy4thSpriteSpecToSprite16
    call AdjustGhostPiece
    ret