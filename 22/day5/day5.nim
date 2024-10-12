import std/[strscans, algorithm]

const
  filename = "input.txt"
  nstacks = 9
  initialStackHeight = 8

proc part1() =
  var
    f: File = filename.open()
    line = f.readLine()
    tab: seq[seq[char]] = @[]

  for i in 0 ..< nstacks:
    tab.add(@[])

  # Parsing
  for nline in 0 ..< initialStackHeight:
    var l = line.len
    for column in 1 .. l:
      if column mod 4 == 1:
        if line[column] != ' ':
          tab[column div 4].add(line[column])
    line = f.readLine()
  discard f.readLine()

  # Sort data
  for i in 0 ..< nstacks:
    tab[i].reverse()

  # Apply operations read from the file
  for line in f.lines():
    var nbCrates, prev, next: int
    discard scanf(line, "move $i from $i to $i", nbCrates, prev, next)
    prev.dec
    next.dec
    for i in 0 ..< nbCrates:
      let temp = pop(tab[prev])
      tab[next].add(temp)

  # Output resulting stack
  var finalString = ""
  for i in 0 ..< nstacks:
    finalString.add(tab[i][tab[i].high])

  echo finalString

proc part2() =
  var
    f: File = filename.open()
    line = f.readLine()
    tab: seq[seq[char]] = @[]

  for i in 0 ..< nstacks:
    tab.add(@[])

  # Parsing
  for nline in 0 ..< initialStackHeight:
    var l = line.len
    for column in 1 .. l:
      if column mod 4 == 1:
        if line[column] != ' ':
          tab[column div 4].add(line[column])
    line = f.readLine()
  discard f.readLine()

  # Sort data
  for i in 0 ..< nstacks:
    tab[i].reverse()

  # Apply operations read from the file
  for line in f.lines():
    var nbCrates, prev, next: int
    discard scanf(line, "move $i from $i to $i", nbCrates, prev, next)
    prev.dec
    next.dec
    echo nbCrates, " ", prev, " ", next
    echo tab[prev]
    echo tab[next]
    var temp:seq[char] = @[]
    for i in 0 ..< nbCrates:
      temp.add(pop(tab[prev]))
    echo ""
    echo temp
    echo ""
    for i in countDown(nbCrates-1, 0):
      echo i, " ", temp[i]
      tab[next].add(temp[i])
    echo tab[prev]
    echo tab[next]
    echo "-----------------------"

  # Output resulting stack
  var finalString = ""
  for i in 0 ..< nstacks:
    finalString.add(tab[i][tab[i].high])

  echo finalString

part1()
part2()
