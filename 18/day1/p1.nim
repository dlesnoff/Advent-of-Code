import std/[strutils, sequtils, re]
const filename = "input.txt"
proc part1() =
  var f: File = open(filename)
  defer:
    f.close()
  var res = 0
  for line in f.lines():
    if line[0] == '+':
      res.inc((line[1 .. line.high]).parseInt())
    elif line[0] == '-':
      res.dec(line[1 .. line.high].parseInt())
  echo res

proc part2() =
  var freq_list: seq[int] = @[0]
  var res = 0
  var duplicateNotFound = true
  while duplicateNotFound:
    var f: File = open(filename)
    defer:
      f.close()
    for line in f.lines():
      if line[0] == '+':
        res.inc((line[1 .. line.high]).parseInt())
      elif line[0] == '-':
        res.dec(line[1 .. line.high].parseInt())
      # echo res
      if res in freq_list:
        duplicateNotFound = false
        break
      else:
        freq_list.add(res)
  echo res

part2()
