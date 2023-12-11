f = open('day11.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

width=len(lines[0])
height=len(lines)

dots='.'*width

blank_rows=[]
stars=[]
for y in range(height):
    if lines[y]==dots:
        blank_rows.append(y)
    for x in range(width):
        if lines[y][x] == '#':
            stars.append((x, y))

#print("rows: %s" % blank_rows)
#print(stars)

# Now do columns. 
counts=[0]*width
for line in lines:
    for i in range(width):
        if line[i] =='.':
            counts[i]=counts[i]+1
blank_columns=[]
for c in range(width):
    if counts[c] == height:
        blank_columns.append(c)
#print("cols: %s" % blank_columns)

for i in range(2):
    answer = 0
    bump=[1, 999999][i]
    for i in range(len(stars)-1):
        for j in range(i+1, len(stars)):
            # find temp distance
            dist = abs(stars[i][0] - stars[j][0])+abs(stars[i][1]-stars[j][1])
            # now see if there are any blank cols or rows between them
            for a in blank_rows:
                if stars[i][1]<=a<=stars[j][1] or stars[j][1]<=a<=stars[i][1]:
                    dist += bump
            for a in blank_columns:
                if stars[i][0]<=a<=stars[j][0] or stars[j][0]<=a<=stars[i][0]:
                    dist += bump
            answer += dist

    print("Day 11 part %d: %d" % (i+1,answer))

