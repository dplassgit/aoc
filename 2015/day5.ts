/*
 * It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
 * It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
 * It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
*/

import {readFileSync} from 'fs';

const data = readFileSync('day5.txt', 'utf-8');


const BADS = ['ab', 'cd', 'pq', 'xy'];
function nice(s:string):boolean {
  const vowels = s.match(/.*[aeiou].*[aeiou].*[aeiou].*/)
  if (!vowels) {
    return false;
  }
  for (var i = 0; i < BADS.length; ++i) {
    if (s.indexOf(BADS[i]) != -1) {
      return false;
    }
  }
  // see if it contains double letters
  for (var i = 1; i < s.length; ++i) {
    if (s[i] == s[i-1]) {
      return true;
    }
  }
  return false;
}

const lines = data.split("\n");
let part1 = 0;
lines.forEach(function (line) { const is = nice(line); if (is) part1++;});
console.log(part1);

let part2 = 0;
lines.forEach(function (line) { 
  const xyxy = line.match(/.*(..).*\1/); 
  if (!xyxy) return;
  const zxz = line.match(/.*(.).\1.*/);
  if (!zxz) return;
  part2++;
});
console.log(part2);
