;-------------------------------------------------------------------------
; Bruce Lee disassembled (BBC Micro version)
; Disassembled in 2024 by Fizgog
; BeebAsm compatible source
; 
; Location  : http://bbcmicro.co.uk/game.php?id=363
; File      : BRUCE1
; Publisher : US Gold - (C) 1985 Micro Power LTD
; Author    : D. Cowham
;-------------------------------------------------------------------------

; Game Loads at $1900 and relocates main code to $0900 
; and some minor code to $0386

NATIVE_ADDR = &0900 ; address at which code will relocate to
RELOAD_ADDR = &1900 ; address at which code will load

OFFSET      = RELOAD_ADDR - NATIVE_ADDR

INCLUDE "Constants.asm"

ORG 0

L0000   = $0000
L0001   = $0001
L0002   = $0002
L0003   = $0003
L0004   = $0004
L0006   = $0006
L0007   = $0007
L0008   = $0008
L0009   = $0009
L000A   = $000A
L000B   = $000B
L000C   = $000C
L000D   = $000D
L000E   = $000E
L000F   = $000F
L0010   = $0010
L0011   = $0011
L0012   = $0012
room_number             = $0013
L0014   = $0014
score1                  = $0015
score2                  = $0016
score3                  = $0017
highscore1              = $0018
highscore2              = $0019
highscore3              = $001A
lives                   = $001B
L001C   = $001C
L001D   = $001D
L001E   = $001E
L001F   = $001F
L0020   = $0020
L0021   = $0021
L0022   = $0022
L0023   = $0023
L0024   = $0024
palette_timer           = $0025
L0026   = $0026
speed_counter           = $0028
L0029   = $0029

rand1   = $002A 
rand2   = $002B
rand3   = $002C

lantern_counter         = $0030
in_play                 = $0031 ; $FF not playing, $00 playing
L0032   = $0032
L0033   = $0033
walking_sound_delay     = $0034
sound_flag              = $0035
L0045   = $0045
L0046   = $0046
L0047   = $0047
L0048   = $0048
L0049   = $0049
L004A   = $004A
L004B   = $004B
L004C   = $004C
L004D   = $004D
L004E   = $004E
L004F   = $004F
L0050   = $0050
L0051   = $0051

L0070   = $0070 ; Z        - Left Key 
L0071   = $0071 ; X        - Right Key 
L0072   = $0072 ; :        - Up Key 
L0073   = $0073 ; /        - Down Key 
L0074   = $0074 ; [SPACE]  - Chop or Kick Key
L0075   = $0075 ; .        - Duck Key
L0076   = $0076 ; S        - Sound Key
L0077   = $0077 ; [DELETE] - Freeze Key
L0078   = $0078 ; [COPY]   - Restart Key

; NB Cannot change these 2 values
L0079   = $0079 ; [SPACE]  - Start Key
L007A   = $007A ; [ESCAPE] - Exit Key

L007B   = $007B
L007C   = $007C
L007D   = $007D
L007E   = $007E
L007F   = $007F
L0080   = $0080
L0081   = $0081
L0082   = $0082
L0083   = $0083
L0084   = $0084
L0085   = $0085
L0086   = $0086
L0087   = $0087
L0088   = $0088
L0089   = $0089
L008A   = $008A
L008B   = $008B
L008C   = $008C
L008D   = $008D
L008E   = $008E
L008F   = $008F
knock_downs             = $0090
L0091   = $0091
L0092   = $0092
L0093   = $0093
L0094   = $0094
L0096   = $0096
L0097   = $0097
L0098   = $0098

; Some code relocated here from $4A00
L0386   = $0386
;L0386               STX $36
;                    sty $37
;                    LDY #$00
;L038c               sty $7b
;                    LDA ($36),Y
;                    bmi L03d4
;                    STA $49
;                    iny
;                    iny
;                    LDA ($36),Y
;                    STA $4b
;                    LDA $35
;                    STA $47
;                    JSR S03d5
;                    LDY $7b
;                    iny
;                    LDA ($36),Y
;                    STA $49
;                    INC $45
;                    JSR S03d5
;                    LDX #$00
;                    STX $47
;                    inx
;                    STX $4b
;                    JSR S03d5
;                    dec $45
;                    JSR S03d5
;                    LDA $35
;                    STA $47
;L03c0               LDA #$80
;                    LDX #$fa
;                    LDY #$ff
;                    JSR $fff4
;                    cpx #$0e
;                    BCC L03c0
;                    LDY $7b
;                    iny
;                    iny
;                    iny
;                    BPL L038c
;L03d4               RTS
                    
;S03d5               LDX #$45
;                    LDY #$00
;                    LDA #$07
;                    JMP $fff1
                    
;                                                              51 55 
;                    42 20 31 31 0d 21 16 05 20 0d 21 20 2e 45 51 55 
;                    42 20 77 61 6c 6c 3a 45 51 55 42 20 2d 31 3a 45 
;                    51 55 42 20 38 38 3a 45 51 55 42 20 26 46 31 3a 
;                    45 51 55 42 20 32 33 0d 21 2a 05 20 0d 21 34 30 
;                    45 51 55 42 20 77 61 6c 6c 3a 45 51 55 42 20 26 
;                    30 30 3a 45 51 55 42 20 31 36 30 3a 45 51 55 42 
;                    20 26 46 31 3a 45 51 55 42 20 32 37 0d 21 3e 05 
;                    20 0d 21 48 30 45 51 55 42 20 77 61 6c 6c 3a 45 
;                    51 55 42 20 26 30 30 3a 45 51 55 42 20 32 33 34 
;                    3a 45 51 55 42 20 26 46 31 3a 45 51 55 42 20 32 
;                    37 0d 21 52 05 20 

        ORG     NATIVE_ADDR
.L0900
        JSR     AttractMode
        JMP     L0955
        ; return

.L0906  ; Game started
        LDX     #$00
        TXS
        STX     L0022
        LDA     #$07            ; Freeze Game
        JSR     ReadKey           

        BNE     L0919

.L0912
        LDA     #$08            ; Restart Game
        JSR     ReadKey           

        BNE     L0912

.L0919
        LDA     #$06            ; Toggle Sound
        JSR     ReadKey           

        BNE     L0926

        LDA     sound_flag
        EOR     #$F1
        STA     sound_flag
.L0926
        LDA     #$0A            ; [ESCAPE] Exit game?
        JSR     ReadKey           

        BEQ     L0900           ; Quit Game

        LDA     #$00
        STA     speed_counter
        STA     L0014
        STA     L0012

        JSR     L135D
        JSR     L1113
        JSR     L0BFA
        JSR     L112D

        LDA     #$FF
        STA     L0014
        JSR     L1357

        JSR     L1105
        JSR     L0BFA

.L094E
        JSR     L110C

        LDA     L0022
        BEQ     L0972

.L0955 
        JSR     NextRoom

        LDA     in_play
        BNE     L0975

        JSR     L1105
        JSR     PlotSpriteBruce
        JSR     L110C
        JSR     L1113

        LDA     #$FE
        STA     L0093
        JSR     L1516

        JSR     L112D

.L0972
        JSR     L1059

.L0975
        JSR     AnimateRoomPalette

        LDA     room_number
        CMP     #$09
        BEQ     L0989           ; room 10 ?

        CMP     #$07
        BEQ     L0989           ; room 8 ?

        CMP     #$04
        BEQ     L0989           ; room 5 ?

        JSR     L1DDE

.L0989
        LDA     L0012
        BEQ     L09A1

        DEC     lives
        JSR     DrawLives

        JSR     L1105

        LDA     #$03
        STA     knock_downs     
        STA     L0014
        JSR     L0BA5
        JMP     L0926
        ; return

.L09A1
        LDA     speed_counter
        CMP     #$02
        BCC     L09A1

        LDA     in_play
        BEQ     L09AC

        RTS

.L09AC
        JMP     L0906
        ; return

.L09AF
        LDX     L0089
        BNE     L09ED

        PHA
        SEC
        LDA     L0081
        PHA
        SBC     #$0A
        LDX     L0014
        BEQ     L09C0

        SBC     #$06
.L09C0
        STA     L0081
        LDA     L0080
        PHA
        JSR     L0BE1

        JSR     L0DEA

        BEQ     L09D5

        PLA
        STA     L0080
        PLA
        STA     L0081
        PLA
        RTS

.L09D5
        PLA
        PLA
        PLA
        LDX     L0014
        BEQ     L09E0

        AND     #$01
        STA     L0086
.L09E0
        LDA     #$86
        STA     L0087
        LDA     #$01
        STA     L0089
        LDA     #$0C
        STA     L008A
        RTS

.L09ED
        DEC     L008A
        BNE     L0A05

.L09F1
        CLC
        LDA     L0081
        ADC     #$0A
        LDX     L0014
        BEQ     L09FC

        ADC     #$06
.L09FC
        STA     L0081
.L09FE
        LDA     #$03
        STA     L008F
        JMP     L0D01
        ; return

.L0A05
        LDA     L0080
        AND     #$03
        BNE     L0A29

        LDA     L0014
        BEQ     L0A22

        LDA     #$02            ; Up Key
        JSR     ReadKey           

        BNE     L0A29

.L0A16
        JSR     L0FF5

        BNE     L0A29

        LDA     #$00
        STA     L0089
        JMP     L0D7A
        ; return

.L0A22
        JSR     RandomNumber

        CMP     #$50
        BCS     L0A16

.L0A29
        JSR     L0DEA

        BNE     L0A32

        JSR     L0BE1

        RTS

.L0A32
        LDX     L0089
        DEX
        BEQ     L09F1

        BNE     L0A87

.L0A39
        TAX
        LDA     L0089
        CMP     #$02
        BEQ     L0A80

        LDA     L0080
        PHA
        LDA     L0081
        PHA
        LDA     L0014
        BEQ     L0A4F

        TXA
        AND     #$01
        STA     L0086
.L0A4F
        LDA     L0086
        LSR     A
        BCS     L0A68

        LDA     L0080
        SBC     #$02
        STA     L0080
        JSR     L0DF4

        BNE     L0A63

        DEC     L0080
        BPL     L0A6F

.L0A63
        PLA
        PLA
        STA     L0080
        RTS

.L0A68
        JSR     L0E62

        BNE     L0A63

        INC     L0080
.L0A6F
        PLA
        STA     L008D
        PLA
        LDA     #$02
        STA     L0089
        LDA     #$08
        STA     L008A
        LDA     #$85
        STA     L0087
        RTS

.L0A80
        DEC     L008A
        BEQ     L0A87

        JMP     L0A05
        ; return

.L0A87
        LDA     #$05
        STA     L008F
        LDA     L0086
        LSR     A
        BCS     L0A96

        LDA     L0080
        ADC     #$03
        STA     L0080
.L0A96
        JMP     L0D01
        ; return

.L0A99
        LDA     L0089
        BEQ     L0AA5

        LDA     #$05            ; Down Key
        JSR     ReadKey           

        BNE     L0AC6

        RTS

.L0AA5
        LDA     #$03
        STA     L0089
        LDA     #$84
        STA     L0087
        LDA     L0080
        STA     L008C
        LDA     L0081
        STA     L008D
        CLC
        ADC     #$14
        STA     L0081
        LDA     L0086
        LSR     A
        BCC     L0AC5

        LDA     L0080
        SBC     #$03
        STA     L0080
.L0AC5
        RTS

.L0AC6
        LDA     L008D
        STA     L0081
.L0ACA
        LDA     L008C
        STA     L0080
        JMP     L09FE
        ; return

.L0AD1
        LDA     L0089
        CMP     #$04
        BEQ     L0AF7

        JSR     L0DEA

        BNE     L0AFB

        LDA     #$04
        STA     L0089
        STA     L008E
        LDA     #$83
        STA     L0087
        LDA     L0080
        STA     L008C
        LDA     L0086
        LSR     A
        BCS     L0AF4

        DEC     L0080
        DEC     L0080
        RTS

.L0AF4
        INC     L0080
        RTS

.L0AF7
        DEC     L008E
        BEQ     L0ACA

.L0AFB
        RTS

        DEC     L008A
        BEQ     L0B1D

        LDA     L0081
        CMP     #$20
        BCC     L0B1D

        JSR     L0FF5

        BNE     L0B14

        LDA     #$00
        STA     L0089
        STA     L008B
        JMP     L0D7A
        ; return

.L0B14
        LDA     #$FF
        STA     L008B
        DEC     L0081
        DEC     L0081
        RTS

.L0B1D
        JMP     L0D01
        ; return

.L0B20
        LDA     L0088
        BNE     L0B28

        LDA     L0086
        BNE     L0B45

.L0B28
        JSR     L0DF4

        BEQ     L0B2E

        RTS

.L0B2E
        DEC     L0080
        LDA     L0088
        BEQ     L0B37

.L0B34
        JSR     L0FB3

.L0B37
        LDA     L0087
        AND     #$07
        TAX
        INX
.L0B3D
        STX     L0087
        JSR     L0DC9

        LDA     #$00
        RTS

.L0B45
        LDA     #$00
        STA     L0086
        LDX     #$80
        BNE     L0B3D
.L0B4D
        LDA     #$87
        CMP     L0087
        BEQ     L0B67

        STA     L0087
        LDA     #$30
        STA     L008A
        LDA     #$00
        STA     L0088
        LDA     L0086
        AND     #$01
        STA     L0086
        LDA     L0081
        STA     L008D
.L0B67
        LDA     #$00
        STA     L008B
        LDA     L008D
        STA     L0081
        JSR     L0F14

        BEQ     L0BD4

        DEC     L008A
        BEQ     L0BA5

        LDA     L008A
        CMP     #$26
        BCC     L0B9D

        LDA     L0086
        PHA
        EOR     #$01
        STA     L0086
        JSR     L0DEA

        TAX
        PLA
        STA     L0086
        CPX     #$00
        BNE     L0B9D

        LDA     L0086
        EOR     #$01
        ASL     A
        SEC
        SBC     #$01
        CLC
        ADC     L0080
        STA     L0080
.L0B9D
        CLC
        LDA     L0081
        ADC     #$0C
        STA     L0081
        RTS

.L0BA5
        LDA     #$00
        STA     L0096
        LDX     knock_downs
        CPX     #$03
        BCS     L0BB2

        JMP     L0D01
        ; return

.L0BB2
        STA     knock_downs
        LDX     #$FF
        LDA     L0014
        BNE     L0BC1

        STX     L0093
        LDA     #$06
        STA     L0089
        RTS

.L0BC1
        STX     L0022
        LDX     #$39
        LDY     #$28
        JSR     L0386

        LDA     lives
        BEQ     GameOver

        JMP     L1D68
        ; return

.GameOver
        JMP     L0900
        ; return

;-------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L0BD4
        LDA     #$FF
        STA     L008B
        LDA     #$25
        STA     L008A
        INC     L008D
        INC     L008D
        RTS
;-------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L0BE1
        DEC     L0080
        LDA     L0086
        ASL     A
        ADC     L0080
        STA     L0080
        RTS
;-------------------------------------------------------------------------
; ReadKey
;-------------------------------------------------------------------------
; On entry  : Y = index into KeyArray
; On exit   : A is preserved
;-------------------------------------------------------------------------
.ReadKey
        PHA
        TAY
        LDX     L0070,Y         
        LDY     #$FF
        LDA     #$81
        JSR     OSBYTE          ; OSBYTE 129 - Read key within time limit.

        PLA
        CPX     #$FF
        RTS
;-------------------------------------------------------------------------

.L0BFA
        LDA     L0096
        BEQ     L0C02

        LDA     #$07
        STA     L0089
.L0C02
        LDA     L0089
        ASL     A
        TAX
        LDA     L0C13,X
        STA     L007B
        LDA     L0C14,X
        STA     L007C
        JMP     (L007B)
        ; return

;-------------------------------------------------------------------------
; Jump Table Data
;-------------------------------------------------------------------------
.L0C13
        EQUB    $23

.L0C14
        EQUB    $0C             ; $0C23
        EQUB    $AF,$09         ; $09AF
        EQUB    $39,$0A         ; $0A39
        EQUB    $99,$0A         ; $0A99
        EQUB    $D1,$0A         ; $0AD1
        EQUB    $FC,$0A         ; $0AFC
        EQUB    $16,$15         ; $1516
        EQUB    $4D,$0B         ; $0B4D
;-------------------------------------------------------------------------
        
.L0C23               
        LDA $8f
        BEQ L0C29
        DEC $8f
.L0C29               
        CLC
        LDA $81
        ADC #$12
        STA $0e
        LDA $80
        STA $0d
        JSR L2007
        CLC
        LDA $80
        ADC #$03
        STA $0d
        JSR L2007
        JSR L0C5E
        LDA $89
        BNE L0C5A
        JSR L1005
        BNE L0C5A
        LDA $88
        PHA
        JSR L0FF5
        PLA
        LDX $88
        BMI L0C5B
        STA $88
.L0C5A   
        RTS
        
.L0C5B   
        DEC $81
        RTS
        
.L0C5E   
        LDA $14
        BNE L0C65
        JMP L140E
        ; return
        
.L0C65   
        LDA #$00                ; Left keypress
        JSR ReadKey
        BEQ L0C8B
        LDA #$01                ; Right keypress
        JSR ReadKey
        BEQ L0C8B
        LDA #$02                ; Up keypress
        JSR ReadKey
        BNE L0C7F
        JSR L0D7A
        BEQ L0C5A
.L0C7F   
        LDA #$03                ; Down keypress
        JSR ReadKey
        BNE L0C8B
        JSR L0DA2
        BEQ L0C5A
.L0C8B   
        LDA #$00
        STA $8b
        LDA $88
        BEQ L0C96
        JMP L0CEA
        ; return
        
.L0C96   
        JSR L0F32
        STA $8b
        BEQ L0CA0
        JMP L0DC2
        ; return
        
.L0CA0   
        LDA $96
        BEQ L0CA5
        RTS
        
.L0CA5   
        LDA $86
        LSR A
        BEQ L0CAE
        LDA $92
        STA $86
.L0CAE   
        LDA $8f
        BNE L0CEA
        LDA #$05                ; Duck Keypress
        JSR ReadKey
        BEQ L0D1F
        LDA #$04                ; Chop / Kick Keypress
        JSR ReadKey
        BNE L0CCE
        LDA #$00                ; Left keypress
        JSR ReadKey
        BEQ L0D1C
        LDA #$01                ; Right keypress
        JSR ReadKey
        BEQ L0D1C
.L0CCE   
        LDA #$02                ; Up keypress
        JSR ReadKey
        BNE L0CE3
        LDA #$00                ; Left keypress
        JSR ReadKey
        BEQ L0D19
        LDA #$01                ; Right keypress
        JSR ReadKey
        BEQ L0D19
.L0CE3   
        LDA #$04                ; Chop / Kick keypress
        JSR ReadKey
        BEQ L0D16
.L0CEA   
        LDA #$00                ; Left keypress
        JSR ReadKey
        BNE L0CF4
        JMP L0B20
        ; return
        
.L0CF4   
        LDA #$01                ; Right keypress
        JSR ReadKey
        BNE L0CFE
        JMP L0D22
        ; return
        
.L0CFE   
        JMP L0D05
        ; return
        
.L0D01
        LDA     #$00
        STA     L0088
