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

priority: proc(line: string): int {
  // true if seen. just use the ascii value beause i'm lazy
  vals:bool[255]

  // Lowercase item types a through z have priorities 1 through 26.
  // Uppercase item types A through Z have priorities 27 through 52.

  i = 0 while i < 255 do i = i + 1 {vals[i] = false}
  half = length(line) / 2
  i = 0 while i < half do i = i + 1 {
    ch = asc(line[i])
    vals[ch] = true
  }
  i = half while i < length(line) do i = i + 1 {
    ch2 = asc(line[i])
    if vals[ch2] {
      // found a duplicate
      print "Found duplicate: " println line[i]
      if ch2 >= asc('a') and ch2 <= asc('z') {
        // lower case
        return ch2 - asc('a') + 1
      } else {
        // upper case
        return ch2 - asc('A') + 27
      }

    }
  }
  return 0
}

// Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?

sum = 0
line = next_line() while line != null do line = next_line() {
  sum = sum + priority(line)
}
println sum
