# requires python3
f = open('day9.txt', 'r')
input=[
'R 4',
'U 4',
'L 3',
'D 1',
'R 4',
'D 1',
'L 5',
'R 2']
input = f.readlines()


# for visualization only
left=-10 
right=10 
top=10 
bottom=-10
head=[0,0]
last_head=head
global tail
tail=[0,0]
Y=0
X=1

tailspots = set()
def recordtail():
    tailspots.add((tail[X], tail[Y]))
recordtail()

def xdist():
    # is this right?
    return abs(head[X]-tail[X])

def ydist():
    # is this right?
    return abs(head[Y]-tail[Y])

def needToMoveTail():
    # if they're at the same spot, it's fine
    # if they're touching it's fine
    if head == tail: return False
    # print("Not the same place")
    if xdist() <= 1 and ydist() <= 1: return False
    # print("xdist %d ydist %d" % (xdist(), ydist()))
    return True

def maybeMoveTail():
    global tail
    print("head now at %s" % head)
    print("tail was at %s" % tail)
    if needToMoveTail():
        print("moving tail to last head %s" % last_head)
        tail=last_head[:]
        recordtail()


def visualize():
    print()
    for y in range(top, bottom, -1):
        for x in range(left, right):
            if head[X] == x and head[Y] == y: print("H",end='')
            elif tail[X]==x and tail[Y] == y: print("T",end='')
            else: print(".",end='')
        print()

visualize()
for line in input:
    print(line)
    (dir, count)= line.split(' ')
    count = int(count)
    if dir == 'U':
        for i in range(0, count):
            last_head = head[:]
            head[Y] = head[Y] + 1
            maybeMoveTail()
    elif dir == 'D':
        for i in range(0, count):
            last_head = head[:]
            head[Y] = head[Y] - 1
            maybeMoveTail()
    elif dir == 'L':
        for i in range(0, count):
            last_head = head[:]
            head[X] = head[X] - 1
            maybeMoveTail()
    elif dir == 'R':
        for i in range(0, count):
            last_head = head[:]
            head[X] = head[X] + 1
            maybeMoveTail()
    visualize()

print(tailspots)
print("Part1: %d" % len(tailspots))
