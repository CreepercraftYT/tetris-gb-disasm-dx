;SECTION "Graphics and Layouts", ROM0[$323f]
SECTION "Graphics and Layouts", ROMX[$46DB], BANK[$1]

Gfx_MenuScreens:
	INCBIN "build/menuScreens.2bpp"
.end:

;Layout_ATypeInGame:
;	INCBIN "data/layout_aTypeInGame.bin"

;STATIC_ASSERT $4000-@ == BANK_0_END_LEN
;Layout_BTypeInGame::
	;INCBIN "data/layout_bTypeInGame.bin", 0, $4000-@
;	INCBIN "data/layout_bTypeInGame.bin"

    
;SECTION "ROM Bank $001", ROMX[$4000], BANK[$1]

	;INCBIN "data/layout_bTypeInGame.bin", BANK_0_END_LEN

Gfx_Ascii::
	INCBIN "build/ascii.1bpp"
.end::
	
Gfx_TitleScreen::
	INCBIN "build/titleScreen.2bpp"
.end::

Layout_Copyright::
	INCBIN "data/layout_copyright.bin"

Layout_TitleScreen::
	INCBIN "data/layout_titleScreen_day.bin"

;Layout_GameMusicTypeScreen::
;	INCBIN "data/layout_gameMusicTypeScreen.bin"

;Layout_ATypeSelectionScreen::
;	INCBIN "data/layout_aTypeSelectionScreen.bin"

;Layout_BTypeSelectionScreen::
;	INCBIN "data/layout_bTypeSelectionScreen.bin"

GameScreenLayout_Dancers::
	INCBIN "data/gameScreenLayout_dancers.bin"

Layout_RocketScene::
	INCBIN "data/layout_rocketScene.bin"

Layout_MarioLuigiScreen::
	INCBIN "data/layout_marioLuigiScreen.bin"

Layout_2PlayerInGame::
	INCBIN "data/layout_2PlayerInGame.bin"

Layout_MarioScore::
	INCBIN "data/layout_marioScore.bin"
	
Layout_BricksAndLuigiScore::
	INCBIN "data/layout_bricksAndLuigiScore.bin"

;Layout_Options::
;	INCBIN "data/layout_options.bin"

Gfx_RocketScene::
	INCBIN "build/rocketScene.2bpp"
.end::

SECTION "Sunrise/Sunset Layouts", ROMX[$5200], BANK[$2]
Layout_TitleScreen_Sunrise_Sunset::
	INCBIN "data/layout_titleScreen_sunrise_set.bin"

Layout_RocketScene_Sunrise_Sunset::
	INCBIN "data/layout_rocketScene_sunrise_set.bin"
.end

PieceColorLookUpTable:
    db $04, $01, $00, $02, $02, $05, $03
.end
PiecePreviewColorLookUpTable:
    db $04, $01, $00, $02, $02, $01, $03
.end
SECTION "Night Layouts", ROMX[$4200], BANK[$3]
Layout_TitleScreen_Night::
    INCBIN "data/layout_titleScreen_night.bin"
	
Layout_RocketScene_Night::
	INCBIN "data/layout_rocketScene_night.bin"

GameScreenLayout_Dancers_Night::
	INCBIN "data/gameScreenLayout_dancers_night.bin"
.end

SECTION "Palettes and Attribute Maps", ROMX, BANK[$3]
Palettes_TitleScreen::
	incbin "data/palettes_titleScreen.bin"

Palettes_InGameGuideline::
	incbin "data/palettes_inGameGuideline.bin"

Palettes_InGameSega::
	incbin "data/palettes_inGameSega.bin"

Palettes_BoardBackgroundStart::
	incbin "data/palettes_boardBackgroundStart.bin"

Palettes_BoardBackgroundTransition::
	incbin "data/palettes_boardBackgroundTransition.bin"

Attributes_TitleScreen::
	incbin "data/palmap_titleScreen.bin"

Layout_TitleScreen_NoRTC::
	incbin "data/layout_titleScreen_noRTC.bin"

Attributes_GameMusicTypeScreen::
	incbin "data/palmap_gameMusicTypeScreen.bin"

Attributes_ATypeSelectionScreen::
	incbin "data/palmap_aTypeSelectionScreen.bin"

Attributes_BTypeSelectionScreen::
	incbin "data/palmap_bTypeSelectionScreen.bin"

