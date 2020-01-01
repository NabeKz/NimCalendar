# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest, times

import baseDate

suite "test2":
  test "can 2020-02":
    let
      c = newCalendar(2020, 2)
      
    check:
      format(c.lastDate, "yyyy-MM-dd") == "2020-02-29"

  test "can 2020-02 index":
    let
      c = newCalendar(2020, 2)

    check:
      c.firstDayIndex == dSat
      c.lastDayIndex == dSat
      ord(c.firstDayIndex) == 5
      ord(c.lastDayIndex) == 5

  test "can 2020-01 index":
    let
      c = newCalendar(2020, 1)

    check:
      c.firstDayIndex == dWed
      c.lastDayIndex == dFri

  test "can 2019-12 index":
    let
      c = newCalendar(2019, 12)

    check:
      c.firstDayIndex == dSun
      c.lastDayIndex == dTue