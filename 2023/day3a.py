f = open("day3.txt", "r")
lines = f.readlines()

#////////////////////////////////////////////////////
#// DAY 3 CODE HERE
#////////////////////////////////////////////////////

#// or 
#// 1. find all symbols. add all 8 adjacent cells to all symbols to a set
#// 2. find all numbers. look up all adjacent cells in the set
answer = 0

rows = len(lines)
cols = len(lines[0])
# row, col
adj = [[False for i in range(cols)] for j in range(rows)]


row = 0
for line in lines:
    col = 0
    line = line.strip()
    for c in line:
        if c not in ['.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
            #print("Found a symbol at row %d, %d" % (row, col))
            # add adjacents to set
            for i in range(col-1, col+2):
                for j in range(row-1, row+2):
                    if i < 0 or j < 0 or i >= cols or j >= rows:
                        continue
                    if i == 0 and j == 0:
                        continue
                    adj[j][i] = True
        col += 1
    row += 1

#for r in range(0, rows):
#    print(adj[r])

row = 0
for line in lines:
    print(line)
    col = 0
    num=-1
    innum=False
    found = False
    for ci in range(0, len(line)):
        c = line[ci]
        # find a number. for each digit, see if its "adj" is true.
        if c in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']:
            if innum:
                # We're in a number, just keep its digit
                num = num * 10 + int(c)
            else:
                innum = True
                num = int(c)
            #print("Found a digit. innum %s current num %d" % (innum, num))
            found = found or adj[row][col]
            #print("found is %s" % found)
        else:
            #print("not in a num. found was %s" % found)
            # Not in a number. either we haven't seen one yet or we just ended one
            if found:
                answer += num
            found = False
            innum=False
        col += 1
    row += 1


print("Answer = %d" % answer)

#for r in range(0, rows):
#    print(adj[r])

