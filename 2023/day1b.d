// TO BUILD:

// nasm -fwin64 lib.asm -o lib.obj
// dcc day1b.d -l lib.obj
// ./day1b.exe < day1.txt



////////////////////////////////////////////////////
// Read data all at once
////////////////////////////////////////////////////
global_data = input

next_line_loc = 0
reset_input: proc() {
  next_line_loc = 0
}

// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc: String {
  line = ''
  len = length(global_data)
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

////////////////////////////////////////////////////
// DAY 1 CODE HERE
////////////////////////////////////////////////////

ifind: extern proc(haystack: string, needle: string): int
strrev: extern proc(s:string): string

find: proc(haystack: string, needle: string): int {
  return ifind(haystack, needle)
}

nums=['!', '1', '2', '3', '4', '5', '6', '7', '8', '9']
words=['!', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
// backwards words
sdrow=['!', 'eno', 'owt', 'eerht', 'ruof', 'evif', 'xis', 'neves', 'thgie', 'enin']

answer = 0
line = next_line() while line != null do line = next_line() {
  println line
  number = 0
  bestloc = 99999999
  bestval = 0
  j = 0 while j < 10 do j++ {
    loc = find(line, words[j])
    if loc != -1 and loc < bestloc {
      bestloc = loc
      bestval = j
    }
  }
  j = 0 while j < 10 do j++ {
    loc = find(line, nums[j])
    if loc != -1 and loc < bestloc {
      bestloc = loc
      bestval = j
    }
  }
  number = bestval
  println number
  //bestloc = -1
  //bestval = 0

  line = strrev(line)
  //println line
  //j = 0 while j < 10 do j++ {
    //loc = find(line, sdrow[j])
    //if loc != -1 and loc > bestloc {
      //bestloc = loc
      //bestval = j
    //}
  //}
  //j = 0 while j < 10 do j++ {
    //loc = find(line, nums[j])
    //if loc != -1 and loc > bestloc {
      //bestloc = loc
      //bestval = j
    //}
  //}
  // now that it's reversed, just do the same thing
  bestloc = 99999999
  bestval = 0
  j = 0 while j < 10 do j++ {
    loc = find(line, sdrow[j])
    if loc != -1 and loc < bestloc {
      bestloc = loc
      bestval = j
    }
  }
  j = 0 while j < 10 do j++ {
    loc = find(line, nums[j])
    if loc != -1 and loc < bestloc {
      bestloc = loc
      bestval = j
    }
  }

  number=number*10+bestval
  //print ": " println number
  answer = answer + number
}

print "Part 2: " println answer
