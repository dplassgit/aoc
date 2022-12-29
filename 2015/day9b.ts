import {readFileSync} from 'fs';

const data = readFileSync('day9.txt', 'utf-8');
const lines = data.split('\n');

const nodes = new Map<string, number>();
const names = new Map<number, string>();
// key = from|to value=distance
const edges = new Map<number, number>();
lines.forEach((line) => {
  if (line.length == 0) {
    return;
  }
  const parts = line.split(' ');
  const from = parts[0];
  let fromInt;
  if (!nodes.has(from)) {
    fromInt = 1<<nodes.size 
    names.set(fromInt, from);
    nodes.set(from, fromInt);
  } else {
    fromInt = nodes.get(from);
  }
  const to = parts[2];
  let toInt;
  if (!nodes.has(to)) {
    toInt = 1<<nodes.size 
    names.set(toInt, to);
    nodes.set(to, toInt);
  } else {
    toInt = nodes.get(to);
  }

  const dist = parseInt(parts[4]);
  edges.set(toInt|fromInt, dist)
});
console.log(nodes);
console.log(edges);
const maxcode = 1<<nodes.size;
const all = maxcode-1;

function dfs(here:number, sofar:number, distancetohere:number): number {
  if (sofar == all) {
    return distancetohere;
  }
  // see which of the unused cities to pick next would work best
  let best = -1;
  for (var city = 1; city < maxcode; city = city * 2) {
    if ((sofar & city) == 0) {
      // not seen
      const thisdist = edges.get(here | city);
      const totaldist = dfs(city, sofar|city, distancetohere+thisdist);
      best = Math.max(best, totaldist);
    }
  }
  return best;
}


let part1 = -1;
for (var city = 1; city < maxcode; city = city * 2) {
  const fromhere=dfs(city, city, 0);
  console.log("best starting at " + names.get(city) + " is " + fromhere);
  part1 = Math.max(part1, fromhere);
}
console.log(part1);
