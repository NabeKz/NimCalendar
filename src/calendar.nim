import algorithm, sequtils, sugar
include baseDate

type
  CalenderDate* = ref object of RootObj
    dt: DateTime
  ThisMonthCalendarDate = ref object of CalenderDate
  OtherMonthCalendarDate = ref object of CalenderDate

proc newThisMonthCalendarDate*(dt: DateTime): ThisMonthCalendarDate =
  ThisMonthCalendarDate(dt: dt)

proc newOtherMonthCalendarDate*(dt: DateTime): OtherMonthCalendarDate =
  OtherMonthCalendarDate(dt: dt)

method `$`*(c: CalenderDate): string{.base.} =
  c.dt.format("yyyy-MM-dd")

method day*(c: CalenderDate): string{.base.} =
  let day = $c.dt.monthday
  " " & day.align(2, '0')

proc thisMonthDays*(dt: BaseDate): seq[CalenderDate] =
  let lastDay = getDaysInMonth(dt.month, dt.year)
  for i in 0..<ord(lastDay):
    let dt = dt + i.days
    result.add(newThisMonthCalendarDate(dt))
  
proc lastMonthDays*(dt: BaseDate): seq[CalenderDate] =
  for i in 1..ord(dt.firstDayIndex):
    let dt = dt - i.days
    result.add(newOtherMonthCalendarDate(dt))
  result.reverse()

proc nextMonthDays*(dt: BaseDate): seq[CalenderDate] =
  let lastDate = dt.lastDate
  for i in 1..6 - ord(dt.lastDayIndex):
    let dt = lastDate + i.days
    result.add(newOtherMonthCalendarDate(dt))


proc chunk[T](ary: openArray[T], n: Natural): seq[seq[T]] =
  let
    m = ary.len mod n == 0
    size = if m: len(ary) div n: else: len(ary) div n + 1

  for i in 0..<size:
    let
      start = i * n
      last = start + n
    if i == size - 1:
      result.add(ary[start..^1])
    else:
      result.add(ary[start..<last])


when isMainModule:
  let 
    header = @["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    baseDate = newBaseDate(2019, 12)
    lastMonthDay = lastMonthDays(baseDate)
    thisMonthDay = thisMonthDays(baseDate)
    nextMonthDay = nextMonthDays(baseDate)
    calendar = concat(lastMonthDay, thisMonthDay, nextMonthDay)

  echo header
  for i in chunk(calendar, 7):
    let m = i.mapIt(it.day)
    echo m
  

# ぎっちり詰めるのでための計算をします
# 1週間は日~土の7日を繰り返しているので、月のはじめとおわりの曜日がわかれば
# つめる分の曜日がわかります。
# 日曜を0, 土曜を6すると
# 2019年12月は日曜(0)はじまり, 火曜(1)おわりです。
# なので、
# はじめ週は曜日の個数 - 6 = 0、でつめなくてOK, 
# おわり週は曜日の個数 - 1 = 5、つめる必要があります。
