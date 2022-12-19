f = open('day18small.txt', 'r')
lines = f.readlines()

qubes=set()
hix=-1
hiy=-1
hiz=-1
dim=-1
for line in lines:
    (x,y,z) = line.strip().split(',')
    hix = max(hix, int(x))
    hiy = max(hiy, int(y))
    hiz = max(hiz, int(z))
    dim=max(dim,int(x))
    dim=max(dim,int(y))
    dim=max(dim,int(z))
    qubes.add((int(x),int(y),int(z)))

dim=dim+1
hix=hix+1
hiy=hiy+1
hiz=hiz+1
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
    #print("popped: ", elt)
    if elt in seen:
        #print("already processed")
        continue
    seen.add(elt)
    if elt in qubes:
        #print("is a qube")
        continue
    # don't go back there
    (x,y,z)=elt
    if x < 0 or y < 0 or z < 0 or x > dim or y > dim or z > dim:
        #print("out of range")
        continue
    for tx in [x-1,x+1]:
        q.append((tx,y,z))
        if (tx, y, z) in qubes:
            part2=part2+1
    for ty in [y-1,y+1]:
        q.append((x,ty,z))
        if (x, ty, z) in qubes:
            part2=part2+1
    for tz in [z-1,z+1]:
        q.append((x,y,tz))
        if (x, y, tz) in qubes:
            part2=part2+1

print("Part 2: ", part2)
