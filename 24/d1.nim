import std/[sequtils, algorithm, parseutils, strutils, tables]

var filename = "input"
# var f = open(filename)
var
  left: seq[uint] = @[]
  right: seq[uint] = @[]
  leftNum = 0.uint
  rightNum = 0.uint
  s = 0.uint
for line in filename.lines():
  var l = line.split(" ")
  discard parseutils.parseUInt(l[0], leftNum)
  discard parseutils.parseUInt(l[3], rightNum)
  left.add(leftNum)
  right.add(rightNum)
  #right.add(l[3])
left = sorted(left)
right = sorted(right)

for i in left:
  var c = 0.uint
  for j in right:
    if j > i: break
    elif j < i: continue
    else:
      c.inc()
  s += c*i
echo s
# for idx, pair in zip(left, right):
#   echo idx, " ", pair
#   s += min(pair[0] - pair[1], pair[1] - pair[0])
#   echo s
# echo s
