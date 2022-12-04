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

//println "splitting a,b,c:" println split("a,b,c", ",")
//println "splitting a,b,:" println split("a,b,", ",")
//println "splitting a:" println split("a", ",")
//println "splitting a, b, c:" println split("a, b, c", ",")

// This prints each line
// x = next_line() while x != null do x = next_line() {
//    println x
// }
