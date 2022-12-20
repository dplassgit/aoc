#
f = open('day20.txt', 'r')
lines = f.readlines()

data=[]
index=0
zero=0
for line in lines:
    value=int(line)
    #value=int(line)*811589153
    if value == 0:
        zero=index
    data.append((value, index))
    index = index + 1

#print(data)

orig = data[:]
for datum in orig:
    thisplace = data.index(datum)
    #print("this place for ", datum, " is ", thisplace)
    # 1. find the original in "data"
    # 2. remove it
    data.remove(datum)
    #print('After removing', data)
    # 3. insert it at right place
    # datum[0] is the value
    newplace = (thisplace + datum[0])% (len(orig)-1)
    #print("newplace ", newplace)
    while newplace < 0:
        newplace = len(orig)+newplace-1
        print("adjusted newplace ", newplace)
    data.insert(newplace, datum)
    #print([x for (x,y) in data])

#print([x for (x,y) in data])
zeroth=data.index((0, zero))
print(zeroth)
k1=data[(zeroth+1000)%(len(orig))]
k2=data[(zeroth+2000)%(len(orig))]
k3=data[(zeroth+3000)%(len(orig))]
print(k1)
print(k2)
print(k3)
print(k1[0]+k2[0]+k3[0])
    




