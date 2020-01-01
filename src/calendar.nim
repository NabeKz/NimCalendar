import algorithm, sequtils
include baseDate

type
  CalenderDate* = ref object of RootObj
    dt: DateTime
  ThisMonthCalendarDate = ref object of CalenderDate
  LastMonthCalendarDate = ref object of CalenderDate
  NextMonthCalendarDate = ref object of CalenderDate


method `$`*(c: CalenderDate): string{.base.} =
  c.dt.format("yyyy-MM-dd")

method day*(c: CalenderDate): string{.base.} =
  intToStr(c.dt.monthday, 2)

proc thisMonthDates*(baseDate: BaseDate): seq[CalenderDate] =
  let lastDay = baseDate.lastDate.monthday
  for i in 0..<lastDay:
    let dt = baseDate.dt + i.days
    result.add(ThisMonthCalendarDate(dt: dt))
  
proc lastMonthDates*(baseDate: BaseDate): seq[CalenderDate] =
  for i in 1..ord(baseDate.firstDayIndex):
    let dt = baseDate.dt - i.days
    result.add(LastMonthCalendarDate(dt: dt))
  result.reverse()

proc nextMonthDates*(baseDate: BaseDate): seq[CalenderDate] =
  let lastDate = baseDate.lastDate
  for i in 1..6 - ord(baseDate.lastDayIndex):
    let dt = lastDate + i.days
    result.add(NextMonthCalendarDate(dt: dt))


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
    header = @["月", "火", "水", "木", "金", "土", "日"]
    baseDate = newBaseDate(2019, 12)
    lastMonth = lastMonthDates(baseDate)
    thisMonth = thisMonthDates(baseDate)
    nextMonth = nextMonthDates(baseDate)
    calendar = concat(lastMonth, thisMonth, nextMonth)

  echo header
  for c in chunk(calendar, 7):
    let m = c.mapIt(it.day)
    # let m = i.mapIt(if (it of ThisMonthCalendarDate): it.day: else: "--")
    echo m
