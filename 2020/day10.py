import fileinput

lines=[]
for line in fileinput.input():
    line = line.strip()
    lines.append(int(line))

lines.sort()
print(lines)
ones = 1
threes = 1
for i in range(1, len(lines)):
    this = lines[i]
    last = lines[i-1]
    if this-last == 1:
        ones = ones + 1
    else:
        threes = threes+1

print("ones", ones)
print("threes", threes)
print("par1: ", ones*threes)
