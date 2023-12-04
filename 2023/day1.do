1 input"File: ";fn$: f=1: open fn$ for input as f
2 a=0: rem answer
3 if eof(f) goto 8: else line input #f, a$: rem print a$
4 fi=0: for i=1 to len(a$): c=asc(mid$(a$, i,1))-48: if c>=0 and c<=9 then fi=c: goto 5: else next
5 se=0: for i=len(a$) to 1 step -1: c=asc(mid$(a$,i,1))-48: if c>=0 and c<=9 then se=c: goto 6: else next
6 a=a+(fi*10+se):rem print ":"fi*10+se
7 goto 3
8 print: print "Part 1: "a
9 close f
