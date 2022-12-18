f = open('day18.txt', 'r')
lines = f.readlines()

qubes=set()
for line in lines:
    (x,y,z) = line.strip().split(',')
    qubes.add((int(x),int(y),int(z)))

print(qubes)
deltas=(-1,1)
answer = 0
if (2,1,1) in qubes:
    print("Foudn 2,1,1")
if (1,1,1) in qubes:
    print("Foudn 1,1,1")

for qub in qubes:
    (x,y,z)=qub
    print("Looking at ", qub)
    visible = 6
    for tx in [x-1,x+1]:
        if (tx, y, z) in qubes:
            print("Blocked at ", (tx, y, z))
            visible = visible-1
    for ty in [y-1,y+1]:
        if (x, ty, z) in qubes:
            print("Blocked at ", (x, ty, z))
            visible = visible-1
    for tz in [z-1,z+1]:
        if (x, y, tz) in qubes:
            print("Blocked at ", (x, y, tz))
            visible = visible-1
    answer = answer + visible

print(answer)

                
    