.L0D05
        LDA     L0088
        BNE     L0D15

        STA     L0089
        LDA     L0081
        AND     #$FE
        STA     L0081
        LDA     #$80
        STA     L0087
.L0D15
        RTS
.L0D16
        JMP     L0AD1
        ; return
.L0D19
        JMP     L09AF
        ; return
.L0D1C
        JMP     L0A39
        ; return
.L0D1F
        JMP     L0A99
        ; return
.L0D22
        LDA     L0088
        BNE     L0D2C

        LDA     #$01
        CMP     L0086
        BNE     L0D44

.L0D2C
        JSR     L0E62

        BEQ     L0D32

        RTS

.L0D32
        INC     L0080
        LDA     L0088
        BEQ     L0D3B

        JMP     L0B34
        ; return

.L0D3B
        LDA     L0087
        AND     #$07
        TAX
        INX
.L0D41
        JMP     L0B3D
        ; return

.L0D44
        STA     L0086
        LDX     #$80
        BNE     L0D41

.L0D4A
        LDA     L0096
        BNE     L0D69

        LDA     L008F
        BNE     L0D69

        LDA     L0014
        BNE     L0D6A

        LDA     L0081
        PHA
        SEC
        SBC     #$12
        STA     L0081
        JSR     L0FB3

        TAX
        PLA
        STA     L0081
        CPX     #$00
        BEQ     L0D6A

.L0D69
        RTS

.L0D6A
        JSR     L0F32

        BNE     L0DA2

        LDA     #$05
        STA     L0089
        LDA     #$0A
        STA     L008A
        LDA     #$00
        RTS

.L0D7A
        JSR     L1005

        BNE     L0DA1

        JSR     L0FF5

        BNE     L0D4A

        LDA     L0086
        CMP     #$02
        BCS     L0D8C

        STA     L0092
.L0D8C
        LDA     #$02
        STA     L0086
        INC     L0087
        DEC     L0081
        DEC     L0081
        LDA     #$05
        STA     L008F
        JSR     L0DC9

        LDA     #$00
        STA     L008B
.L0DA1
        RTS

.L0DA2
        JSR     L0FB3

        BNE     L0DC8

        JSR     L0F14

        BNE     L0DC8

        LDA     L0086
        LSR     A
        BNE     L0DB5

        LDA     L0086
        STA     L0092
.L0DB5
        LDA     #$03
        STA     L0086
        INC     L0087
        JSR     L0DC9

        LDA     #$00
        STA     L008B
.L0DC2
        INC     L0081
        INC     L0081
        LDA     #$00
.L0DC8
        RTS

.L0DC9
        LDA     walking_sound_delay
        BNE     L0DC8

        LDA     L0014
        BEQ     L0DC8

        LDA     sound_flag
        BEQ     L0DC8

        LDA     #$06            ; walking sound delay
        STA     walking_sound_delay
        LDA     #$07
        LDX     #$E2            
        LDY     #$0D            ; $0DE2
        JMP     OSWORD          ; Play Sound
        ; return

        ; Sound Data $0DE2
        EQUB    $12,$00         ; Channel
        EQUB    $11,$00         ; Volume / Envelope No.
        EQUB    $F1,$FF         ; Pitch
        EQUB    $00,$00         ; Duration

.L0DEA
        LDA     L0086
        BNE     L0DF1

        JMP     L0DF4
        ; return

.L0DF1
        JMP     L0E62
        ; return

.L0DF4
        LDX     L0080
        DEX
        BMI     L0DFD

        TXA
        JMP     L0E6B
        ; return

.L0DFD
        LDA     L0014
        BNE     L0E04

        JMP     L0FF2
        ; return

.L0E04
        DEC     room_number
        CLC
        LDA     L0080
        ADC     #$4B
        STA     L0080
        LDA     L008C
        ADC     #$4B
        STA     L008C
        LDX     room_number
        CPX     #$04            ; room 5 ?
        BNE     L0E26

        SEC
        LDA     L0081
        SBC     #$08
        STA     L0081
        LDA     L008D
        SBC     #$08
        STA     L008D
.L0E26
        CPX     #$08
        BNE     L0E4A

        LDA     L0081
        CMP     #$AA
        BCS     L0E3D

        ADC     #$40
        STA     L0081
        LDA     L008D
        ADC     #$40
        STA     L008D
        JMP     L0E5B
        ; return

.L0E3D
        SBC     #$10
        STA     L0081
        LDA     L008D
        SBC     #$10
        STA     L008D
        JMP     L0E5B
        ; return

.L0E4A
        CPX     #$05
        BNE     L0E5B

        CLC
        LDA     L0081
        ADC     #$20
        STA     L0081
        LDA     L008D
        ADC     #$20
        STA     L008D
.L0E5B
        LDA     #$FF
        STA     L0022
        JMP     L0FF2
        ; return

.L0E62
        CLC
        LDA     L0080
        ADC     #$04
        CMP     #$4F
        BCS     L0EAE

.L0E6B
        STA     L000D
        LDA     L0081
        STA     L000E
        JSR     L0E95

        BNE     L0E8C

        LDA     #$08
        JSR     L0E8D

        BNE     L0E8C

        LDA     #$10
        JSR     L0E8D

        BNE     L0E8C

        LDA     #$19
        JMP     L0E8D
        ; return

        JSR     L0E95

.L0E8C
        RTS

.L0E8D
        CLC
        ADC     L0081
        STA     L000E
        JMP     L0E95
        ; return

.L0E95
        JSR     L2007

        BEQ     L0EA6

        LDY     #$06
.L0E9C
        CMP     L0EA7,Y
        BEQ     L0EA6

        DEY
        BPL     L0E9C

        LDA     #$FF
.L0EA6
        RTS

.L0EA7
        EQUB    $08

        EQUB    $09,$0A,$0B,$0C,$0D,$0E

.L0EAE
        LDA     L0014
        BNE     L0EB5

        JMP     L0FF2
        ; return

.L0EB5
        INC     room_number
        SEC
        LDA     L0080
        SBC     #$4C
        STA     L0080
        LDA     L008C
        SBC     #$4C
        STA     L008C
        LDX     room_number
        CPX     #$05            ; room 6 ?
        BNE     L0ED7

        CLC
        LDA     L0081
        ADC     #$08
        STA     L0081
        LDA     L008D
        ADC     #$08
        STA     L008D
.L0ED7
        CPX     #$09
        BNE     L0EFD

        LDA     L0081
        CMP     #$AA
        BCS     L0EEF

        SEC
        SBC     #$40
        STA     L0081
        LDA     L008D
        SBC     #$40
        STA     L008D
        JMP     L0E5B
        ; return

.L0EEF
        CLC
        ADC     #$10
        STA     L0081
        LDA     L008D
        ADC     #$10
        STA     L008D
        JMP     L0E5B
        ; return

.L0EFD
        CPX     #$06
        BNE     L0F0E

        SEC
        LDA     L0081
        SBC     #$20
        STA     L0081
        LDA     L008D
        SBC     #$20
        STA     L008D
.L0F0E
        JMP     L0E5B
        ; return

        LDA     #$FF
        RTS

.L0F14
        LDA     L0081
        CMP     #$E6
        BCS     L0F67

        ADC     #$1A
        STA     L000E
.L0F1E
        LDA     L0080
        STA     L000D
        JSR     L0E95

        BNE     L0F31

        CLC
        LDA     L0080
        ADC     #$03
        STA     L000D
        JSR     L0E95

.L0F31
        RTS

.L0F32
        LDA     L0081
        CMP     #$E6
        BCS     L0F67

        ADC     #$1A
        STA     L000E
        LDA     L0080
        STA     L000D
        JSR     L2007

        BEQ     L0F4D

        CMP     #$08
        BEQ     L0F4D

        CMP     #$0A
        BNE     L0F64

.L0F4D
        CLC
        LDA     L0080
        ADC     #$03
        STA     L000D
        JSR     L2007

        BEQ     L0F61

        CMP     #$08
        BEQ     L0F61

        CMP     #$0A
        BNE     L0F64

.L0F61
        LDA     #$FF
        RTS

.L0F64
        LDA     #$00
        RTS

.L0F67
        LDA     L0014
        BNE     L0F75

        LDA     #$FF
        STA     L0093
        LDA     #$06
        STA     L0089
        BNE     L0F61

.L0F75
        SEC
        LDA     L0081
        AND     #$FC
        SBC     #$C2
        STA     L0081
        LDA     L008D
        AND     #$FC
        SBC     #$C2
        STA     L008D
        CLC
        LDA     room_number
        ADC     #$04                    ; add 4 to room number 
        STA     room_number
        JMP     L1041
        ; return

.L0F90
        LDA     #$00
        STA     L0088
        JSR     L2007

        LDX     #$FF
        LDY     #$06
.L0F9B
        CMP     L0EA7,Y
        BEQ     L0FAC

        DEY
        BMI     L0FAB

        CPY     #$04
        BNE     L0F9B

        LDX     #$01
        BNE     L0F9B

.L0FAB
        RTS

.L0FAC
        STX     L0088
        PLA
        PLA
        LDA     #$00
        RTS

.L0FB3
        LDX     L0080
        STX     L000D
        CLC
        LDA     L0081
        ADC     #$13
        STA     L000E
        JSR     L0F90

        CLC
        LDA     L0081
        ADC     #$1A
        STA     L000E
        JSR     L0F90

        INC     L000D
        INC     L000D
        INC     L000D
        JSR     L0F90

        CLC
        LDA     L0081
        ADC     #$13
        STA     L000E
        JSR     L0F90

        CLC
        LDA     L0081
        ADC     #$03
        STA     L000E
        JSR     L0F90

        LDA     L0080
        STA     L000D
        JSR     L0F90

        LDA     #$FF
        RTS

.L0FF2
        LDA     #$00
        RTS

;-------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L0FF5
        LDA     L0081
        PHA
        DEC     L0081
        DEC     L0081
        JSR     L0FB3

        TAX
        PLA
        STA     L0081
        TXA
        RTS
;-------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L1005
        LDA     L0081
        CMP     #$22
        BCC     L1012

        SBC     #$02
        STA     L000E
        JMP     L0F1E
        ; return

.L1012
        LDA     L0014
        BNE     L1019

        JMP     L0FF2
        ; return

.L1019
        SEC
        LDA     room_number
        SBC     #$04
        STA     room_number
        CMP     #$06                    ; room 7 ?
        BNE     L1034

        CLC
        LDA     L0081
        ADC     #$A6
        STA     L0081
        LDA     L008D
        ADC     #$A6
        STA     L008D
        JMP     L1041
        ; return

.L1034
        CLC
        LDA     L0081
        ADC     #$B6
        STA     L0081
        LDA     L008D
        ADC     #$B6
        STA     L008D
.L1041
        INC     L0022
        JMP     L094E
        ; return

        ; DATA ???
        EQUB    $31
        EQUB    $0D,$04,$1A,$14,$44,$45,$58,$3A
        EQUB    $42,$4E,$45,$20,$6C,$6F,$63,$5F
        EQUB    $6C,$6F

.L1059
        LDA     L0093
        BEQ     L10C6

        LDA     L15AA
        CMP     #$5A
        BCC     L1066

        LDA     #$00
.L1066
        STA     L007B
        LDA     L1591
        CMP     #$5A
        BCC     L1071

        LDA     #$00
.L1071
        STA     L007C
        CLC
        LDA     L007B
        ADC     #$08
        CMP     L007C
        BCC     L10C6

        LDA     L007C
        ADC     #$07
        CMP     L007B
        BCC     L10C6

        LDA     L15AB
        ADC     #$2E
        BCC     L108D

        LDA     #$FF
.L108D
        CMP     L1592
        BCC     L10C6

        LDA     L1592
        ADC     #$2D
        BCC     L109B

        LDA     #$FF
.L109B
        CMP     L15AB
        BCC     L10C6

        JSR     L1105

        LDA     L15AB
        CMP     L1592
        BCS     L10AE

        LDA     L1592
.L10AE
        JSR     L1324
        JSR     EraseSprite
        JSR     L1113
        JSR     L10E6                   ; move ninja ?
        JSR     L1105
        JSR     PlotSpriteBruce
        JSR     L110C
        JMP     L1DDE
        ; return

.L10C6
        JSR     L1105

        LDA     L0081
        JSR     L1324
        JSR     EraseSprite
        JSR     PlotSpriteBruce
        JSR     L110C

.L10D7
        LDA     speed_counter
        BEQ     L10D7

        JSR     L1DDE
        JSR     L1113

        LDA     L0081
        JSR     L1324

.L10E6
        LDX     L0093
        BEQ     L10F1

        INX
        BNE     L10F4

        LDX     #$FE
        STX     L0093

.L10F1  ; Erase green ninja
        JSR     EraseSprite

.L10F4
        LDX     L0093
        BEQ     L10FF

        DEX
        BNE     L1102

        STX     L0093
        STX     L0089
.L10FF
        JSR     PlotSpriteBruce

.L1102
        JMP     L112D
        ; return

.L1105
        LDX     #$AA
        LDY     #$15
        JMP     L1117
        ; return

.L110C
        LDX     #$AA
        LDY     #$15
        JMP     L1131
        ; return

.L1113
        LDX     #$91
        LDY     #$15
.L1117
        STX     L007B
        STY     L007C
        LDA     #$80
        STA     L007D
        LDA     #$00
        STA     L007E
        LDY     #$18
.L1125
        LDA     (L007B),Y
        STA     (L007D),Y
        DEY
        BPL     L1125

        RTS

.L112D
        LDX     #$91
        LDY     #$15
.L1131
        STX     L007D
        STY     L007E
        LDA     #$80
        STA     L007B
        LDA     #$00
        STA     L007C
        LDY     #$16
        BNE     L1125

.L1141
        LDA     L0021
        AND     #$FE
        TAX
        LDA     L26B4,X
        STA     L119B
        LDA     L26B5,X
        STA     L119C
        LDA     L0021
        AND     #$01
        JMP     L116D
        ; return

;-------------------------------------------------------------------------
; ???
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L1159
        LDX     #$00
        LDY     #$00
        LDA     L0000
        AND     #$07
        STA     L000A
        LDA     #$08
        SEC
        SBC     L000A
        STA     L007C
        RTS
;-------------------------------------------------------------------------

.L116B
        LDA     #$FF
.L116D
        STA     L0021
        JSR     L1159

.L1172
        LDA     L0000
        STA     L0006
        LDA     L0001
        STA     L0007
        LDA     L007C
        STA     L000A
        JSR     L1312

        BEQ     L11EC

        LDA     L000C
        STA     L0009
.L1187
        LDA     (L0000,X)
        STA     (L0097),Y
        LDA     (L0002),Y
        LDX     L0021
        BMI     L119D

        BEQ     L1197

        LSR     A
        LSR     A
        LSR     A
        LSR     A
.L1197
        AND     #$0F
        TAX
.L119A
        LDA     LFFFF,X
L119B = L119A+1
L119C = L119A+2
.L119D
        LDX     #$00
        CMP     #$C0
        BEQ     L11B8

        STA     L007B
        AND     #$AA
        CMP     #$80
        BEQ     L11CF

        LDA     L007B
        AND     #$55
        CMP     #$40
        BEQ     L11C1

        LDA     L007B
        JMP     L11DB
        ; return

.L11B8
        LDA     (L0000,X)
        JMP     L11DB
        ; return

        CMP     #$80
        BCS     L11CF

.L11C1
        LDA     L007B
        AND     #$AA
        STA     L007B
        LDA     (L0000,X)
        AND     #$55
        ORA     L007B
        BNE     L11DB

.L11CF
        LDA     L007B
        AND     #$55
        STA     L007B
        LDA     (L0000,X)
        AND     #$AA
        ORA     L007B
.L11DB
        STA     (L0000,X)
        INY
        BNE     L11E2

        INC     L0003
.L11E2
        DEC     L000A
        BEQ     L1203

        INC     L0000
.L11E8
        DEC     L0009
        BNE     L1187

.L11EC
        CLC
        LDA     L0006
        ADC     #$08
        STA     L0000
        LDA     L0007
        ADC     #$00
        STA     L0001
        INC     L0004
        DEC     L0008
        BEQ     L1202

        JMP     L1172
        ; return

.L1202
        RTS

.L1203
        CLC
        LDA     L0000
        ADC     #$79
        STA     L0000
        LDA     L0001
        ADC     #$02
        STA     L0001
        LDA     #$08
        STA     L000A
        BNE     L11E8

.L1216
        CLC
        LDA     L0002
        ADC     L001F
        STA     L0002
        LDA     L0003
        ADC     #$00
        STA     L0003
        JSR     L1159

        LDA     L000C
        ASL     A
        STA     L007D
.L122B
        SEC
        LDA     L0002
        SBC     L007D
        STA     L0002
        LDA     L0003
        SBC     #$00
        STA     L0003
        LDA     L0000
        STA     L0006
        LDA     L0001
        STA     L0007
        LDA     L007C
        STA     L000A
        JSR     L12A9

        BEQ     L1282

        LDA     L000C
        STA     L0009
.L124D
        LDA     (L0000,X)
        STA     (L0097),Y
        LDA     (L0002,X)
        AND     #$AA
        LSR     A
        CMP     #$40
        BNE     L125E

        LDA     (L0000,X)
        AND     #$55
.L125E
        STA     L007B
        LDA     (L0002,X)
        AND     #$55
        ASL     A
        CMP     #$80
        BNE     L126D

        LDA     (L0000,X)
        AND     #$AA
.L126D
        ORA     L007B
        STA     (L0000,X)
        INY
        INC     L0002
        BNE     L1278

        INC     L0003
.L1278
        DEC     L000A
        BEQ     L1296

        INC     L0000
.L127E
        DEC     L0009
        BNE     L124D

.L1282
        CLC
        LDA     L0006
        ADC     #$08
        STA     L0000
        LDA     L0007
        ADC     #$00
        STA     L0001
        INC     L0004
        DEC     L0008
        BNE     L122B

        RTS

.L1296
        CLC
        LDA     L0000
        ADC     #$79
        STA     L0000
        LDA     L0001
        ADC     #$02
        STA     L0001
        LDA     #$08
        STA     L000A
        BNE     L127E

.L12A9
        LDA     L0004
        CMP     #$50
        BCS     L12B0

        RTS

.L12B0
        CLC
        TYA
        ADC     L000C
        TAY
        LDA     L0002
        ADC     L000C
        STA     L0002
        LDA     L0003
        ADC     #$00
        STA     L0003
        LDA     #$00
        RTS

;-------------------------------------------------------------------------
; EraseMaskedSprite
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.EraseMaskedSprite
        JSR     L1159

.L12C7
        LDA     L0000
        STA     L0006
        LDA     L0001
        STA     L0007
        LDA     L007C
        STA     L000A
        JSR     L1312

        BEQ     L12EB

        LDA     L000C
        STA     L0009
.L12DC
        LDA     (L0002),Y
        STA     (L0000,X)
        INY
        DEC     L000A
        BEQ     L12FF

        INC     L0000
.L12E7
        DEC     L0009
        BNE     L12DC

.L12EB
        CLC
        LDA     L0006
        ADC     #$08
        STA     L0000
        LDA     L0007
        ADC     #$00
        STA     L0001
        INC     L0004
        DEC     L0008
        BNE     L12C7

        RTS

