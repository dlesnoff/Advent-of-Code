import std/[strutils, strscans, sequtils, sets, parseutils]

type
  FSTree = ref object
    childrens: seq[FSTREE]
    name: string
    size: Natural

proc `==`(a, b: FSTree): bool = a.name == b.name

var
  addFileMode = false
  filesystem = new(FSTree)
filesystem.name = "/"
filesystem.size = 0 # unknown size for now
var name = ""
var currentNode = filesystem
for line in "test.txt".lines:
  if line.scanf("$$ ls"):
    addFileMode = true
  elif line.scanf("$$ cd $w", name):
    let children = currentNode.childrens[0]
    while children.name != name: continue
    currentNode = children
  if addFileMode:
    discard line.scanf("dir $w", name)
    currentNode.childrens.add(newNode)
