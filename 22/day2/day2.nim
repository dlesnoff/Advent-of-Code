import std/[strutils, sequtils, re]

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

# A, X Rock
# B, Y Paper
# C, Z Scissors

# Paper > Rock > Scissors > Paper
type
  Shape = enum
    Rock, Paper, Scissors

proc part1() =
  var f: File = open("input.txt")
  defer:
    f.close()
  var sum=0
  for line in f.lines():
    var l = line.split()
    var
      opponent = l[0]
      player = l[1]
    # echo opponent, player
    case player[0]
    of 'X':
      sum+=1
      case opponent[0]
      of 'A': sum+=3
      of 'B': sum+=0
      of 'C': sum+=6
      else:
        raise newException(ValueError, "")
    of 'Y':
      sum+=2
      case opponent[0]
      of 'A': sum+=6
      of 'B': sum+=3
      of 'C': sum+=0
      else:
        raise newException(ValueError, "")
    of 'Z':
      sum+=3
      case opponent[0]
      of 'A': sum+=0
      of 'B': sum+=6
      of 'C': sum+=3
      else:
        raise newException(ValueError, "")
    else:
      raise newException(ValueError, "")
  echo sum

proc value(s: Shape): int = ord(s) + 1

proc part2() =
  var f: File = open("input.txt")
  defer:
    f.close()
  var sum=0
  echo ord(Rock), ord(Paper), ord(Scissors)
  for line in f.lines():
    var l = line.split()
    var
      opponent = l[0]
      player = l[1]
    # echo opponent, player
    case player[0]
    of 'X': # Lose (on purpose)
      sum+=0
      case opponent[0]
      of 'A':
        # Rock Scissors
        sum+=value(Scissors)
      of 'B':
        # Paper Rock
        sum+=value(Rock)
      of 'C':
        # Scissors Paper
        sum+=value(Paper)
      else:
        raise newException(ValueError, "")
    of 'Y': # Draw (on purpose)
      sum+=3
      case opponent[0]
      of 'A': sum+=value(Rock)
      of 'B': sum+=value(Paper)
      of 'C': sum+=value(Scissors)
      else:
        raise newException(ValueError, "")
    of 'Z': # Win (on purpose)
      sum+=6
      case opponent[0]
      of 'A': sum+=value(Paper)
      of 'B': sum+=value(Scissors)
      of 'C': sum+=value(Rock)
      else:
        raise newException(ValueError, "")
    else:
      raise newException(ValueError, "")
  echo sum

part1()
part2()
