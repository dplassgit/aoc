f = open('day4.txt', 'r')
lines = f.readlines()

count = 0
for line in lines:
    es = line.split(',')
    r1 = es[0].split('-')
    a,b= [int(x) for x in r1]
    r2 = es[1].split('-')
    c,d = [int(x) for x in r2]
    if (a <= c <= b and a <= d <= b) or (c <= a <= d and c <= b <= d): count = count + 1


print count

count = 0
for line in lines:
    es = line.split(',')
    r1 = es[0].split('-')
    a,b = [int(x) for x in r1]
    r2 = es[1].split('-')
    c,d = [int(x) for x in r2]
    if (a <= c <= b or a <= d <= b) or (c <= a <= d or c <= b <= d): count = count + 1

print count
