import fileinput


lines=[]
width=0
seats=[]
height=0
for line in fileinput.input():
    line = line.strip()
    if len(line) == 0:
        break
    height = height+1
    width=len(line)
    for seat in line:
        seats.append(seat)


def printa(matrix):
    for y in range(height):
        print("".join(matrix[y*width:(y+1)*width]))

printa(seats)

aseats=seats
bseats=aseats[:]

mseats=[aseats, bseats]
color=0

changed=False
while True:
    changed=False
    # read
    cseats=mseats[color]
    # write
    dseats=mseats[1-color]

    print("before:")
    printa(cseats)
    for y in range(height):
      for x in range(width):
        #print("x,y:", x, y)
        # look at others
        this = cseats[x+y*width]
        if this == '.':
            continue
        dseats[x+y*width]=this
        neighbors=0
        for dx in range(-1, 2):
            for dy in range(-1, 2):
                if dx==0 and dy == 0:
                    continue
                if x+dx>=width or x+dx<0 or y+dy>=height or y+dy < 0:
                    continue
                if cseats[x+dx+(y+dy)*width] == '#':
                    neighbors = neighbors+1
        #print("neighbors:", neighbors)
        if this=='#':
            if neighbors>=4:
                dseats[x+y*width]='L'
                changed=True
        else:
            if neighbors == 0:
                dseats[x+y*width]='#'
                changed=True
    
    print("after:")
    printa(dseats)
    if not changed:
        break

    # swap a & b
    color = 1-color
                

print("Final:")
# count #s
printa(mseats[color])
part1=0
for x in mseats[color]:
    if x == '#':
        part1 = part1 + 1
print(part1)


