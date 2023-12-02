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

answer = 0
line = next_line() while line != null do line = next_line() {
  number = 0
  i = 0 while i < length(line) do i++ {
    c = line[i]
    if c >= '0' and c <= '9' {
      number = asc(c)-asc('0')
      break
    }
  }
  number=number*10
  i = length(line)-1 while i >= 0 do i-- {
    c = line[i]
    if c >= '0' and c <= '9' {
      number = number + asc(c)-asc('0')
      break
    }
  }
  answer = answer + number
}

print "Part 1: " println answer
