import std/[algorithm, strutils, sequtils, strformat, strscans]
import macros

macro debug*(n: varargs[typed]): untyped =
  result = newNimNode(nnkStmtList, n)
  for i in 0..n.len-1:
    if n[i].kind == nnkStrLit:
      # pure string literals are written directly
      result.add(newCall("write", newIdentNode("stdout"), n[i]))
    else:
      # other expressions are written in <expression>: <value> syntax
      result.add(newCall("write", newIdentNode("stdout"), toStrLit(n[i])))
      result.add(newCall("write", newIdentNode("stdout"), newStrLitNode(": ")))
      result.add(newCall("write", newIdentNode("stdout"), n[i]))
    if i != n.len-1:
      # separate by ", "
      result.add(newCall("write", newIdentNode("stdout"), newStrLitNode(", ")))
    else:
      # add newline
      result.add(newCall("writeLine", newIdentNode("stdout"), newStrLitNode("")))

const filename = "input.txt"
type
  Location = tuple[x:int, y:int]

proc hash(l: Location): int16 =
  (201*l.x + l.y).int16

proc update_pos(loc: var Location, carac: char) =
    case carac
    of '^':
      loc.y += 1
    of 'v':
      loc.y -= 1
    of '>':
      loc.x += 1
    of '<':
      loc.x -= 1
    else:
      echo "Unexpected character: ", carac

proc part1() =
  var
    f: File = open(filename)
    visited: set[int16] = {}
    current_loc: Location
    nb_gifts = 1 # Santa gives a gift to the starting house
  defer: f.close()
  let line = f.readline().strip(chars={'\n'}, leading=false)
  for carac in line:
    update_pos(current_loc, carac)
    if hash(current_loc) notin visited:
      nb_gifts += 1
    visited = visited + {hash(current_loc)}
  echo nb_gifts


proc part2() =
  var
    f: File = open(filename)
    visited: set[int16] = {0}
    current_loc_santa: Location
    current_loc_robot: Location
    current_loc: Location
    nb_gifts = 1 # Santa gives a gift to the starting house
  defer: f.close()
  let line = f.readline().strip(chars={'\n'}, leading=false)
  for idx, carac in line:
    # Assignment
    if idx mod 2 == 1:
      current_loc = current_loc_santa
    else:
      current_loc = current_loc_robot

    update_pos(current_loc, carac)
    if hash(current_loc) notin visited:
      nb_gifts += 1
    visited = visited + {hash(current_loc)}
    # Updates
    if idx mod 2 == 1:
      current_loc_santa = current_loc
    else:
      current_loc_robot = current_loc
  echo nb_gifts

part1()
part2()