.L12FF
        CLC
        LDA     L0000
        ADC     #$79
        STA     L0000
        LDA     L0001
        ADC     #$02
        STA     L0001
        LDA     #$08
        STA     L000A
        BNE     L12E7

.L1312
        LDA     L0004
        CMP     #$50
        BCS     L1319

        RTS

.L1319
        CLC
        TYA
        ADC     L000C
        TAY
        LDA     #$00
        RTS

        PLA
        PLA
        RTS

;-------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L1324
{
        CLC
        ADC     #$29
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        TAX
.loop
        LDA     #$C5
        STA     LFE4C
        LDA     #$E5
        STA     LFE4C
        LDA     #$10
        STA     crtcAddr
        LDA     crtcData
        SEC
        SBC     #$06
        CMP     L1347,X
        BCC     loop
        RTS
}
;-------------------------------------------------------------------------

.L1347  ; DATA
        EQUB    $00,$01,$01,$02,$03,$03,$04,$04
        EQUB    $05,$06,$06,$07,$08,$08,$09,$09

.L1357
        LDX     #$00
        LDY     #$02
        BNE     L1361

.L135D
        LDX     #$02
        LDY     #$00
.L1361
        STY     L0014
        LDA     #$AA
        STA     L007B,X
        LDA     #$15
        STA     L007C,X
        LDA     #$91
        STA     L007B,Y
        LDA     #$15
        STA     L007C,Y
        LDY     #$09
        LDA     (L007B),Y
        BNE     L13FA

        LDY     #$01
        LDA     (L007B),Y
        SEC
        SBC     #$10
        CMP     (L007D),Y
        BCS     L13FA

        LDA     (L007D),Y
        SBC     #$0F
        CMP     (L007B),Y
        BCS     L13FA

        DEY
        LDA     (L007B),Y
        SEC
        SBC     (L007D),Y
        CMP     #$07
        BCC     L139C

        CMP     #$F9
        BCC     L13FA

.L139C
        LDY     #$09
        LDA     (L007B),Y
        CMP     #$07
        BEQ     L13FA

        LDA     (L007D),Y
        STA     L007F
        CMP     #$02
        BEQ     L13B0

        CMP     #$04
        BNE     L13FA

.L13B0
        LDA     sound_flag
        BEQ     L13BD

        LDA     #$07
        LDX     #$FB
        LDY     #$13            ; $13FB
        JSR     OSWORD          ; Play Sound

.L13BD
        LDY     #$06
        LDA     (L007D),Y
        EOR     #$01
        STA     (L007B),Y
        LDY     #$09
        LDA     #$07
        STA     (L007B),Y
        LDY     #$10
        LDA     (L007B),Y
        CLC
        ADC     #$01
        STA     (L007B),Y
        LDX     L0014
        BEQ     L13E1

        CMP     #$03
        BCC     L13FA

        DEC     lives
        JMP     DrawLives
        ; return

.L13E1  ; Knock down green ninja 75 score
        SED
        LDA     L007F
        CMP     #$04
        BEQ     L13F6

        CLC
        LDA     score1
        ADC     #$75
        STA     score1
        LDA     score2
        ADC     #$00
        JMP     Add1000
        ; return

.L13F6
        CLC
        JMP     L18CA
        ; return

.L13FA
        RTS

        ; Sound Data $13FB
        EQUB    $11,$00         ; Channel
        EQUB    $01,$00         ; Volumne / Envelope No.
        EQUB    $0A,$00         ; Pitch
        EQUB    $01,$00         ; Duration
    
.L1403
        LDA     #$00
        BEQ     L1409

.L1407
        LDA     #$01
.L1409
        STA     L0086
        JMP     L0A39
        ; return
.L140E
        JSR     L14F2

        LDA     L008F
        BEQ     L1419

        DEC     L008F
        BNE     L1454

.L1419
        LDA     L0088
        BNE     L1454

        LDA     L008B
        BNE     L1454

        LDA     L0086
        LSR     A
        BEQ     L142A

        LDA     L0092
        STA     L0086
.L142A
        LDA     L15B3
        CMP     #$07
        BEQ     L1454

        SEC
        LDA     L15AB
        SBC     #$10
        CMP     L0081
        BCS     L1454

        LDA     L0081
        SBC     #$0F
        CMP     L15AB
        BCS     L1454

        SEC
        LDA     L0080
        SBC     L15AA
        STA     L007B
        CMP     #$07
        BEQ     L1403

        CMP     #$F9
        BEQ     L1407

.L1454
        LDA     L0080
        AND     #$03
        BNE     L147B

        LDA     L0086
        LSR     A
        BNE     L14B2

        JSR     RandomNumber

        CMP     #$80
        BCS     L147B

        LDA     L15AB
        CMP     L0081
        BEQ     L147B

        BCS     L1476

.L146F
        JSR     L0D7A

        BEQ     L14D6

        BNE     L147B

.L1476
        JSR     L0DA2

        BEQ     L14D6

.L147B
        LDA     #$00
        STA     L008B
        LDA     L0088
        BNE     L148D

        JSR     L0F32

        STA     L008B
        BEQ     L148D

        JMP     L0DC2
        ; return

.L148D
        LDA     room_number
        CMP     #$04                    ; room 5 ?
        BNE     L14A0

        LDA     L0086
        BNE     L14A0

        LDA     L0080
        CMP     #$3C
        BCS     L14A0

        JMP     L09AF
        ; return

.L14A0
        JSR     RandomNumber

        CMP     #$F5
        BCC     L14B2

        JSR     RandomNumber

        CMP     #$40
        BCS     L14BF

        AND     #$01
        STA     L0086
.L14B2
        LDA     L0086
.L14B4
        TAX
        BEQ     L14CC

        DEX
        BEQ     L14D7

        DEX
        BEQ     L146F

        BNE     L1476

.L14BF
        SEC
        LDA     L15AA
        SBC     L0080
        ROL     A
        AND     #$01
        STA     L0086
        BPL     L14B4

.L14CC
        JSR     L0B20

        BEQ     L14E2

        JSR     L0D22

        BEQ     L14E2

.L14D6
        RTS

.L14D7
        JSR     L0D22

        BEQ     L14E2

        JMP     L0B20
        ; return

        BEQ     L14E2
        RTS

.L14E2
        JSR     L0F32
        BNE     L14E8
        RTS

.L14E8
        LDA     L0081
        CMP     L15AB
        BCC     L1510
        JMP     L09AF
        ; return

.L14F2
        LDA     L0081
        CMP     #$1A
        BCC     L1506

        CMP     #$E6
        BCS     L1506

        LDA     L0080
        CMP     #$FC
        BCS     L1511

        CMP     #$50
        BCC     L1510

.L1506
        PLA
        PLA
        LDA     #$06
        STA     L0089
        LDA     #$FF
        STA     L0093
.L1510
        RTS

.L1511
        PLA
        PLA
        JMP     L14B2
        ; return

.L1516
        LDA     #$06
        STA     L0089
        LDA     #$00
        STA     L0096
        LDA     room_number
        CMP     #$09                    ; room 10 ?
        BCS     L1575

        CMP     #$03
        BEQ     L1575

        CMP     #$07
        BEQ     L1575

        LDA     L0093
        CMP     #$FE
        BNE     L153B

        JSR     RandomNumber

        AND     #$3E
        ORA     #$0E
        STA     L0093
.L153B
        DEC     L0093
        LDX     L0093
        DEX
        BNE     L1575

        LDA     room_number
        ASL     A
        STA     L007B
        ASL     A
        CLC
        ADC     L007B
        TAX
        LDA     L20B4,X
        STA     L000F
        LDA     L20B5,X
        STA     L0010
        JSR     RandomNumber

        LDY     #$00
        STY     L15A7
        AND     (L000F),Y
        TAY
        INY
        LDA     (L000F),Y
        INY
        STA     L0080
        LDA     (L000F),Y
        INY
        STA     L0081
        LDA     (L000F),Y
        INY
        STA     L0086
        LDA     (L000F),Y
        STA     L0087
.L1575
        RTS

;-------------------------------------------------------------------------
; ReadSystemClock
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.ReadSystemClock
        LDX     #$2A
        LDY     #$00            ; $002A Clock storage area
        LDA     #$01
        JMP     OSWORD          ; OSWORD 1 - Read system clock.
        ; return

;-------------------------------------------------------------------------
; RandomNumber
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.RandomNumber
        LDA     rand1
        AND     #$42
        CLC
        ADC     #$3E
        ASL     A
        ASL     A
        ROL     rand3
        ROL     rand2
        ROL     rand1
        LDA     rand1
        RTS
;-------------------------------------------------------------------------

.L1591  ; DATA
        EQUB    $C8

.L1592
        EQUB    $46,$00,$80,$05,$1A,$00,$80,$00
        EQUB    $06,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$FE,$A0,$16

.L15A7
        EQUB    $00,$40

.L15A9
        EQUB    $07

.L15AA
        EQUB    $08

.L15AB
        EQUB    $46,$00,$80,$05,$1A,$01,$80,$00

.L15B3
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$01,$05,$D2,$16,$00,$80,$06

.L15C3  ; Initialise game data?
        LDA     #$FF
        STA     in_play
        LDA     #$04
        STA     lives
.L15CB
        LDA     #$00
        STA     L0026
        STA     lantern_counter
        STA     L0012
        STA     L0011
        STA     L0029

        LDY     #$0B
        STY     room_number
        STY     L0033
.L15DD
        STA     L1BD9,Y         ; reset some data to 0 
        DEY
        BPL     L15DD

        LDA     #$01
        STA     palette_timer
.L15E7
        JSR     L1883

        DEC     room_number
        BPL     L15E7

        LDA     #$00
        STA     L0033
        STA     room_number
        JSR     DrawScoreandHighscore
        JSR     DrawLives
        JMP     ReadSystemClock
        ; return

.L15FD
        LDA     #$00
        STA     L007C
        LDA     L000D
        LSR     A
        LSR     A
        STA     L007B
        LDA     L000E
        AND     #$F8
        PHA
        LSR     A
        ADC     L007B
        STA     L007B
        PLA
        ASL     A
        ROL     L007C
        CLC
        ADC     L007B
        STA     L007B
        LDA     L007C
        ADC     #$04
        STA     L007C
        LDA     #$00
        CLC
        ADC     L007B
        STA     L007B
        LDA     L007C
        ADC     #$00
        STA     L007C
        RTS

;-------------------------------------------------------------------------
; CalcAddress ???
;-------------------------------------------------------------------------
; On entry  : X and Y contain character position
; On exit   : A,X and Y are undefined  
;-------------------------------------------------------------------------
.CalcAddress
{
        LDA     L000D
        CMP     #$A0
        BCC     L1656

        LDA     #$00
        SBC     L000D
        STA     L0000
        LDA     #$00
        ASL     L0000
        ROL     A
        ASL     L0000
        ROL     A
        ASL     L0000
        ROL     A
        STA     L0001
        SEC
        LDA     #$00
        SBC     L0000
        STA     L0000
        LDA     #$30
        SBC     L0001
        STA     L0001
        BNE     L1665

.L1656
        STA     L0000
        LDA     #$06
        ASL     L0000
        ROL     A
        ASL     L0000
        ROL     A
        ASL     L0000
        ROL     A
        STA     L0001
.L1665
        LDA     L000E
        AND     #$07
        ORA     L0000
        STA     L0000
        LDA     #$00
        STA     L007C
        LDA     L000E
        AND     #$F8
        ASL     A
        ROL     L007C
        ASL     A
        ROL     L007C
        ASL     A
        ROL     L007C
        ASL     A
        ROL     L007C
        PHA
        CLC
        ADC     L0000
        STA     L0000
        LDA     L0001
        ADC     L007C
        STA     L0001
        PLA
        ASL     A
        ROL     L007C
        ASL     A
        ROL     L007C
        CLC
        ADC     L0000
        STA     L0000
        LDA     L0001
        ADC     L007C
        STA     L0001
        RTS
}
;-------------------------------------------------------------------------
        ; DATA ?
        EQUB    $01
        EQUB    $2E,$05,$1A,$9C,$83,$2E,$05,$1A
        EQUB    $9C,$01,$2E,$05,$1A,$9C,$05,$2F
        EQUB    $04,$1A,$82,$6D,$2F,$04,$1A,$82
        EQUB    $C3,$2B,$06,$1A,$B6,$5F,$2C,$08
        EQUB    $06,$36,$D5,$2F,$08,$10,$90,$55
        EQUB    $30,$05,$1A,$9C,$D7,$30,$08,$0E
        EQUB    $7E,$EF,$29,$05,$1A,$9C,$71,$2A
        EQUB    $05,$1A,$9C,$6D,$29,$05,$1A,$9C
        EQUB    $F3,$2A,$04,$1A,$82,$5B,$2B,$04
        EQUB    $1A,$82,$C3,$2B,$06,$1A,$B6,$5F
        EQUB    $2C,$08,$06,$36,$8F,$2C,$08,$10
        EQUB    $90,$0F,$2D,$05,$1A,$9C,$91,$2D
        EQUB    $08,$0E,$7E

;-------------------------------------------------------------------------
; ClearScreen
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.ClearScreen    ; clear from $3A00 - $7FFF
{
        LDA     #$39
        STA     L007C
        LDA     #$80
        STA     L007B

        LDX     #$47
        LDY     #$80
.loop
        STA     (L007B),Y
        INY
        BNE     loop

        INC     L007C
        DEX
        BNE     loop
        RTS
}
;-------------------------------------------------------------------------
; Set Palette
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.SetPalette
{
        SEI    
        LDX     #$0F
.loop
        LDA     PaletteData,X
        AND     #$F0
        ORA     #$07
        STA     ulaPalette
        DEX
        BPL     loop

        CLI
        RTS
}
;-------------------------------------------------------------------------
; SetRoomPalette
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.SetRoomPalette
        SEI
        LDA     room_number
        ASL     A
        TAX
        LDA     L173F,X
        STA     L007B
        LDA     L1740,X
        STA     L007C
        JMP     (L007B)
        ; return
;-------------------------------------------------------------------------
; RoomPalete JMP Table Data
;-------------------------------------------------------------------------
.L173F
        EQUB    $5C
.L1740
        EQUB    $17             ; room 1 address   
        EQUB    $57,$17         ; room 2 address
        EQUB    $95,$17         ; room 3 address
        EQUB    $57,$17         ; room 4 address
        EQUB    $5F,$17         ; room 5 address
        EQUB    $72,$17         ; room 6 address
        EQUB    $81,$17         ; room 7 address
        EQUB    $5C,$17         ; room 8 address
        EQUB    $81,$17         ; room 9 address
        EQUB    $A6,$17         ; room 10 address
        EQUB    $AC,$17         ; room 11 address
        EQUB    $5F,$17         ; room 12 address

;-------------------------------------------------------------------------
; Room Code to change the palette
;-------------------------------------------------------------------------     
.L1757  ; room 2, 4
        LDA     #$96            ; Red
        STA     L17F2

.L175C  ; room 1, 8
        JMP     L17DC
        ; return

.L175F  ; room 5, 12
        LDA     #$FF    
        STA     L0011
        JSR     L17C0
        LDA     #$D6            ; Red
        STA     L17F6
        LDA     #$E6            ; Red
        STA     L17F7
        BNE     L17DC

.L1772  ; room 6
        LDA     #$D3            ; Blue
        STA     L17F6
        LDA     L0011
        BNE     L17B1
        JSR     L17C0
        JMP     L1795

.L1781  ; room 7, 9  
        LDA     #$96            ; Red
        STA     L17F2
        LDA     #$A7            ; Black
        STA     L17F3
        LDA     #$B7            ; Black
        STA     L17F4
        LDA     #$C7            ; Black
        STA     L17F5

.L1795  ; room 3 
        LDA     #$D3            ; Blue
        STA     L17F6
        LDA     #$E3            ; Blue
        STA     L17F7
        LDA     #$F3            ; Blue
        STA     L17F8
        BNE     L17DC

.L17A6  ; room 10
        JSR     L17C0
        JMP     L1795

.L17AC  ; room 11
        LDA     #$D3            ; Blue
        STA     L17F6

.L17B1               
        JSR     L17C0
        LDA     #$E6            ; Red
        STA     L17F7
        LDA     #$F0            ; White
        STA     L17F8
        BNE     L17DC
.L17C0               
        LDX     #$01
        STX     palette_timer
        DEX
        STX     L0026
        LDX     #$96            ; Red
        STX     L17F2
        LDX     #$AD            ; Green
        STX     L17F3
        LDX     #$BC            ; Yellow
        STX     L17F4
        LDX     #$CB            ; Blue
        STX     L17F5
        RTS         

.L17DC              
        LDX     #$0F
.L17DE               
        LDA     PaletteData,X
        STA     ulaPalette
        DEX
        BPL     L17DE
        CLI
        RTS

;-------------------------------------------------------------------------
; PaletteData
;-------------------------------------------------------------------------
; X0 = X8 = White
; X1 = X9 = Cyan      
; X2 = XA = Magenta   
; X3 = XB = Blue      
; X4 = XC = Yellow    
; X5 = XD = Green     
; X6 = XE = Red       
; X7 = XF = Black     
;-------------------------------------------------------------------------
.PaletteData  
        EQUB    $07     ; Black
        EQUB    $16     ; Red
        EQUB    $25     ; Green
        EQUB    $34     ; Yellow
        EQUB    $43     ; Blue
        EQUB    $52     ; Magenta
        EQUB    $61     ; Cyan
        EQUB    $70     ; White
        EQUB    $8F     ; Black
.L17F2
        EQUB    $96     ; Red
.L17F3
        EQUB    $AD     ; Green
.L17F4
        EQUB    $BC     ; Yellow
.L17F5  
        EQUB    $CB     ; Blue
.L17F6
        EQUB    $D3     ; Blue
.L17F7
        EQUB    $E3     ; Blue
.L17F8
        EQUB    $F3     ; Blue

;-------------------------------------------------------------------------
; AnimatedRoomPalette
;-------------------------------------------------------------------------
; Toggle colours between black and white
;-------------------------------------------------------------------------
.AnimateRoomPalette
        SEI
        DEC     palette_timer           ; palette timer
        BNE     L1841

        LDA     #$03
        STA     palette_timer

        LDA     room_number
        CMP     #$05            ; room 6
        BEQ     L1818

        CMP     #$09            ; room 10
        BEQ     L1818

        CMP     #$0A            ; room 11
        BEQ     L1818

        CMP     #$0B            ; room 12
        BEQ     L1818

        CMP     #$04            ; room 5
        BNE     L1843

.L1818  ; Animate room palette                    
        LDA     L0026
        EOR     #$FF
        STA     L0026
        BNE     L182D

        LDA     #$90            ; White
        STA     ulaPalette
        LDA     #$A0            ; White
        LDX     #$B7            ; Black
        LDY     #$C7            ; Black
        BNE     L1838

.L182D
        LDA     #$97            ; Black
        STA     ulaPalette
        LDA     #$A7            ; Black
        LDX     #$B0            ; White
        LDY     #$C0            ; White
.L1838
        STA     ulaPalette
        STX     ulaPalette
        STY     ulaPalette
.L1841
        CLI
        RTS
;-------------------------------------------------------------------------
; Standard rooms palatte
;-------------------------------------------------------------------------
.L1843
        CMP     #$08            ; room 9
        BEQ     L184B

        CMP     #$06            ; room 8
        BNE     L1865

