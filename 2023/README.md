# Advent of Code 2023

https://adventofcode.com/2023


## Compiling with the D compiler

First, compile the compiler:

```shell
cd ~/dev/d2lang
bazel build src/com/plasstech/lang/d2:D2Compiler
```

Then the executable (directory) can be referenced absolutely:

```shell
~/dev/d2lang/bazel-bin/src/com/plasstech/lang/d2/D2Compiler.exe day2.d -o day2.exe
```

I have a shell script to do it:

```shell
dcc day2.d -o day2.exe --save-temps
day2.exe < day2.txt
```

## Using the assembly language library (lib.asm)


```shell
nasm -fwin64 ../lib/lib.asm -o lib.obj && dcc day1b.d -c && gcc day1b.obj lib.obj -o day1b.exe
./day1b.exe < day1.txt
```


## Javascript

```
node day1.js
```

## Typescript

```shell
npx tsc day4.ts --lib es6,dom && node day4.js
```

## BASIC

Use [CloudT](https://bitchin100.com/CloudT/#!/M100Display) or [VirtualT](https://sourceforge.net/projects/virtualt/)
