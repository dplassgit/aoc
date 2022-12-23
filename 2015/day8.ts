import {readFileSync} from 'fs';

/*
 * "" is 2 characters of code (the two double quotes), but the string contains zero characters.
 * "abc" is 5 characters of code, but 3 characters in the string data.
 * "aaa\"aaa" is 10 characters of code, but the string itself contains six "a" characters and a single, escaped quote character, for a total of 7 characters in the string data.
 * "\x27" is 6 characters of code, but the string itself contains just one - an apostrophe ('), escaped using hexadecimal notation.
*/

const data = readFileSync('day8.txt', 'utf-8');

const lines = data.split('\n');

/* the number of characters of code for string literals minus the number of characters in memory for the values of the strings */
let part1 = 0;
lines.forEach(function (line) { 
  if (line.length == 0) return;
  console.log("Before: " + line);
  const ondisk = line.length;
  line = line.replace(/\\\\/g, "|"); // slash
  line = line.replace(/\\'/g, "t"); // don't replace with tick becaues it may double-unescape
  line = line.replace(/\\"/g, "t"); // doesn't matter
  line = line.replace(/\\x[a-f0-9][a-f0-9]/g, '9');  // doesn't matter
  console.log("After: " + line);
  const inmemory = line.length - 2;
  console.log("ondisk: " + ondisk + " inmemory: " + inmemory);
  part1 = part1 + (ondisk - inmemory);
  // subtract 2
});
console.log(part1);

