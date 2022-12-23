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

def part2(part1):
    for i in range(len(data)-1):
        if data[i] > part1:
            print("FAIL")
            return -1
        for j in range(i+1, len(data)):
            # TIL sum(slice)...
            thesum=sum(data[i:j])
            if thesum==part1:
                minv=min(data[i:j])
                maxv=max(data[i:j])
                print("minv", minv, "maxv", maxv)
                print(minv+maxv)
                return
part2(thepart1)
