INCLUDE "includes.s"

SECTION "SRAM", SRAM[$A000]
sGameScreenBufferAttr:: 
    ds $400
.end::

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

sBTypeHighScores:: ; $d000
    ds HISCORE_SIZEOF * 10 * 6

sATypeHighScores:: ; $d654
    ds HISCORE_SIZEOF * 10
.end:: 



sSramBufferAddressesForCompletedRows:: ; 
    ds 9 ; big-endian
.end::

sIsSRAMInitialized::
    ds 1
 .end::

sSkipBg::
    ds 1
.end