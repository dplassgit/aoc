from collections import defaultdict
import fileinput

lines=[]
maxwidth=0
for line in fileinput.input():
    line = line.strip()
    line = ''.join(reversed(line))
    lines.append(line)
    maxwidth=max(maxwidth, len(line))

answer=[0 for x in range(maxwidth * 2)]

def adjust(digit, newvalue):
    if -2 <= newvalue <= 2:
        # Just set it.
        answer[digit] = newvalue
    elif newvalue == 3:
        answer[digit] = -2
        adjust(digit+1, answer[digit+1]+1)
    elif newvalue == 4:
        answer[digit] = -1
        adjust(digit+1, answer[digit+1]+1)
    elif newvalue == -3:
        # 1(-3) is 5-3=02
        answer[digit] = 2
        adjust(digit+1, answer[digit+1]-1)
    elif newvalue == -4:
        # 1(-4) is 5-4=01
        answer[digit] = 1
        adjust(digit+1, answer[digit+1]-1)
    else:
        print("PANIC, newvalue is ", newvalue)


for num5 in lines:
    #print('adding', num5)
    for place in range(0, len(num5)):
        digit=num5[place]
        if digit in ['0', '1', '2']:
            actual=int(digit)
        elif digit == '-':
            actual=-1
        else:
            actual=-2
        maybeanswer = answer[place] + actual
        adjust(place, maybeanswer)
    #print("Answer is now", answer)

print('Answer smallest to largest:', answer)
r=[x for x in reversed(answer)]
print('Answer little-endian:', r)
i=0

while r[i] == 0:
    i = i + 1
part1=''
for j in range(i, len(r)):
    if r[j] >= 0:
        part1=part1+str(r[j])
    elif r[j] == -1:
        part1=part1+'-'
    else:
        part1=part1+'='
print(part1)
