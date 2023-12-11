fn="day10s.txt"
sc="F"  # equivalent character to put at the origin | for full sample

fn="day10.txt"
sc="|"  # equivalent character to put at the origin | for full sample

f = open(fn, 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

width=len(lines[0])
height=len(lines)
seen=[[False for x in range(width)] for y in range(height)]
best=[[10000000000 for x in range(width)] for y in range(height)]

sx=0
sy=0
for line in lines:
    sx = line.find("S")
    if sx != -1:
        break
    sy+=1


# location, dist so far
queue=[(sx, sy, 0)]
def add(x, y, dist):
    # if illegal, skip
    if x<0 or y<0: return
    if x>=width or y>=height: return
    # if we've been there already and the dist is worse, skip
    if seen[y][x] and dist >= best[y][x] : return
    queue.append((x, y, dist))

answer = 0
while len(queue):
    (x, y, dist) = queue.pop(0)
    #print("At %d, %d: %d" % (x, y, dist))
    seen[y][x] = True
    best[y][x] = min(dist, best[y][x])
    answer = max(answer, best[y][x])
    ch = lines[y][x]
    if y == sy and x == sx:
        # first
        ch = sc
    # Go both directions
    if ch=='|':
        # go up and down
        add(x,y+1,dist+1)
        add(x,y-1,dist+1)
    elif ch=='-':
        # go left and right
        add(x-1,y,dist+1)
        add(x+1,y,dist+1)
    elif ch=='7':
        # go down and left
        add(x-1,y,dist+1)
        add(x,y+1,dist+1)
    elif ch=='L':
        # go up and right
        add(x+1,y,dist+1)
        add(x,y-1,dist+1)
    elif ch=='J':
        # go up and left
        add(x-1,y,dist+1)
        add(x,y-1,dist+1)
    elif ch=='F':
        # go down and right
        add(x,y+1,dist+1)
        add(x+1,y,dist+1)
#    for x in seen: print(x)
#    for x in best: print(x)
#    print("Q")
    #print(queue)

#for x in best: print(x)
    

print("Day 10 part 1: %d" % answer)

