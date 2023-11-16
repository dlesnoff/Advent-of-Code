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

const filename = "input"

proc part1() =
  var
    f: File = open(filename)
    total_paper = 0
    idx: int

  for line in f.lines:
    var seq_num = line.strip(chars={'\n'}, leading=false).split('x')
    var
      l = seq_num[0].parseInt()
      w = seq_num[1].parseInt()
      h = seq_num[2].parseInt()
    let
      total_area = 2*(l*w+w*h+h*l)
      slack = min(min(l*w, w*h), h*l)
    total_paper += total_area + slack
    # debug l, w, h, slack, total_area, total_paper
    idx += 1
    # if idx == 5:
    #   return
  echo total_paper


proc part2() =
  var
    f: File = open(filename)
    length_ribbon = 0
    idx: int

  for line in f.lines:
    var seq_num = line.strip(chars={'\n'}, leading=false).split('x')
    var
      l = seq_num[0].parseInt()
      w = seq_num[1].parseInt()
      h = seq_num[2].parseInt()
      sorted_seq = [l, w, h]
    sort(sorted_seq)
    let
      total_area = 2*(sorted_seq[0] + sorted_seq[1])
      bow = l*w*h
    length_ribbon += total_area + bow
    debug l, w, h, total_area, bow, length_ribbon
    idx += 1
    # if idx == 5:
    #   return
  echo length_ribbon

part1()
part2()
