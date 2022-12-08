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

countSplitParts: proc(s:string, div:string): int {
  j = 0 i = 0 while i < length(s) do i = i + 1 {
    if s[i] == div {
      j = j + 1
    }
  }
  return j
}

split: proc(s:string, div:string): string[] {
  // TODO: use a DList for this
  parts:string[countSplitParts(s, div) + 1]
  sofar = ''
  j = 0 i = 0 while i < length(s) do i = i + 1 {
    ch = s[i]
    // Uses asc for integer vs string comparison
    if asc(ch) == asc(div) {
      // found another one
      parts[j] = sofar
      j = j + 1
      sofar = ''
    } else {
      sofar = sofar + ch
    }
  }
  parts[j] = sofar
  return parts
}

height=0
width=0
line = next_line() while line != null do line = next_line() {
  height = height + 1
  width = length(line)
}
print width print "x" println height

reset_next_line()
data:int[height * width]

parse_row: proc(row:int, line:string) {
  i = 0 while i < width do i = i + 1 {
    data[row * width + i] = asc(line[i]) - asc('0')
  }
}

height=0
line = next_line() while line != null do line = next_line() {
  parse_row(height, line)
  println line
  height = height + 1
}

// get the value at x, y
xy: proc(x:int, y:int):int {
  return data[y*width + x]
}

seen:bool[height * width]
i = 0 while i < width do i = i + 1 {
  // the whole first row
  seen[i] = true
  // the whole last row
  seen[i+(height-1)*height] = true
}
i = 0 while i < height do i = i + 1 {
  // the whole first column
  seen[i*height] = true
  // the whole last column
  seen[i*height+width-1] = true
}

print_seen: proc() {
  i = 0 while i < height do i = i + 1 {
    j = 0 while j < height do j = j + 1 {
      print seen[i*height + j] print ","
    }
    println ""
  }
}
//print_seen()
//println ""

count_seen: proc():int {
  answer = 0
  i = 0 while i < height do i = i + 1 {
    j = 0 while j < height do j = j + 1 {
      if seen[i*height + j] {answer = answer + 1}
    }
  }
  return answer
}

process_swath: proc(sx: int, sy:int, ex: int, ey: int, dx:int, dy:int) {
  // this is wrong. it needs to start before
  tallest = xy(sx, sy)
//  print "initial tallest " println tallest
  if sx == ex {
    // one column
    x = sx
    y = sy while y != ey do y = y + dy {
      it = xy(x, y)
 //     print x print "," print y print ":" println it
      if it > tallest {
        tallest = it
        seen[x+y*height] = true
      }
    }
  } else {
    // one row
    y = sy
    x = sx while x != ex do x = x + dx {
      it = xy(x, y)
  //    print x print "," print y print ":" println it
      if it > tallest {
        tallest = it
        seen[x+y*height] = true
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
//print_seen()

println count_seen()
