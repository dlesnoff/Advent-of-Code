import std/[strutils, re]

proc contains(s: openArray[int]): bool =
  let (a, b, c, d) = (s[0], s[1], s[2], s[3])
  if a <= c and b >= d:
    return true
  elif c <= a and b <= d:
    return true
  else:
    return false

proc overlaps(s: openArray[int]): bool =
  let (a, b, c, d) = (s[0], s[1], s[2], s[3])
  return not(b < c) and not(d < a)

proc part1() =
  var sum = 0
  for line in "input.txt".lines:
    let line = line.split(re"\D")
    # echo line
    var digits: seq[int] = @[]
    for c in line:
      digits.add(parseInt(c))
    # echo digits
    if contains(digits):
      sum += 1
  echo sum

proc part2() =
  var sum = 0
  for line in "input.txt".lines:
    let line = line.split(re"\D")
    var digits: seq[int] = @[]
    for c in line:
      digits.add(parseInt(c))
    if overlaps(digits):
      sum += 1
      echo digits
  echo sum


part1()
part2()
