atoi: extern proc(s:string):int

// test this with other inputs, e.g.,
// global_data = 'foo\nbar\n'
global_data=input

next_line_loc=0

reset_input: proc() {
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

split_space: proc(s:string): string[] {
  return split(s, ' ')
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


X=1
clock=1

// find 20, 60, 100 , 140, 220
target=20
part1 = 0
instr = next_line() while instr != null do instr = next_line() {
  xatstart=X
  clockatstart=clock
  parts = split_space(instr)
  if parts[0] == 'noop' {
    clock = clock + 1
  } elif parts[0] == 'addx' {
    X = X + atoi(parts[1])
    clock = clock + 2
  }
//  print "After " + instr + ", clock=" print clock print ", X= " println X
  if clockatstart <= target and clock > target {
    part1 = part1 + target * xatstart
    print "During target " print target print "X was " println xatstart
    target = target + 40
  }
}

print "Part1: " println part1
