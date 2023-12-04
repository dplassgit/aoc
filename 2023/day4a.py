f = open("day4.txt", "r")
lines = f.readlines()

ans = 0
for line in lines:
    halves = line.strip().split(":")
    numbers = halves[1]
    parts = numbers.strip().split("|")
    winners = parts[0].strip()
    winners = winners.split(' ')
    winners = set([int(winner) for winner in winners if winner])
    mine = parts[1].strip()
    mine = mine.split(' ')
    mine = set([int(my) for my in mine if my])
    print(line)
    print(winners)
    print(mine)
    my_winners = winners.intersection(mine)
    print(my_winners)
    if len(my_winners) == 0:
        continue
    score = 2**(len(my_winners)-1)
    print(score)
    ans = ans + score


print("Part 1: %d" % ans)

