f = open("day4.txt", "r")
lines = f.readlines()

counts = [1 for line in lines]

def process(line):
    halves = line.strip().split(":")
    cardid = halves[0].strip().split()
    cardnum = int(cardid[1]) - 1
    numbers = halves[1]
    parts = numbers.strip().split("|")
    winners = parts[0].strip()
    winners = winners.split(' ')
    winners = set([int(winner) for winner in winners if winner])
    mine = parts[1].strip()
    mine = mine.split(' ')
    mine = set([int(my) for my in mine if my])
    my_winners = winners.intersection(mine)
    numwinners = len(my_winners)

    # For each of the numwinners children we add OUR count (?)
    for i in range(0, numwinners):
        counts[cardnum+i+1] += counts[cardnum]


ans = 0
for i in range(0, len(lines)):
    process(lines[i])
    ans = ans + counts[i]

print("Part 2: %d" % ans)

