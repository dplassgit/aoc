import {Md5} from 'ts-md5';


var i = 0;
while (true) {
  const ans = Md5.hashStr(`iwrupvqb${i}`);
  if (ans.startsWith('00000')) {
    console.log("Part 1: " + i);
    console.log(ans);
    break;
  }
  i = i + 1;
}

i = 0;
while (true) {
  const ans = Md5.hashStr(`iwrupvqb${i}`);
  if (ans.startsWith('000000')) {
    console.log("Part 2: " + i);
    console.log(ans);
    break;
  }
  i = i + 1;
}
