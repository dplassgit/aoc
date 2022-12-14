# Advent of Code 2022

https://adventofcode.com/2022

I'm trying to use my own programming language, D, available at https://github.com/dplassgit/d2lang


## Running the D compiler from the deployjar

```shell
java -jar D2Compiler_deploy.jar day2.d -o day2.exe
```

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

(I have a shell script to do it)


## Typescript

If you don't give an outfile, it writes to `input.js`.


```shell
npx tsc input.ts [--outfile alternate.js]
```
