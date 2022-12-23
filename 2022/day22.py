"""
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5
"""

f = open('day22.txt', 'r')
lines = f.readlines()

def leftmost(s):
    dot=s.find('.')
    pound=s.find('#')
    if dot == -1:
        return pound
    elif pound == -1:
        return dot
    else:
        return min(pound, dot)

maze=[]
width=0
# find max width
for line in lines:
    line=line.rstrip()
    if len(line.strip()) == 0:
        break
    width=max(width, len(line))

# Make sure every row is max width
for line in lines:
    line=line.rstrip()
    if len(line.strip()) == 0:
        break
    # expand to full width
    newline=line + ' '*(width-len(line))
    maze.append(newline)

height=len(maze)

print("\n".join(maze))
instructions = lines[-1].strip()+"x" # who cares what the last letter is
instructions=instructions.replace("L", "L ")
instructions=instructions.replace("R", "R ")
print(instructions)

(x,y)=(leftmost(maze[0]), 0) # NOTE ZERO INDEXED
print("Starting at", x, y)

steps = instructions.strip().split(" ")
dirnames=['right', 'down', 'left', 'up']
arrow=['>', 'v', '<', '^']
facing=0 # right
# dx, dy for right, down, left, up
deltas=((1, 0), (0, 1), (-1, 0), (0, -1))

def bump_xy(facing, ox, oy):
    nx = ox + deltas[facing][0]
    if nx < 0:
        print("Wrapped left")
        nx = width -1
    elif nx >= width:
        print("Wrapped right")
        nx = 0

    ny = oy + deltas[facing][1]
    if ny >= height:
        print("Wrapped bottom")
        ny = 0
    elif ny < 0:
        print("Wrapped top")
        ny = height - 1
    return (nx, ny)

for step in steps:
    # go this amount in the current direciton
    amount=int(step[:-1])
    print("Instruction: go", amount),
    print("starting x, y, dir for this step", x, y, dirnames[facing])
    for i in range(amount):
        # if we go too far left, wrap to right, etc.
        (nx, ny) = bump_xy(facing, x, y)
        while maze[ny][nx] == ' ':
            # print("saw a space at ", nx, ny)
            # Keep going, modulo wraparound
            (nx, ny) = bump_xy(facing, nx, ny)

        # see if we can go to the next step
        if maze[ny][nx] == '#':
            # stop
            # print("Found a block at ", nx, ny, 'stopping at ', x, y ,'instead.')
            break
        x = nx
        y = ny
        print("progressed to", x, y)
        maze[y]=maze[y][:x]+arrow[facing]+maze[y][x+1:]
    
    # Then turn
    if step[-1] == 'x':
        break
    goright=step[-1]=='R'
    #print("Turning", step[-1], "from", dirnames[facing]),
    if goright:
        facing = (facing + 1) % 4
    else:
        facing = facing - 1
        if facing == -1:
            facing = 3
    #print("to", dirnames[facing])
    #print(amount, rotation)
    print("final x, y,dir for this step", x, y, dirnames[facing])
    maze[y]=maze[y][:x]+arrow[facing]+maze[y][x+1:]

print("\n".join(maze))
print("Loc:", x, y)
print("Answer:", (x+1)*4+1000*(y+1)+facing)
