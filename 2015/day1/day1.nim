import std/[strutils, strscans, algorithm]

const
  filename = "input.txt"

proc part1() =
  var
    line = filename.readLines(1)
    stack = 0

  for c in line[0]:
    if c == '(':
      stack += 1
    elif c == ')':
      stack -= 1
    else:
      echo "Unknown character"

  echo $stack

proc part2() =
  var
    line = filename.readLines(1)
    stack = 0

  for idx, c in line[0]:
    if c == '(':
      stack += 1
    elif c == ')':
      stack -= 1
    else:
      echo "Unknown character"
    if stack == -1:
      echo idx + 1
      return


part1()
part2()
