import io
import re

valid=0
f = open("d2.txt", "r")

for line in f:
    m = re.match(r"(\d+)-(\d+) (.): ([a-z]+)", line)
    lowest = int(m.group(1))
    highest = int(m.group(2))
    letter = m.group(3)
    pw = m.group(4)
    #print lowest,highest,letter,pw
    #print pw[lowest-1],pw[highest-1]
    if (pw[lowest-1] == letter and  pw[highest-1] != letter) or (pw[lowest-1] != letter and pw[highest-1] == letter):
        valid = valid + 1
    #count = len([x for x in pw if x==letter])
    #if count >= lowest and count <= highest:
        #valid = valid+1

print(valid)
