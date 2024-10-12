import std/[parseutils, strutils, tables]

const
  filename = "test"
  Colors = @["red", "green", "blue"]

type
  Cubes = enum
    Red, Green, Blue
  Subset = array[0..2, Cubes]

proc part1() =
  var f: File = open(filename)
  for line in f.lines():
    var turns = line.split(';')
    turns[0] = turns[0].split(':')[1]
    echo turns
    for str in turns:
      for xs in str.split(','):
        let xs = xs.split(' ')
        let
          number = parseInt($(xs[1]))
          color = xs[2]
        let idx = find(Colors, color)
        echo number, " ", color, " ", idx
        # echo digit, " ", color, " ", idx
      # echo ""

part1()
# part2()