.L184B
        INC     L0026
        LDX     L0026
        DEX
        BEQ     L185B

        CPX     #$06
        BCC     L185F

        LDX     #$01
        STX     L0026
        DEX
.L185B
        LDA     #$20
        STA     palette_timer
.L185F
        LDA     L1867,X
        STA     ulaPalette
.L1865
        CLI
        RTS
;-------------------------------------------------------------------------

.L1867  ; Palette data
        EQUB    $A7     ; Black
        EQUB    $A0     ; White
        EQUB    $B0     ; White
        EQUB    $C0     ; White
        EQUB    $C7     ; Black
        EQUB    $B7     ; Black

;-------------------------------------------------------------------------

.L186D
        LDA     room_number
        ASL     A
        STA     L007D
        ASL     A
        ADC     L007D
        TAX
        LDA     L20B2,X
        STA     L007D
        LDA     L20B3,X
        STA     L007E
        LDY     #$00
        RTS

.L1883
        JSR     L186D

        LDA     #$80
        STA     L001C
.L188A
        LDA     (L007D),Y
        CMP     #$FF
        BEQ     L18B8

        LDX     L0033
        BNE     L18B9

        INY
        PHA
        LDA     (L007D),Y
        INY
        STA     L000D
        STA     L0004
        LDA     (L007D),Y
        INY
        STA     L000E
        PLA
        BMI     L18B4

        TYA
        PHA
        JSR     CalcAddress

        LDA     #$11
        JSR     PlotSprite

        JSR     L1D16

        PLA
        TAY
.L18B4
        INC     L001C
        BNE     L188A

.L18B8
        RTS

.L18B9
        LDA     #$00
        STA     (L007D),Y
        INY
        INY
        INY
        BNE     L18B4
        ; Always branch

;-------------------------------------------------------------------------
; AddScore
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.Add125  ; Lantern score 125
        SED
        CLC
        LDA     score1
        ADC     #$25
        STA     score1
.L18CA
        LDA     score2
        ADC     #$01
.Add1000
        STA     score2
        TAX
        LDA     score3
        ADC     #$00
        STA     score3
        TAY
        CLD
        CMP     highscore3
        BCC     L18EB

        BNE     L18EE

        CPX     highscore2
        BCC     L18EB

        BNE     L18EE

        LDA     score1
        CMP     highscore1
        BCS     L18EE

.L18EB
        JMP     DrawScoreandHighscore
        ; return

.L18EE
        LDA     score1
        STA     highscore1
        STX     highscore2
        STY     highscore3
        JMP     DrawScoreandHighscore
        ; return
;-------------------------------------------------------------------------

.L18F9
        SEC
        SBC     #$80
        STA     L007B
        ASL     A
        CLC
        ADC     L007B
        STA     L007F
        JSR     L186D

        LDY     L007F
        INY
        LDA     (L007D),Y
        CLC
        ADC     #$03
        CMP     L0080
        BCC     L194A

        SBC     #$07
        BCS     L1919

        LDA     #$00
.L1919
        CMP     L0080
        BCS     L194A

        DEY
        LDA     (L007D),Y
        BMI     L194A

        ORA     #$80
        STA     (L007D),Y
        INY
        LDA     (L007D),Y
        INY
        STA     L000D
        LDA     (L007D),Y
        STA     L000E
        JSR     EraseSprite             ; erase bruce ?

        JSR     CalcAddress

        LDA     L000D
        STA     L0004

        LDA     #$12                    ; is lantern #$12 ?
        JSR     PlotSprite              ; erase lantern ?
        JSR     PlotSpriteBruce         ; draw bruce
        JSR     Add125                  ; add score

        INC     lantern_counter
        JMP     L194B                   ; move bruce along (flying jump)
        ; return

.L194A
        RTS

.L194B
        SEI
        LDA     room_number
        ASL     A
        TAX
        LDA     L1960,X
        STA     L007B
        LDA     L1961,X
        STA     L007C
        JSR     L186D

        JMP     (L007B)
        ; return

;-------------------------------------------------------------------------
; Another JMP table
;-------------------------------------------------------------------------
.L1960
        EQUB    $86

.L1961
        EQUB    $19             ; $1986
        EQUB    $78,$19         ; $1978
        EQUB    $88,$19         ; $1988
        EQUB    $96,$19         ; $1996
        EQUB    $A4,$19         ; $19A4
        EQUB    $D9,$19         ; $19D9
        EQUB    $1E,$1A         ; $1A1E
        EQUB    $86,$19         ; $1986
        EQUB    $34,$1A         ; $1A34
        EQUB    $5C,$1A         ; $1A5C
        EQUB    $9C,$1A         ; $1A9C
        EQUB    $C2,$19         ; $19C2
        
.L1978 
        LDA     $30
        CMP     #$14
        BCC     L1986
        LDA     #$97            ; Black
        STA     L17F2
        STA     ulaPalette
.L1986               
        CLI
        RTS
                    
.L1988               
        LDA     L0011
        BEQ     L1986
        LDA     #$D7            ; Black
        STA     L17F6
        STA     ulaPalette
        CLI
        RTS
                    
.L1996               
        LDA     ($7D),Y
        BPL     L19A2
        LDA     #$97            ; Black
        STA     L17F2
        STA     ulaPalette
.L19A2               
        CLI
        RTS
                    
.L19A4               
        LDY     #$03
        LDA     ($7D),Y
        BPL     L19B2
        LDA     #$E7            ; Black
        STA     L17F7
        STA     ulaPalette
.L19B2               
        LDY     #$00
        LDA     ($7D),Y
        BPL     L19C0
        LDA     #$D7            ; Black
        STA     L17F6
        STA     ulaPalette
.L19C0               
        CLI
        RTS
                    
.L19C2               
        LDY     #$03
        LDA     ($7D),Y
        BPL     L19B2
        CLI
        LDX     #$1D
        LDY     #$28
        JSR     L0386
        JSR     L15CB
        JSR     L1F7E
        JMP     L0955
                    
.L19D9               
        LDA     L0011
        BEQ     L19F4
        LDY     #$09
        LDA     ($7D),Y
        BPL     L19EB
        LDX     #$D7            ; Black
        STX     L17F6
        STX     ulaPalette
.L19EB               
        LDY     #$0C
        LDA     ($7D),Y
        BPL     L1A1C
        JMP     L1ABC
                    
.L19F4               
        LDY     #$18
        LDA     ($7D),Y
        BPL     L1A1C
        LDY     #$1B
        LDA     ($7D),Y
        BPL     L1A1C
        LDX     #$E7            ; Black
        STX     L17F7
        STX     ulaPalette
        LDY     #$12
        LDA     ($7D),Y
        BPL     L1A1C
        LDY     #$15
        LDA     ($7D),Y
        BPL     L1A1C
        LDX     #$F7            ; Black
        STX     L17F8
        STX     ulaPalette
.L1A1C               
        CLI
        RTS
                    
.L1A1E               
        LDY     #$0F
.L1A20               
        LDA     ($7D),Y
        BPL     L1A31
        DEY
        DEY
        DEY
        BPL     L1A20
        LDA     #$D7            ; Black
        STA     L17F6
        STA     ulaPalette
.L1A31               
        CLI
        RTS
                    
.L1A33               
        RTS
                    
.L1A34               
        LDY     #$09
.L1A36               
        LDA     ($7D),Y
        BPL     L1A31
        DEY
        DEY
        DEY
        BPL     L1A36
        LDA     #$D7            ; Black
        STA     L17F6
        STA     ulaPalette
        LDY     #$1B
.L1A49               
        LDA     ($7D),Y
        BPL     L1A5A
        DEY
        DEY
        DEY
        BPL     L1A49
        LDA     #$E7            ; Black
        STA     L17F7
        STA     ulaPalette
.L1A5A               
        CLI
        RTS
                    
.L1A5C               
        LDA     ($7D),Y
        BPL     L1A9A
        LDA     #$D7            ; Black
        STA     L17F6
        STA     ulaPalette
        dec     room_number
        JSR     L186D
        INC     room_number
        LDY     #$1E
        LDA     ($7D),Y
        BPL     L1A9A
        LDY     #$21
        LDA     ($7D),Y
        BPL     L1A9A
        LDA     #$E7            ; Black
        STA     L17F7
        STA     ulaPalette
        JSR     L186D
        LDY     #$03
        LDA     ($7D),Y
        BPL     L1A9A
        LDY     #$06
        LDA     ($7D),Y
        BPL     L1A9A
        LDA     #$F7            ; Black
        STA     L17F8
        STA     ulaPalette
.L1A9A               
        CLI
        RTS
                    
.L1A9C               
        LDA     ($7D),Y
        BPL     L1ACC
        LDY     #$03
        LDA     ($7D),Y
        BPL     L1ACC
        STA     $29
        LDY     #$06
        LDA     ($7D),Y
        BPL     L1ACC
        LDA     #$D7            ; Black
        STA     L17F6
        STA     ulaPalette
        LDY     #$09
        LDA     ($7D),Y
        BPL     L1ACC
.L1ABC              
        LDA     #$E7            ; Black
        STA     L17F7
        STA     ulaPalette
        LDA     #$F7            ; Black
        STA     L17F8
        STA     ulaPalette
.L1ACC               
        CLI
        RTS

;-------------------------------------------------------------------------
; DrawScoreandHighscore
;-------------------------------------------------------------------------
; On entry  :
; On exit   : 
;-------------------------------------------------------------------------
.DrawScoreandHighscore
        LDA     #$C8
        STA     L0000
        LDA     #$37            ; $37C8
        STA     L0001
        LDA     score3
        JSR     DrawNumbers

        LDA     score2
        JSR     DrawNumbers

        LDA     score1
        JSR     DrawNumbers

        LDA     #$C0
        STA     L0000
        LDA     #$38            ; $38C0
        STA     L0001
        LDA     highscore3
        JSR     DrawNumbers

        LDA     highscore2
        JSR     DrawNumbers

        LDA     highscore1
        JMP     DrawNumbers
        ; return

;-------------------------------------------------------------------------
; DrawLives
;-------------------------------------------------------------------------
; On entry  :
; On exit   : 
;-------------------------------------------------------------------------
.DrawLives
        LDA     #$E0
        STA     L0000
        LDA     #$39
        STA     L0001           ; $39E0
        LDA     lives
        ; drop through

;-------------------------------------------------------------------------
; DrawNumbers
;-------------------------------------------------------------------------
; On entry  : A contains value
; On exit   : 
;-------------------------------------------------------------------------
.DrawNumbers
        PHA
        LDA     #$00
        STA     L0004
        PLA
        PHA
        LSR     A
        LSR     A
        LSR     A
        LSR     A
        CLC
        ADC     #$14
        JSR     PlotSprite

        PLA
        AND     #$0F
        CLC
        ADC     #$14
        JSR     PlotSprite
        RTS
;-------------------------------------------------------------------------
; EraseSprite
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.EraseSprite
        LDA     L0097
        STA     L0002
        LDA     L0098
        STA     L0003
        LDA     L0082
        STA     L0000
        LDA     L0083
        STA     L0001
        LDA     L0091
        STA     L0004
        LDA     L0084
        STA     L0008
        LDA     L0085
        STA     L000C
        JMP     EraseMaskedSprite
        ; return
;-------------------------------------------------------------------------

.L1B40
        LDA     L0080
        STA     L000D
        LDA     L0081
        STA     L000E
        LDA     L0080
        STA     L0004
        STA     L0091
        JSR     CalcAddress

        LDA     L0000
        STA     L0082
        LDA     L0001
        STA     L0083
        RTS

;-------------------------------------------------------------------------
; PlotSpriteBruce? PlotSpriteMask? PlotSpriteBruceFirstTimeOnScreen?
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.PlotSpriteBruce
        JSR     L1B40

        LDA     L008B
        BNE     L1B88

        LDA     L0089
        BNE     L1B69

        LDA     L0088
        BMI     L1B8E

.L1B69
        LDA     L0086
        CMP     #$02
        BCS     L1B8E

        AND     #$01
        STA     L0020
        LDA     L0087
        BPL     L1B82

        CLC
        ADC     #$82
        CMP     #$0B
        BCC     L1B98

        LDA     #$02
        BNE     L1B98

.L1B82
        AND     #$02
        LSR     A
        NOP
        BPL     L1B98

.L1B88
        LDA     #$04
        STA     L0020
        BNE     L1B98

.L1B8E
        LDA     L0087
        AND     #$04
        LSR     A
        LSR     A
        STA     L0020
        LDA     #$03
.L1B98
        STA     L007B
        ASL     A
        ASL     A
        CLC
        ADC     L007B
        TAY
        LDA     (L0094),Y
        INY
        STA     L0002
        LDA     (L0094),Y
        INY
        STA     L0003
        LDA     (L0094),Y
        INY
        STA     L000B
        STA     L0008
        STA     L0084
        LDA     (L0094),Y
        INY
        STA     L000C
        STA     L0085
        LDA     (L0094),Y
        STA     L001F
        LDA     L0020
        BEQ     L1BC5

        JMP     L1216
        ; return

.L1BC5
        JMP     L116B
        ; return

;-------------------------------------------------------------------------
; EventHandler
;-------------------------------------------------------------------------
; On entry  :
; On exit   : 
;-------------------------------------------------------------------------
.EventHandler
{
        PHP
        PHA
        CMP     #%00000100              ; Is this a v-sync event?
        BNE     exit    

        INC     speed_counter           ; counter between 0 - 2

        LDA     walking_sound_delay     ; counter between 0 - 6
        BEQ     exit
        DEC     walking_sound_delay
.exit
        PLA
        PLP
        RTS
}
;-------------------------------------------------------------------------

.L1BD9  ; Room entered Data, first value never used for room 1
        EQUB    $00,$00,$00,$00
        EQUB    $00,$00,$00,$00
        EQUB    $00,$00,$00,$00

;-------------------------------------------------------------------------
; NextRoom
;-------------------------------------------------------------------------
; On entry  :
; On exit   : 
;-------------------------------------------------------------------------
.NextRoom
        LDA     in_play
        BNE     L1C00           ; Attract Mode?

        LDX     room_number
        BEQ     L1C00           ; room 1 no entry score

        LDA     L1BD9,X
        BNE     L1C00           ; room already entered

        LDA     #$FF            ; Room entered, mark it with $FF
        STA     L1BD9,X
        SED
        CLC
        LDA     score2
        ADC     #$20            ; Score 2000 points for entering new room
        JSR     Add1000

.L1C00
        JSR     L1105

        LDA     #$00
        STA     L0088
        JSR     L110C

        JSR     L1F0F

        LDA     #$80
        STA     L007B
        LDA     #$03
        STA     L007C
        LDA     #$03
        STA     L007D
        LDY     #$80
        LDA     #$00
.L1C1D
        STA     (L007B),Y
        INY
        BNE     L1C1D

        INC     L007C
        DEC     L007D
        BNE     L1C1D

        LDA     #$00
        STA     L0020

        JSR     SetPalette
        JSR     ClearScreen

        LDA     room_number
        CMP     #$05
        BNE     L1C47

        LDA     L0011
        BEQ     L1C47

        LDA     #$0B
        STA     L000F
        LDA     #$1D
        STA     L0010
        JSR     L1C67

.L1C47
        LDA     room_number
        ASL     A
        STA     L007B
        ASL     A
        CLC
        ADC     L007B
        TAX
        LDA     L20B0,X
        STA     L000F
        LDA     L20B1,X
        STA     L0010

        JSR     L1C67
        JSR     L1883
        JSR     SetRoomPalette
        JMP     L194B
        ; return

.L1C67
        LDY     #$00
        LDA     (L000F),Y
        INY
        CMP     #$F3
        BNE     L1C71
        RTS

.L1C71
        STA     L001C
        LDA     (L000F),Y
        INY
        STA     L000D
        LDA     (L000F),Y
        INY
        STA     L000E
        LDA     (L000F),Y
        INY
        STA     L001E
        LDA     (L000F),Y
        STA     L001D
        JSR     CalcAddress

.L1C89
        LDA     room_number
        CMP     #$05
        BNE     L1CA5

        LDA     L0011
        BEQ     L1CA5

        LDA     L001C
        CMP     #$2B
        BEQ     L1CC1

        CMP     #$2A
        BEQ     L1CC1

        CMP     #$06
        BEQ     L1CC1

        CMP     #$2D
        BEQ     L1CC1

.L1CA5
        LDA     L0029
        BEQ     L1CAF

        LDA     L001C
        CMP     #$2C
        BEQ     L1CC1

.L1CAF
        LDA     L000D
        STA     L0004
        LDA     L001C
        CMP     #$F0
        BEQ     L1CBE

        LDA     L001C
        JSR     PlotSprite

.L1CBE
        JSR     L1D16

.L1CC1
        LDA     L001E
        CMP     #$F3
        BEQ     L1D0A

        DEC     L001D
        BEQ     L1CEA

        CMP     #$F1
        BEQ     L1CE3

        CMP     #$F2
        BEQ     L1CD6

        JMP     L1CFA
        ; return

.L1CD6
        CLC
        LDA     L000E
        ADC     L000C
        STA     L000E
        JSR     CalcAddress

        JMP     L1C89
        ; return

.L1CE3
        LDA     L0004
        STA     L000D
        JMP     L1C89
        ; return

.L1CEA
        CLC
        LDA     L000F
        ADC     #$05
        STA     L000F
        LDA     L0010
        ADC     #$00
        STA     L0010
        JMP     L1C67
        ; return

.L1CFA
        CLC
        LDA     L000F
        ADC     #$03
        STA     L000F
        LDA     L0010
        ADC     #$00
        STA     L0010
        JMP     L1C67
        ; return

.L1D0A
        RTS

        ; DATA ?
        EQUB    $03,$34,$20,$F2,$0B,$2E,$41,$20
        EQUB    $F1,$02,$F3

.L1D16
        LDA     L000D
        PHA
        LDA     L000E
        PHA
        LDA     L001C
        PHA
        CMP     #$F0
        BCS     L1D2B

        CMP     #$80
        BCS     L1D2B

        CMP     #$34
        BCS     L1D53

.L1D2B
        JSR     L15FD

        LDA     L000B
        LSR     A
        LSR     A
        BNE     L1D36

        LDA     #$01
.L1D36
        STA     L000B
        LDA     L000C
        LSR     A
        LSR     A
        LSR     A
        BNE     L1D41

        LDA     #$01
.L1D41
        STA     L0009
        LDY     #$00
.L1D45
        TYA
        PHA
        JSR     L1D5D

        PLA
        CLC
        ADC     #$14
        TAY
        DEC     L0009
        BNE     L1D45

.L1D53
        PLA
        STA     L001C
        PLA
        STA     L000E
        PLA
        STA     L000D
        RTS

.L1D5D
        LDA     L001C
        LDX     L000B
.L1D61
        STA     (L007B),Y
        INY
        DEX
        BNE     L1D61

        RTS



.L1D68  ; Game loop ?
        LDA     #$00
        STA     L0089
        STA     L0096
        LDA     room_number
        CMP     #$0A
        BNE     L1D80

        LDA     room_number
        LDX     L0081
        CPX     #$BE
        BCC     L1D80

        LDA     #$09
        STA     room_number
.L1D80
        ASL     A
        ASL     A
        TAX
        LDA     L1D9A,X
        STA     L0080
        LDA     L1D9B,X
        STA     L0081
        LDA     L1D9C,X
        STA     L0086
        LDA     L1D9D,X
        STA     L0087
        JMP     L110C
        ; return

