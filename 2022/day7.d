atoi: extern proc(s:string):int

// test this with other inputs, e.g.,
//global_data = 'foo\nbar\n'
global_data=input

next_line_loc=0
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

////////////////////////////////////////////////
// Day 7

Dir: record {
  name: string
  total_direct_child_size: int // sum of files
  total_tree_size: int // includes self
  num_children: int
	children: Dir[15]
	parent: Dir
}

root= new Dir
root.num_children = 0
root.name = '/'

cwd=root

findChild: proc(parent: Dir, target:string): Dir {
  i = 0 while i < parent.num_children do i = i + 1 {
    child = parent.children[i]
    if child.name == target {
      return child
    }
  }
  exit "Could not find child named " + target
}

// $ cd foo
processCd: proc(line:string) {
 parts = split(line, ' ')
 dirname = parts[2]
 print "cding from " + cwd.name 
 if dirname == '..' {
   cwd = cwd.parent
 } elif dirname == '/' {
   cwd = root
 } else {
   // find the child
   cwd = findChild(cwd, dirname)
 }
 println " to " + cwd.name
}


//Format:
// $ ls
// dir a
// 14848514 b.txt
// 8504156 c.dat
// dir d
// $ cd ..

global_line:string
processLs:proc() {
  // the current line is “ls”
  global_line = next_line() while global_line[0] != '$' do global_line = next_line() {
    parts = split(global_line, ' ')
    if asc(parts[0]) == asc('d') {
      println "Adding child directory " + parts[1]  + " to directory " + cwd.name
      // directory
      child = new Dir
      child.name = parts[1]
      child.parent = cwd
      // add child to parent list
      cs = cwd.children
      cs[cwd.num_children] = child
      cwd.num_children = cwd.num_children + 1
    } else {
       // file. Get size, add to parent size.
       fileSize = atoi(parts[0])
       print "Adding " print fileSize println " bytes to directory " + cwd.name
       cwd.total_direct_child_size = cwd.total_direct_child_size + fileSize
    }
  }
}

next_line() // skip "cd /"
global_line = next_line() while global_line != null {
  if global_line == '$ ls' {
    processLs()
  } else {
    processCd(global_line)
    global_line = next_line()
  }
}

// now, calculate size of all directories
// then for each dir greater than 10k, add it

calcSize: proc(d:Dir):int {
  sum = d.total_direct_child_size
  i = 0 while i < d.num_children do i = i + 1 {
    sum = sum + calcSize(d.children[i])
  }
  d.total_tree_size = sum
  print "Size of dir " + d.name + " is " println sum
  return sum
}
calcSize(root)

answer = 0
calcSmallSize: proc(d:Dir) {
  if d.total_tree_size < 100000 {
    answer = answer + d.total_tree_size
  }
  i = 0 while i < d.num_children do i = i + 1 {
    calcSmallSize(d.children[i]) 
  }
}
calcSmallSize(root)
print "Part 1: " println answer

unused = 70000000 - root.total_tree_size
needed = 30000000 - unused

answer = 1000000000
// find the smallest directory bigger than  needed
smallest: proc(d:Dir) {
  it = d.total_tree_size
  if it > needed and it < answer {
    answer = it
  }
  i = 0 while i < d.num_children do i = i + 1 {
    smallest(d.children[i])
  }
}
smallest(root)
print "Part 2: " println answer
