
GameState24_CopyrightDisplay::
; check for RTC
    ld a, [sPlaceholder]
	ld c, a
	ld a, 09
	ld [rRAMB], a
	ld a, [_SRAM]
	ld b, a
	ld a, c
	ld [_SRAM], a
	xor a
	ld [rRAMB], a
	ld a, b
	ld [sRTCAvailable], a
; switch to bank 1 for graphics data	
	ld a, BANK_GRAPHICS_AND_LAYOUTS
	ld [rROMB0], a
	
	call TurnOffLCD                                                 ; $0369

	call CopyAsciiAndTitleScreenTileData                            ; $036c
	ld   de, Layout_Copyright                                       ; $036f
	call CopyLayoutToScreen0   
	ld a, BANK_DEMO_AND_NIGHT_GRAPHICS
	ld [rROMB0], a
	ld de, Palettes_TitleScreen
	xor a
	ld [sSkipBg], a
	call LoadTimeBasedPalettes
	ld a, BANK_GRAPHICS_AND_LAYOUTS
	ld [rROMB0], a                              ; $0372
	call Clear_wOam                                                 ; $0375

; switch to demo pieces bank
	ld a, BANK_DEMO_AND_NIGHT_GRAPHICS
	ld [rROMB0], a
	
; set demo pieces
	ld   hl, wDemoOrMultiplayerPieces                               ; $0378
	ld   de, DemoPieces                                             ; $037b

.copyLoop:
	ld   a, [de]                                                    ; $037e
	ld   [hl+], a                                                   ; $037f
	inc  de                                                         ; $0380
	ld   a, h                                                       ; $0381
	cp   HIGH(wDemoOrMultiplayerPieces.end)                         ; $0382
	jr   nz, .copyLoop                                              ; $0384

; show all, with bg data at $8000, displayed at $9800
	ld   a, LCDCF_ON|LCDCF_WIN9C00|LCDCF_BG8000|LCDCF_OBJON|LCDCF_BGON ; $0386
	ldh  [rLCDC], a                                                 ; $0388

; timer until title screen
	ld   a, $fa                                                     ; $038a
	ldh  [hTimer1], a                                               ; $038c

; set next game state
	ld   a, GS_COPYRIGHT_WAITING                                    ; $038e
	ldh  [hGameState], a                                            ; $0390
	ret                                                             ; $0392


GameState25_CopyrightWaiting:
; check for inputs and skip copyright screen or wait for timer, set a new one, then go to next state
    ldh  a, [hButtonsPressed]                                       ; $03a0
	and  a                                                          ; $03a2
	jr   nz, GameState35_CopyrightCanContinue                                         ; $03a3
	ldh  a, [hButtonsHeld]                                       ; $03a0
	and  a                                                          ; $03a2
	jr   nz, GameState35_CopyrightCanContinue 
	ldh  a, [hTimer1]                                               ; $0393
	and  a                                                          ; $0395
	ret  nz                                                         ; $0396

	ld   a, $fa                                                     ; $0397
	ldh  [hTimer1], a                                               ; $0399
	ld   a, GS_COPYRIGHT_CAN_CONTINUE                               ; $039b
	ldh  [hGameState], a                                            ; $039d
	ret                                                             ; $039f


GameState35_CopyrightCanContinue:
; go to next game state, when timer is done, or a button is pressed
	ldh  a, [hButtonsPressed]                                       ; $03a0
	and  a                                                          ; $03a2
	jr   nz, .setNewState                                           ; $03a3
	ldh  a, [hButtonsHeld]                                       ; $03a0
	and  a                                                          ; $03a2
	jr   nz, .setNewState 

	ldh  a, [hTimer1]                                               ; $03a5
	and  a                                                          ; $03a7
	ret  nz                                                         ; $03a8

.setNewState:
	ld   a, GS_TITLE_SCREEN_INIT                                    ; $03a9
	ldh  [hGameState], a                                            ; $03ab
	ret                                                             ; $03ad


GameState06_TitleScreenInit::
; switch to bank 1 for graphics data	
	ld a, BANK_GRAPHICS_AND_LAYOUTS
	ld [rROMB0], a
	
	call TurnOffLCD                                                 ; $03ae

