// test this with other inputs, e.g.,
// global_data = 'foo,bar'
global_data=input


loc=0
// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc(): String {
  line = ''
  len=length(global_data)
  while loc < len {
    ch = global_data[loc]
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

count: proc(s:string, div:string): int {
  j = 0
  i = 0 while i < length(s) do i = i + 1 {
    if s[i] == div {
      j = j + 1
    }
  }
  return j
}

split: proc(s:string, div:string): string[] {
  parts:string[count(s, div) + 1]
  j = 0
  sofar = ''
  i = 0 while i < length(s) do i = i + 1 {
    ch = s[i]
    if ch == div {
      // found another one
      parts[j] = sofar
      j = j + 1
      sofar = ''
    } else {
      sofar = sofar + ch
    }
  }
  parts[j] = sofar
  j = j + 1
  return parts
}

atoi: extern proc(s:string): int

parse: proc(s:string[]): int[] {
  result:int[2]
  i = 0 while i < 2 do i = i + 1 {
    result[i] = atoi(s[i])
  }
  return result
}

covers: proc(s:string): bool {
  es = split(s, ',')
  r1 = split(es[0], '-')
  r2 = split(es[1], '-')
  range1=parse(r1)
  range2=parse(r2)
  return (range1[0] <= range2[0] and range1[1] >= range2[1]) OR 
     (range2[0] <= range1[0] and range2[1] >= range1[1]) 
}

any_covers: proc(s:string): bool {
  es = split(s, ',')
  r1 = split(es[0], '-')
  r2 = split(es[1], '-')
  range1=parse(r1)
  print "range1: " println range1
  range2=parse(r2)
  print "range2: " println range2
  return 
     (range2[0] <= range1[0] and range1[0] <= range2[1]) OR 
     (range2[0] <= range1[1] and range1[1] <= range2[1]) OR 
     (range1[0] <= range2[0] and range2[0] <= range1[1]) OR 
     (range1[0] <= range2[1] and range2[1] <= range1[1])
}

part1: proc {
  covered = 0
  x = next_line() while x != null do x = next_line() {
    if covers(x) {
      covered = covered + 1
    } else {
    }
  }
  print "part1: " println covered
}

part2: proc {
  covered = 0
  x = next_line() while x != null do x = next_line() {
    if any_covers(x) {
      println x + " is covered"
      covered = covered + 1
    } else {
      println x + " is not covered"
    }
  }
  print "part2: " println covered
}

part1()
loc = 0 // reset
part2()


