// test this with other inputs, e.g.,
global_data = 'foo,bar'
// global_data=input

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
    println tail.value.value
  }
}

makeDValue: proc(v:string):DValue {
  dval = new DValue
  dval.value = v
  return dval
}

//list = new DList
//append(list, makeDValue("hi"))
//printList(list) println "-"
//push(list, makeDValue("first"))
//printList(list) println "-"
//append(list, makeDValue("bye"))
//printList(list) println "-"
//pop(list)
//printList(list) println "-"

//println "splitting a,b,c:" println split("a,b,c", ",")
//println "splitting a,b,:" println split("a,b,", ",")
//println "splitting a:" println split("a", ",")
//println "splitting a, b, c:" println split("a, b, c", ",")

// This prints each line
// x = next_line() while x != null do x = next_line() {
//    println x
// }
