f = open('day9.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

answer = 0
for line in lines:
    parts = [int(x) for x in line.split()]

    # Iterations
    iters=[parts]
    olddiffs = parts
    while not all([x==0 for x in olddiffs]):
        # All zeros
        diffs = [0] * (len(olddiffs) - 1)
        for i in range(1, len(olddiffs)):
            diffs[i-1] = olddiffs[i] - olddiffs[i-1]
        iters.insert(0, diffs)
        olddiffs = diffs
    #print(iters)

    p = 0  # prediction
    for i in range(1, len(iters)):
        lst = iters[i] # this is the "next" row
        mylast = lst[-1] # the last one in our row
        p = mylast + p # add the last one in our row to the last prediction
        #print("new prediction %d" % p)

    answer += p

print("Day 9 part 1: %d" % answer)

