import checksums/md5

const input = "ckczppom"

proc part1(input: string): int =
  var secret_key: int
  while true:
    var s = input & $secret_key
    var digest = toMD5(s)
    if digest[0..1] == [0.uint8, 0] and digest[2] < 16:
      break
    secret_key.inc
  return secret_key

proc part2(input: string, startValue: int) =
  var secret_key: int = startValue
  while true:
    var s = input & $secret_key
    var digest = toMD5(s)
    if digest[0..2] == [0.uint8, 0, 0]:
      break
    secret_key.inc
  echo secret_key

let start = part1(input)
echo start
part2(input, start)