.L1D9A  ; DATA ?
        EQUB    $08
.L1D9B
        EQUB    $46
.L1D9C
        EQUB    $01
.L1D9D
        EQUB    $80,$00,$46,$01,$80,$00,$46,$01
        EQUB    $80,$00,$D6,$01,$80,$4B,$CE,$00
        EQUB    $80,$24,$22,$03,$82,$47,$C6,$00
        EQUB    $80,$04,$46,$01,$80,$0A,$22,$03
        EQUB    $82,$00,$46,$01,$80,$00,$46,$00
        EQUB    $80,$48,$66,$00,$80

;-------------------------------------------------------------------------
; ???
;-------------------------------------------------------------------------
; On entry  :
; On exit   : 
;-------------------------------------------------------------------------
.L1DCA
        LDA     room_number
        ASL     A
        TAX
        LDA     L2714,X
        STA     L0023
        LDA     L2715,X
        STA     L0024
        LDA     #$00
        TAY
        RTS
;-------------------------------------------------------------------------

.L1DDC
        PLA
        RTS
;-------------------------------------------------------------------------

.L1DDE
        JSR     L1105
        JSR     L1DCA

.L1DE4
        PHA
        STA     L007F
        ASL     A
        ASL     A
        CLC
        ADC     L007F
        TAX
        LDA     L0012
        BNE     L1DDC

        LDA     (L0023),Y
        INY
        CMP     #$FF
        BEQ     L1DDC

        STA     L007F
        LDA     L004D,X
        BMI     L1E02

        DEC     L004D,X
        BPL     L1E0C

.L1E02
        JSR     L1EB2

        CLC
        TYA
        ADC     #$05
        TAY
        BNE     L1E5E

.L1E0C
        INY
        LDA     (L0023),Y
        INY
        STA     L000D
        LDA     (L0023),Y
        INY
        STA     L000E
        LDA     (L0023),Y
        PHP
        LDA     L004E,X
        PLP
        BPL     L1E24

        CLC
        ADC     #$02
        ADC     L007F
.L1E24
        CLC
        ADC     L000D
        STA     L000D
        JSR     L1E8E

        CLC
        LDA     L000D
        ADC     (L0023),Y
        STA     L000D
        CLC
        LDA     L004E,X
        ADC     (L0023),Y
        INY
        STA     L004E,X
        STX     L007D
        STY     L007E
        JSR     L1E65

        JSR     CalcAddress

        LDX     L007D
        LDY     L007E
        LDA     L0000
        STA     L004F,X
        LDA     L0001
        STA     L0050,X
        LDA     (L0023),Y
        INY
        STY     L007E
        JSR     PlotSprite

        JSR     L1E8E

        LDY     L007E
.L1E5E
        PLA
        CLC
        ADC     #$01
        JMP     L1DE4
        ; return

.L1E65
        LDA     #$03
        STA     L0008
        STA     L000C
        LDA     (L0023),Y
        CMP     #$33
        BEQ     L1E79

        LDA     #$02
        STA     L0008
        LDA     #$09
        STA     L000C
.L1E79
        LDA     L004F,X
        STA     L0000
        LDA     L0050,X
        STA     L0001
        LDA     #$30
        STA     L0002
        LDA     #$38
        STA     L0003
        STA     L0004
        JMP     EraseMaskedSprite
        ; return

.L1E8E
        CLC
        LDA     L0080
        ADC     #$04
        CMP     L000D
        BCC     L1EB1

        LDA     L000D
        ADC     #$01
        CMP     L0080
        BCC     L1EB1

        LDA     L0081
        ADC     #$1A
        CMP     L000E
        BCC     L1EB1

        LDA     L000E
        ADC     #$09
        CMP     L0081
        BCC     L1EB1

        STA     L0012
.L1EB1
        RTS

.L1EB2
        TXA
        PHA
        TYA
        PHA
        DEC     L0051,X
        BEQ     L1ECD

        LDA     L004D,X
        CMP     #$FF
        BNE     L1F0A

        DEC     L004D,X
        CLC
        TYA
        ADC     #$04
        TAY
        JSR     L1E65
        JMP     L1F0A
        ; return

.L1ECD
        LDA     (L0023),Y
        STA     L0051,X
        LDA     L007F
        STA     L004D,X
        LDA     #$00
        STA     L004E,X
        JSR     L186D

        LDX     #$01
        LDA     room_number
        CMP     #$08
        BNE     L1EF7

        LDY     #$1E
        LDA     (L007D),Y
        BPL     L1EF2

        LDY     #$21
        LDA     (L007D),Y
        BPL     L1EF2

        LDX     #$FF
.L1EF2
        STX     L277B
        BNE     L1F0A

.L1EF7
        CMP     #$0A
        BNE     L1F0A

        LDA     (L007D),Y
        BPL     L1F07

        LDY     #$03
        LDA     (L007D),Y
        BPL     L1F07

        LDX     #$FF
.L1F07
        STX     L278F
.L1F0A
        PLA
        TAY
.L1F0C
        PLA
        TAX
        RTS

.L1F0F
        JSR     L1DCA

.L1F12
        STA     L007B
        PHA
        ASL     A
        ASL     A
        CLC
        ADC     L007B
        TAX
        LDA     #$01
        STA     L0051,X
        LDA     #$80
        STA     L0050,X
        LDA     (L0023),Y
        INY
        CMP     #$FF
        BEQ     L1F0C

        STA     L007F
        JSR     L1EB2

        INY
        INY
        INY
        INY
        INY
        PLA
        CLC
        ADC     #$01
        BNE     L1F12           ; Always branch
        
;-------------------------------------------------------------------------
; AttractMode
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.AttractMode  
        JSR     L15C3

.L1F3D
        LDA     #$00
        STA     speed_counter
        STA     L0032
        STA     L0011
        STA     L0029

        JSR     L1105
        JSR     L1D68
        JSR     L0955

.L1F50  ; Loop to handle waiting for SPACE bar to play game
        LDA     #$00
        STA     speed_counter

        JSR     L0975
        JSR     L1DDE

        LDA     #$09            ; [SPACE] Start Game
        JSR     ReadKey           

        BEQ     L1F73           ; Start Game

        DEC     L0032
        BMI     L1F50           ; loop

        ; Attract Mode showing screens 0 - 12?
        INC     room_number
        LDA     room_number
        CMP     #$0C
        BCC     L1F3D

        LDA     #$00
        STA     room_number
        BEQ     L1F3D           ; Always loop
;-------------------------------------------------------------------------

.L1F73  ; Start Game
        LDA     #$00
        STA     score1
        STA     score2
        STA     score3
        JSR     DrawScoreandHighscore
.L1F7E
        LDA     #$96
        STA     L007B
        LDA     #$1F
        STA     L007C

        LDY     #$17
.L1F88
        LDA     (L007B),Y
        STA     L15A9,Y
        DEY
        BNE     L1F88

        STY     in_play         ; Y = 0
        STY     L0011
        STY     room_number
        RTS
;-------------------------------------------------------------------------
        ; DATA
        EQUB    $08,$46,$00,$80,$05,$1A,$01,$80
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$01,$05,$D2,$16,$00

;-------------------------------------------------------------------------
; PlotSprite
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.PlotSprite
        STA     L007B
        TAX
        ASL     A
        ASL     A
        CLC
        ADC     L007B
        STA     L007B
        LDA     #$00
        TAY
        ADC     #$00
        STA     L007C
        LDA     L007B
        ADC     #$46
        STA     L007B
        LDA     L007C
        ADC     #$28
        STA     L007C
        LDA     (L007B),Y
        INY
        STA     L0002
        LDA     (L007B),Y
        INY
        STA     L0003
        LDA     (L007B),Y
        INY
        STA     L000B
        STA     L0008
        LDA     (L007B),Y
        INY
        STA     L000C
        LDA     (L007B),Y
        STA     L0021
        LDA     L0097
        PHA
        LDA     L0098
        PHA
        LDA     #$80
        STA     L0098
        CPX     #$0D
        BEQ     L1FFD

        CPX     #$30
        BEQ     L1FFD

        JSR     L1141
        JMP     L2000
        ; return

.L1FFD
        JSR     L116B

.L2000
        PLA
        STA     L0098
        PLA
        STA     L0097
        RTS
;-------------------------------------------------------------------------

.L2007
        JSR     L15FD

        LDY     #$00
        LDA     (L007B),Y
        PHA
        CMP     #$F0
        BEQ     L2037

        CMP     #$22
        BNE     L2022

        LDA     L17F2
        AND     #$0F
        CMP     #$07
        BEQ     L2072

        BNE     L2037

.L2022
        CMP     #$29
        BCC     L203B

        CMP     #$2C
        BCS     L203B

        SEC
        SBC     #$29
.L202D
        TAX
        LDA     L17F6,X
        AND     #$0F
        CMP     #$07
        BEQ     L2072

.L2037
        PLA
        LDA     #$FF
        RTS

.L203B
        CMP     #$06
        BCS     L2048

        CMP     #$03
        BCC     L2048

        SBC     #$03
        JMP     L202D
        ; return

.L2048
        CMP     #$27
        BCS     L2055

        CMP     #$25
        BCC     L2055

        SBC     #$25
        JMP     L202D
        ; return

.L2055
        CMP     #$2D
        BNE     L2076

.L2059
        LDA     #$07
        CMP     L0089
        BEQ     L2037

        STA     L0089
        LDA     #$03
        STA     knock_downs
        LDA     L0014
        BEQ     L206E

        DEC     lives
        JSR     DrawLives

.L206E
        LDA     #$FF
        STA     L0096
.L2072
        PLA
        LDA     #$00
        RTS

.L2076
        CMP     #$2E
        BNE     L2083

        LDA     L17F8
        CMP     #$F7
        BNE     L2059

        BEQ     L2072

.L2083
        CMP     #$2F
        BEQ     L2059

        CMP     #$30
        BNE     L2093

        LDA     L0026
        CMP     #$01
        BEQ     L2072

        BNE     L2059

.L2093
        CMP     #$80
        BCS     L20A1

        LDY     #$01
        LDA     (L007B),Y
        CMP     #$80
        BCS     L20A1

        PLA
        RTS

.L20A1
        LDX     L0089
        CPX     #$05
        BEQ     L20AA

        DEX
        BNE     L2072

.L20AA
        JSR     L18F9
        JMP     L2072
        ; return

        ; Sprite Data Below ?
.L20B0
        EQUB    $F8

.L20B1
        EQUB    $20

.L20B2
        EQUB    $45

.L20B3
        EQUB    $21

.L20B4
        EQUB    $55

.L20B5
        EQUB    $21,$5E,$21,$A6,$21,$B9,$21,$C6
        EQUB    $21,$46,$22,$41,$22,$16,$26,$90
        EQUB    $26,$28,$25,$62,$22,$E1,$22,$E8
        EQUB    $22,$ED,$22,$66,$23,$85,$23,$8A
        EQUB    $23,$EE,$23,$01,$24,$E8,$25,$E7
        EQUB    $25,$E7,$25,$06,$24,$61,$24,$86
        EQUB    $24,$8B,$24,$1C,$25,$28,$25,$29
        EQUB    $25,$D8,$25,$28,$25,$98,$27,$94
        EQUB    $26,$28,$25,$01,$00,$F0,$F1,$1B
        EQUB    $34,$10,$BE,$37,$10,$AF,$21,$10
        EQUB    $A8,$34,$36,$BE,$34,$3D,$BE,$35
        EQUB    $41,$76,$36,$45,$76,$02,$00,$84
        EQUB    $F2,$12,$02,$4C,$A8,$F2,$0C,$07
        EQUB    $00,$60,$F1,$0C,$09,$20,$60,$08
        EQUB    $20,$68,$F2,$0C,$0F,$00,$96,$F1
        EQUB    $04,$0F,$3C,$60,$F1,$0A,$0F,$30
        EQUB    $A8,$F1,$10,$F0,$04,$34,$10,$00
        EQUB    $46,$13,$06,$AC,$20,$0F,$90,$F3
        EQUB    $00,$06,$BA,$00,$3E,$73,$00,$4C
        EQUB    $73,$00,$32,$BA,$00,$48,$BA,$FF
        EQUB    $04,$4F,$46,$00,$80,$4F,$8E,$00
        EQUB    $80,$02,$4C,$60,$F2,$18,$01,$00
        EQUB    $F0,$F1,$1B,$38,$09,$76,$38,$45
        EQUB    $76,$34,$0C,$BE,$34,$3C,$BE,$02
        EQUB    $00,$A8,$F2,$0C,$0F,$00,$60,$F1
        EQUB    $08,$0F,$40,$60,$F1,$08,$07,$1C
        EQUB    $60,$F1,$06,$0F,$00,$A8,$F1,$0E
        EQUB    $0F,$34,$A8,$F1,$0E,$09,$24,$60
        EQUB    $08,$24,$68,$F2,$03,$09,$24,$A8
        EQUB    $08,$24,$B0,$F2,$03,$22,$24,$F0
        EQUB    $F3,$00,$0C,$73,$00,$42,$73,$00
        EQUB    $06,$BA,$00,$18,$BA,$00,$36,$BA
        EQUB    $00,$48,$BA,$FF,$08,$FC,$46,$01
        EQUB    $80,$4F,$46,$00,$80,$FC,$8E,$01
        EQUB    $80,$03,$4C,$AC,$F2,$0C,$01,$00
        EQUB    $F0,$F1,$1B,$38,$15,$BE,$38,$2B
        EQUB    $BE,$38,$0A,$76,$39,$0A,$A8,$38
        EQUB    $0A,$BE,$38,$3B,$BE,$39,$3B,$AC
        EQUB    $38,$2B,$76,$34,$41,$BE,$37,$41
        EQUB    $AF,$21,$41,$A8,$F0,$40,$34,$10
        EQUB    $40,$46,$02,$00,$60,$F2,$18,$07
        EQUB    $3F,$60,$F1,$03,$1F,$4A,$60,$1E
        EQUB    $4C,$6C,$F2,$08,$1F,$38,$60,$1E
        EQUB    $3A,$6C,$F2,$08,$20,$40,$90,$07
        EQUB    $1C,$60,$F1,$03,$08,$20,$68,$F2
        EQUB    $0C,$09,$20,$60,$09,$20,$A8,$0F
        EQUB    $00,$60,$F1,$08,$0F,$28,$60,$F1
        EQUB    $04,$0F,$00,$A8,$F1,$04,$0F,$10
        EQUB    $A8,$F1,$06,$0F,$24,$A8,$F1,$08
        EQUB    $3A,$37,$6B,$F3,$00,$00,$46,$01
        EQUB    $80,$00,$28,$73,$00,$28,$BA,$00
        EQUB    $30,$BA,$00,$04,$73,$00,$0C,$73
        EQUB    $00,$04,$BA,$00,$12,$BA,$00,$18
        EQUB    $BA,$00,$37,$73,$FF,$28,$1C,$2A
        EQUB    $28,$48,$2A,$2D,$2C,$74,$2D,$38
        EQUB    $74,$0B,$10,$68,$0A,$10,$70,$F2
        EQUB    $0A,$0D,$30,$37,$F2,$16,$0D,$34
        EQUB    $37,$F2,$16,$02,$00,$2A,$F2,$20
        EQUB    $02,$0C,$68,$F2,$16,$02,$18,$22
        EQUB    $F2,$18,$02,$28,$68,$F2,$16,$02
        EQUB    $2C,$68,$F2,$02,$02,$38,$68,$F2
        EQUB    $02,$02,$3C,$68,$F2,$0C,$02,$4C
        EQUB    $22,$F2,$18,$01,$0C,$E8,$F1,$0C
        EQUB    $01,$0C,$F2,$F1,$0C,$01,$38,$E8
        EQUB    $F1,$08,$01,$38,$F2,$F1,$08,$01
        EQUB    $00,$E8,$01,$00,$F2,$24,$00,$22
        EQUB    $F1,$0B,$24,$3C,$22,$F1,$05,$25
        EQUB    $1C,$A8,$F1,$03,$26,$40,$A8,$F1
        EQUB    $03,$2D,$2C,$20,$F1,$05,$2F,$2F
        EQUB    $E8,$F1,$03,$F3,$00,$1C,$32,$00
        EQUB    $49,$32,$FF,$00,$4F,$CE,$00,$80
        EQUB    $2D,$41,$20,$F1,$02,$0D,$40,$34
        EQUB    $F2,$14,$0D,$44,$34,$F2,$14,$28
        EQUB    $35,$6A,$28,$1D,$B2,$28,$31,$B2
        EQUB    $02,$00,$28,$F2,$16,$06,$34,$28
        EQUB    $F2,$0A,$02,$38,$60,$F2,$0C,$02
        EQUB    $4C,$28,$F2,$0A,$24,$00,$20,$F1
        EQUB    $09,$2B,$00,$B2,$F2,$08,$2A,$20
        EQUB    $B2,$F2,$08,$28,$34,$B2,$F2,$08
        EQUB    $28,$4C,$B2,$F2,$08,$28,$03,$B2
        EQUB    $28,$23,$B2,$24,$2C,$20,$F1,$05
        EQUB    $24,$48,$20,$F1,$02,$24,$0C,$60
        EQUB    $F1,$0D,$24,$48,$60,$F1,$02,$24
        EQUB    $00,$A8,$F1,$0A,$24,$30,$A8,$F1
        EQUB    $04,$24,$48,$A8,$F1,$02,$24,$00
        EQUB    $F0,$F1,$10,$24,$48,$F0,$F1,$02
        EQUB    $F3,$00,$04,$2A,$00,$0C,$2A,$00
        EQUB    $31,$2A,$00,$38,$2A,$00,$49,$2A
        EQUB    $00,$35,$72,$00,$04,$BA,$00,$1D
        EQUB    $BA,$00,$24,$BA,$00,$31,$BA,$FF
        EQUB    $00,$24,$1A,$03,$82,$34,$1A,$AE
        EQUB    $37,$1A,$9F,$34,$2E,$AE,$37,$2E
        EQUB    $9F,$38,$1C,$56,$39,$1C,$44,$38
        EQUB    $32,$56,$39,$32,$44,$03,$00,$20
        EQUB    $F2,$12,$02,$00,$88,$F2,$0F,$02
        EQUB    $4C,$20,$F2,$21,$0A,$04,$8C,$F2
        EQUB    $06,$0B,$04,$88,$01,$00,$E0,$F1
        EQUB    $1B,$01,$00,$EA,$F1,$1B,$01,$00
        EQUB    $F4,$F1,$1B,$0F,$14,$88,$F1,$14
        EQUB    $13,$16,$9E,$13,$38,$9E,$0F,$18
        EQUB    $30,$F1,$10,$13,$18,$46,$13,$20
        EQUB    $46,$13,$36,$46,$13,$2E,$46,$30
        EQUB    $24,$C8,$30,$10,$C8,$30,$38,$C8
        EQUB    $F3,$00,$16,$AC,$00,$38,$AC,$00
        EQUB    $18,$54,$00,$20,$54,$00,$36,$54
        EQUB    $00,$2E,$54,$FF,$00,$47,$C6,$00
        EQUB    $80,$30,$10,$40,$30,$38,$40,$30
        EQUB    $04,$88,$30,$1C,$88,$F1,$02,$02
        EQUB    $00,$20,$F2,$22,$03,$40,$20,$F2
        EQUB    $0B,$02,$4C,$20,$F2,$0B,$28,$4C
        EQUB    $58,$04,$4C,$60,$F2,$0B,$01,$FF
        EQUB    $58,$F1,$17,$01,$00,$A0,$F1,$1B
        EQUB    $01,$00,$EA,$F1,$1B,$01,$00,$F4
        EQUB    $F1,$1B,$22,$04,$E0,$F1,$02,$27
        EQUB    $0E,$E0,$F1,$38,$22,$46,$E0,$F1
        EQUB    $02,$28,$08,$62,$28,$0B,$62,$28
        EQUB    $18,$62,$28,$1B,$62,$28,$2C,$62
        EQUB    $28,$2F,$62,$F3,$00,$18,$20,$00
        EQUB    $1C,$20,$00,$36,$20,$00,$3A,$20
        EQUB    $00,$08,$6A,$00,$0C,$6A,$00,$18
        EQUB    $6A,$00,$1C,$6A,$00,$2C,$6A,$00
        EQUB    $30,$6A,$00,$04,$AA,$00,$08,$AA
        EQUB    $FF,$00,$0C,$24,$03,$82,$28,$00
        EQUB    $60,$F2,$09,$29,$00,$A8,$F2,$09
        EQUB    $0D,$04,$60,$F2,$11,$28,$08,$60
        EQUB    $F2,$08,$2D,$08,$A0,$28,$1C,$20
        EQUB    $F2,$0B,$2A,$1C,$78,$F2,$06,$28
        EQUB    $1C,$A8,$F2,$09,$28,$1F,$20,$F2
        EQUB    $02,$0D,$24,$34,$F2,$16,$0D,$28
        EQUB    $34,$F2,$16,$2D,$23,$20,$F1,$03
        EQUB    $28,$2D,$20,$F2,$02,$28,$30,$20
        EQUB    $F2,$0B,$2B,$30,$78,$F2,$06,$28
        EQUB    $30,$A8,$F2,$09,$28,$44,$60,$F2
        EQUB    $08,$0D,$48,$60,$F2,$11,$2C,$4C
        EQUB    $20,$F2,$08,$28,$4C,$60,$F2,$08
        EQUB    $2D,$44,$A0,$24,$00,$F0,$F1,$14
        EQUB    $24,$1C,$68,$F1,$02,$24,$2C,$68
        EQUB    $F1,$02,$24,$18,$A8,$F1,$03,$24
        EQUB    $2C,$A8,$F1,$03,$2F,$04,$E8,$2F
        EQUB    $14,$E8,$2F,$24,$E8,$2F,$29,$E8
        EQUB    $2F,$48,$E8,$2F,$38,$E8,$F3,$00
        EQUB    $0C,$70,$00,$20,$30,$00,$2D,$30
        EQUB    $00,$41,$70,$FF,$28,$00,$68,$F2
        EQUB    $08,$0D,$04,$80,$F2,$05,$0D,$08
        EQUB    $70,$F2,$04,$0D,$0C,$60,$F2,$04
        EQUB    $0D,$10,$50,$F2,$04,$0D,$14,$50
        EQUB    $F2,$02,$0D,$18,$50,$F2,$02,$24
        EQUB    $00,$60,$F1,$02,$28,$08,$A4,$28
        EQUB    $0C,$94,$F2,$03,$28,$10,$84,$F2
        EQUB    $05,$28,$14,$74,$F2,$07,$28,$18
        EQUB    $74,$2F,$08,$90,$2F,$0C,$80,$2F
        EQUB    $10,$70,$2F,$14,$60,$2F,$18,$60
        EQUB    $28,$30,$20,$F2,$0D,$29,$30,$84
        EQUB    $F2,$05,$28,$38,$A4,$24,$00,$A8
        EQUB    $F1,$07,$0D,$34,$70,$F2,$07,$0D
        EQUB    $38,$60,$F2,$06,$0D,$3C,$50,$F2
        EQUB    $06,$0D,$40,$50,$F2,$03,$28,$44
        EQUB    $20,$F2,$0A,$0D,$48,$34,$F2,$18
        EQUB    $28,$4C,$20,$F2,$1B,$23,$00,$F0
        EQUB    $F1,$02,$27,$0A,$F0,$F1,$2E,$23
        EQUB    $38,$F0,$23,$40,$F0,$F1,$03,$28
        EQUB    $3C,$94,$F2,$0D,$24,$28,$A8,$F1
        EQUB    $08,$2F,$38,$90,$2F,$3C,$80,$2D
        EQUB    $44,$70,$2E,$48,$20,$28,$34,$B2
        EQUB    $F1,$04,$F3,$00,$36,$BA,$00,$39
        EQUB    $BA,$00,$18,$7C,$00,$41,$20,$00
        EQUB    $40,$BA,$FF,$01,$04,$60,$F1,$03
        EQUB    $27,$0C,$60,$F1,$38,$27,$0C,$A8
        EQUB    $F1,$38,$27,$04,$F0,$F1,$40,$01
        EQUB    $44,$A8,$F1,$04,$02,$00,$20,$F2
        EQUB    $23,$01,$FE,$F0,$F1,$02,$02,$4C
        EQUB    $20,$F2,$23,$01,$4C,$F0,$F1,$02
        EQUB    $F3,$01,$02,$B8,$F1,$02,$02,$00
        EQUB    $20,$F2,$13,$02,$00,$A4,$F2,$05
        EQUB    $02,$40,$4A,$F2,$0B,$02,$40,$A0
        EQUB    $F2,$0E,$02,$4C,$20,$F2,$23,$01
        EQUB    $00,$F0,$F1,$1B,$34,$14,$BE,$01
        EQUB    $14,$B8,$F1,$03,$34,$28,$BE,$01
        EQUB    $28,$B8,$F1,$03,$0C,$3C,$B8,$08
        EQUB    $3C,$C0,$01,$04,$78,$F1,$02,$27
        EQUB    $0A,$78,$F1,$32,$27,$04,$20,$F1
        EQUB    $48,$0C,$3C,$78,$08,$3C,$80,$08
        EQUB    $3C,$84,$08,$04,$88,$08,$48,$68
        EQUB    $F2,$03,$08,$48,$B0,$F2,$03,$0C
        EQUB    $04,$82,$F1,$0E,$0C,$48,$60,$0C
        EQUB    $48,$A8,$0C,$04,$2A,$F1,$12,$08
        EQUB    $48,$32,$0C,$04,$48,$F2,$02,$22
        EQUB    $04,$F0,$F3,$00,$44,$BC,$FF,$00
        EQUB    $14,$BA,$00,$1C,$B2,$FF,$1B,$55
        EQUB    $03,$70,$FF,$32,$09,$36,$3F,$B5
        EQUB    $FF,$33,$19,$21,$30,$CD,$01,$33
        EQUB    $2E,$01,$1A,$E5,$FF,$33,$FF