; reset some vars
	xor  a                                                          ; $03b1
	ldh  [hIsRecordingDemo], a                                      ; $03b2
	ldh  [hPieceFallingState], a                                    ; $03b4
	ldh  [hTetrisFlashCount], a                                     ; $03b6
	ldh  [hPieceCollisionDetected], a                               ; $03b8
	ldh  [h1stHighScoreHighestByteForLevel], a                      ; $03ba
	ldh  [hNumLinesCompletedBCD+1], a                               ; $03bc
	ldh  [hRowsShiftingDownState], a                                ; $03be
	ldh  [hMustEnterHighScore], a                                   ; $03c0

; clear some in-game vars and load gfx
	call ClearPointersToCompletedTetrisRows                         ; $03c2
	call ClearScoreCategoryVarsAndTotalScore                        ; $03c5
	call CopyAsciiAndTitleScreenTileData                            ; $03c8

; clear screen buffer
	ld   hl, wGameScreenBuffer                                      ; $03cb

.clearScreenBuffer:
	ld   a, TILE_EMPTY                                              ; $03ce
	ld   [hl+], a                                                   ; $03d0
	ld   a, h                                                       ; $03d1
	cp   HIGH(wGameScreenBuffer.end)                                ; $03d2
	jr   nz, .clearScreenBuffer                                     ; $03d4

; black lines where game bricks would be
	ld   hl, wGameScreenBuffer+1                                    ; $03d6
	call DisplayBlackColumnFromHLdown                               ; $03d9
	ld   hl, wGameScreenBuffer+$c                                   ; $03dc
	call DisplayBlackColumnFromHLdown                               ; $03df

; black row under screen
	ld   hl, wGameScreenBuffer+$241                                 ; $03e2
	ld   b, $0c                                                     ; $03e5
	ld   a, TILE_BLACK                                              ; $03e7

.displayBlackRow:
	ld   [hl+], a                                                   ; $03e9
	dec  b                                                          ; $03ea
	jr   nz, .displayBlackRow                                       ; $03eb

; set display and oam
; set correct bank based on time
    ld a, [sRTCAvailable]
	and a
	jr z, .noRTCLayout
    ld a, [sIsDay_DuskDawn_Night]
	inc a
	ld [rROMB0], a
	cp a, 2
	jr z, .sunriseOrSunset
	cp a, 3
	jr z, .night
	ld   de, Layout_TitleScreen  
	jr .copy         
.sunriseOrSunset
	ld   de, Layout_TitleScreen_Sunrise_Sunset
	jr .copy
.night 
	ld   de, Layout_TitleScreen_Night
	jr .copy
.noRTCLayout
	ld a, 3
	ld [rROMB0], a
	ld   de, Layout_TitleScreen_NoRTC    
.copy                     ; $03ed
	call CopyLayoutAndAttrToScreen0        
	ld a, BANK_DEMO_AND_NIGHT_GRAPHICS
	ld [rROMB0], a  
	ld de, Palettes_TitleScreen
	xor a
	ld [sSkipBg], a
    call LoadTimeBasedPalettes
	ld a, BANK_GRAPHICS_AND_LAYOUTS
	ld [rROMB0], a  
	xor a
	; set the bank back
	inc a
	ld [rROMB0], a                             ; $03f0
	call Clear_wOam                                                 ; $03f3

; cursor OAM
	ld   hl, wOam                                                   ; $03f6
	ld   [hl], $80                                                  ; $03f9
	inc  l                                                          ; $03fb
	ld   [hl], $08                                                 ; $03fc
	inc  l                                                          ; $03fe
	ld   [hl], TILE_CURSOR                                          ; $03ff

; start playing sound
	ld   a, MUS_TITLE_SCREEN                                        ; $0401
	ld   [wSongToStart], a                                          ; $0403

; set LCD state, game state and timer
	ld   a, LCDCF_ON|LCDCF_WIN9C00|LCDCF_BG8000|LCDCF_OBJON|LCDCF_BGON ; $0406
	ldh  [rLCDC], a                                                 ; $0408
	ld   a, GS_TITLE_SCREEN_MAIN                                    ; $040a
	ldh  [hGameState], a                                            ; $040c
	ld   a, $7d                                                     ; $040e
	ldh  [hTimer1], a                                               ; $0410

; if demo had played, shorter timer before next demo
	ld   a, $04                                                     ; $0412
	ldh  [hTimerMultiplier], a                                      ; $0414

	ldh  a, [hPrevOrCurrDemoPlayed]                                 ; $0416
	and  a                                                          ; $0418
	ret  nz                                                         ; $0419

