10 mw=0:for k = 1 to 200: read li$: if li$="end" then print "count="; k: goto 30
20 if len(li$) > mw then mw = len(li$)
25 next k
30 dim answer(mw*2): rem index 1 is LSD, mw*2-1 is MSD
35 restore
40 for i = 1 to 200: read num5$: if num5$="end" then goto 100
42 :print "processing: "; num5$
45 :for place = len(num5$) to 1 step -1
50 ::actual=0: digit$=mid$(num5$, place, 1)
55 ::if digit$="0" then actual=0
60 ::if digit$="1" then actual=1
65 ::if digit$="-" then actual=-1
70 ::if digit$="2" then actual=2
75 ::if digit$="=" then actual=-2
80 ::p1=len(num5$)-place+1: nv = answer(p1) + actual
85 ::gosub 2000 : rem adjust(place, nv)
90 :next place
95 next i
100 print "part1:"
105 gosub 1000
110 end

1000 for j = mw*2-1 to 1 step -1
1010 if answer(j) = 0 then print "0";
1015 if answer(j) = 1 then print "1";
1020 if answer(j) = 2 then print "2";
1025 if answer(j) = -1 then print "-";
1030 if answer(j) = -2 then print "=";
1035 next j
1040 print ""
1099 return

2000 for p2 = p1 to mw*2-1
2005 if -2 <= nv and nv <= 2 then answer(p2) = nv: return
2010 if nv = 3 then answer(p2) = -2: nv = answer(p2+1)+1: goto 2100
2015 if nv = 4 then answer(p2) = -1: nv = answer(p2+1)+1: goto 2100
2020 if nv = -3 then answer(p2) = 2: nv = answer(p2+1)-1: goto 2100
2025 if nv = -4 then answer(p2) = 1: nv = answer(p2+1)-1
2100 next p2
2110 return

6000 data "1=12=1--2220--2=21"
6001 data "2=20---12"
6002 data "1=2=-=2-0=0=022"
6003 data "1212=--0-20=1"
6004 data "1202-1"
6005 data "2=2-=1-"
6006 data "1-22-12-1"
6007 data "1-1-1120=1=120221"
6008 data "10-02"
6009 data "122-12="
6010 data "2-2"
6011 data "20001--=20100"
6012 data "1-=-00=00=2"
6013 data "1=--0200=--0=2--1-"
6014 data "1==--001"
6015 data "1-10011"
6016 data "1-1=2-==2=2"
6017 data "2-=02=02222-=0"
6018 data "1-121="
6019 data "2012=2=="
6020 data "1--"
6021 data "1212-2"
6022 data "1--10-112="
6023 data "100--1011-=-12---"
6024 data "2="
6025 data "120"
6026 data "1=12-1-==0==2-02"
6027 data "1==10"
6028 data "12==2201112-1=-"
6029 data "22201="
6031 data "202-022=1111-0"
6032 data "1-=1-=--2"
6033 data "111011---"
6034 data "2-=1122101--1-2-11"
6035 data "22100"
6036 data "1=20-112"
6037 data "21=--1"
6038 data "1-000--21=110101="
6039 data "2-10=02-121="
6040 data "112"
6041 data "121=0-2000=-=01=12="
6042 data "11=-121-=-1"
6043 data "1-20==---=000-"
6044 data "111221==2-122111"
6045 data "1=122=22010120121"
6046 data "2-11=-22=2"
6047 data "1-"
6048 data "101=0121121-2122"
6049 data "1=2221-11-2-="
6050 data "212"
6051 data "11=-==00--"
6052 data "121-0--1===111"
6053 data "11"
6054 data "2==00-21222=-2"
6055 data "2=-02-=22-2=1"
6056 data "22==-1222=-1-12--"
6057 data "1--22"
6060 data "2110-=2-0-211-12="
6061 data "202222-1111"
6062 data "2-=-=1222221="
6063 data "1=-=-==-1="
6064 data "1-1-0121"
6065 data "12-1==0222"
6066 data "11---100"
6067 data "1--01020-2"
6068 data "10=20"
6069 data "12=1=-002-02-=1222"
6070 data "1011-0--0121-"
6071 data "101-2=="
6072 data "2112021212==212"
6073 data "1-==1-=110-021-22"
6074 data "1==20111-2022-0"
6075 data "1=1=2-=0="
6076 data "1-0==11-1--"
6077 data "1--21-21-0-2-"
6078 data "11-111=-=10==10-"
6079 data "12-"
6080 data "202-10221="
6081 data "1-1=-00=0"
6082 data "2-=11"
6083 data "200-"
6084 data "21=1=12022-01-0--="
6085 data "1=---0=021-0=="
6086 data "1-=00-1-0210=2"
6087 data "1121=1=2=20-"
6088 data "220100-02111=2211-"
6089 data "1-0-00-0200-001-"
6090 data "1002"
6091 data "12-=0-012-111"
6092 data "1=-0111-10=0"
6093 data "21=10-2=1=00-120-"
6094 data "201="
6095 data "21"
6096 data "2000=0-="
6097 data "11==0--212=--12-121"
6098 data "11-220-0=22-011=="
6099 data "1-1-0=1-21-101=="
6100 data "111="
6101 data "2--1=2=-"
6102 data "1==0=0-"
6103 data "1=021222=0---2-1="
6104 data "2-20=210212-0122"
6105 data "1-2100-021=-2=010-11"
6106 data "1-=-1-0-1-=-0"
6107 data "20-122200202-12-0="
6108 data "2=-20"
6109 data "1-1-=-"
6110 data "11=2=1=1-"
6111 data "1=11-=-20=20"
6112 data "end"