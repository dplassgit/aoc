atoi: extern proc(s:string):int

// test this with other inputs, e.g.,
// global_data = 'foo\nbar\n'
global_data=input

next_line_loc=0

reset_input: proc() {
  next_line_loc = 0
}

// Get the next line. Returns null at EOF. NOTE: LAST LINE MUST END WITH \n
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


////////////////////////////////////////////////////
// SET
////////////////////////////////////////////////////
DSet: record {
  buckets: DList[29]
}

PRIMES = [13, 17, 2, 3, 5, 7, 11]
hashCode: proc(value: int[]): int {
  hash = 17 + length(value)
  i = 0 while i < length(value) do i = i + 1 {
    ch = value[i]
    hash = hash + abs(ch * PRIMES[i % 2])
  }
  if hash < 0 {
    print "negative hash of " print hash print " for: " println value
    exit "sorry"
  }
  return hash
}

addToSet: proc(set: DSet, value: int[]): bool {
  hash = hashCode(value)
  hash = hash % length(set.buckets)
  bucket = set.buckets[hash]
  if listContains(bucket, value) {
    // already there
    return true
  }
  if bucket == null {
    sb = set.buckets
    bucket = new DList
    sb[hash] = bucket
  }

  // put it in the head of the list.
  push(bucket, arr2DValue(value))
  return false
}

printSet: proc(set: DSet) {
  i = 0 while i < length(set.buckets) do i = i + 1 {
    print "bucket[" print i print "]: "
    b = set.buckets[i]
    if b != null {
      printList(b)
    } else {
      println ""
    }
  }
}

setSize: proc(set: DSet):int {
  size = 0
  i = 0 while i < length(set.buckets) do i = i + 1 {
    b = set.buckets[i]
    if b != null {
      size = size + listSize(b)
    }
  }
  return size
}


////////////////////////////////////////////////////
// LIST
////////////////////////////////////////////////////

DValue:record { // your data here
  value:int[2]
}
DEntry:record { dvalue: DValue next:DEntry}
DList:record { head:DEntry }

printList: proc(list: DList) {
  tail = list.head while tail != null do tail = tail.next {
    print tail.dvalue.value
    if tail.next != null {
      print ", "
    }
  }
  println ""
}

push: proc(list: DList, value: DValue): DList {
  e = new DEntry
  e.dvalue = value
  e.next = list.head
  list.head = e
  return list
}

arr2DValue: proc(v:int[]): DValue {
  dval = new DValue
  dup:int[2]
  copy(v, dup)
  dval.value = dup
  return dval
}

listContains: proc(list:DList, value: int[]): bool {
  if list == null {
    return false
  }
  return listEntryContains(list.head, value)
}

listEntryContains: proc(head:DEntry, value: int[]): bool {
  if head == null {
    return false
  }
  if head.dvalue.value == value {
    return true
  }
  return listEntryContains(head.next, value)
}

listSize: proc(list:DList): int {
  size = 0
  tail = list.head while tail != null do tail = tail.next {
    size = size + 1
  }
  return size
}


// DAY 9

left=-10
right=10
top=10
bottom=-10
d9head=[0,0]
last_head=[0,0]
d9tail=[0,0]

Y=0
X=1

tailspots=new DSet
recordtail:proc() {
  addToSet(tailspots, d9tail)
}
recordtail()

abs: proc(i:int):int {
  if i < 0 { return -i }
  return i
}

xdist:proc:int {
  return abs(d9head[X]-d9tail[X])
}

ydist:proc:int {
  return abs(d9head[Y]-d9tail[Y])
}

needToMoveTail:proc:bool {
  // only need to move if more than 2 away
  return not (xdist() <= 1 and ydist() <= 1)
}

copy:proc(from:int[], to:int[]) {
  to[0] = from[0]
  to[1] = from[1]
}

maybeMoveTail: proc {
  //print "head now: " println d9head
  //print "tail was: " println d9tail
  if needToMoveTail() {
      //print "moving tail to last head" println last_head
      copy(last_head, d9tail)
      recordtail()
  }
}


visualize:proc {
  println ""
  y = top -1 while y > bottom do y = y - 1 {
    x = left while x < right do x = x + 1 {
      if d9head[X] == x and d9head[Y] == y { print "H" }
      elif d9tail[X]==x and d9tail[Y] == y { print "T" }
      else { print "." }
    }
    println ""
  }
}

i = 0
line = next_line() while line != null do line = next_line() {
  parts = split(line, ' ')
  dir = parts[0]
  count = atoi(parts[1])
  if dir == 'U' {
    i = 0 while i < count do i = i + 1 {
      copy(d9head, last_head)
      d9head[Y] = d9head[Y] + 1
      maybeMoveTail()
    }
  }
  elif dir == 'D' {
    i = 0 while i < count do i = i + 1 {
      copy(d9head, last_head)
      d9head[Y] = d9head[Y] - 1
      maybeMoveTail()
    }
  }
  elif dir == 'L' {
    i = 0 while i < count do i = i + 1 {
      copy(d9head, last_head)
      d9head[X] = d9head[X] - 1
      maybeMoveTail()
    }
  }
  elif dir == 'R' {
    i = 0 while i < count do i = i + 1 {
      copy(d9head, last_head)
      d9head[X] = d9head[X] + 1
      maybeMoveTail()
    }
  }
  // visualize()
}

// printSet(tailspots)
Print "Part1: " println setSize(tailspots)


