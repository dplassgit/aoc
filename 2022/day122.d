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
  value: int  // this is the location in the map: x+y*width
}
DEntry:record { value: DValue next:DEntry}
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

removeFromList: proc(list: DList, target: int):bool {
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


listContains: proc(list:DList, value: int): bool {
  if list == null {
    return false
  }
  return listEntryContains(list.head, value) 
}

listEntryContains: proc(head:DEntry, value: int): bool {
  if head == null {
    return false
  }
  if head.value.value == value {
    return true
  }
  return listEntryContains(head.next, value)
}

width=0
height=0
line=next_line() while line != null do line = next_line() {
  if width == 0 { width = length(line)}
  height = height + 1
}

reset_input()
map:int[width*height]
dist:int[width*height]
inq:bool[width*height]
seen:bool[width*height]

j=0
startx=0
starty=0
endx=0
endy=0
line=next_line() while line != null do line = next_line() {
  i = 0 while i < width do i = i + 1 {
    spot = asc(line[i])
    if spot == asc('S') {
      startx=i
      starty=j
      print "start at " print startx print ',' println starty
      spot = asc('a')
    } elif spot == asc('E') {
      endx=i
      endy=j
      print "end at " print endx print ',' println endy
      spot = asc('z')
    }
    map[i+j*width] = spot - asc('a')
  }
  j = j + 1
}

INFINITY=100000000

printArr: proc(arr:int[]) {
  j = 0 while j < height do j = j + 1 {
    i = 0 while i < width do i = i + 1 {
      loc = i + j * width
      if arr[loc] == INFINITY { 
        print "inf "
      } else {
        print arr[loc] print " "
      }
    }
    println ""
  }
}
printArr(map)



processNeighbor2: proc(q:DList, uvalue: DValue, dx: int, dy: int) {
  // go back from u to x, y
  u = uvalue.value
  y = u/width
  x = u % width
  vx = x + dx
  vy = y + dy
  if vx >= 0 and vx < width and vy >= 0 and vy < height {
    // we're on the board
    v = vx + vy * width
    oldheight = map[u]
    newheight = map[v]
    if map[v] == map[u] or map[v] - map[u] == 1 or map[v] < map[u] {
      if not seen[v] {
        // not processed before
        old_cost = dist[v]
        new_cost = dist[u] + 1
        if new_cost < old_cost {
          qvalue = new DValue
          qvalue.value = v
          append(q, qvalue)
          dist[v] = new_cost
        }
      }
    }
  }
}

endloc = endx + endy*width
print "Startloc " println (startx + starty*width)
print "Endloc " println endloc

bfs:proc {
  q=new DList
  j = 0 while j < height do j = j + 1 {
    i = 0 while i < width do i = i + 1 {
      vloc = i + j*width
      if map[vloc] == 0 {// all 'a's are good
        qvalue = new DValue
        qvalue.value = vloc
        append(q, qvalue)
        dist[vloc] = 0
      } else {
        dist[vloc] = INFINITY
      }
    }
  }


  while q.head != null {
    v = pop(q)
    if seen[v.value] {
      continue
    }
    if v.value == endloc {
      break
    }
    seen[v.value] = true

    processNeighbor2(q, v, -1, 0)
    processNeighbor2(q, v, 1, 0)
    processNeighbor2(q, v, 0, -1)
    processNeighbor2(q, v, 0, 1)
//    println "Queue is now " printList(q)
 //   println "Dist is now" 
 //   printArr(dist)
  }
}

bfs()
println "After"
printArr(dist)
print "Part 2: " print dist[endx + endy*width]
