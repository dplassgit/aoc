// Writtten in the same style as the c version, for fun.
main:proc {
  answer = 1L
  time = 46689866L
  dist = 358105418071080L
  wins = 0L
  t = 1L 
  while t < time {
    //# if we can win, bump the counter.
    //# for every unit we hold down the thingie 
    //# the speed is that amount.
    timeleft = time - t
    speed = t
    ourdist = speed * timeleft
    if ourdist > dist {
      //print "time/speed: " print t print " dist: " print ourdist print " maxdist: " println dist
      //println "^Won!"
      wins++
    }
    t++
  }
  answer = wins

  print "Day 6: " println answer
}

main()
