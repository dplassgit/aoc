f = open('day6b.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

times = lines.pop(0)
times = times.split()[1:]
times = [int(s) for s in times]

dists = lines.pop(0)
dists = dists.split()[1:]
dists = [int(s) for s in dists]

print(times)
print(dists)

answer = 1
for r in range(0, len(times)):
    time = times[r]
    dist = dists[r]
    wins = 0
    for t in range(1, time):
        # if we can win, bump the counter.
        # for every unit we hold down the thingie 
        # the speed is that amount.
        timeleft = time - t
        speed = t
        ourdist = speed * timeleft
        #print("Race %d: speed %d dist %d maxdist %d" % (r, speed, ourdist, dist))
        if ourdist > dist:
            #print("Won!")
            wins = wins + 1
    answer = answer * wins

print("Day 6: %d" % answer)

