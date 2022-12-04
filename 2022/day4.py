f = open('day4.txt', 'r')
lines = f.readlines()

count = 0
for line in lines:
    es = line.split(',')
    r1 = es[0].split('-')
    range1 = [int(x) for x in r1]
    r2 = es[1].split('-')
    range2 = [int(x) for x in r2]
    if ((range1[0] <= range2[0] and range1[1] >= range2[1]) or (range2[0] <= range1[0] and range2[1] >= range1[1])): count = count + 1

print count

count = 0
for line in lines:
    es = line.split(',')
    r1 = es[0].split('-')
    range1 = [int(x) for x in r1]
    r2 = es[1].split('-')
    range2 = [int(x) for x in r2]
    if ( 
     (range2[0] <= range1[0] and range1[0] <= range2[1]) or 
     (range2[0] <= range1[1] and range1[1] <= range2[1]) or 
     (range1[0] <= range2[0] and range2[0] <= range1[1]) or 
     (range1[0] <= range2[1] and range2[1] <= range1[1])): count = count + 1

print count
