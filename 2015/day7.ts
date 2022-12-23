import {readFileSync} from 'fs';

/*
 *
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i
*/

const data = readFileSync('day7b.txt', 'utf-8');

// map of names to values
const values = new Map<string, number>();

// set of need-to-evaluate entries
const needed = new Map<string, Array<any> >();

const lines = data.split('\n');
lines.forEach(function (line) { 
  if (line.length == 0) return;
  const parts = line.split(" ");
  if (parts.length == 3) {
    const value = parseInt(parts[0]);
    const name = parts[2];
    if (!isNaN(value)) {
      values.set(name, value);
    } else {
      needed.set(name, [parts[0]]);
    }
  } else {
    const name = parts[parts.length-1];
    if (parts[0] == 'NOT') {
      // NOT
      const source = parts[1];
      needed.set(name, ['NOT', source]);
    } else {
      const left = parts[0]
      if (!isNaN(parseInt(left))) {
        // literal.
        values.set(left, parseInt(left));
      }
      const op = parts[1]
      const right = parts[2];
      if (!isNaN(parseInt(right))) {
        // literal.
        values.set(right, parseInt(right));
      }
      needed.set(name, [left, op, right]);
    }
  }
});
console.log(values);
console.log(needed);

while (needed.size > 0) {
  for (let [key, value] of needed) {
    if (value.length == 1) {
      const source = value[0];
      if (values.has(source)) {
        const leftvalue = values.get(source);
        needed.delete(key)
        console.log("top setting " + key + " to " + leftvalue);
        values.set(key, leftvalue);
      }
    } else if (value.length == 2) {
      const source = value[1];
      // NOT
      if (values.has(source)) {
        const leftvalue = values.get(source);
        needed.delete(key)
        console.log("notop setting " + key + " to " + (~leftvalue));
        values.set(key, (~leftvalue+65536));
      }
    } else {
      const left = value[0];
      const right = value[2];
      // get left, get right
      if (values.has(left) && (values.has(right) || !isNaN(parseInt(right)))) {
        const leftvalue = values.get(left);
        let rightvalue = parseInt(right);
        if (isNaN(rightvalue)) {
          rightvalue = values.get(right);
        }
        const op = value[1];
        console.log("setting " + key + " to " + leftvalue + " " + op + " " + rightvalue);
        let newvalue = 0;
        if (op == 'AND') {
          newvalue = leftvalue & rightvalue;
        } else if (op == 'OR') {
          newvalue = leftvalue | rightvalue;
        } else if (op == 'LSHIFT') {
          newvalue = (leftvalue << rightvalue)&65535;
        } else {
          newvalue = leftvalue >> rightvalue;
        }
        needed.delete(key);
        console.log("setting " + key + " to " + newvalue);
        values.set(key, newvalue);
      } else {
      }
    }
  }
  console.log("Values: ");console.log(values);
}
console.log(values.get('a'));
