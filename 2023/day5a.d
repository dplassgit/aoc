////////////////////////////////////////////////////
// Read data all at once
////////////////////////////////////////////////////
global_data = input

next_line_loc = 0

// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc: string {
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

countSplitParts: proc(s: string, div: string): int {
  j = 0 i = 0 while i < length(s) do i = i + 1 {
    if s[i] == div {
      j = j + 1
    }
  }
  return j
}


////////////////////////////////////////////////////
// SPLIT
////////////////////////////////////////////////////
split_space: proc(s: string): string[] {
  return split(s, ' ')
}

split: proc(s: string, div: string): string[] {
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


////////////////////////////////////////////////////
// LIST
////////////////////////////////////////////////////

DValue:record { // your data here
  value:long[3]
}
DEntry:record { value: DValue next: DEntry }
DList:record { head:DEntry }

printList: proc(list: DList) {
  tail = list.head while tail != null do tail = tail.next {
    print tail.value.value
    if tail.next != null {
      print ", "
    }
  }
  println ""
}

append: proc(list: DList, value: DValue): DList {
  // 1. Find tail
  // 2. Add new tail
  newtail = new DEntry
  newtail.value = value
  if list.head == null {
    // no tail
    list.head = newtail
    return list
  }

  tail = list.head while tail.next != null do tail = tail.next {
  }
  // tail is really the tail
  tail.next = newtail
  return list
}

arr2DValue: proc(v:long[]): DValue {
  dval = new DValue
  dval.value = v
  return dval
}


////////////////////////////////////////////////////
// STRINGS AND NUMBERS
////////////////////////////////////////////////////

atol: extern proc(s: string): long


////////////////////////////////////////////////////
// DAY 5 part 2 CODE HERE
////////////////////////////////////////////////////


maps: DList[7]
i=0 while i < 7 do i++ {
  maps[i] = new DList
}

line = next_line() 

seeds_str = split_space(line)
// throw away the first
seeds: long[length(seeds_str) - 1]
i = 0 while i < length(seeds) do i++ {
  seeds[i] = atol(seeds_str[i+1])
}
print "Seeds: "
println seeds

line=next_line()

i = 0
line = next_line() while line != null do line = next_line() {
  if i == 8 {
    break
  }
  println line
  if length(line) == 0 {
    println "^ empty line"
    i++
    continue
  }
  first = asc(line[0])-48
  if not (first >= 0 and first <= 9) {
    //  skip headers
    println "^ Header"
    continue
  }
  cur:DList
  cur=maps[i]
  datum_str = split_space(line)
  datum:long[3]
  datum[0] = atol(datum_str[0])
  datum[1] = atol(datum_str[1])
  datum[2] = atol(datum_str[2])
  println datum
  append(cur, arr2DValue(datum))
}

i=0 while i < 7 do i++ {
  printList(maps[i])
}

traverse: proc(seed: long): long {
  j=0 while j < 7 do j++ {
    m=maps[j]
    tail = m.head while tail != null do tail = tail.next {
        range = tail.value.value
        dest = range[0]
        source = range[1]
        len= range[2]
        if seed >= source and seed < source+len{
            //# Found it
            seed = dest + (seed - source)
            break
        }
    }
  }
  return seed
}


answer=-1L
i = 0 while i < length(seeds) do i++ {
  seed = seeds[i]
  loc = traverse(seed)
  print "Loc of " print seed print " is " println loc
  if answer == -1L or loc < answer {
    answer = loc
  }
}


print "Part 1: " println answer
