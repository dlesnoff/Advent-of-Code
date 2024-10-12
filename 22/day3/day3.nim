import std/[sets, strutils, sequtils]

proc score(c: char): int =
  if c.isLowerAscii():
    return int(c) - 97 + 1
  elif c.isUpperAscii():
    return int(c) - 65 + 27
  else:
    raise newException(ValueError, "")

proc part1(): int =
  result = 0
  for line in "input.txt".lines():
    let lim = line.len div 2
    var charSeq = toSeq(line)
    let
      s1 = toHashSet(line[0 ..< lim])
      s2 = toHashSet(line[lim .. charSeq.high])
    let letter = char(toSeq(s1 * s2)[0])
    result += score(letter)

proc part2(): int =
  result = 0
  var modulo3 = 1
  var hashSets: seq[HashSet[char]] = @[]
  for line in "input.txt".lines():
    hashSets.add(toHashSet(line))
    if modulo3 mod 3 == 0:
      let letter = char(toSeq(hashSets[0] * hashSets[1] * hashSets[2])[0])
      # echo letter, " ", score(letter)
      result += score(letter)
      hashSets = @[]
      modulo3 = 0
    modulo3.inc()

echo part1()
echo part2()
