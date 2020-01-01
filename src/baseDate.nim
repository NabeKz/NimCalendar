import times, strutils

type
  BaseDate = DateTime

proc newBaseDate*(year: Natural, month: range[1..12]): BaseDate =
  let
    d = [$year, $month, "1"].join("-")
    baseDate = parse(d, "yyyy-M-d")
  baseDate

proc firstDayIndex(baseDate: BaseDate): WeekDay =
  getDayOfWeek(1, baseDate.month, baseDate.year)

proc lastDate(baseDate: BaseDate): BaseDate =
  let
    lastDay = getDaysInMonth(baseDate.month, baseDate.year)
  initDateTime(lastDay, baseDate.month, baseDate.year, 0, 0, 0)

proc lastDayIndex(baseDate: BaseDate): WeekDay =
  let
    dt = baseDate.lastDate
  getDayOfWeek(dt.monthday, dt.month, dt.year)
  