f = open('day20.txt', 'r')
lines = f.readlines()

data=[]
index=0
zero=0
for line in lines:
    value=int(line)*811589153
    if value == 0:
        zero=index
    data.append((value, index, value))
    index = index + 1

#olddata=data[:]
#data=[]
#for datum in olddata:
    #newdatum = (datum[0] % (len(olddata)-1), datum[1], datum[0])
    #data.append(newdatum)

#print(data)

orig = data[:]
for i in range(10):
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
        #print([z for (x,y,z) in data])

#print("Final")
#print([x for (x,y) in data])
#print(data)
zeroth=data.index((0, zero, 0))
print(zeroth)
k1=data[(zeroth+1000)%(len(orig))]
k2=data[(zeroth+2000)%(len(orig))]
k3=data[(zeroth+3000)%(len(orig))]
print(k1)
print(k2)
print(k3)
print(k1[2]+k2[2]+k3[2])
    




