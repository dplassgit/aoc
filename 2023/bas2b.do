5 CLS: CLEAR500
10 INPUT "File: "; FN$
15 F = 1: OPEN FN$ FOR INPUT AS F
20 A = 0: REM answer
30 IF EOF(F) GOTO 1000: ELSE LINE INPUT #F, A$: REMprint a$
40 NUM$ = MID$(A$, INSTR(A$, " ")): REM everything past the space
42 NUM$ = LEFT$(NUM$, INSTR(NUM$, ": ")): REM everything before the colon
43 ID = VAL(NUM$): PRINT ID;
45 A$ = MID$(A$, INSTR(A$, ": ")+2)
50 SEMI = INSTR(A$, ";"): IF SE = 0 THEN G$ = A$ ELSE G$ = LEFT$(A$, SE-1): A$ = MID$(A$, SE+1)
100 REM now split on commas
105 R = 0: B = 0: G = 0: REM red green blue
110 CM = INSTR(G$, ", "): IF CM = 0 THEN B$ = G$ ELSE B$ = LEFT$(G$, CM-1): G$ = MID$(G$, CM+1)
130 IF LEFT$(B$, 1) = " "THENB$ = MID$(B$, 2)
135 S = INSTR(B$, " "): NUM$ = LEFT$(B$, S): C$ = MID$(B$, S+1, 1): REM color
140 IF C$ = "r" THEN R = VAL(NUM$)
150 IF C$ = "g" THEN G = VAL(NUM$)
160 IF C$ = "b" THEN B = VAL(NUM$)
170 IF R>12 OR G > 13 OR B > 14 THEN PRINT": over": GOTO 30
200 IF CM<>0 THEN 110: REM more colors in this game
205 REM print "red "; r; " green "; g; " blue "b
900 IF SEMI<>0 THEN 50: REM more data on this line
905 REM done with a line, bump counter.
910 PRINT": good": A = A + ID
920 GOTO 30: REM next line
1000 PRINT: PRINT "Part 1: "A
1010 CLOSE F