.L26B4
        EQUB    $C4

.L26B5
        EQUB    $26,$D4,$26,$E4,$26,$F4,$26,$F8
        EQUB    $26,$FC,$26,$00,$27,$04,$27,$00
        EQUB    $01,$02,$03,$15,$40,$17,$42,$2A
        EQUB    $2B,$80,$81,$3F,$6A,$95,$C0,$00
        EQUB    $10,$20,$30,$04,$40,$24,$60,$08
        EQUB    $18,$80,$90,$0C,$48,$84,$C0,$00
        EQUB    $01,$02,$03,$05,$40,$07,$42,$0A
        EQUB    $0B,$80,$81,$0F,$4A,$85,$C0,$00
        EQUB    $41,$82,$C3,$00,$51,$A2,$F3,$00
        EQUB    $54,$A8,$FC,$00,$55,$AA,$FF,$00
        EQUB    $54,$A8,$FC,$55,$40,$FD,$E8,$AA
        EQUB    $FE,$80,$D4,$FF,$EA,$D5,$C0

.L2714
        EQUB    $3E

.L2715
        EQUB    $27,$3E,$27,$3E,$27,$2C,$27,$3F
        EQUB    $27,$3E,$27,$3E,$27,$52,$27,$77
        EQUB    $27,$7E,$27,$8B,$27,$9B,$26,$2D
        EQUB    $01,$0A,$75,$01,$33,$47,$6E,$03
        EQUB    $3C,$01,$31,$48,$A0,$00,$98,$FF
        EQUB    $32,$FF,$07,$1E,$03,$DC,$01,$31
        EQUB    $0A,$19,$1B,$8C,$01,$31,$0A,$19
        EQUB    $3F,$8C,$01,$31,$FF,$1A,$01,$0C
        EQUB    $5D,$01,$33,$1A,$01,$25,$5D,$FF
        EQUB    $33,$1A,$01,$25,$A5,$01,$33,$1A
        EQUB    $01,$0C,$A5,$FF,$33,$1D,$01,$05
        EQUB    $ED,$01,$33,$1D,$01,$23,$ED,$FF
        EQUB    $33,$FF,$33,$01,$0E,$DD

.L277B
        EQUB    $01,$33,$FF,$0E,$19,$0B,$62,$01
        EQUB    $31,$0E,$19,$32,$62,$FF,$32,$FF
        EQUB    $29,$01,$0A,$ED

