// test this with other inputs, e.g.,
// data = 'foo\nbar'
data = input
// data="vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\n"
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

process_line: proc(line: string): bool[] {
  vals:bool[255]
  i = 0 while i < length(line) do i = i + 1 {
    ch = asc(line[i])
    vals[ch] = true
  }
  return vals
}

priority: proc(group:string[]): int {
  // find the character that is in all 3 groups
  vals0=process_line(group[0])
  vals1=process_line(group[1])
  vals2=process_line(group[2])
  ch = 0 while ch < 256 do ch = ch + 1 {
    if vals0[ch] and vals1[ch] and vals2[ch] {
      // this is the dup
      if ch >= asc('a') and ch <= asc('z') {
        // lower case
        return ch - asc('a') + 1
      } else {
        // upper case
        return ch - asc('A') + 27
      }
    }
  }
  exit 'sorry'
}

// Find the item type that corresponds to the badges of each three-Elf group. What is the sum of the priorities of those item types?
sum = 0
line = next_line() while line != null {
  group:string[3]
  group[0] = line
  group[1] = next_line()
  group[2] = next_line()
  sum = sum + priority(group)
  line = next_line()

}
println sum
