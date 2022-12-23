import {readFileSync} from 'fs';

const data = readFileSync('day6.txt', 'utf-8');

/*
 * turn on 0,0 through 999,999 would turn on (or leave on) every light.
 * toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
 * turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
 */
const lights = new Map<string, number>();

let part2 = 0;
const lines = data.split('\n');
lines.forEach(function (line) { 
  if (line.length == 0) {
    return;
  }
  const parts = line.split(" ");
  let job = 0;
  let from, to;
  if (parts[0] == 'turn') {
    if (parts[1] == 'on') {
      job = 1;
    }
    from = parts[2];
    to = parts[4];
  } else {
    // toggle
    job = -1;
    from = parts[1];
    to = parts[3];
  }
  const startCol = parseInt(from.split(',')[0]);
  const startRow = parseInt(from.split(',')[1]);
  const endCol = parseInt(to.split(',')[0]);
  const endRow = parseInt(to.split(',')[1]);
  console.log(`from ${startCol},${startRow} to ${endCol},${endRow}`);

  for (var row = startRow; row <= endRow; ++row) {
    for (var col = startCol; col <= endCol; ++col) {
      const key = `${row},${col}`;
      const hasit = lights.has(key);
      if (job == 0) {
        // turn down
        if (!hasit) {
          // do nothing
        } else {
          const value = lights.get(key);
          if (value == 1) {
            lights.delete(key);
          } else if (value > 0) {
            lights.set(key, value - 1);
          }
        }
      } else if (job == 1) {
        // turn up
        if (!hasit) {
          lights.set(key, 1);
        } else {
          const value = lights.get(key);
          lights.set(key, value + 1);
        }
      } else {
        // toggle
        if (!hasit) {
          lights.set(key, 2);
        } else {
          const value = lights.get(key);
          lights.set(key, value + 2);
        }
      }
    }
  }
}
);

for (let val of lights.values()) {
  part2 = part2 + val;
}
console.log(part2);
