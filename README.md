# DT
Dyalog APL tools for date-handling in applications

These are date-manipulation routines for calculating with dates as Julian Day Numbers (not Julian Dates).
They support and use ⎕DT and 1200⌶ from Dyalog APL v18.0 and later, but most of the functionality is available
in earlier versions of APL as well.

Simple calculations with serial date numbers such as these simply involve adding and subtracting a number of
days, but these tools are available for more complicated calculations such as adding/subtracting calendar
months, years, weekdays, and working days, and finding the day of week/month/year, the beginning of weeks,
months, years, calendar ages, and similar functionality.  Timestamps are also supported for some processes
by using a fractional date, and time-sensitive functions are available for changing between local and UTC time
zones, determining time zones, daylight savings time adjustments, and so on.

The basic functionality begins with two functions that convert back and forth between Julian Day and Gregorian
Date, for interfacing with other systems.  These functions use ⎕DT if it is available or will calculate it in
ordinary APL if it isn't.

1200⌶ is also used by a cover function to format dates and times.  This is expected to be updated when 1200⌶
is one day integrated into ⎕DT itself.

A Describe variable is included in the namespace for simple documentation of the tools available.

Any problems, suggestions, or requests should be reported to the author.  Otherwise, enjoy the calculation
flexibility that these tools provide.
