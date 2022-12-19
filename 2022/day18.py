f = open('day18.txt', 'r')
lines = f.readlines()

qubes=set()
hix=-1
hiy=-1
hiz=-1
lox=25
loy=25
loz=25
for line in lines:
    [x,y,z] = [int(n) for n in line.strip().split(',')]
    hix = max(hix, x)
    hiy = max(hiy, y)
    hiz = max(hiz, z)
    lox = min(lox, x)
    loy = min(loy, y)
    loz = min(loz, z)
    qubes.add((x,y,z))

print("max x, y, z", (hix, hiy, hiz))

part1 = 0
for qub in qubes:
    (x,y,z)=qub
    # print("Looking at ", qub)
    visible = 6
    for tx in [x-1,x+1]:
        if (tx, y, z) in qubes:
            # print("Blocked at ", (tx, y, z))
            visible = visible-1
    for ty in [y-1,y+1]:
        if (x, ty, z) in qubes:
            # print("Blocked at ", (x, ty, z))
            visible = visible-1
    for tz in [z-1,z+1]:
        if (x, y, tz) in qubes:
            # print("Blocked at ", (x, y, tz))
            visible = visible-1
    part1 = part1 + visible

print("Part 1: ", part1)

part2=0
q=[]
q.append((0,0,0))
seen=set()

# BFS
while len(q)> 0:
    elt = q.pop()
    # print("popped: ", elt)
    if elt in seen:
        # print("already processed")
        continue
    seen.add(elt)
    if elt in qubes:
        # print("is a qube")
        continue
    # don't go back there
    (x,y,z)=elt
    if x < lox-1 or y < loy-1 or z < loz-1 or x > hix+1 or y > hiy+1 or z > hiz+1:
        # print("out of range")
        continue
    for tx in [x-1,x+1]:
        # print("Pushing ", (tx,y,z))
        q.append((tx,y,z))
        if (tx, y, z) in qubes:
            part2=part2+1
    for ty in [y-1,y+1]:
        # print("Pushing ", (x,ty,z))
        q.append((x,ty,z))
        if (x, ty, z) in qubes:
            part2=part2+1
    for tz in [z-1,z+1]:
        # print("Pushing ", (x,y,tz))
        q.append((x,y,tz))
        if (x, y, tz) in qubes:
            part2=part2+1

print("Part 2: ", part2)