; else set a longer time
	ld   a, $13                                                     ; $041a
	ldh  [hTimerMultiplier], a                                      ; $041c
	ret                                                             ; $041e


PlayDemo:
;load demo pieces & inputs bank
	ld a, BANK_DEMO_AND_NIGHT_GRAPHICS
	ld [rROMB0], a

	ld   a, GAME_TYPE_A_TYPE                                        ; $041f
	ldh  [hGameType], a                                             ; $0421

; for demo 2, a type level 9
	ld   a, $09                                                     ; $0423
	ldh  [hATypeLevel], a                                           ; $0425

; defaults for either demo
	xor  a                                                          ; $0427
	ldh  [hIs2Player], a                                            ; $0428
	ldh  [hLowByteOfCurrDemoStepAddress], a                         ; $042a
	ldh  [hDemoButtonsHeld], a                                      ; $042c
	ldh  [hFramesUntilNextDemoInput], a                             ; $042e

; demo 2 input address
	ld   a, HIGH(Demo2Inputs)                                       ; $0430
	ldh  [hAddressOfDemoInput], a                                   ; $0432
	ld   a, LOW(Demo2Inputs)                                        ; $0434
	ldh  [hAddressOfDemoInput+1], a                                 ; $0436

; flip between demo 1 and 2
	ldh  a, [hPrevOrCurrDemoPlayed]                                 ; $0438
	cp   $02                                                        ; $043a
	ld   a, $02                                                     ; $043c
	jr   nz, .setDemoPlayed                                         ; $043e

; for demo 1 - b type level 9, high 2
	ld   a, GAME_TYPE_B_TYPE                                        ; $0440
	ldh  [hGameType], a                                             ; $0442
	ld   a, $09                                                     ; $0444
	ldh  [hBTypeLevel], a                                           ; $0446
	ld   a, $02                                                     ; $0448
	ldh  [hBTypeHigh], a                                            ; $044a

; demo 1 input address
	ld   a, HIGH(Demo1Inputs)                                       ; $044c
	ldh  [hAddressOfDemoInput], a                                   ; $044e
	ld   a, LOW(Demo1Inputs)                                        ; $0450
	ldh  [hAddressOfDemoInput+1], a                                 ; $0452

