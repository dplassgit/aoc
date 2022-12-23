import {readFileSync} from 'fs';

const data = readFileSync('day6.txt', 'utf-8');

/*
 * turn on 0,0 through 999,999 would turn on (or leave on) every light.
 * toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
 * turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
 */
const lights = new Set<String>();

let part1 = 0;
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
      const point = `${row},${col}`;
      if (job == 0) {
        // turn off
        lights.delete(point);
      } else if (job == 1) {
        lights.add(point);
      } else {
        if (lights.has(point)) {
          lights.delete(point);
        } else {
          lights.add(point);
        }
      }

    }
  }
}
);

console.log(lights.size);
