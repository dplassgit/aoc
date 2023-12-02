f = open('day1.txt', 'r')
lines = f.readlines()

words=['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
answer = 0
for line in lines:
    number = 0
    bestloc = 99999999
    bestval = 0
    print(line)
    for j in range(len(words)):
        loc = line.find(words[j])
        if loc != -1 and loc < bestloc:
            bestloc = loc
            bestval = j
    for j in range(0,10):
        loc = line.find(str(j))
        if loc != -1 and loc < bestloc:
            bestloc = loc
            bestval = j
    number = bestval
    print(number)
    bestloc = -1
    bestval = 0
    for j in range(len(words)):
        loc = line.rfind(words[j])
        if loc != -1 and loc > bestloc:
            bestloc = loc
            bestval = j
    for j in range(0,10):
        loc = line.rfind(str(j))
        if loc != -1 and loc > bestloc:
            bestloc = loc
            bestval = j
    number = number*10+bestval
    print(number)
    answer = answer + number


print(answer)



