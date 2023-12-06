////////////////////////////////////////////////////
// Read data all at once
////////////////////////////////////////////////////
global_data = input

next_line_loc = 0
reset_input: proc() {
  next_line_loc = 0
}

// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc: String {
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


////////////////////////////////////////////////////
// SPLIT
////////////////////////////////////////////////////

count_split_parts: proc(s: string, div: string): int {
  adiv = asc(div)
  part_count = 0 

  indiv = false // are we in a divider?
  i = 0 while i < length(s) do i++ {
    ach = asc(s[i])
    if ach != adiv and indiv {
      // we need a new one
      part_count++
    }
    indiv = ach == adiv
  }
  if not indiv {
    part_count++
  }
  return part_count
}

split: proc(s: string, div: string): string[] {
  s = trim(s)
  parts: string[count_split_parts(s, div)]
  adiv = asc(div)

  part_count = 0
  indiv = false // are we in a divider?
  part = ''
  i = 0 while i < length(s) do i++ {
    ch = s[i]
    if asc(ch) != adiv {
      if indiv and part != '' {
        // we need a new one
        parts[part_count] = part
        part_count++
        part = ''
      }
      part = part + ch
    }
    indiv = asc(ch) == adiv
  }
  if part != '' {
    parts[part_count] = part
  }
  return parts
}

trim: proc(s: string): string {
  i = 0 while s[i] == ' ' and i < length(s) do i++ {}
  j = length(s) - 1 while (s[j] == ' ' or s[j] == '\n') and j >= 0 do j-- {}
  if i == 0 and j == length(s) - 1 {
    return s
  }
  out = ''
  // This isn't super efficient because D doesn't free
  k = i while k <= j do k++ {out = out + s[k]}
  return out 
}


////////////////////////////////////////////////////
// SET
////////////////////////////////////////////////////
DSet: record {
  buckets:DList[29]
}

PRIMES = [2,3,5,7,11]
hashCode: proc(value: string): int {
  hash = 17 + length(value)
  i = 0 while i < length(value) do i = i + 1 {
    ch = value[i]
    hash = hash + asc(ch) * PRIMES[i%5]
  }
  return hash
}

addToSet: proc(set: DSet, value: string): bool {
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
  push(bucket, string2DValue(value))
  return false
}

removeFromSet: proc(set: DSet, value: string): bool {
  hash = hashCode(value)
  hash = hash % length(set.buckets)
  bucket = set.buckets[hash]
  if not listContains(bucket, value) {
    // not there
    return false
  }

  // remove it from the bucket (!)
  removeFromList(bucket, value)
  return true
}

setContains: proc(set: DSet, value:string): bool {
  hash = hashCode(value)
  hash = hash % length(set.buckets)
  bucket = set.buckets[hash]
  return listContains(bucket, value)
}

// a list of all values in the set
allSetValues: proc(set: DSet): DList {
  list = new DList
  i = 0 while i < length(set.buckets) do i = i + 1 {
    b = set.buckets[i]
    if b == null {
      continue
    }
    h = b.head while h != null do h = h.next {
      // add each one
      append(list, h.value)
    }
  }
  return list
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


////////////////////////////////////////////////////
// LIST
////////////////////////////////////////////////////

DValue:record { // your data here
  value:string
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


////////////////////////////////////////////////////
// STRINGS AND NUMBERS
////////////////////////////////////////////////////

// return substring(i1 to end)
substring: proc(s: string, start: int): string {
  ns = ''
  i = start while i < length(s) do i = i + 1 {
    ns = ns + s[i]
  }
  return ns
}

atoi: extern proc(s: string): int
abs: proc(i: int): int { if i < 0 { return -i } return i }


////////////////////////////////////////////////////
// DAY XX CODE HERE
////////////////////////////////////////////////////

answer = 0
line = next_line() while line != null do line = next_line() {
  println line
}

print "Part 1: " println answer
