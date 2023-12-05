f = open('day5.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

seeds=lines.pop(0)
lines=lines[1:]
seeds=seeds.split()[1:]
seeds=[int(s) for s in seeds]

# seed to soil, soil to fertilizer, water to light, light to temp, temp to hum, hum to loc
# each entry is a list of lists (just basically the input): (deststart, sourcestart, length)
maps=[[], [], [], [], [], [], []]

i = 0
for line in lines:
    if line == "":
        # Blank line between sections
        i+=1
        continue

    if line[0].isalpha():
        # Skip headers
        continue
    
    cur=maps[i]
    # If we got here it's fine.
    datum = line.split()
    datum = [int(d) for d in datum]
    cur.append(datum)

def traverse(seed):
    for m in maps:
        # find the corresponding dest for the current input (seed)
        for data in m:
            # (dest, source, length) = data
            if seed >= data[1] and seed < data[1]+data[2]:
                # Found it
                seed = data[0] + (seed - data[1])
                break
    return seed

answer = 99999999999999999999
for i in range(0, len(seeds), 2):
    # traverse the map
    start = seeds[i]
    length = seeds[i+1]
    print("range %d to %d" % (start, start+length))
    for seed in range(start, start+length):
        loc = traverse(seed)
        # print("seed %d at %d" % (seed, loc))
        if loc < answer:
            answer = loc
            print("New best: seed %d at %d" % (seed, answer))


print(answer)



