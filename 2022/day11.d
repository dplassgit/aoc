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

abs: proc(i:int):int { if i < 0 { return -i } return i }


////////////////////////////////////////////////////
// LIST
////////////////////////////////////////////////////

DValue:record { // your data here
  value:string
}
DEntry:record { value: DValue next:DEntry}
DList:record { head:DEntry }

printList: proc(list: DList) {
  if list == null {
    return
  }
  tail = list.head while tail != null do tail = tail.next {
    print tail.value.value
    if tail.next != null {
      print ", "
    }
  }
  println ""
}

push: proc(list: DList, value: DValue): DList {
  e = new DEntry
  e.value = value
  e.next = list.head
  list.head = e
  return list
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

pop: proc(list: DList): DValue {
  if list.head == null {
    exit "head of list is null"
  }
  value = list.head.value
  list.head = list.head.next
  return value
}

head: proc(list: DList): DValue {
  if list.head == null {
    exit "head of list is null"
  }
  return list.head.value
}

removeFromList: proc(list: DList, target: string):bool {
  h = list.head
  if h == null {
    return false
  }
  if h.value.value == target {
    // need to change head
    list.head = h.next
    return true
  } else {

    while h != null do h = h.next {
      next = h.next
      if next == null {
        return false
      }
      if next.value.value == target {
        // found it.
        h.next = next.next
        return true
      }
    }
  }
  return false
}

// NOTE: if v is mutable, consider making a copy before
// making the DValue
string2DValue: proc(v:string): DValue {
  dval = new DValue
  dval.value = v
  return dval
}

listContains: proc(list:DList, value: string): bool {
  if list == null {
    return false
  }
  return listEntryContains(list.head, value) 
}

listEntryContains: proc(head:DEntry, value: string): bool {
  if head == null {
    return false
  }
  if head.value.value == value {
    return true
  }
  return listEntryContains(head.next, value)
}


///
// SUBSTRING
//

// return substring(i1 to end)
toend: proc(s:string, i1: int):string {
  ns = ''
  i = i1 while i < length(s) do i = i + 1 {
    ns = ns + s[i]
  }
  return ns
}

part1=0

ADD=asc('+')
MULT=asc('*')
SQUARE=asc('^')
Monkey:record {
  num: int
  items: DList         
  operation: int
  factor: int
  test: int
  toTrue: int // monkey number to throw to if true
  toFalse: int // monkey number to throw to if true
}

//Monkey 0:
//  Starting items: 79, 98
//  Operation: new = old * 19
//  Test: divisible by 23
//    If true: throw to monkey 2
//    If false: throw to monkey 3
processMonkey: proc(i:int): Monkey {
  m = new Monkey
  m.num = i
  m.items = new DList
  if next_line() == null {
    return null
  }
  items = next_line()
  items2 = toend(items, 18)
  parts = split(items2, ",")
  j = 0 while j < length(parts) do j = j + 1 {
    push(m.items, string2DValue(parts[j]))
  }

  operation = next_line()
  parts = split_space(operation)
  len = length(parts)
  m.operation = asc(parts[len - 2])
  if parts[len-1] == 'old' {
    m.operation = SQUARE
  } else {
    m.factor = atoi(parts[length(parts)-1])
  }

  test = next_line()
  parts = split_space(test)
  m.test = atoi(parts[length(parts)-1])

  iftrue = next_line()
  parts = split_space(iftrue)
  m.toTrue = atoi(parts[length(parts)-1])

  iffalse = next_line()
  parts = split_space(iffalse)
  m.toFalse = atoi(parts[length(parts)-1])

  next_line() // blank
  return m
}


printMonkey: proc(m: Monkey) {
  print "Monkey " println m.num
  print "  Items: " printList(m.items)
  print "  Operation: new = old " print chr(m.operation) print " " println m.factor
  print "  Test: divible by " println m.test
  print "    If true: throw to monkey " println m.toTrue
  print "    If false: throw to monkey " println m.toFalse
}

monkeys:Monkey[8]

i = 0
while true do i = i + 1 {
  m = processMonkey(i)
  if m==null { break}
  monkeys[i] = m
  printMonkey(monkeys[i])
}

print "Part 1: " println part1

//s = new DSet
//print "Should be false: " println setContains(s, 'hi')
//print "Should be false: " println addToSet(s, 'hi')
//printSet(s)
//printList(allSetValues(s))
//removeFromSet(s, 'ab')
