atoi: extern proc(s:string):int

// test this with other inputs, e.g.,
// global_data = 'foo,bar'
 global_data=input
//global_data='bvwbjplbgvbhsrlpgdmjqwftvncz\n' // : first marker after character 5
//global_data='nppdvjthqldpwncqszvftbrmjlhg\n' // : first marker after character 6
//global_data='nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg\n' // : first marker after character 29
//global_data='zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw\n' // : first marker after character 11


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

makeDValue: proc(v:string): DValue {
  dval = new DValue
  dval.value = v
  return dval
}

unique: proc(list: DList):bool {
  used:bool[26]
  // if all 14 elements are unique, return true
  h = list.head
  i = 0 while i < 14 do i = i + 1 {
    ch = asc(h.value.value)- asc('a')
    if used[ch] {
      println " found twice: " + h.value.value
      return false
    }
    used[ch] = true
    h = h.next
  }
  return true

}

line = next_line()
list = new DList
i = 0 while i < 14 do i = i + 1 {
  append(list, makeDValue(line[i]))
}

while i < length(line) do i = i + 1 {
  printList(list)

  if unique(list) {
    print "Answer: " println i
    break
  } else {
    pop(list)
    append(list, makeDValue(line[i]))
  }
}
