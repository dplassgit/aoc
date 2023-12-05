f = open('day5.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

seeds=lines.pop(0)
lines=lines[1:]
seeds=seeds.split()[1:]
seeds=[int(s) for s in seeds]

# seed to soil, soil to fertilizer, water to light, light to temp, temp to hum, hum to loc
# each entry is a list of tuplies (just basically the input): (deststart, sourcestart, length)
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


for m in maps:
    print(m)

def traverse(seed):
    for m in maps:
        # find the corresponding dest for the current input (seed)
        for range in m:
            (dest, source, length) = range
            if seed >= source and seed < source+length:
                # Found it
                seed = dest + (seed - source)
                break
    return seed

answer = -1
for seed in seeds:
    # traverse the map
    loc = traverse(seed)
    print("Loc of %d is %d" % (seed, loc))
    if answer == -1 or loc < answer:
        answer = loc


print(answer)



