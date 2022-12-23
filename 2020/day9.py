import fileinput

window=25
data=[]
for line in fileinput.input():
    line = line.strip()
    data.append(int(line))

#print(data)

thepart1=0
def dopart1():
    global data
    for i in range(window, len(data)):
        x = data[i]
        found=False
        for j in range(i-window, i):
            for k in range(j+1, i):
                if data[j]+data[k] == x:
                    found = True
                    break
        if not found:
            return x

thepart1=dopart1()
print("Part 1", thepart1)

# I hate this part.
def part2(part1):
    for i in range(len(data)-1):
        if data[i] > part1:
            print("FAIL")
            return -1
        for j in range(i+1, len(data)):
                sum=data[i]
                minv=data[i]
                maxv=data[i]
                # add up all the numbers between i an dj
                #print("Adding up from", i, "to", j)
                for k in range(i+1, j):
                    minv=min(minv, data[k])
                    maxv=max(maxv, data[k])
                    sum = sum + data[k]
                    #print("sum=", sum)
                    if sum == part1:
                        print("Found it, i=", i, "j=", j)
                        print("minv", minv, "maxv", maxv)
                        print(minv+maxv)
                        return
part2(thepart1)
