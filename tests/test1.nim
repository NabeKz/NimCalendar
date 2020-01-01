# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import baseDate, calendar, sequtils

suite "test1":
  test "can thisMonth":
    let 
      c = newCalendar(2019, 12)
      thisMonthDays = c.thisMonthDays
    
    check:
      $thisMonthDays[0] == "2019-12-01"
      $thisMonthDays[^1] == "2019-12-31"

  test "can 2020-02":
    let
      c = newCalendar(2020, 2)
      thisMonthDays = c.thisMonthDays
      lastMonthDays = c.lastMonthDays
      nextMonthDays = c.nextMonthDays
      calendar = concat(lastMonthDays, thisMonthDays, nextMonthDays)
    
    check:
      $lastMonthDays[0] == "2020-01-27"
      $lastMonthDays[^1] == "2020-01-31"
      $nextMonthDays[0] == "2020-03-01"
      $nextMonthDays[^1] == "2020-03-01"
      $calendar[0] == "2020-01-27"
      $calendar[^1] == "2020-03-01"

  test "can 2019-12":
    let
      c = newCalendar(2019, 12)
      thisMonthDays = c.thisMonthDays
      lastMonthDays = c.lastMonthDays
      nextMonthDays = c.nextMonthDays
      calendar = concat(lastMonthDays, thisMonthDays, nextMonthDays)
    
    check:
      $calendar[0] == "2019-11-25"
      $calendar[^1] == "2020-01-05"

  test "can 2020-01":
    let
      c = newCalendar(2020, 1)
      thisMonthDays = c.thisMonthDays
      lastMonthDays = c.lastMonthDays
      nextMonthDays = c.nextMonthDays
      calendar = concat(lastMonthDays, thisMonthDays, nextMonthDays)
    
    check:
      $calendar[0] == "2019-12-30"
      $calendar[^1] == "2020-02-02"

  test "can 2020-06":
    let
      c = newCalendar(2020, 6)
      thisMonthDays = c.thisMonthDays
      lastMonthDays = c.lastMonthDays
      nextMonthDays = c.nextMonthDays
      calendar = concat(lastMonthDays, thisMonthDays, nextMonthDays)
    
    check:
      $calendar[0] == "2020-06-01"
      $calendar[^1] == "2020-07-05"