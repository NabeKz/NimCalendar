import times, strutils

type
  BaseDate = DateTime

proc newBaseDate*(year, month: Natural): BaseDate =
  let 
    d = [$year, $month, "1"].join("-")
    dt = parse(d, "yyyy-M-d")
  dt

proc firstDayIndex(dt: BaseDate): WeekDay =
  getDayOfWeek(1, dt.month, dt.year)
  

proc lastDayIndex(dt: BaseDate): WeekDay =
  let 
    lastDay = getDaysInMonth(dt.month, dt.year)
  getDayOfWeek(lastDay, dt.month, dt.year)


proc lastDate(dt: BaseDate): BaseDate =
  let 
    lastDay = getDaysInMonth(dt.month, dt.year)
  initDateTime(lastDay, dt.month, dt.year, 0, 0, 0)
