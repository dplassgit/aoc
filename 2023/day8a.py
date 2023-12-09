f = open('day8.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

# directions
dir = lines.pop(0)
lines.pop(0)

# key: node name. value: left node, right node
nodes = {}
for line in lines:
    name = line[:3]
    left = line[7:10]
    right = line[12:15]
    nodes[name]=(left, right)

print(nodes)

nodename='AAA'
di=0 # index into dir
answer = 0
while nodename != 'ZZZ':
    print("visiting %s" % nodename)
    answer = answer + 1
    d = dir[di]
    di = di + 1
    if di == len(dir):
        di = 0
    node = nodes[nodename]
    if d=='L':
        nodename = node[0]
    else:
        nodename = node[1]

print("Day 8 part 1: %d" % answer)

