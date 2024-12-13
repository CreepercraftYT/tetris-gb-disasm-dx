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

Attributes_GameMusicTypeScreen::
	incbin "data/palmap_gameMusicTypeScreen.bin"

Attributes_ATypeSelectionScreen::
	incbin "data/palmap_aTypeSelectionScreen.bin"

Attributes_BTypeSelectionScreen::
	incbin "data/palmap_bTypeSelectionScreen.bin"

Attributes_ATypeInGame::
	incbin "data/palmap_aTypeInGame.bin"

Attributes_BTypeInGame::
	incbin "data/palmap_bTypeInGame.bin"

Layout_ATypePaused::
	incbin "data/layout_aTypePaused.bin"

Layout_BTypePaused::
	incbin "data/layout_bTypePaused.bin"
.end
Layout_DMG::
	incbin "data/layout_dmg.bin"

Palettes_BType::
	incbin "data/palettes_bType.bin"

IsDMG::
	ld a, 1 
	ld [rROMB0], a
	call CopyAsciiAndTitleScreenTileData
	ld a, 3
	ld [rROMB0], a
	ld de, Layout_DMG
	call CopyLayoutToScreen0
	ld a, %11100100
	ld [rBGP], a 
	jr IsDMG
.end
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
SECTION "Rosy Retrospection Data", ROMX, BANK[$4]
