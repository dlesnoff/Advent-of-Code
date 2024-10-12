import std/[sequtils]

const length = 14

let file = "input.txt".open()
let line = file.readline
var buffer = line[0 .. length-1]
var assertion: bool = deduplicate(toSeq(buffer)).len != length
var position = length
while assertion:
  for i in 0 .. length-2:
    buffer[i] = buffer[i+1]
  buffer[^1] = line[position]

  # Comparison of buffer's characters
  assertion = deduplicate(toSeq(buffer)).len != length
  position.inc
echo position
file.close()
