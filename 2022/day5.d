// test this with other inputs, e.g.,
//global_data = 'foo,bar'
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

countSplitParts: proc(s:string, div:string): int {
  j = 0
  i = 0 while i < length(s) do i = i + 1 {
    if s[i] == div {
      j = j + 1
    }
  }
  return j
}

split: proc(s:string, div:string): string[] {
  parts:string[countSplitParts(s, div) + 1]
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


DValue:record { // your data here
  value:string
}
DEntry:record { value: DValue next:DEntry}
DList:record { head:DEntry }

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

printList: proc(list: DList) {
  tail = list.head while tail != null do tail = tail.next {
    print tail.value.value
    if tail.next != null {
      print ", "
    }
  }
  println ""
}

makeDValue: proc(v:string):DValue {
  dval = new DValue
  dval.value = v
  return dval
}


// 1. get predefined stacks
stacks:DList[10]
i = 1 while i < 10 do i = i + 1 {
  stacks[i] = new DList
}

x = next_line() while length(x) > 0 do x = next_line() {
 if x[1] == '1' {
   break
 }
 // process left to right
 j=1 i = 1 while i < length(x) do i = i + 4 {
   if x[i] != ' ' {
     append(stacks[j], makeDValue(x[i]))
   }
   j = j + 1
 }
}

i = 1 while i < 10 do i = i + 1 {
  printList(stacks[i])
}

// skip blank
next_line()

atoi: extern proc(s:string):int

process_command: proc(count: int, from:int, to:int) {
  i = 0 while i < count do i = i + 1 {
    val = pop(stacks[from])
    push(stacks[to], val)
  }
}

// 2. process each command
x = next_line() while x != null do x = next_line() {
  command = split(x, " ")
  count = atoi(command[1])
  from = atoi(command[3])
  to = atoi(command[5])
  process_command(count, from, to)
}

println "AFTER:"
i = 1 while i < 10 do i = i + 1 {
  printList(stacks[i])
}

i = 1 while i < 10 do i = i + 1 {
  print(head(stacks[i]).value)
}

