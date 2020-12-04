import io

trees=0
f = open("d3.txt", "r")

column=0
skip=False
for line in f:
    if not skip:
      line = line.strip()
      print line
      if line[column % len(line)] == '#':
          trees = trees+1
      column = column + 1
    skip = not skip

print trees
# r1,d1 60
# r3,d1 191
# r5,d1 64
# r7,d1 63
# r1,d2 32
