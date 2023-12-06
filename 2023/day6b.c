#include <stdio.h>

void main() {
  long answer = 1L;
  long long time = 46689866L;
  long long dist = 358105418071080L;
  long wins = 0L;
  long long t = 1L;
  while (t < time) {
    //# if we can win, bump the counter.
    //# for every unit we hold down the thingie 
    //# the speed is that amount.
    long long timeleft = time - t;
    long long speed = t;
    long long ourdist = speed * timeleft;
    if (ourdist > dist) {
      //print "time/speed: " print t print " dist: " print ourdist print " maxdist: " println dist
      //println "^Won!"
      wins++;
    }
    t++;
  }
  answer = wins;

  printf("Day 6: %ld\n", answer);
}