.L278F
        EQUB    $01,$33,$12,$38,$1B,$74,$01,$31
        EQUB    $FF,$02,$4C,$20,$F2,$23,$02,$00
        EQUB    $20,$F2,$23,$02,$18,$84,$F2,$12
        EQUB    $2D,$1C,$34,$0D,$1C,$48,$F2,$04
        EQUB    $0D,$20,$48,$F2,$04,$2D,$20,$34
        EQUB    $2F,$20,$68,$28,$20,$7C,$2D,$24
        EQUB    $34,$0D,$24,$48,$F2,$07,$28,$28
        EQUB    $34,$F2,$03,$2D,$28,$4C,$0D,$28
        EQUB    $60,$F2,$04,$2D,$2C,$34,$0D,$2C
        EQUB    $48,$F2,$07,$0D,$30,$48,$F2,$04
        EQUB    $2D,$30,$34,$2F,$30,$68,$28,$30
        EQUB    $7C,$0D,$34,$48,$F2,$07,$2D,$34
        EQUB    $34,$27,$40,$B8,$F1,$0C,$27,$30
        EQUB    $D0,$F1,$1C,$27,$1C,$E8,$F1,$30
        EQUB    $24,$14,$80,$F1,$0E,$25,$40,$80
        EQUB    $F1,$02,$24,$00,$F0,$F1,$14,$0B
        EQUB    $04,$80,$0A,$04,$88,$F2,$08,$28
        EQUB    $14,$B2,$28,$1C,$AA,$F3,$61,$4D
        EQUB    $02,$61,$4D,$02,$61,$4D,$02,$61
        EQUB    $4D,$03,$59,$45,$05,$59,$45,$05
        EQUB    $4D,$39,$05,$4D,$39,$05,$59,$45
        EQUB    $05,$FF,$75,$35,$04,$6D,$31,$04
        EQUB    $65,$29,$04,$61,$21,$09,$FF,$00
        EQUB    $00,$00,$00,$00,$27,$32,$03,$0A
        EQUB    $00,$45,$32,$04,$06,$02,$45,$32
        EQUB    $04,$06,$08,$45,$32,$04,$06,$0A
        EQUB    $45,$32,$04,$06,$0C,$45,$32,$04
        EQUB    $06,$02,$5D,$32,$04,$02,$00,$69
        EQUB    $32,$04,$08,$00,$69,$32,$04,$08
        EQUB    $00,$86,$36,$04,$08,$01,$86,$36
        EQUB    $04,$08,$01,$A6,$36,$04,$08,$01
        EQUB    $47,$31,$04,$08,$00,$47,$31,$04
        EQUB    $08,$00,$89,$32,$02,$18,$00,$D1
        EQUB    $32,$08,$1A,$02,$A1,$33,$03,$10
        EQUB    $04,$11,$34,$03,$10,$00,$F1,$33
        EQUB    $02,$10,$00,$41,$34,$02,$07,$00
        EQUB    $4F,$34,$02,$07,$00,$5D,$34,$02
        EQUB    $07,$00,$6B,$34,$02,$07,$00,$79
        EQUB    $34,$02,$07,$00,$87,$34,$02,$07
        EQUB    $00,$95,$34,$02,$07,$00,$A3,$34
        EQUB    $02,$07,$00,$B1,$34,$02,$07,$00
        EQUB    $BF,$34,$02,$07,$00,$CD,$34,$04
        EQUB    $08,$00,$ED,$34,$08,$0C,$00,$27
        EQUB    $32,$0A,$18,$01,$D9,$34,$09,$07
        EQUB    $01,$7C,$35,$05,$0A,$07,$7C,$35
        EQUB    $05,$0A,$01,$C6,$35,$04,$0A,$01
        EQUB    $C6,$35,$04,$0A,$09,$C6,$35,$04
        EQUB    $0A,$0B,$C6,$36,$01,$0A,$03,$EE
        EQUB    $35,$04,$08,$03,$EE,$35,$04,$08
        EQUB    $09,$EE,$35,$04,$08,$0B,$EE,$35
        EQUB    $04,$08,$0D,$EE,$35,$04,$08,$03
        EQUB    $0E,$36,$03,$14,$01,$0E,$36,$03
        EQUB    $14,$0F,$4A,$36,$03,$14,$01,$67
        EQUB    $31,$08,$18,$00,$D0,$36,$02,$09
        EQUB    $05,$36,$36,$02,$09,$04,$2D,$36
        EQUB    $03,$03,$04,$17,$33,$09,$32,$01
        EQUB    $17,$33,$06,$32,$01,$7B,$33,$07
        EQUB    $32,$01,$4D,$35,$09,$14,$00,$18
        EQUB    $35,$02,$32,$01,$01,$36,$02,$16
        EQUB    $00,$AE,$35,$03,$08,$01,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$33
        EQUB    $22,$11,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$33
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$33,$33,$C0,$C0,$C0,$C0
        EQUB    $C0,$81,$03,$03,$03,$03,$03,$03
        EQUB    $33,$33,$85,$0F,$0F,$91,$90,$33
        EQUB    $80,$91,$80,$C0,$33,$33,$91,$91
        EQUB    $91,$81,$03,$03,$42,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$0F,$0F,$0F,$27
        EQUB    $33,$33,$11,$22,$11,$22,$33,$33
        EQUB    $33,$33,$33,$03,$03,$03,$03,$03
        EQUB    $03,$03,$03,$03,$33,$33,$C0,$4A
        EQUB    $4A,$4A,$4A,$4A,$C0,$C0,$62,$33
        EQUB    $11,$33,$62,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$62
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$81,$81,$81,$81
        EQUB    $91,$33,$85,$0F,$0F,$91,$90,$33
        EQUB    $91,$C0,$91,$91,$80,$33,$22,$91
        EQUB    $91,$81,$81,$81,$03,$03,$03,$42
        EQUB    $42,$42,$62,$62,$0F,$0F,$0F,$27
        EQUB    $33,$33,$33,$33,$33,$22,$33,$00
        EQUB    $33,$00,$33,$03,$03,$03,$03,$81
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$4A
        EQUB    $4A,$4A,$4A,$4A,$C0,$C0,$62,$33
        EQUB    $11,$33,$33,$C0,$C0,$C0,$C0,$C0
        EQUB    $42,$03,$03,$81,$C0,$C0,$91,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$62,$62,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$42,$13,$13,$62
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$62,$33,$91,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$85,$0F,$0F,$91
        EQUB    $90,$33,$91,$C0,$91,$80,$33,$33
        EQUB    $80,$91,$91,$81,$81,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$91,$0F,$0F
        EQUB    $0F,$27,$33,$33,$33,$33,$33,$33
        EQUB    $33,$11,$33,$33,$33,$03,$03,$03
        EQUB    $03,$03,$03,$03,$03,$03,$33,$33
        EQUB    $C0,$4A,$4A,$4A,$4A,$4A,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$62,$62,$40,$62,$33,$33,$62
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$91,$C0,$85
        EQUB    $0F,$0F,$0F,$0F,$85,$91,$33,$33
        EQUB    $33,$33,$33,$33,$03,$03,$03,$03
        EQUB    $03,$03,$03,$03,$03,$03,$33,$33
        EQUB    $C0,$4A,$0F,$0F,$0F,$0F,$4A,$62
        EQUB    $33,$33,$33,$33,$33,$33,$03,$03
        EQUB    $03,$81,$81,$81,$91,$91,$C0,$C0
        EQUB    $C0,$C0,$91,$91,$80,$91,$91,$91
        EQUB    $91,$33,$33,$62,$C0,$C0,$C0,$C0
        EQUB    $C0,$42,$42,$42,$42,$42,$62,$33
        EQUB    $C0,$C0,$C0,$C0,$62,$62,$40,$62
        EQUB    $62,$62,$62,$33,$33,$91,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$91,$C0,$85
        EQUB    $0F,$0F,$0F,$0F,$85,$91,$33,$33
        EQUB    $33,$33,$33,$33,$03,$03,$03,$03
        EQUB    $03,$03,$03,$03,$03,$03,$33,$33
        EQUB    $C0,$4A,$0F,$0F,$0F,$0F,$4A,$62
        EQUB    $33,$33,$33,$33,$33,$33,$03,$03
        EQUB    $03,$81,$81,$81,$81,$81,$81,$81
        EQUB    $91,$91,$91,$91,$80,$91,$91,$91
        EQUB    $91,$33,$33,$62,$C0,$C0,$C0,$C0
        EQUB    $C0,$42,$42,$42,$42,$42,$42,$42
        EQUB    $42,$42,$62,$33,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$33,$22,$11
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$85
        EQUB    $85,$C0,$C0,$91,$C0,$C0,$C0,$C0
        EQUB    $33,$33,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $0F,$0F,$0F,$33,$31,$33,$33,$33
        EQUB    $91,$91,$33,$33,$80,$91,$91,$81
        EQUB    $81,$81,$81,$81,$81,$81,$81,$81
        EQUB    $91,$33,$4A,$0F,$0F,$0F,$27,$27
        EQUB    $62,$62,$62,$33,$33,$22,$11,$33
        EQUB    $33,$03,$03,$03,$03,$42,$42,$42
        EQUB    $42,$42,$62,$62,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$42,$03,$03
        EQUB    $81,$81,$C0,$C0,$C0,$91,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$42,$42,$03,$03,$33,$62
        EQUB    $85,$0F,$0F,$1B,$1A,$4A,$4A,$0F
        EQUB    $33,$33,$33,$62,$C0,$91,$33,$22
        EQUB    $11,$33,$33,$33,$11,$33,$22,$91
        EQUB    $C0,$62,$62,$01,$23,$23,$C0,$C0
        EQUB    $C0,$03,$03,$03,$C0,$C0,$03,$03
        EQUB    $03,$C0,$C0,$C0,$13,$13,$13,$91
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$62,$62
        EQUB    $33,$91,$91,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $03,$03,$03,$C0,$C0,$C0,$C0,$91
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $03,$03,$03,$C0,$C0,$91,$33,$62
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $03,$03,$03,$C0,$C0,$03,$03,$03
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $03,$23,$33,$13,$03,$03,$03,$03
        EQUB    $C0,$85,$85,$C0,$C0,$91,$C0,$C0
        EQUB    $33,$33,$11,$22,$33,$C0,$C0,$C0
        EQUB    $0F,$0F,$0F,$33,$31,$33,$33,$91
        EQUB    $33,$33,$11,$33,$62,$C0,$C0,$C0
        EQUB    $4A,$0F,$0F,$0F,$27,$62,$62,$62
        EQUB    $62,$62,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $81,$03,$03,$03,$81,$C0,$C0,$91
        EQUB    $C0,$C0,$85,$0F,$0F,$91,$90,$33
        EQUB    $91,$C0,$91,$91,$80,$33,$22,$91
        EQUB    $91,$81,$03,$03,$C0,$42,$13,$13
        EQUB    $62,$C0,$C0,$C0,$0F,$0F,$0F,$27
        EQUB    $33,$33,$33,$33,$33,$22,$33,$00
        EQUB    $33,$00,$33,$03,$03,$03,$03,$81
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$4A
        EQUB    $4A,$4A,$4A,$4A,$C0,$C0,$62,$33
        EQUB    $11,$33,$33,$C0,$C0,$C0,$C0,$C0
        EQUB    $42,$42,$03,$03,$81,$81,$C0,$91
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$62,$62,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$42,$13
        EQUB    $62,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$62,$33,$91
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$81,$23,$03,$03,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$81,$03
        EQUB    $42,$C0,$03,$03,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$42,$03,$81
        EQUB    $03,$13,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$91,$22,$13,$02,$33
        EQUB    $85,$0F,$0F,$91,$90,$33,$91,$C0
        EQUB    $33,$11,$33,$33,$00,$33,$0F,$0F
        EQUB    $0F,$27,$33,$33,$33,$33,$33,$33
        EQUB    $33,$22,$11,$33,$C0,$4A,$4A,$4A
        EQUB    $4A,$4A,$C0,$C0,$C0,$62,$62,$62
        EQUB    $62,$C0,$C0,$C0,$C0,$C0,$84,$84
        EQUB    $C0,$C0,$48,$0C,$84,$80,$84,$84
        EQUB    $84,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$90,$84,$0C,$24
        EQUB    $0C,$0C,$06,$0C,$C0,$84,$0C,$0C
        EQUB    $00,$0C,$0C,$1D,$3F,$3F,$84,$84
        EQUB    $84,$84,$84,$84,$84,$0C,$30,$18
        EQUB    $0C,$0C,$0C,$0C,$08,$04,$0C,$0C
        EQUB    $0C,$04,$0C,$0C,$3F,$3F,$6A,$48
        EQUB    $48,$48,$48,$48,$48,$48,$48,$48
        EQUB    $90,$60,$60,$60,$60,$C0,$C0,$C0
        EQUB    $48,$48,$48,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $84,$84,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $84,$84,$84,$80,$84,$0C,$90,$84
        EQUB    $0C,$24,$0C,$0C,$06,$0C,$80,$84
        EQUB    $08,$0C,$08,$0C,$84,$95,$95,$2E
        EQUB    $0C,$0C,$0C,$48,$48,$48,$40,$48
        EQUB    $30,$18,$0C,$0C,$0C,$0C,$48,$04
        EQUB    $0C,$08,$0C,$00,$0C,$00,$0C,$3F
        EQUB    $3F,$0C,$0C,$84,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$90,$60,$60,$60,$60,$C0
        EQUB    $C0,$C0,$48,$0C,$04,$0C,$0C,$C0
        EQUB    $C0,$C0,$C0,$C0,$48,$0C,$0C,$84
        EQUB    $C0,$C0,$84,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$48,$48
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $48,$08,$04,$48,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$48,$48,$40,$48,$0C
        EQUB    $0C,$48,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$84
        EQUB    $C0,$90,$30,$20,$30,$30,$90,$84
        EQUB    $0C,$0C,$0C,$0C,$0C,$0C,$3F,$1D
        EQUB    $0C,$0C,$0C,$0C,$0C,$0C,$0C,$08
        EQUB    $04,$0C,$C0,$60,$30,$10,$30,$30
        EQUB    $60,$48,$0C,$0C,$0C,$0C,$0C,$0C
        EQUB    $3F,$3F,$2E,$84,$84,$80,$84,$84
        EQUB    $C0,$C0,$C0,$C0,$84,$84,$80,$84
        EQUB    $84,$84,$84,$0C,$0C,$48,$C0,$C0
        EQUB    $C0,$C0,$C0,$48,$48,$48,$48,$48
        EQUB    $40,$0C,$C0,$C0,$C0,$C0,$48,$48
        EQUB    $40,$48,$48,$48,$48,$0C,$0C,$84
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$84
        EQUB    $C0,$90,$30,$20,$30,$30,$90,$84
        EQUB    $0C,$0C,$0C,$0C,$0C,$0C,$3F,$1D
        EQUB    $0C,$0C,$0C,$0C,$0C,$0C,$0C,$08
        EQUB    $04,$0C,$C0,$60,$30,$10,$30,$30
        EQUB    $60,$48,$0C,$0C,$0C,$0C,$0C,$0C
        EQUB    $3F,$3F,$2E,$84,$84,$84,$84,$84
        EQUB    $84,$80,$84,$84,$84,$84,$80,$84
        EQUB    $84,$84,$84,$0C,$0C,$48,$C0,$C0
        EQUB    $C0,$C0,$C0,$48,$48,$48,$48,$48
        EQUB    $48,$48,$48,$48,$40,$0C,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$48,$48,$0C,$0C
        EQUB    $84,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$0C,$0C
        EQUB    $0C,$C0,$C0,$C0,$C0,$84,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$0C,$0C
        EQUB    $0C,$C0,$C0,$84,$0C,$08,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$0C,$0C
        EQUB    $0C,$C0,$C0,$0C,$04,$0C,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$1D,$1D
        EQUB    $2A,$2E,$2A,$1D,$0C,$0C,$C0,$C0
        EQUB    $84,$90,$0C,$81,$84,$C0,$0C,$08
        EQUB    $04,$0C,$00,$0C,$C0,$C0,$30,$0C
        EQUB    $0C,$0C,$0C,$0C,$0C,$0C,$04,$0C
        EQUB    $08,$04,$0C,$48,$C0,$C0,$60,$30
        EQUB    $18,$18,$18,$48,$48,$48,$48,$48
        EQUB    $48,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$84,$84,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$84,$0C
        EQUB    $0C,$0C,$84,$C0,$C0,$84,$C0,$C0
        EQUB    $90,$84,$0C,$24,$0C,$0C,$06,$0C
        EQUB    $80,$84,$08,$0C,$08,$0C,$84,$95
        EQUB    $0C,$0C,$C0,$48,$04,$0C,$48,$C0
        EQUB    $C0,$C0,$30,$18,$0C,$0C,$0C,$0C
        EQUB    $08,$04,$0C,$08,$0C,$00,$0C,$00
        EQUB    $0C,$3F,$0C,$0C,$0C,$84,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$90,$60,$60,$60
        EQUB    $60,$C0,$C0,$C0,$48,$0C,$04,$0C
        EQUB    $0C,$C0,$C0,$C0,$C0,$C0,$48,$48
        EQUB    $0C,$0C,$84,$84,$C0,$84,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $48,$48,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$48,$04,$48,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$48,$0C,$84,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $84,$0C,$0C,$0C,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$84,$0C,$48,$C0
        EQUB    $0C,$0C,$C0,$C0,$C0,$C0,$C0,$C0
        EQUB    $C0,$C0,$C0,$48,$0C,$95,$0C,$0C
        EQUB    $C0,$C0,$C0,$C0,$84,$C0,$C0,$C0
        EQUB    $C0,$84,$08,$2E,$2A,$0C,$90,$84
        EQUB    $0C,$24,$0C,$06,$0C,$84,$0C,$04
        EQUB    $0C,$0C,$00,$0C,$30,$18,$0C,$0C
        EQUB    $0C,$0C,$08,$04,$0C,$0C,$0C,$08
        EQUB    $04,$0C,$90,$60,$60,$60,$60,$C0
        EQUB    $C0,$C0,$C0,$48,$48,$48,$48,$C0
        EQUB    $41,$CF,$82,$CB,$50,$CC,$A0,$D8
        EQUB    $8A,$97,$2A,$45,$88,$B5,$2A,$44
        EQUB    $6F,$41,$6B,$45,$6E,$50,$7A,$44
        EQUB    $C7,$6B,$CF,$C7,$E4,$7A,$CC,$E4
        EQUB    $00,$00,$00,$A0,$A0,$A0,$F0,$F0
        EQUB    $F0,$F0,$45,$45,$45,$45,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$A0,$A0,$F0,$50,$50,$50
        EQUB    $00,$A0,$A0,$CF,$CF,$8A,$8A,$CF
        EQUB    $45,$00,$00,$00,$00,$00,$00,$00
        EQUB    $50,$F0,$F0,$50,$50,$00,$A0,$A0
        EQUB    $F0,$50,$00,$45,$E5,$45,$CF,$8A
        EQUB    $CF,$CE,$CC,$44,$00,$00,$00,$00
        EQUB    $50,$50,$50,$A0,$A0,$A0,$F0,$50
        EQUB    $A0,$8A,$DA,$8A,$DA,$CF,$CF,$45
        EQUB    $8A,$CF,$8A,$CC,$88,$CC,$44,$15
        EQUB    $00,$50,$50,$50,$A0,$A0,$A0,$A0
        EQUB    $A0,$45,$A0,$CF,$8A,$00,$8A,$CF
        EQUB    $CF,$CD,$44,$44,$CC,$CC,$88,$2A
        EQUB    $00,$00,$50,$50,$50,$F0,$A0,$F0
        EQUB    $50,$50,$CF,$CF,$8A,$CF,$CF,$45
        EQUB    $CF,$CE,$44,$88,$88,$00,$00,$00
        EQUB    $00,$A0,$A0,$50,$50,$A0,$A0,$00
        EQUB    $50,$45,$CF,$45,$8A,$8A,$8A,$8A
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $A0,$A0,$F0,$50,$50,$F0,$F0,$F0
        EQUB    $A0,$8A,$8A,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $06,$06,$46,$46,$43,$0C,$0C,$0C
        EQUB    $0C,$03,$0C,$0C,$0C,$0C,$03,$09
        EQUB    $49,$49,$49,$43,$0C,$0C,$0C,$0C
        EQUB    $03,$0C,$0C,$0C,$8C,$C3,$42,$43
        EQUB    $02,$02,$02,$03,$00,$40,$C2,$C1
        EQUB    $42,$40,$C0,$01,$02,$C0,$42,$01
        EQUB    $02,$02,$02,$02,$02,$02,$03,$83
        EQUB    $83,$C3,$C3,$43,$43,$C3,$C3,$C3
        EQUB    $43,$43,$CF,$4C,$4F,$CF,$CF,$0E
        EQUB    $0F,$0F,$0E,$08,$0E,$0E,$0E,$0C
        EQUB    $CE,$CE,$CD,$0C,$0D,$CD,$CD,$C4
        EQUB    $CD,$CD,$CF,$CD,$CF,$CF,$0F,$0C
        EQUB    $0F,$0F,$0B,$03,$03,$00,$43,$43
        EQUB    $43,$CE,$CE,$CC,$CC,$CC,$CC,$CC
        EQUB    $CC,$CC,$CC,$8C,$8C,$0C,$0C,$48
        EQUB    $08,$00,$4F,$47,$87,$85,$07,$07
        EQUB    $C7,$CF,$CF,$CF,$CF,$CF,$CF,$CF
        EQUB    $CF,$CF,$CF,$CF,$4F,$48,$C8,$C0
        EQUB    $0F,$0F,$00,$00,$00,$00,$01,$C1
        EQUB    $C1,$C1,$C1,$C3,$C5,$CF,$CF,$C1
        EQUB    $C0,$C3,$C1,$80,$C1,$81,$80,$03
        EQUB    $02,$01,$0F,$0F,$0F,$0F,$0F,$CF
        EQUB    $CF,$CF,$CF,$CF,$CF,$CF,$CF,$CF
        EQUB    $CF,$CF,$CF,$CF,$8F,$0F,$4F,$CF
        EQUB    $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
        EQUB    $CF,$CE,$CE,$CE,$CE,$CE,$CE,$CE
        EQUB    $CF,$CF,$CE,$4E,$CE,$CE,$CE,$8F
        EQUB    $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
        EQUB    $0F,$8F,$8F,$CF,$CF,$CF,$CF,$CF
        EQUB    $CC,$CC,$8F,$8F,$8D,$0F,$0F,$0C
        EQUB    $CC,$CF,$CF,$CF,$CF,$CF,$CF,$CC
        EQUB    $CD,$CD,$8C,$8F,$8E,$88,$88,$CC
        EQUB    $CE,$CC,$CC,$CC,$8E,$8C,$8E,$8C
        EQUB    $88,$8C,$8C,$CC,$CC,$CC,$CC,$8C
        EQUB    $8C,$8C,$8F,$8C,$CC,$CC,$C0,$C8
        EQUB    $C4,$88,$84,$88,$8C,$8C,$8C,$80
        EQUB    $CC,$C8,$C4,$CC,$CC,$CF,$CF,$CF
        EQUB    $CF,$CF,$CF,$CF,$4F,$4D,$4C,$4D
        EQUB    $44,$C8,$C0,$CC,$C4,$CC,$4C,$4C
        EQUB    $4C,$44,$4C,$4C,$40,$CC,$CC,$CE
        EQUB    $CE,$4E,$4E,$4E,$4E,$4E,$CD,$CD
        EQUB    $CD,$CF,$CF,$4D,$4D,$4D,$4F,$4D
        EQUB    $4C,$4C,$CF,$CD,$CF,$CD,$CD,$CC
        EQUB    $CC,$CD,$CD,$CD,$CD,$CD,$8D,$8C
        EQUB    $8F,$8F,$8F,$CF,$CF,$CE,$CE,$CE
        EQUB    $CE,$8E,$8C,$0C,$0F,$8F,$8C,$CE
        EQUB    $CE,$CC,$8C,$8F,$0F,$0F,$8F,$8F
        EQUB    $CF,$CD,$CC,$CC,$CC,$8D,$8D,$8F
        EQUB    $8C,$8C,$8C,$86,$CE,$CE,$CC,$CC
        EQUB    $CC,$CF,$CD,$CD,$CD,$CD,$CD,$CD
        EQUB    $4C,$4C,$4C,$46,$46,$C6,$CC,$CC
        EQUB    $CC,$CD,$4F,$0F,$0F,$0F,$0F,$0F
        EQUB    $0D,$4D,$4D,$47,$0F,$0F,$0D,$0D
        EQUB    $0D,$0F,$43,$C3,$C3,$C3,$C3,$53
        EQUB    $53,$53,$53,$53,$53,$53,$C3,$C3
        EQUB    $C3,$C3,$C0,$CA,$CF,$CF,$CF,$CF
        EQUB    $CA,$C2,$C3,$C3,$C3,$C3,$C3,$C3
        EQUB    $C3,$C3,$CF,$CF,$CE,$8E,$8E,$0E
        EQUB    $0C,$8C,$8C,$C8,$C8,$C0,$84,$84
        EQUB    $04,$04,$8D,$8D,$CD,$CD,$CD,$CD
        EQUB    $CC,$CC,$CC,$C5,$CD,$CD,$CD,$CD
        EQUB    $CD,$CD,$CC,$CC,$C8,$C8,$C0,$C0
        EQUB    $C0,$C0,$C0,$C0,$00,$00,$00,$00
        EQUB    $00,$C0,$C8,$C8,$C0,$C0,$40,$00
        EQUB    $00,$00,$00,$00,$00,$40,$40,$40
        EQUB    $00,$00,$0F,$0F,$0F,$0F,$4F,$C0
        EQUB    $C0,$C0,$C0,$00,$00,$00,$00,$00
        EQUB    $00,$00,$CC,$C8,$C8,$C8,$C8,$C8
        EQUB    $CC,$C8,$C8,$C8,$C8,$C8,$C8,$C8
        EQUB    $C4,$C4,$C4,$C4,$C4,$C4,$C4,$C0
        EQUB    $C0,$C0,$C0,$40,$40,$C0,$CC,$C0
        EQUB    $C0,$CC,$C8,$C8,$4C,$48,$C8,$C8
        EQUB    $C8,$C0,$C0,$C8,$CC,$C0,$C0,$CC
        EQUB    $C0,$C0,$CC,$C8,$C8,$C8,$C8,$C8
        EQUB    $C8,$C8,$C8,$C8,$C8,$CC,$C0,$C0
        EQUB    $00,$08,$08,$08,$08,$C8,$C8,$C8
        EQUB    $CC,$C8,$08,$0C,$00,$00,$0C,$08
        EQUB    $00,$C0,$C8,$C8,$C8,$08,$0C,$08
        EQUB    $08,$0C,$C8,$C8,$CC,$C8,$C0,$00
        EQUB    $08,$08,$08,$08,$0C,$00,$C0,$C0
        EQUB    $D0,$D0,$D0,$D8,$D8,$D8,$D8,$D8
        EQUB    $D8,$D8,$DC,$D8,$D8,$DC,$D8,$D8
        EQUB    $DC,$D8,$D8,$D8,$D8,$D8,$D8,$D8
        EQUB    $DC,$D8,$D8,$DC,$D0,$D0,$DC,$D8
        EQUB    $D8,$D8,$D8,$D8,$D8,$D8,$DB,$DB
        EQUB    $D7,$D7,$D7,$DB,$DB,$D3,$DF,$DF
        EQUB    $DF,$DF,$1F,$1F,$0F,$03,$0B,$3B
        EQUB    $1F,$3F,$0F,$1B,$0B,$33,$3F,$2F
        EQUB    $37,$37,$07,$3F,$0F,$37,$03,$33
        EQUB    $1F,$2B,$13,$2B,$3F,$0F,$33,$3B
        EQUB    $2F,$3F,$23,$33,$07,$3F,$1F,$2F
        EQUB    $17,$27,$33,$03,$3B,$2F,$1B,$2B
        EQUB    $1F,$3B,$03,$3B,$1F,$0F,$03,$2F
        EQUB    $37,$33,$03,$03,$07,$0F,$0F,$2F
        EQUB    $07,$C3,$C3,$CF,$CF,$C3,$C3,$C3
        EQUB    $C7,$CB,$CB,$8B,$87,$87,$83,$8F
        EQUB    $8F,$83,$CB,$CB,$CF,$CF,$C7,$CF
        EQUB    $CF,$CF,$C3,$CB,$C3,$C7,$C3,$C3
        EQUB    $C7,$CB,$CB,$CB,$C7,$C7,$C3,$C3
        EQUB    $CF,$CF,$C7,$C7,$CF,$CF,$C7,$CF
        EQUB    $CF,$CF,$C7,$CF,$CF,$CF,$CC,$CC
        EQUB    $CC,$C8,$C8,$C8,$CC,$4C,$4C,$4C
        EQUB    $4C,$4C,$48,$48,$C8,$C8,$C8,$C8
        EQUB    $C8,$CC,$CC,$CC,$CC,$C4,$C4,$C4
        EQUB    $CC,$CC,$CC,$CC,$CC,$CC,$C4,$C4
        EQUB    $C4,$C4,$C4,$C4,$C4,$CC,$CC,$CC
        EQUB    $C8,$C8,$C8,$C8,$C8,$0C,$1C,$1C
        EQUB    $0C,$0C,$0C,$38,$08,$00,$30,$38
        EQUB    $38,$1C,$1C,$0C,$14,$24,$24,$34
        EQUB    $04,$3C,$3C,$0C,$0C,$3C,$04,$00
        EQUB    $30,$00,$00,$30,$30,$24,$2C,$0C
        EQUB    $2C,$1C,$1C,$3C,$0C,$0C,$2C,$2C
        EQUB    $0C,$0C,$0C,$38,$08,$00,$30,$08
        EQUB    $08,$0C,$0C,$3C,$10,$10,$30,$00
        EQUB    $00,$1C,$2C,$3C,$0C,$0C,$24,$10
        EQUB    $20,$30,$20,$30,$00,$04,$0C,$1C
        EQUB    $3C,$2C,$2C,$2C,$2C,$2C,$2C,$3C
        EQUB    $2C,$1C,$3C,$2C,$2C,$24,$24,$2C
        EQUB    $2C,$3C,$2C,$1C,$3C,$20,$20,$20
        EQUB    $2C,$2C,$2C,$3C,$2C,$1C,$30,$20
        EQUB    $20,$20,$20,$20,$20,$3C,$2D,$2D
        EQUB    $1D,$2D,$0D,$0D,$2D,$1D,$2D,$2D
        EQUB    $0D,$2D,$1D,$1D,$2D,$0D,$2D,$2D
        EQUB    $1D,$2D,$0C,$0C,$2C,$1C,$2C,$2C
        EQUB    $0C,$2C,$0C,$0C,$28,$08,$28,$F8
        EQUB    $EC,$EC,$FC,$FC,$F8,$F8,$F8,$F8
        EQUB    $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
        EQUB    $FC,$FC,$F4,$E4,$E4,$C4,$8C,$8C
        EQUB    $8C,$8C,$84,$84,$84,$84,$8F,$8E
        EQUB    $8C,$8D,$8C,$8C,$2F,$2F,$BD,$FE
        EQUB    $ED,$CF,$DE,$DD,$DE,$DF,$DD,$DE
        EQUB    $DF,$DD,$DD,$DE,$DE,$7E,$7D,$7D
        EQUB    $7F,$73,$F2,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$02
        EQUB    $03,$01,$00,$00,$40,$40,$00,$10
        EQUB    $20,$20,$80,$80,$81,$83,$83,$83
        EQUB    $80,$80,$80,$80,$80,$80,$80,$80
        EQUB    $C1,$43,$42,$00,$23,$23,$20,$20
        EQUB    $20,$80,$80,$80,$80,$80,$80,$82
        EQUB    $83,$81,$83,$83,$C0,$40,$00,$D0
        EQUB    $C0,$D0,$D0,$D0,$40,$D1,$D2,$F3
        EQUB    $D2,$F3,$F5,$FF,$CF,$F1,$F0,$F3
        EQUB    $C1,$F0,$F3,$F1,$E3,$F3,$F0,$E3
        EQUB    $8F,$EF,$EF,$E7,$C3,$E3,$E3,$C3
        EQUB    $03,$03,$C3,$02,$01,$03,$C0,$CA
        EQUB    $0A,$0A,$CA,$0A,$00,$00,$C0,$C2
        EQUB    $02,$02,$C2,$00,$00,$00,$C0,$C0
        EQUB    $04,$04,$C0,$00,$08,$0C,$C4,$80
        EQUB    $84,$C4,$C4,$40,$80,$C0,$C0,$40
        EQUB    $40,$F0,$E0,$E0,$D0,$D0,$D0,$E4
        EQUB    $EC,$F4,$DC,$EC,$F6,$DC,$E0,$D4
        EQUB    $FC,$EC,$D0,$0D,$1F,$2C,$05,$20
        EQUB    $0D,$1F,$36,$1F,$45,$51,$55,$42
        EQUB    $20,$73,$68,$6F,$63,$6B,$3A,$45
        EQUB    $51,$55,$42,$20,$33,$36,$3A,$45
        EQUB    $51,$55,$42,$20,$32,$30,$30,$0D
        EQUB    $1F,$40,$05,$20,$0D,$1F,$4A,$1F
        EQUB    $45,$51,$55,$42,$20,$73,$68,$6F
        EQUB    $63,$6B,$3A,$45,$51,$55,$42,$20
        EQUB    $31,$36,$3A,$45,$51,$55,$42,$20
        EQUB    $32,$30,$30,$0D,$1F,$54,$05,$20
        EQUB    $0D,$1F,$5E,$1F,$45,$51,$55,$42
        EQUB    $20,$73,$68,$6F,$63,$6B,$3A,$45
        EQUB    $51,$55,$42,$20,$35,$36,$3A,$45
        EQUB    $51,$55,$42,$20,$32,$30,$30,$0D
        EQUB    $1F,$68,$05,$20,$0D,$1F,$72,$0C
        EQUB    $45,$51,$55,$42,$20,$26,$46,$33
        EQUB    $0D,$1F,$7C,$05,$20,$0D,$1F,$86
        EQUB    $05,$20,$0D,$1F,$90,$1A,$2E,$73
        EQUB    $63,$72,$65,$65,$6E,$36,$5F,$6C
        EQUB    $61,$6E,$74,$65,$72,$6E,$5F,$74
        EQUB    $61
        
        ; Start of 1UP sprites
        ; Mode 2 8x8 sprites are 32 bytes each
        EQUB    $15,$3F,$15,$15,$15,$15,$3F,$00 ; .#..#..#
        EQUB    $00,$00,$00,$00,$00,$00,$2A,$00 ; ##..#..#
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$15,$00 ; .#..#..#
        EQUB    $15,$15,$15,$15,$15,$15,$2A,$00 ; .#..#..#
                                                ; .#..#..#
                                                ; .#..#..#
                                                ; ###..##.
                                                ; ........

        EQUB    $15,$15,$15,$15,$15,$15,$15,$00
        EQUB    $2A,$15,$15,$2A,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00

        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00

        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00

        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00    
        EQUB    $3F,$15,$15,$15,$15,$15,$15,$00

        EQUB    $2A,$00,$00,$00,$00,$00,$00,$00
        EQUB    $15,$2A,$2A,$2A,$2A,$2A,$15,$00
        EQUB    $2A,$15,$15,$15,$15,$15,$2A,$00
        EQUB    $15,$15,$15,$15,$15,$15,$15,$00

        EQUB    $2A,$15,$15,$2A,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00

        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00

        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00
        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00

        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $3F,$2A,$2A,$3F,$2A,$2A,$2A,$00
        EQUB    $2A,$00,$00,$00,$00,$00,$00,$00

        EQUB    $15,$2A,$2A,$3F,$2A,$2A,$2A,$00
        EQUB    $2A,$15,$15,$3F,$15,$15,$15,$00
        EQUB    $15,$15,$15,$15,$15,$15,$15,$00
        EQUB    $00,$00,$00,$00,$00,$00,$3F,$00

        EQUB    $15,$15,$15,$15,$15,$15,$15,$00
        EQUB    $00,$00,$00,$00,$00,$00,$3F,$00
        EQUB    $00,$00,$15,$15,$00,$00,$15,$00
        EQUB    $3F,$00,$00,$3F,$00,$00,$3F,$00
        
        EQUB    $00,$2A,$00,$00,$2A,$2A,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00
        EQUB    $00,$00,$00,$00,$00,$00,$00,$00    

        EQUB    $3F,$2A,$2A,$2A,$2A,$2A,$3F,$00 ; ###.#.#.
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00 ; #.#.#.#.
        EQUB    $2A,$2A,$2A,$3F,$00,$00,$00,$00 ; #.#.#.#.   
        EQUB    $2A,$2A,$2A,$2A,$2A,$2A,$2A,$00 ; #.#.###.
                                                ; #.#...#.
                                                ; #.#...#.
                                                ; ###...#.
                                                ; ........

