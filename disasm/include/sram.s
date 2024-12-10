INCLUDE "includes.s"

SECTION "SRAM", SRAM[$A000]
sCurrMonth::
    ds 1
sCurrYear::
    ds 2
.end::
; Time Of Day
sIsDay_DuskDawn_Night::
    ds 1
.end::
sIsRocketScene::
    ds 1
.end

; option toggles
sOptionLights::
    ds 1
sOptionColors::
    ds 1 
sOptionDayNightCycle::
    ds 1
.end::

sGameScreenBufferAttr:: ; $c800
    ds $400
.end::

sBTypeHighScores:: ; $d000
    ds HISCORE_SIZEOF * 10 * 6

sATypeHighScores:: ; $d654
    ds HISCORE_SIZEOF * 10
.end:: 

sIsSRAMInitialized::
   ds 1
.end::