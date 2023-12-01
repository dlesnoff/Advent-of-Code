import std/[parseutils, strutils, tables]

const
  filename = "input"

proc part1() =
  var total: uint = 0
  var secondDigit: uint = 0
  for line in filename.lines():
    var firstDigit: uint = 11
    for c in line:
      if c.isDigit():
        if firstDigit == 11:
          discard parseutils.parseUInt([c], firstDigit)
          discard parseutils.parseUInt([c], secondDigit)
        else:
          discard parseutils.parseUInt([c], secondDigit)
    total += firstDigit*10 + secondDigit
  echo total


template updateDigits(firstDigitFound: bool; firstDigit, lastDigit: var int; variable: untyped) =
  if not firstDigitFound:
    firstDigit = variable
    firstDigitFound = true
  lastDigit = variable

const
  digits3 = {"one": 1, "two": 2, "six": 6}.toTable
  digits4 = {"four": 4, "five": 5, "nine": 9}.toTable
  digits5 = {"three": 3, "seven": 7, "eight": 8}.toTable

  # digits = {"one": 1, "two": 2, "three": 3,
  # "four": 4, "five": 5, "six": 6, "seven": 7,
  # "eight": 8, "nine": 9,
  # "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6":6,
  # "7": 7, "8": 8, "9": 9}.toTable
  # firstLetters = {'o', 't', 'f', 's', 'e', 'n'}
proc part2() =
  var total: int = 0
  for line in filename.lines():
    var idx = 0
    var firstDigit: int = 0
    var lastDigit: int = 0
    var firstDigitFound: bool = false
    echo line
    while idx < line.len:
      var c = line[idx]
      # echo c, " ", c in firstLetters
      if  c in {'o', 't', 's'} and idx <= (line.len-3) and line[idx..idx + 2] in digits3:
        # echo c, " "
        updateDigits(firstDigitFound, firstDigit, lastDigit, digits3[line[idx..idx + 2]])
      elif c in {'f', 'n'} and idx <= (line.len-4) and line[idx..idx + 3] in digits4:
        updateDigits(firstDigitFound, firstDigit, lastDigit, digits4[line[idx..idx + 3]])
      elif c in {'t', 's', 'e'} and idx <= (line.len-5) and line[idx..idx + 4] in digits5:
        updateDigits(firstDigitFound, firstDigit, lastDigit, digits5[line[idx..idx + 4]])
      elif c in Digits:
        updateDigits(firstDigitFound, firstDigit, lastDigit, parseInt($c))
      idx += 1
    total += firstDigit*10 + lastDigit
    echo firstDigit*10 + lastDigit
  echo total

part1()
part2()