.L4A00  ; Minor code relocation
        EQUB    $86,$36,$84,$37,$A0,$00,$84
        EQUB    $7B,$B1,$36,$30,$42,$85,$49,$C8
        EQUB    $C8,$B1,$36,$85,$4B,$A5,$35,$85
        EQUB    $47,$20,$D5,$03,$A4,$7B,$C8,$B1
        EQUB    $36,$85,$49,$E6,$45,$20,$D5,$03
        EQUB    $A2,$00,$86,$47,$E8,$86,$4B,$20
        EQUB    $D5,$03,$C6,$45,$20,$D5,$03,$A5
        EQUB    $35,$85,$47,$A9,$80,$A2,$FA,$A0
        EQUB    $FF,$20,$F4,$FF,$E0,$0E,$90,$F3
        EQUB    $A4,$7B,$C8,$C8,$C8,$10,$B8,$60
        EQUB    $A2,$45,$A0,$00,$A9,$07,$4C,$F1
        EQUB    $FF,$51,$55,$42,$20,$31,$31,$0D
        EQUB    $21,$16,$05,$20,$0D,$21,$20,$2E
        EQUB    $45,$51,$55,$42,$20,$77,$61,$6C
        EQUB    $6C,$3A,$45,$51,$55,$42,$20,$2D
        EQUB    $31,$3A,$45,$51,$55,$42,$20,$38
        EQUB    $38,$3A,$45,$51,$55,$42,$20,$26
        EQUB    $46,$31,$3A,$45,$51,$55,$42,$20
        EQUB    $32,$33,$0D,$21,$2A,$05,$20,$0D
        EQUB    $21,$34,$30,$45,$51,$55,$42,$20
        EQUB    $77,$61,$6C,$6C,$3A,$45,$51,$55
        EQUB    $42,$20,$26,$30,$30,$3A,$45,$51
        EQUB    $55,$42,$20,$31,$36,$30,$3A,$45
        EQUB    $51,$55,$42,$20,$26,$46,$31,$3A
        EQUB    $45,$51,$55,$42,$20,$32,$37,$0D
        EQUB    $21,$3E,$05,$20,$0D,$21,$48,$30
        EQUB    $45,$51,$55,$42,$20,$77,$61,$6C
        EQUB    $6C,$3A,$45,$51,$55,$42,$20,$26
        EQUB    $30,$30,$3A,$45,$51,$55,$42,$20
        EQUB    $32,$33,$34,$3A,$45,$51,$55,$42
        EQUB    $20,$26,$46,$31,$3A,$45,$51,$55
        EQUB    $42,$20,$32,$37,$0D,$21,$52,$05
        EQUB    $20,$0D,$21,$5C,$30,$45,$51,$55
        EQUB    $42,$20,$77,$61,$6C,$6C,$3A,$45
        EQUB    $51,$55,$42,$20,$26,$30,$30,$3A
        EQUB    $45,$51,$55,$42,$20,$32,$34,$34
        EQUB    $3A,$45,$51,$55,$42,$20,$26,$46
        EQUB    $31,$3A,$45,$51,$55,$42,$20,$32
        EQUB    $37,$0D,$21,$66,$05,$20,$0D,$21
        EQUB    $70,$2F,$45,$51,$55,$42,$20,$70
        EQUB    $6C,$75,$67,$3A,$45,$51,$55,$42
        EQUB    $20,$26,$30,$34,$3A,$45,$51,$55
        EQUB    $42,$20,$32,$32,$34,$3A,$45,$51
        EQUB    $55,$42,$20,$26,$46,$31,$3A,$45
        EQUB    $51,$55,$42,$20,$32,$0D,$21,$7A
        EQUB    $05,$20,$0D,$21,$84,$32,$45,$51
        EQUB    $55,$42,$20,$66,$6C,$6F,$6F,$72
        EQUB    $31,$3A,$45,$51,$55,$42,$20,$26
        EQUB    $30

;-------------------------------------------------------------------------
; Relocation Code
;-------------------------------------------------------------------------
; On entry  : 
; On exit   : 
;-------------------------------------------------------------------------
.L4B80
        LDA     #$8C
        LDX     #$00
        JSR     OSBYTE          ; OSBYTE 140 - Select TAPE file system.

        JSR     L4BFD + OFFSET

        LDA     #$C8
        LDX     #$02            ; bit 1 set clears memory on BREAK
        LDY     #$00
        JSR     OSBYTE          ; OSBYTE 200 - Escape and break effect.  

        SEI
        LDA     #$C8
        STA     EVENTV
        LDA     #$1B
        STA     EVENTV+1        ; $1BC8
        CLI
        LDA     #$0E
        LDX     #$04
        JSR     OSBYTE          ; OSBYTE  14 - Enable events. 

        LDA     #$7E
        JSR     OSBYTE          ; OSBYTE 126 - Acknowledge detection of ESCAPE condition.

        SEI
        LDX     #$0D
.crtc_loop
        STX     crtcAddr
        LDA     crtcRegs + OFFSET,X
        STA     crtcData
        DEX
        BPL     crtc_loop

        LDA     #$14            ; Mode 2
        STA     ulaMode         
        CLI

        LDA     #$00
        STA     highscore1      ; Hiscore (right to left)
        STA     highscore2           
        STA     highscore3
        STA     score1          ; score (rightto left)
        STA     score2          
        STA     score3          
        STA     walking_sound_delay

        LDA     #$F1
        STA     sound_flag

        LDA     #$08
        LDX     #$EE
        LDY     #$4B            ; $4BEE
        JSR     OSWORD          ; OSWORD 8 - Define an envelope 
        JMP     L0900           ; Jump to start of relocated game
        ; return

.crtcRegs
        EQUB    $7F     ; R0  horizontal total
        EQUB    $50     ; R1  horizontal displayed
        EQUB    $62     ; R2  horizontal position
        EQUB    $28     ; R3  sync width
        EQUB    $26     ; R4  vertical total
        EQUB    $00     ; R5  vertical total adjust
        EQUB    $1D     ; R6  vertical displayed
        EQUB    $21     ; R7  vertical position
        EQUB    $01     ; R8  interlace off
        EQUB    $07     ; R9  scanlines per row
        EQUB    $00     ; R10 cursor start
        EQUB    $08     ; R11 cursor end
        EQUB    $06     ; R12 screen start address, high
        EQUB    $F0     ; R13 screen start address, low

.L4BEE  ; Envelope Data $4BEE
        EQUB    $01,$00,$00,$00,$00,$00,$00,$00
        EQUB    $7E,$82,$00,$00,$7E,$00,$00

.L4BFD  ; Relocate code from $1900 to $0900
        LDY     #$00
        STY     L0000
        LDA     #$19
        STA     L0001           ; $1900
        LDA     #$00
        STA     L0002
        LDA     #$09
        STA     L0003           ; $0900        
        LDX     #$31
.L4C0F
        LDA     (L0000),Y
        STA     (L0002),Y
        INY
        BNE     L4C0F

        INC     L0001
        INC     L0003
        DEX
        BNE     L4C0F

        ; Relocate minor code from $4A00 to $0386
        LDA     #$00
        STA     L0000
        LDA     #$4A
        STA     L0001           ; $4A00
        LDA     #$86
        STA     L0002
        LDA     #$03
        STA     L0003           ; $0386
        LDX     #$01
        LDY     #$00
.L4C31
        LDA     (L0000),Y
        STA     (L0002),Y
        INY
        BNE     L4C31

        INC     L0001
        INC     L0003
        DEX
        BNE     L4C31

        LDA     #$01
        STA     L0045
        STA     L0046
        LDA     #$F1
        STA     L0047
        LDA     #$FF
        STA     L0048
        LDA     #$00
        STA     L0049
        STA     L004A
        STA     L004B
        STA     L004C
        RTS

.L4C58  ; DATA - seems to be EQUB text?
        EQUB    $37
        EQUB    $3A,$45,$51,$55,$42,$20,$39,$38
        EQUB    $0D,$21,$F2,$05,$20,$0D,$21,$FC
        EQUB    $20,$45,$51,$55,$42,$20,$76,$5F
        EQUB    $77,$61,$6C,$6C,$31,$3A,$45,$51
        EQUB    $55,$42,$20,$34,$34,$3A,$45,$51
        EQUB    $55,$42,$20,$39,$38,$0D,$22,$06
        EQUB    $05,$20,$0D,$22,$10,$20,$45,$51
        EQUB    $55,$42,$20,$76,$5F,$77,$61,$6C
        EQUB    $6C,$31,$3A,$45,$51,$55,$42,$20
        EQUB    $34,$37,$3A,$45,$51,$55,$42,$20
        EQUB    $39,$38,$0D,$22,$1A,$05,$20,$0D
        EQUB    $22,$24,$0C,$45,$51,$55,$42,$20
        EQUB    $26,$46,$33,$0D,$22,$2E,$05,$20
        EQUB    $0D,$22,$38,$05,$20,$0D,$22,$42
        EQUB    $1A,$2E,$73,$63,$72,$65,$65,$6E
        EQUB    $38,$5F,$6C,$61,$6E,$74,$65,$72
        EQUB    $6E,$5F,$74,$61,$62,$6C,$65,$0D
        EQUB    $22,$4C,$1C,$45,$51,$55,$42,$20
        EQUB    $26,$30,$30,$3A,$45,$51,$55,$42
        EQUB    $20,$32,$34,$3A,$45,$51,$55,$42
        EQUB    $20,$33,$32,$0D,$22,$56,$05,$20
        EQUB    $0D,$22,$60,$1C,$45,$51,$55,$42
        EQUB    $20,$26,$30,$30,$3A,$45,$51,$55
        EQUB    $42,$20,$32,$38,$3A,$45,$51,$55
        EQUB    $42,$20,$33,$32,$0D,$22,$6A,$05
        EQUB    $20,$0D,$22,$74,$1C,$45,$51,$55
        EQUB    $42,$20,$26,$30,$30,$3A,$45,$51
        EQUB    $55,$42,$20,$35,$34,$3A,$45,$51
        EQUB    $55,$42,$20,$33,$32,$0D,$22,$7E
        EQUB    $05,$20,$0D,$22,$88,$1C,$45,$51
        EQUB    $55,$42,$20,$26,$30,$30,$3A,$45
        EQUB    $51,$55,$42,$20,$35,$38,$3A,$45
        EQUB    $51,$55,$42,$20,$33,$32,$0D,$22
        EQUB    $92,$05,$20,$0D,$22,$9C,$1C,$45
        EQUB    $51,$55,$42,$20,$26,$30,$30,$3A
        EQUB    $45,$51,$55,$42,$20,$38,$3A,$45
        EQUB    $51,$55,$42,$20,$31,$30,$36

.RELOC_START
.L4D80
        LDA     #$7E
        JSR     OSBYTE          ; OSBYTE 126 - Acknowledge detection of ESCAPE condition.
        JSR     OSASCI          ; Write a character (to screen) from A

        LDA     #$0C
        JSR     OSWRCH          ; VDU 12 Clear text or graphics window.

        JMP     L4B80 + OFFSET
        ; return

;-------------------------------------------------------------------------
; End address to be saved
;-------------------------------------------------------------------------
.RELOC_END

SAVE "Bruce1", NATIVE_ADDR, RELOC_END, RELOC_START+OFFSET, RELOAD_ADDR

puttext "BOOT", "!BOOT",&FFFF
putbasic "BLOAD.bas", "BLOAD"
putfile "BRUCE0.bin","BRUCE0",&1100
putfile "BRUCEP.bin","BRUCEP",&6840
