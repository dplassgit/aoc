// test this with other inputs, e.g.,
// data = 'foo\nbar'
data = input
//data="vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\n"
//data="wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw\n"

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

process_group: proc(group:string[]): int {
  // find the character that is in all 3 groups
  vals0:bool[255]
  vals1:bool[255]
  vals2:bool[255]
  line = group[0]
  i = 0 while i < length(line) do i = i + 1 {
    ch = asc(line[i])
    vals0[ch] = true
  }
  line = group[1]
  i = 0 while i < length(line) do i = i + 1 {
    ch = asc(line[i])
    vals1[ch] = true
  }
  line = group[2]
  i = 0 while i < length(line) do i = i + 1 {
    ch = asc(line[i])
    vals2[ch] = true
  }
  i = 0 while i < 255 do i = i + 1 {
    if vals0[i] and vals1[i] and vals2[i] {
      // this is the dup
      if i >= asc('a') and i <= asc('z') {
        // lower case
        return i - asc('a') + 1
      } else {
        // upper case
        return i - asc('A') + 27
      }
    }
  }
  exit 'sorry'
}

// Find the item type that corresponds to the badges of each three-Elf group. What is the sum of the priorities of those item types?
sum = 0
line = next_line() while line != null {
  mygroup:string[3]
  mygroup[0] = line
  mygroup[1] = next_line()
  mygroup[2] = next_line()
  sum = sum + process_group(mygroup)
  line = next_line()

}
println sum
