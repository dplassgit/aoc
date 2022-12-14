input="498,4 -> 498,6 -> 496,6\n503,4 -> 502,4 -> 502,9 -> 494,9"


def topair(s): 
    (x,y)=[int(i) for i in s.split(',')]
    return (x,y)

rocks = input.split("\n")
left=10000000
right=-1
top=0
bottom=-1
for rock in rocks:
    path=[topair(spot) for spot in rock.split(" -> ")]
    for xy in path:
        left=min(left, xy[0])
        right=max(right, xy[0])+1
        bottom=max(bottom, xy[1])+1
    # print(path)

cave=[]
for y in range(top, bottom):
    row=[]
    cave.append(row)
    for x in range(left, right):
        row.append('.')

def sgn(x):
    if x == 0: return 0
    if x < 0: return -1
    return 1

print("Left %d right %d bottom %d" % (left, right, bottom))
for rock in rocks:
    path=[topair(spot) for spot in rock.split(" -> ")]
    start=path[0]
    for xy in path[1:]:
        end=xy
        if start[0] == end[0]:
            # same x, loop over ys
            for y in range(min(start[1], end[1]), max(start[1], end[1])+1):
                row=cave[y]
                row[start[0]-left] = "#"
        else:
            # same y, loop over xs
            for x in range(min(start[0], end[0]), max(start[0], end[0])+1):
                row=cave[start[1]]
                row[x-left] = "#"
        start=end

for row in cave:
    print(''.join(row))
print('')

part1=0

done=False
while not done:
    part1=part1+1
    # start at 500,0
    sx=500
    sy=0
    # drop
    done=False
    while True:
        #print("sx, sy %d, %d" % (sx, sy))
        # look down
        if sy > bottom-1:
            #print("off the bottom")
            done=True
            break
        row=cave[sy+1]
        there=row[sx-left]
        if there=='.':
            # down is good
            sy = sy + 1
            continue
        # look down and to the left
        if sx-left-1 >= 0: 
            there=row[sx-left-1]
            if there=='.':
                # down is good
                sy = sy + 1
                sx = sx - 1
                continue
        else:
            #print("off the left")
            # went off the left
            done=True
            break
        if sx<right-1:
            there=row[sx-left+1]
            if there=='.':
                sy = sy + 1
                sx = sx + 1
                continue
        else:
            # went off the right 
            #print("off the right: sx %d right %d" % (sx, right))
            done=True
            break
        # if we got here there is no where to go (?)
        row=cave[sy]
        row[sx-left]='o'
        break
    if (part1%100) ==0: 
        for row in cave:
            print(''.join(row))
        print('')

for row in cave:
    print(''.join(row))
print('')
print("Part 1: %d" % (part1-1))