Attributes_ATypeInGame::
	incbin "data/palmap_aTypeInGameRosy.bin"

Attributes_BTypeInGame::
	incbin "data/palmap_bTypeInGameRosy.bin"

Layout_ATypePaused::
	incbin "data/layout_aTypePausedRosy.bin"

Layout_BTypePaused::
	incbin "data/layout_bTypePausedRosy.bin"
.end
Layout_DMG::
	incbin "data/layout_dmg.bin"

Palettes_BType::
	incbin "data/palettes_bType.bin"

Palettes_2P::
	incbin "data/palettes_2P.bin"


BoardBackgroundColorTransition::
	; Return if not in the correct state
	ld a, [wBoardBackgroundColorTransitionState]
	and a
	ret z
	; are we already doing the transition?
	ld a, [wTransitionTimer]
	and a
	jr nz, .skipTimerSet
	; set the timer
	ld a, 15
	ld [wTransitionTimer], a
	xor a
	ld [wTransitionTimer+1], a
.skipTimerSet
	; get the correct color offset
	ld de, Palettes_BoardBackgroundTransition
	; Level Color
	ld a, [wBoardBackgroundColorTransitionState]
	dec a
	add a
	add a
	add a
	ld h, 0
	ld l, a
	add hl, de
	ld d, h
	ld e, l
	; Time Color
	ld a, [sIsDay_DuskDawn_Night]
	add a
	add a
	add a
	add a
	add a
	add a
	add a, 2
	ld h, 0
	ld l, a
	add hl, de
	ld d, h
	ld e, l
.updateColor
	ld a, [wTransitionTimer+1]
	ld h, 0
	ld l, a
	add hl, de
	ld d, h
	ld e, l
	ld hl, rBCPS
	ld c, 2
	ld b, 28+$80
	call CopyPalettesToCram
	ld hl, wTransitionTimer
	dec [hl]
	ld a, [hl]
	and a
	jp z, .doneWaiting
	ret
.doneWaiting
    ld a, 15
	ld [wTransitionTimer], a
	ld a, [wTransitionTimer+1]
	add a, 2
	ld [wTransitionTimer+1], a
	cp a, 8
	jr z, .doneTransition
	ret
.doneTransition
	xor a
	ld [wBoardBackgroundColorTransitionState], a
	ld [wTransitionTimer], a
	ld [wTransitionTimer+1], a
	ret

Gfx_GridAnimation::
	INCBIN "build/gridAnimation.2bpp"

AnimateGrid::
	; Return if game paused
	ld a, [hGamePaused]
	and a
	ret nz
	; Return if wrong Game State
	ld a, [hGameState]
	cp a, $1A
	jr z, .continue
	and a
	ret nz
.continue
	; are we already doing the transition?
	ld a, [wUpdateTimer]
	and a
	jr nz, .skipTimerSet
	; set the timer
	ld a, 15
	ld [wUpdateTimer], a
	xor a
	ld [wUpdateTimer+1], a
.skipTimerSet
	; get the correct color offset
	ld hl, Gfx_GridAnimation
.updateGrid
	ld a, [wUpdateTimer+1]
	ld d, 0
	ld e, a
	add hl, de
	ld de, _VRAM+$330
	ld bc, 32
	call CopyHLtoDE_BCbytes
	ld hl, wUpdateTimer
	dec [hl]
	ld a, [hl]
	and a
	jp z, .doneWaiting
	ret
.doneWaiting
    ld a, 15
	ld [wUpdateTimer], a
	ld a, [wUpdateTimer+1]
	add a, 32
	ld [wUpdateTimer+1], a
	cp a, 128
	jr z, .doneLoop
	ret
.doneLoop
	xor a
	ld [wUpdateTimer], a
	ld [wUpdateTimer+1], a
	ret

CheckIfOtherPlayerCleared2PlusLines2::
    ldh  a, [hOtherPlayersMultiplierToProcess]                   ; $0c8c
    and  a                                                       ; $0c8e
    jr   z, .checkIfMultiplierToProcess                          ; $0c8f

; if multiplier to process, and exec'd function to play next piece, jump
    bit  7, a                                                    ; $0c91
    ret  z                                                       ; $0c93

    and  $07                                                     ; $0c94
    jr   .multiplierToProcessAfterPlayingPiece                  ; $0c96

