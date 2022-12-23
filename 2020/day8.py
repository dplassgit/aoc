import io

f = open("day8.txt", "r")
lines=[]
for line in f:
    lines.append(line)

def simulate():
    seen = set()
    ip=0
    acc=0
    while True and ip < len(lines):
        if ip in seen:
            return (False, acc)
        seen.add(ip)
        line = lines[ip].strip()
        print("ip", ip, ":", line, "acc=", acc)
        parts = line.split(" ")
        to=int(parts[1])
        if parts[0] == 'nop':
            ip = ip + 1
        elif parts[0] == 'jmp':
            ip = ip + to
        else:
            acc = acc + to
            ip = ip + 1

    return (True, acc)

print("part1: ", simulate())

for ip in range(len(lines)):
    line = lines[ip]
    oldline = line
    parts = line.split(" ")
    if parts[0] == 'acc':
        continue
    if parts[0] == 'nop':
        lines[ip] = 'jmp %s' % parts[1]
    else:
        lines[ip] = 'nop %s' % parts[1]
    result = simulate()
    print("sim result: ", result)
    if result[0]:
        print("Part2: ", result)
        break
    lines[ip] = oldline
    


