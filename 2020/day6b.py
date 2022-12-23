lines = open("day6.txt", "r")

unique = set()
part1 = 0
first=True
for line in lines:
    line = line.strip()
    if len(line) == 0:
        #print("End of section, size of", unique, "is", len(unique))
        part1 = part1 + len(unique)
        unique = set()
        first=True
    else:
        ours= set()
        for x in line:
            ours.add(x)
        if first:
            # just use ours
            unique = ours
        else:
            # keep only letters we have
            unique = unique.intersection(ours)
        first=False

part1 = part1 + len(unique)

print(part1)
    