.checkIfMultiplierToProcess:
; continue if other player cleared 2+ lines
    ldh  a, [h2toThePowerOf_OtherPlayersLinesClearedMinus1]      ; $0c98
    and  a                                                       ; $0c9a
    ret  z                                                       ; $0c9b

; store the multiplier once, dont do anything until after a piece is played
    ldh  [hOtherPlayersMultiplierToProcess], a                   ; $0c9c
    xor  a                                                       ; $0c9e
    ldh  [h2toThePowerOf_OtherPlayersLinesClearedMinus1], a      ; $0c9f
    ret                                                          ; $0ca1

.multiplierToProcessAfterPlayingPiece:
; 1, 2 or 4 in C
    ld   c, a                                                    ; $0ca2
    push bc                                                      ; $0ca3

; get starting row, the higher the other player's multiplier,
; the higher we're shifting rows
    ld   hl, sGameScreenBufferAttr+$22                               ; $0ca4
    ld   de, -GB_TILE_WIDTH                                      ; $0ca7

.getStartingRow:
    add  hl, de                                                  ; $0caa
    dec  c                                                       ; $0cab
    jr   nz, .getStartingRow                                     ; $0cac

; hl is high up, de is top of screen
    ld   de, sGameScreenBufferAttr+$22                               ; $0cae
    ld   c, GAME_SCREEN_ROWS-1                                   ; $0cb1

; copy rows upwards
.copyNextRow:
    ld   b, GAME_SQUARE_WIDTH                                    ; $0cb3

.copyNextCol:
    ld   a, [de]                                                 ; $0cb5
    ld   [hl+], a                                                ; $0cb6
    inc  e                                                       ; $0cb7
    dec  b                                                       ; $0cb8
    jr   nz, .copyNextCol                                        ; $0cb9

; hl to next row
    push de                                                      ; $0cbb
    ld   de, GB_TILE_WIDTH-GAME_SQUARE_WIDTH                     ; $0cbc
    add  hl, de                                                  ; $0cbf
    pop  de                                                      ; $0cc0

; de to next row
    push hl                                                      ; $0cc1
    ld   hl, GB_TILE_WIDTH-GAME_SQUARE_WIDTH                     ; $0cc2
    add  hl, de                                                  ; $0cc5
    push hl                                                      ; $0cc6
    pop  de                                                      ; $0cc7
    pop  hl                                                      ; $0cc8

    dec  c                                                       ; $0cc9
    jr   nz, .copyNextRow                                        ; $0cca

    

; C is multiplier, hl now bottom of high-related blocks
    pop  bc                                                      ; $0ccc

; copy dark solid blocks underneath our loaded high-related blocks
.copyDarkSolidRow:
    ld   de, wDarkSolidBlocksUnderRandomBlocks                   ; $0ccd
    ld   b, GAME_SQUARE_WIDTH                                    ; $0cd0

.copyDarkSolidCol:
    ld   a, [de]     
	cp a, $28
	jr nz, .no 
	ld a, 4
	jr .do
.no
	ld a, 3  
.do                                          ; $0cd2
    ld   [hl+], a                                                ; $0cd3
    inc  de                                                      ; $0cd4
    dec  b                                                       ; $0cd5
    jr   nz, .copyDarkSolidCol                                   ; $0cd6

    push de                                                      ; $0cd8
    ld   de, GB_TILE_WIDTH-GAME_SQUARE_WIDTH                     ; $0cd9
    add  hl, de                                                  ; $0cdc
    pop  de                                                      ; $0cdd
    dec  c                                                       ; $0cde
    jr   nz, .copyDarkSolidRow                                   ; $0cdf
	ret

SECTION "Rosy Retrospection Graphics", ROMX[$5cc5], BANK[$4]
;Attributes_ATypeInGameRosy::
;	incbin "data/palmap_aTypeInGameRosy.bin"

;Attributes_BTypeInGameRosy::
;	incbin "data/palmap_bTypeInGameRosy.bin"

;Layout_ATypePausedRosy::
;	incbin "data/layout_aTypePausedRosy.bin"

;Layout_BTypePausedRosy::
;	incbin "data/layout_bTypePausedRosy.bin"
;.end
Gfx_MenuScreensVBK1:
	INCBIN "build/menuScreensVBK1.2bpp"
.end:
