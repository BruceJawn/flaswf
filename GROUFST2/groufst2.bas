SCREEN 13: DEF SEG = &HA000
DIM hei%(4096 - 1), col%(4096 - 1)

   'Generate palette
OUT &H3C8, 0
FOR z% = 0 TO 63: OUT &H3C9, z%: OUT &H3C9, z%: OUT &H3C9, z% \ 2: NEXT z%
FOR z% = 0 TO 63: OUT &H3C9, z% \ 2: OUT &H3C9, z%: OUT &H3C9, z%: NEXT z%

   'Generate interesting height & color maps
p% = 0
FOR y% = 0 TO 63
   FOR x% = 0 TO 63
      d% = 15 * 15 - ((x% AND 31) - 16) ^ 2 - ((y% AND 31) - 16) ^ 2
      IF d% > 0 AND ((x% XOR y%) AND 32) THEN
         hei%(p%) = 64 - SQR(d%): col%(p%) = (x% + y%) * .5
      ELSE
         hei%(p%) = 64: col%(p%) = (COS(x% * .2) + SIN(y% * .3)) * 3 + 88
      END IF
      p% = p% + 1
   NEXT x%
NEXT y%

   'Initialize starting position
posx& = 0: posy& = 0: posz& = 40 * 65536: ang = 0: horiz& = -50

r160 = 1 / 160
dd& = 65536 * r160 'Increment size
de& = dd& * 128    'Scan out 128 units
sdz& = (100 - horiz&) * 65536 * r160
DO
   cosang = COS(ang) * 65536: sinang = SIN(ang) * 65536
   dx& = sinang + cosang: dxi& = -sinang * r160
   dy& = sinang - cosang: dyi& = cosang * r160

      'For each column in 320*200 mode...
   FOR sx% = 0 TO 319

         'Fast ray trace! No *'s or /'s in here (\ 65536 is a shift)
      x& = posx&: y& = posy&: z& = posz&: dz& = sdz&: p& = sx% + 63680
      FOR d& = 0 TO de& STEP dd&
         x& = x& + dx&: y& = y& + dy&: z& = z& + dz&
         i% = (((x& * 64) AND &HFC00000) + (y& AND &H3F0000)) \ 65536
         h& = hei%(i%) * 65536
         DO WHILE h& < z&
            POKE p&, col%(i%): p& = p& - 320&
            z& = z& - d&: dz& = dz& - dd&
         LOOP
      NEXT d&
      dx& = dx& + dxi&: dy& = dy& + dyi&

         'Finish off rest of line
      DO WHILE p& >= 19200: POKE p&, 0: p& = p& - 320: LOOP
   NEXT sx%

      'Move position & angle
   posx& = posx& + cosang * 4
   posy& = posy& + sinang * 4
   ang = ang + .02

LOOP WHILE INKEY$ = ""
