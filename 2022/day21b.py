f = open('day21.txt', 'r')
lines = f.readlines()

nodes=dict()
q=[]
for line in lines:
    parts = line.strip().split(' ')
    name=parts[0][:-1] # remove colon
    value=None
    left=None
    op=None
    right=None

    if parts[1].isnumeric():
        value=int(parts[1])
    else:
        left=parts[1]
        op=parts[2]
        right=parts[3]
    node = [name, value, left, op, right, [], None, None]   # last array is the node names that depend on this
    if value is not None:
        q.append(node)
    nodes[name] = node

for node in nodes.values():
    left=node[2]
    right=node[4]
    if left is not None:
        # we depend on left and right
        leftnode = nodes[left]
        rightnode = nodes[right]
        # Add our name to the left and right
        leftnode[5].append(node[0])
        rightnode[5].append(node[0])

print("Values:")
for node in nodes.values():
    print(node)

def reset():
    for node in nodes.values():
        node[6] = None
        node[7] = None

algo="""
L ← Empty list that will contain the sorted elements
S ← Set of all nodes with no incoming edge

while S is not empty do
    remove a node n from S
    add n to L
    for each node m with an edge e from n to m do
        remove edge e from the graph
        if m has no other incoming edges then
            insert m into S

if graph has edges then
    return error   (graph has at least one cycle)
else 
    return L   (a topologically sorted order)
"""
def onerun():
    while len(q):
        head=q.pop()
        #print("Head ", head)
        (name, value, left, op, right, deps, leftvalue, rightvalue) = head
        if name == 'root':
            return head
        for depname in deps:
            # tell each dependency about our number
            dep = nodes[depname]
            #print("dep  ", dep)
            if dep[1] is None:
                if dep[6] == None and dep[2] == name:
                    dep[6] = value
                if dep[7] == None and dep[4] == name:
                    dep[7] = value
                #print("updated dep ", dep)
                if isinstance(dep[6], int) and isinstance(dep[7], int):
                    # both are numbers, calculate our new number and add us to the queue.
                    newvalue = 0
                    op=dep[3]
                    if op == '+':
                        newvalue = dep[6] + dep[7]
                    elif op == '-':
                        newvalue = dep[6] - dep[7]
                    elif op == '*':
                        newvalue = dep[6] * dep[7]
                    elif op == '/':
                        newvalue = dep[6] // dep[7]
                    else:
                        print("UNKNOWN OP ", op)
                    dep[1]= newvalue
                    #print("adding updated dep ", dep)
                    q.append(dep)
        #print("queue is now ", q)

humn=nodes['humn']
print('Humn ', humn)
root=onerun()
print('Root ', root)
while root[6] != root[7]:
    if root[6] > root[7]:
        humn[1]=
       
