BIG="""Sensor at x=2391367, y=3787759: closest beacon is at x=2345659, y=4354867
Sensor at x=1826659, y=2843839: closest beacon is at x=1654342, y=3193298
Sensor at x=980874, y=2369046: closest beacon is at x=31358, y=2000000
Sensor at x=2916267, y=2516612: closest beacon is at x=3064453, y=2107409
Sensor at x=3304786, y=844925: closest beacon is at x=3064453, y=2107409
Sensor at x=45969, y=76553: closest beacon is at x=31358, y=2000000
Sensor at x=2647492, y=1985479: closest beacon is at x=2483905, y=2123337
Sensor at x=15629, y=2015720: closest beacon is at x=31358, y=2000000
Sensor at x=3793239, y=3203486: closest beacon is at x=3528871, y=3361675
Sensor at x=3998240, y=15268: closest beacon is at x=4731853, y=1213406
Sensor at x=3475687, y=3738894: closest beacon is at x=3528871, y=3361675
Sensor at x=3993022, y=3910207: closest beacon is at x=3528871, y=3361675
Sensor at x=258318, y=2150378: closest beacon is at x=31358, y=2000000
Sensor at x=1615638, y=1108834: closest beacon is at x=2483905, y=2123337
Sensor at x=1183930, y=3997648: closest beacon is at x=1654342, y=3193298
Sensor at x=404933, y=3377916: closest beacon is at x=1654342, y=3193298
Sensor at x=3829801, y=2534117: closest beacon is at x=3528871, y=3361675
Sensor at x=2360813, y=2494240: closest beacon is at x=2483905, y=2123337
Sensor at x=2286195, y=3134541: closest beacon is at x=1654342, y=3193298
Sensor at x=15626, y=1984269: closest beacon is at x=31358, y=2000000
Sensor at x=3009341, y=3849969: closest beacon is at x=3528871, y=3361675
Sensor at x=1926292, y=193430: closest beacon is at x=1884716, y=-881769
Sensor at x=3028318, y=3091480: closest beacon is at x=3528871, y=3361675"""
BIG_ROW=2000000

SMALL="""Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3"""
SMALL_ROW=10

input=BIG
row=BIG_ROW
#input=SMALL
#row=SMALL_ROW

def toint(s):
    return int(s[2:].rstrip(',:'))

def part1(row):
    nobeacons=set()
    beacons=set() # columns that beacons are on, in the target row
    for line in input.split("\n"):
        parts=line.split(" ")
        sx=toint(parts[2])
        sy=toint(parts[3])
        bx=toint(parts[8])
        by=toint(parts[9])
        effectivewidth=abs(bx-sx)+abs(by-sy)
        #print("effectivewidth", effectivewidth)
        rows_distance=abs(row-sy)
        #print("n", rows_distance)
        width_at_line_row=(effectivewidth-rows_distance)*2+1
        half=width_at_line_row//2
        if by==row: # on that row
            beacons.add(bx)
        for col in range(sx-half, sx+half+1):
            # width at line "ROW":
            # =(xdist+ydist)*2+1
            nobeacons.add(col)
        # do we have to mark every single thing?
    #print(nobeacons)
    #print(beacons)
    return (beacons,nobeacons)

(b,nb)=part1(row)

print("Part1: ", len(nb)-len(b))

def part2():
    # for row in 0, 4million
    #   run part1, see if there are any "gaps" of size 1?
    for row in range(0, 4000000):
        #print("Row: ", row)
        (b,nb)=part1(row)
        #print(nb)
        z=[y for y in nb]
        z.sort()
        #print(z)
        for col in range(1, len(z)):
           if z[col] - z[col-1] > 1:
            print("x,y=", z[col]-1,row)
            return (z[col]-1,row)

#(x,y)=part2()
#print("Part 2: ", (x*4000000)+y)

