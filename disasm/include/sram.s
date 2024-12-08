INCLUDE "includes.s"

SECTION "SRAM", SRAM[$A000]
sCurrMonth::
    ds 1
sCurrYear::
    ds 2
.end::