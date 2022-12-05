import std/[tables, strutils, re, sequtils]

proc part1(): int =
  var f: File = open("input.txt")
  defer: f.close()
  var totals: array[0 .. 1, int] = [0, 0]
  for line in f.lines():
    let letterFrequencies = toCountTable(line)
    var doubleLetter = false
    var threeLetter = false
    for letter, occurence in letterFrequencies:
      if occurence == 2:
        doubleLetter = true
      elif occurence == 3:
        threeLetter = true
      else:
        continue
    totals[0].inc(int(doubleLetter))
    totals[1].inc(int(threeLetter))
  return totals[0] * totals[1]

proc part1() =
  let f = readLines("input.txt", 2)
  let nlines = f.len
  for i in 0 ..< nlines:
    let line = nlines[i]
    for j in 1 >..
echo part1()
