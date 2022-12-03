// test this with other inputs, e.g.,
// data = 'foo\nbar'
data=input

loc=0

// Get the next line. Returns null at EOF.
// NOTE: LAST LINE MUST END WITH \n
next_line: proc(): String {
  line = ''
  len=length(data)
  while loc < len {
    ch = data[loc]
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


normalize:proc(v:string): string {
  if v == 'A'{ return 'r'}
  if v == 'B'{ return 'p'}
  if v == 'C'{ return 's'}
  if v == 'X'{ return 'r'}
  if v == 'Y'{ return 'p'}
  if v == 'Z'{ return 's'}
  return ''
}

iwon:proc(them:string, me:string):int {
  // rock beats scissors
  // paper beats rock
  // scissors beats paper
  print "them: " + them + " me: " + me
  if (them=='r' and me == 's') or (them=='p' and me == 'r') or(them=='s' and me == 'p'){
      // they won
      return 0
  }
  if (me=='r' and them == 's') or (me=='p' and them == 'r') or(me=='s' and them == 'p') {
      // i won
      return 6
  }
  // tie
  return 3
}

score = 0
line = next_line() while line != null do line = next_line() {
  println "Original: " + line
  them = line[0]
  me = line[2]
  result = iwon(normalize(them), normalize(me))
  print "; round result " println result 
  if me == 'X' { result = result + 1 }
  if me == 'Y' { result = result + 2 }
  if me == 'Z' { result = result + 3 }
  score  = score + result
  print "running score " println score
}
println score



