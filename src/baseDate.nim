import times, strutils

type
  BaseDate = ref object
    dt: DateTime

proc newBaseDate*(year: Natural, month: range[1..12]): BaseDate =
  let
    d = [$year, $month, "1"].join("-")
    dt = parse(d, "yyyy-M-d")
  BaseDate(dt: dt)

method month(baseDate: BaseDate): Month{.base.} =
  baseDate.dt.month

method year(baseDate: BaseDate): int{.base.} =
  baseDate.dt.year
  
method lastDate(baseDate: BaseDate): DateTime{.base.} =
  let
    lastDay = getDaysInMonth(baseDate.month, baseDate.year)
  initDateTime(lastDay, baseDate.month, baseDate.year, 0, 0, 0)
  

method firstDayIndex(baseDate: BaseDate): WeekDay{.base.} =
  getDayOfWeek(1, baseDate.month, baseDate.year)


method lastDayIndex(baseDate: BaseDate): WeekDay{.base.} =
  let
    dt = baseDate.lastDate
  getDayOfWeek(dt.monthday, dt.month, dt.year)
  