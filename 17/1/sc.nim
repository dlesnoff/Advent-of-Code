import std/strutils

proc day1(s: string): int =
  var first = parseInt($s[0])
  var refDigit = first
  for index in 1..<s.len:
    var currentDigit = parseInt($s[index])
    if currentDigit == refDigit:
      result += currentDigit
    else:
      refDigit = currentDigit
  if parseInt($s[^1]) == first:
    result += first

when isMainModule:
  import std/unittest

  suite "Rotation Numbers":
    test "1122":
      check day1("1122") == 3
    test "1111":
      check day1("1111") == 4
    test "1234":
      check day1("1234") == 0
    test "9123456789":
      check day1("9123456789") == 9

  var f = open("input.txt")

  var s = ""
  for j in f.lines:
    s &= j
  echo day1(s)