; start from step $11 (after demo 2's steps)
	ld   a, $11                                                     ; $0454
	ldh  [hLowByteOfCurrDemoStepAddress], a                         ; $0456
	ld   a, $01                                                     ; $0458

.setDemoPlayed:
	ldh  [hPrevOrCurrDemoPlayed], a                                 ; $045a

; set game state
	ld   a, GS_IN_GAME_INIT                                         ; $045c
	ldh  [hGameState], a                                            ; $045e

; load screen while lcd off
	call TurnOffLCD                                                 ; $0460
	call LoadAsciiAndMenuScreenGfx                                  ; $0463
	ld   de, Attributes_GameMusicTypeScreen                            ; $0466
	call CopyLayoutAndAttrToScreen0                                        ; $0469
	call Clear_wOam                                                 ; $046c

; turn on LCD
	ld   a, LCDCF_ON|LCDCF_WIN9C00|LCDCF_BG8000|LCDCF_OBJON|LCDCF_BGON ; $046f
	ldh  [rLCDC], a                                                 ; $0471
	ret                                                             ; $0473


UnusedSetRecordingDemo:
	ld   a, $ff                                                     ; $0474
	ldh  [hIsRecordingDemo], a                                      ; $0476
	ret                                                             ; $0478


GameState07_TitleScreenMain:
; timer multiplier * $7d until a demo plays
	ldh  a, [hTimer1]                                               ; $0479
	and  a                                                          ; $047b
	jr   nz, .afterTimerCheck                                       ; $047c

	ld   hl, hTimerMultiplier                                       ; $047e
	dec  [hl]                                                       ; $0481
	jr   z, PlayDemo                                                ; $0482

	ld   a, $7d                                                     ; $0484
	ldh  [hTimer1], a                                               ; $0486

.afterTimerCheck:
; send $55 to indicate to a master GB that we're active
	call SerialTransferWaitFunc                                     ; $0488
	ld   a, SB_PASSIVES_PING_IN_TITLE_SCREEN                        ; $048b
	ldh  [rSB], a                                                   ; $048d
	ld   a, SC_REQUEST_TRANSFER|SC_PASSIVE                          ; $048f
	ldh  [rSC], a                                                   ; $0491

; if a byte was processed..
	ldh  a, [hSerialInterruptHandled]                               ; $0493
	and  a                                                          ; $0495
	jr   z, .checkButtonsPressed                                    ; $0496

; and we've been assigned a role, go to multiplayer state
; ie auto-start for passive GB
	ldh  a, [hMultiplayerPlayerRole]                                ; $0498
	and  a                                                          ; $049a
	jp   nz, .setGameStateTo2ah                                     ; $049b

; otherwise state is invalid
	xor  a                                                          ; $049d
	ldh  [hSerialInterruptHandled], a                               ; $049e
	jp   .multiplayerInvalid                                        ; $04a0

.checkButtonsPressed:
; buttons pressed in B, is 2 player in A
	ldh  a, [hButtonsPressed]                                       ; $04a2
	ld   b, a                                                       ; $04a4
	ldh  a, [hIs2Player]                                            ; $04a5

; select flips between 2 options, left/right does as intended
; ignore all the following if on options menu
    ld c, a
    ld a, [hIsOptionMenu]
    cp a, 1
	ld a, c
    jp z, .optionMenu

	bit  PADB_SELECT, b                                             ; $04a7
	jp   nz, .flipNumPlayersOption                                  ; $04a9

	bit  PADB_RIGHT, b                                              ; $04ab
	jp   nz, .pressedRight                                          ; $04ad

	bit  PADB_LEFT, b                                               ; $04af
	jp   nz, .pressedLeft                                           ; $04b1

	bit PADB_DOWN, b
    jp nz, .pressedDown

	bit PADB_UP, b
	jp nz, .pressedUp

; start or A to select an option, other buttons are invalid
; if options menu, ignore this
    ld c, a
    ld a, [hIsOptionMenu]
	cp a, 1
	jp z, .optionMenu
	ld a, c
	bit  PADB_START, b   
	jr nz, :+
	bit  PADB_A, b                                                  ; $04b3
	ret  z
	                                                                ; $04b5
; if options, scroll down the screen and jump to the menu handler
:   cp a, 2
	jr nz, .playerChecks
.scrollLoop
	ld b, $ff
	ld c, $2 
	ld hl, rSCY
:	dec b
	jr nz, :-
	dec c
	jr nz, :-
	inc [hl]
	ld a, [hl]
	cp a, $80
	jp z, .optionMenu
	jr .scrollLoop
.playerChecks
; if 1 player, set 1player state in A
	and  a                                                          ; $04b6
	ld   a, GS_GAME_MUSIC_TYPE_INIT                                 ; $04b7
	jr   z, .is1Player                                              ; $04b9

; 2-player start
	ld   a, b                                                       ; $04bb
	cp   PADF_START                                                 ; $04bc
	ret  nz                                                         ; $04be

; if we're still master, continue
	ldh  a, [hMultiplayerPlayerRole]                                ; $04bf
	cp   MP_ROLE_MASTER                                             ; $04c1
	jr   z, .setGameStateTo2ah                                      ; $04c3

; if 1st gb to press start, send a start request and wait for a reponse
	ld   a, SB_MASTER_PRESSING_START                                ; $04c5
	ldh  [rSB], a                                                   ; $04c7
	ld   a, SC_REQUEST_TRANSFER|SC_MASTER                           ; $04c9
	ldh  [rSC], a                                                   ; $04cb

.waitUntilSerialIntHandled:
	ldh  a, [hSerialInterruptHandled]                               ; $04cd
	and  a                                                          ; $04cf
	jr   z, .waitUntilSerialIntHandled                              ; $04d0

; if not assigned a role, no listening gb
	ldh  a, [hMultiplayerPlayerRole]                                ; $04d2
	and  a                                                          ; $04d4
	jr   z, .multiplayerInvalid                                     ; $04d5

.setGameStateTo2ah:
	ld   a, GS_2PLAYER_GAME_MUSIC_TYPE_INIT                         ; $04d7

.setGameState:
	ldh  [hGameState], a                                            ; $04d9

; clear main timer, level and b type high, and demo played
	xor  a                                                          ; $04db
	ldh  [hTimer1], a                                               ; $04dc
	ldh  [hATypeLevel], a                                           ; $04de
	ldh  [hBTypeLevel], a                                           ; $04e0
	ldh  [hBTypeHigh], a                                            ; $04e2
	ldh  [hPrevOrCurrDemoPlayed], a                                 ; $04e4
	ret                                                             ; $04e6

.is1Player:
	push af                                                         ; $04e7
; if up held while on title screen, set hard mode
	ldh  a, [hButtonsHeld]                                          ; $04e8
	bit  PADB_UP, a                                               ; $04ea
	jr   z, .afterUpCheck                                         ; $04ec

	ldh  [hIsHardMode], a                                           ; $04ee

.afterUpCheck:
	pop  af                                                         ; $04f0
	jr   .setGameState                                              ; $04f1

.flipNumPlayersOption:
	xor  $01                                                        ; $04f3

.setNumPlayersOpt:
	ldh  [hIs2Player], a                                            ; $04f5

; set cursor X and Y based on if 1 player, 2 players or options
; again, ignore if options menu
    ld c, a
    ld a, [hIsOptionMenu]
    cp a, 1
	jr z, .optionMenu
	ld a, c
	cp   a, $00
	jr nz, :+
	ld a, $80
    ld   [wOam+OAM_Y], a                                                    ; $04f7
 	ld   a, $08
	jr   z, .setCursorX                                                    ; $04f8
:   cp a, $01
    jr nz, :+
	ld a, $80
    ld   [wOam+OAM_Y], a                                                                ; $04fa
	ld   a, $58
	jr   z, .setCursorX
:   ld a, $90
    ld   [wOam+OAM_Y], a
	ld a, $30                                                                     ; $04fc

.setCursorX:
	ld   [wOam+OAM_X], a                                            ; $04fe
	ret                                                             ; $0501

.pressedRight:
; ret if already 2 player
	cp a, $01                                                         ; $0502
	ret  z                                                         ; $0503

	xor  a                                                          ; $0504
	jr   .flipNumPlayersOption                                      ; $0505

.pressedLeft:
; ret if already 1 player
	and  a                                                          ; $0507
	ret  z
    jr   .multiplayerInvalid                                        ; $0508

.pressedDown
; move the cursor to the "Options" tag
; if already at it, move down to the options menu
    cp a, 2
	jp z, .scrollLoop
    ld a, $02
	jr .setNumPlayersOpt

.pressedUp
; move cursor back to the "1PLAYER/2PLAYERS" line
    xor a
	jr .setNumPlayersOpt

.multiplayerInvalid:
; set to 1 player
	xor  a                                                          ; $0509
	jr   .setNumPlayersOpt                                          ; $050a

.optionMenu
	ld a, 1
	ld [hIsOptionMenu], a
	ld a, $08
	ld   [wOam+OAM_X], a  
	;check for RTC
	ld a, [sRTCAvailable]
	and a
	jr nz, .cursorPos
.noRTC
	ld a, 1
	ld [hSelectedOption], a
.cursorPos
; set cursor Y based on selected option
    ld a, [hSelectedOption]
    cp   a, OPTION_LIGHTS_ID
    jr nz, :+                                                 ; $04f7
    ld   a, OPTION_LIGHTS_Y
    jr   z, .setCursorY                                                    ; $04f8
:   cp a, OPTION_COLORS_ID
    jr nz, :+                                                              ; $04fa
    ld   a, OPTION_COLORS_Y
    jr   z, .setCursorY
:   cp a, OPTION_DAYNIGHT_CYCLE_ID
    jr nz, :+  
    ld a, OPTION_DAYNIGHT_CYCLE_Y   
	jr   z, .setCursorY 
:   cp a, OPTION_ROSY_RETRO_MODE
    jr nz, :+
	ld a, OPTION_ROSY_RETRO_MODE_Y
	jr   z, .setCursorY 
:   ld a, OPTION_TIME_Y   
	                                                             ; $04fc

.setCursorY:
    ld   [wOam+OAM_Y], a                                            ; $04fe  
	ld hl, hSelectedOption
	ld a, [hl]
	cp a, OPTION_HOURS_ID
	jp z, .hours
	cp a, OPTION_MINUTES_ID
	jp z, .minutes
.checkButtonsPressedOptions
	bit PADB_DOWN, b
    jp nz, .pressedDownOptions

	bit PADB_RIGHT, b
	jp nz, .pressedDownOptions

	bit PADB_LEFT, b
	jp nz, .pressedUpOptions

	bit PADB_UP, b
	jp nz, .pressedUpOptions

	bit PADB_B, b
	jp nz, .pressedBOptions

	bit PADB_A, b
	jp nz, .pressedAOptions
    push bc
    ld hl, $9b81
	call UpdateClock

.updateToggledOptions
	xor a, a
	ld [rRAMB], a
	ld c, 4
	ld b, a
	ld a, [sRTCAvailable]
	and a
	ld a, b
	jr nz, .updateLoop
.noRTCOptionToggle
	ld a, 1
	ld c, 2
.updateLoop
	push af
	push bc
	; get the state of the option
	ld h, HIGH(sOptionLights)
	ld b, LOW(sOptionLights)
	ld d, a
	add a, b
	ld l, a
    ld a, [hl]
	ld e, a
    ld a, d
	; update the toggle tile
	call ChangeToggleTile
	pop bc
	pop af
	ld b, a
	ld a, [sRTCAvailable]
	and a
	ld a, b
	jr nz, .incOnce
.incTwice
	inc a
.incOnce
	inc a
    dec c
	jr nz, .updateLoop
	pop bc
	bit PADB_A, b
	ret z
.pressedDownOptions
	ld hl, hSelectedOption
	;check for RTC
	ld a, [sRTCAvailable]
	and a
	jr z, .noRTCDown
; if already at the last option, return
	ld a, [hl]
	cp a, OPTION_TIME_ID
	ret z
	inc [hl]
	jr .returnDown
.noRTCDown
	; if already at the last option, return
	ld a, [hl]
	cp a, OPTION_ROSY_RETRO_MODE
	ret z
	inc [hl]
	inc [hl]
	ret
.returnDown
	ret 

.pressedUpOptions
	;check for RTC
	ld a, [sRTCAvailable]
	and a
	jr z, .noRTCUp
; if already at the first option, go back
	ld hl, hSelectedOption
	ld a, [hl]
	cp a, OPTION_LIGHTS_ID
    jr z, .pressedBOptions
	dec [hl]
	ret
.noRTCUp
	ld hl, hSelectedOption
	ld a, [hl]
	cp a, OPTION_COLORS_ID
    jr z, .pressedBOptions
	dec [hl]
	dec [hl]
	ret 

.pressedBOptions
; leave the option menu
.scrollLoopBack
	ld b, $ff
	ld c, $2 
	ld hl, rSCY
:	dec b
	jr nz, :-
	dec c
	jr nz, :-
	dec [hl]
	ld a, [hl]
	cp a, $00
	jp z, .doneScrolling
	jr .scrollLoopBack
.doneScrolling
	ld a, $30
	ld   [wOam+OAM_X], a  
	ld a, $90
	ld   [wOam+OAM_Y], a  
	xor a
	ld [hIsOptionMenu], a
	ld a, 2
	ret

.pressedAOptions
; toggle the option on or off
	ld hl, hSelectedOption
	ld a, [hl]
	cp a, OPTION_TIME_ID
    jr z, .setTime
	ld h, HIGH(sOptionLights)
	ld b, LOW(sOptionLights)
	add a, b
	ld l, a
    ld a, [hl]
	inc a
	and a, 1
	ld [hl], a
	ld e, a
	ld hl, hSelectedOption
	ld a, [hl]
    call ChangeToggleTile
    ret
.setTime
; invert the palette
	call InvertPalettes
; Open SRAM
	ld a, $0A
	ld [$0000], a
.hours
	ld a, OPTION_HOURS_ID
	ld [hSelectedOption], a
; Access Hour Register
    xor a
	ld [$6000], a
	inc a
	ld [$6000], a
	ld a, $0a
	ld [$4000], a
	ld a, $68
	ld   [wOam+OAM_Y], a  
	ld a, $14
	ld   [wOam+OAM_X], a 
	ld a, "v"
	ld   [wOam+OAM_TILE_IDX], a 
	ld a, [$a000]
	ld d, a
	ldh  a, [hButtonsPressed]                                     ; $04a2
	ld   b, a                                                       ; $04a4

	bit  PADB_RIGHT, b                                              ; $04ab
	jp   nz, .minutes                                          ; $04ad

	bit PADB_DOWN, b
    jp nz, .decreaseHours

	bit PADB_UP, b
	jp nz, .increaseHours

	bit PADB_B, b
	jp nz, .exit
	xor a
	ld [$4000], a
	ret z
.decreaseHours
	ld a, d
	dec a
	cp a, $ff
    jr nz, .updateDecH
	ld a, 23
.updateDecH
	ld [$a000], a
	call SeparateTens
    ld hl, $9b81
	call WaitVRAM
    ld c, a
    ld a, b
    ldi [hl], a
    ld a, c
    ld [hl], a
	xor a
	ld [$4000], a
;    jp .hours
	ret
.increaseHours
	ld a, d
	inc a
	cp a, 24
    jr nz, .updateIncH
	ld a, 0
.updateIncH
	ld [$a000], a
	call SeparateTens
    ld hl, $9b81
	call WaitVRAM
    ld c, a
    ld a, b
    ldi [hl], a
    ld a, c
    ld [hl], a
	xor a
	ld [$4000], a
;    jp .hours
	ret 
.minutes
	ld a, OPTION_MINUTES_ID
	ld [hSelectedOption], a
	; Access Minute Register
	xor a
	ld [$6000], a
	inc a
	ld [$6000], a
	ld a, $09
	ld [$4000], a
	ld a, $68
	ld   [wOam+OAM_Y], a  
	ld a, $2c
	ld   [wOam+OAM_X], a 
	ld a, "v"
	ld   [wOam+OAM_TILE_IDX], a 
	ld a, [$a000]
	ld d, a
	ldh  a, [hButtonsPressed]                                      ; $04a2
	ld   b, a                                                       ; $04a4
	ld a, [$a000]

	bit  PADB_LEFT, b                                              ; $04ab
	jp   nz, .hours                                          ; $04ad

	bit PADB_DOWN, b
    jp nz, .decreaseMinutes

	bit PADB_UP, b
	jp nz, .increaseMinutes

	bit PADB_B, b
	jp nz, .exit

	bit PADB_START, b
	jp nz, .exit
	xor a
	ld [$4000], a
	ret z
.decreaseMinutes
	ld a, d
	dec a
	cp a, $ff
    jr nz, .updateDecM
	ld a, 59
.updateDecM
	ld [$a000], a
    call SeparateTens
    ld hl, $9b84
	call WaitVRAM
    ld c, a
    ld a, b
    ldi [hl], a
    ld a, c
    ld [hl], a
	ld a, $08
	ld [$4000], a
	xor a
	ld [$a000], a
	ld [$4000], a
;   jp .minutes
    ret
.increaseMinutes
	ld a, d
	inc a
	cp a, 60
    jr nz, .updateIncM
	ld a, 0
.updateIncM
	ld [$a000], a
	call SeparateTens
    ld hl, $9b84
	call WaitVRAM
    ld c, a
    ld a, b
    ldi [hl], a
    ld a, c
    ld [hl], a
	ld a, $08
	ld [$4000], a
	xor a
	ld [$a000], a
	ld [$4000], a
;    jp .minutes
    ret
.exit
	; invert the palette back
	call InvertPalettes
	; put the correct cursor tile
	ld a, ">"
	ld   [wOam+OAM_TILE_IDX], a
	ld a, OPTION_TIME_ID
	ld [hSelectedOption], a 
    ret
SeparateTens::
; in: a: value <100
; out: a: units; b: tens
    ld b, -1
.loop
	inc b
    sub 10
	jr nc, .loop
	add a, 10
	ret

ChangeToggleTile::
; get the VRAM address
	ld h, HIGH(OPTION_LIGHTS)
	ld b, LOW(OPTION_LIGHTS)
	ld c, $20
	inc a
	ld d, a
	ld a, b
:   dec d
    jr z, :+
    add a, c
	jr :-
:   ld l, a
; get the toggle back in A
    ld a, e
	ld b, "*"
; get the correct tile
	add a, b
; load it
    call WaitVRAM
    ld [hl], a
    ret

;DemocracyInput::
;	ld c, 6
;	ld hl, wPollInputResults
;.loop
;	ldi a, [hl]
;	cp a, 0
;	jr z, .zeroInput
;.nonZeroInput
;	inc b
;	ld d, h
;	ld e, l
;	dec de
;.zeroInput
;	dec c
;	jr nz, .loop
;.checkDemocracy
;	ld a, b
;	cp a, 5
;	jr c, .noInput
;.input
;	ld a, [de]
;	ld [hButtonsPressed], a
;	ret
;.noInput
;	xor a 
;	ld [hButtonsPressed], a
;	ret
	
WaitVRAM::
	push af
.loop
	ldh a, [rSTAT]
	and STATF_BUSY
	jr nz, .loop
	pop af  
	ret