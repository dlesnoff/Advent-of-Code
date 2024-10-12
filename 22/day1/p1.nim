import std/[strutils]

proc computeRations(f: string): seq[int] =
  var f: File = open(f)
  defer:
    f.close()
  result = @[]
  var sum = 0
  for line in f.lines():
    if line != "":
      sum.inc(line.parseInt())
    else:
      result.add(sum)
      sum = 0

proc part1() =
  var f: File = open("inputP1.txt")
  defer:
    f.close()
  var rations: seq[int] = @[]
  var res = 0
  for line in f.lines():
    if line != "":
      res.inc(line.parseInt())
    else:
      rations.add(res)
      res = 0
  echo max(rations)

proc part2() =
  let rations = computeRations("inputP1.txt")
  var maxis: array[0..2, int] = [0, 0, 0]
  for i in 0 .. rations.high:
    if (rations[i] > maxis[0]):
      maxis[2] = maxis[1]
      maxis[1] = maxis[0]
      maxis[0] = rations[i]
    elif (rations[i] > maxis[1]):
      maxis[2] = maxis[1]
      maxis[1] = rations[i]
    elif (rations[i] > maxis[2]):
      maxis[2] = rations[i]
  echo maxis[0] + maxis[1] + maxis[2]

part1()
part2()
