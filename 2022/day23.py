from collections import defaultdict
import fileinput

lines=[]
elves=set()
y=0
for line in fileinput.input():
    line = line.strip()
    x=0
    for x,ch in enumerate(line):
        if ch == '#':
            elves.add((x, y))
    y = y + 1

    
def printit():
    global elves
    minx=9999999
    maxx=0
    miny=9999999
    maxy=0
    for (x,y) in elves:
        minx=min(x, minx)
        miny=min(y, miny)
        maxx=max(x, maxx)
        maxy=max(y, maxy)
    count = 0
    for y in range(miny, maxy+1):
        for x in range(minx, maxx+1):
            if (x,y) in elves:
                print("#",end='')
            else:
                print(".",end='')
                count = count + 1
        print("")
    return count


"""
If there is no Elf in the N, NE, or NW adjacent positions, the Elf proposes moving north one step.
If there is no Elf in the S, SE, or SW adjacent positions, the Elf proposes moving south one step.
If there is no Elf in the W, NW, or SW adjacent positions, the Elf proposes moving west one step.
If there is no Elf in the E, NE, or SE adjacent positions, the Elf proposes moving east one step.
"""

def cangonorth(x, y):
    #print("trying north from", x, y)
    if (x-1,y-1) not in elves and (x,y-1) not in elves and (x+1,y-1) not in elves:
        return (0, -1)
    else:
        return None
def cangosouth(x, y):
    #print("trying south from", x, y)
    if (x-1,y+1) not in elves and (x,y+1) not in elves and (x+1,y+1) not in elves:
        return (0, 1)
    else:
        return None
def cangowest(x, y):
    #print("trying west from", x, y)
    if (x-1,y-1) not in elves and (x-1,y) not in elves and (x-1,y+1) not in elves:
        return (-1, 0)
    else:
        return None
def cangoeast(x, y):
    #print("trying east from", x, y)
    if (x+1,y-1) not in elves and (x+1,y) not in elves and (x+1,y+1) not in elves:
        return (1, 0)
    else:
        return None


testers=[cangonorth,cangosouth,cangowest,cangoeast]
def oneround(dir):
    global elves
    #print("starting dir", dir)
    # 1. each elf picks a new spot
    # 2. if there is contention, they do not move
    proposals=defaultdict(list)
    for elf in elves:
        (x,y)=elf
        #print("elf at", elf)
        if cangonorth(x,y) is not None and cangosouth(x,y) is not None and cangowest(x, y) is not None and cangoeast(x,y) is not None:
            #print("no neighors to go, stay here")
            # no move
            proposals[elf].append(elf)
        else:
            for tempdir in range(4):
                actualdir = (tempdir+dir)%4
                #print("actualdir", actualdir)
                proposal = testers[actualdir](x,y)
                if proposal is not None:
                    #print("can go to", proposal)
                    (dx, dy) = proposal
                    # we can move there
                    proposals[(x+dx, y+dy)].append(elf)
                    break
            else:
                # no place to go
                #print("no place to go, stay here")
                proposals[elf].append(elf)
    #print("proposals:", proposals)
    newworld = set()
    for newplace in proposals:
        elflist = proposals[newplace]
        #print("elflist", elflist)
        if len(elflist) == 1:
            # only one - we can go to the new place
            newworld.add(newplace)
        else:
            # they stay at their old places
            for other in elflist:
                newworld.add(other)
    #print("newworld:", newworld)
    elves=newworld


def part1():
    startdir=0
    print("Initial:")
    printit()
    for round in range(10):
        print("Round", round)
        oneround(startdir)
        printit()
        startdir = (startdir + 1) % 4

    
part1()
print(printit())

