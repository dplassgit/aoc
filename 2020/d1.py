import io

data=[]
f = open("d1.txt", "r")

for line in f:
    if len(line) > 0:
        data.append(int(line))
    else:
        break

for i in range(0,len(data)):
    for j in range(i,len(data)):
        for k in range(j,len(data)):
          if data[i]+data[j]+data[k] == 2020:
            print(data[i]*data[j]*data[k])
            break
    
