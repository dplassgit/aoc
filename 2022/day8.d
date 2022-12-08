atoi: extern proc(s:string):int

// test this with other inputs, e.g.,
// global_data = '30373\n25512\n65332\n33549\n35390\n'
global_data=input

next_line_loc=0
reset_next_line: proc() {
  next_line_loc = 0
}
// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc(): String {
  line = ''
  len=length(global_data)
  while next_line_loc < len {
    ch = global_data[next_line_loc]
    next_line_loc = next_line_loc + 1
    if asc(ch) != asc('\n') {
      line = line + ch
    } else {
      return line
    }
  }
  // got to eof
  return null
}

// Day 8

height=0
width=0
line = next_line() while line != null do line = next_line() {
  height = height + 1
  width = length(line)
}
print width print "x" println height

data:int[height * width]

parse_row: proc(row:int, line:string) {
  i = 0 while i < width do i = i + 1 {
    data[row * width + i] = asc(line[i]) - asc('0')
  }
}

height=0
part1=0
reset_next_line()
line = next_line() while line != null do line = next_line() {
  parse_row(height, line)
  height = height + 1
}

// get the value at x, y
xy: proc(x:int, y:int):int {
  return data[y*width + x]
}

seen:bool[height * width]
i = 0 while i < width do i = i + 1 {
  // the whole first row
  setSeen(i, 0)
  // the whole last row
  setSeen(i, height-1)
}
i = 0 while i < height do i = i + 1 {
  // the whole first column
  setSeen(0, i)
  // the whole last column
  setSeen(width-1, i)
}

setSeen:proc(x:int, y:int) {
  if not seen[x+y*height] {
    seen[x+y*height] = true
    part1 = part1 + 1
  }
}

print_seen: proc() {
  i = 0 while i < height do i = i + 1 {
    j = 0 while j < width do j = j + 1 {
      print seen[i*height + j] print ","
    }
    println ""
  }
}
//print_seen()
//println ""


process_swath: proc(sx: int, sy:int, ex: int, ey: int, dx:int, dy:int) {
  tallest = xy(sx, sy)
  if sx == ex {
    // one column
    x = sx
    y = sy while y != ey do y = y + dy {
      it = xy(x, y)
      if it > tallest {
        tallest = it
        setSeen(x, y)
      }
    }
  } else {
    // one row
    y = sy
    x = sx while x != ex do x = x + dx {
      it = xy(x, y)
      if it > tallest {
        tallest = it
        setSeen(x, y)
      }
    }
  }
}

// go from left to right, from right to left, 
y = 1 while y < height - 1 do y = y + 1 {
  // look at row y from left to right
  process_swath(0,       y, width, y, 1, 0)
  // look at row y from right to left
  process_swath(width-1, y, 0,     y, -1, 0)
}

// go from top to bottom, from bottom to top
x = 1 while x < width - 1 do x = x + 1 {
  // look at column x from top to bottom
  process_swath(x, 0,        x, height, 0,  1)
  // look at column x from bottom to top
  process_swath(x, height-1, x, 0,      0, -1)
}
// print_seen()

print 'Part1: ' println part1

// OH I THINK I TSEE IT NOW
// 3 cases: 1 off the grid: stop. 2. not off the grid, i'm bigger: keep going. 3. not off the grid, they're bigger: stop.
good: proc(x:int, y:int, me:int): int {
  if x < 0 or y < 0 { return 0 }
  if x >= width or y >= height { return 0 }
  if me > xy(x, y) { return 1} else {return -1}
}

calcScenicHeight: proc(x: int, y:int): int {
  me = xy(x, y)
  // go up down left right, get length, multiple
  left = 0
  right = 0
  up = 0
  down = 0
  tx = x - 1 while true { g = good (tx, y, me) if g == 0 { break} else { left = left + 1 tx = tx - 1 if g == -1 { break }}}
  tx = x + 1 while true { g = good (tx, y, me) if g == 0 { break} else { right = right + 1 tx = tx + 1 if g == -1 { break }}}
  ty = y - 1 while true { g = good (x, ty, me) if g == 0 { break} else { up = up + 1 ty = ty - 1 if g == -1 { break }}}
  ty = y + 1 while true { g = good (x, ty, me) if g == 0 { break} else { down = down + 1 ty = ty + 1 if g == -1 { break }}}

  return left*right*up*down
}

// for part 2:
part2 = -1
y = 1 while y < height - 1 do y = y + 1 {
  x = 1 while x < width - 1 do x = x + 1 {
    // scenic height
    sh = calcScenicHeight(x, y)
    if sh > part2 {
  print sh print " is best at " print x print "," println y
      part2 = sh
    }
  }
}


print 'Part2: ' println part2
