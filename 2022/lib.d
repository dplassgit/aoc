// test this with other inputs, e.g.,
// data = 'foo\nbar'
data=input

loc=0

// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc(): String {
  line = ''
  len=length(data)
  while loc < len {
    ch = data[loc]
    loc = loc + 1
    if ch != '\n' {
      line = line + ch
    } else {
      return line
    }
  }
  // got to eof
  return null
}

// This prints each line
x = next_line() while x != null do x = next_line() {
  println x
}
