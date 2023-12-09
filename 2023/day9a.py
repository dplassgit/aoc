f = open('day9.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

def all_zeros(lst):
    return len([x for x in lst if x != 0]) == 0

answer = 0
for line in lines:
    parts = [int(x) for x in line.split()]
    #print(parts)
    iters=[parts]
    olddiffs = parts
    while True:
        diffs = [0]*(len(olddiffs)-1)
        for i in range(1, len(olddiffs)):
            diffs[i-1] = olddiffs[i] - olddiffs[i-1]
        iters.insert(0, diffs)
        if all_zeros(diffs):
            break
        olddiffs = diffs
    #print(iters)
    # now rebuild the thing

    print(iters)
    p = iters[0][-1]# prediction
    for i in range(1, len(iters)):
        lst = iters[i] # this is the next row
        mylast = lst[-1] # the last one in our row
        p = p + mylast # add the last one in our row to the last prediction (?)
        #print("new prediction %d" % p)

    answer += p

print("Day 9 part 1: %d" % answer)

