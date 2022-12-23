lines = open("day6.txt", "r")

unique = set()
part1 = 0
for line in lines:
    line = line.strip()
    if len(line) == 0:
        #print("End of section, size of", unique, "is", len(unique))
        part1 = part1 + len(unique)
        unique = set()
    else:
        for x in line:
            unique.add(x)

part1 = part1 + len(unique)

print(part1)
    
