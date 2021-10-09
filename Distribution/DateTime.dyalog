:Namespace DateTime
⍝ === VARIABLES ===

Linux0DateTime←2440588

MS0Date←2415019


⍝ === End of variables definition ===

(⎕IO ⎕ML ⎕WX)←1 1 3

∇ next←{count}AddMonth JJJ;ymd;ym;s;y;m
     ⍝ Given a "Julian Day Number", return the number of the date which is
     ⍝ one calendar month (or specified number of months) in the future (or
     ⍝ past).  The day of the month remains the same.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'count' ⋄ count←1 ⋄ :EndIf ⍝ Default = 1 = Next month
 s←¯1*0>ymd←GD JJJ ⋄ ymd←|ymd
 y←s×⌊ymd÷10000 ⋄ m←100|⌊ymd÷100 ⋄ ym←(m-1)+12×y-1 ⍝ Relative month #
 ym←ym+count ⍝ Add in specified number of calendar months
 m←1+12|ym ⋄ s←¯1*0>y←1+⌊ym÷12
 next←JD s×(10000×|y)+(100×m)+100|ymd
 ym←ym+1 ⍝ February can wrap more than 1 day ahead - limit it
 m←1+12|ym ⋄ s←¯1*0>y←1+⌊ym÷12
 next←next⌊JD s×(10000×|y)+(100×m)+1
 next←next×JJJ≠0 ⍝ If incoming date = 0 (null), also return 0
∇

∇ next←{count}AddWeekday JJJ
     ⍝ Given a "Julian Day Number", add one (or the specified number of)
     ⍝ week days and return the new date.  This automatically skips over
     ⍝ weekends, so adding 1 to a Friday date gives a Monday date, and
     ⍝ adding 2 gives a Tuesday date.  Starting dates which fall on weekends
     ⍝ are automatically adjusted to Monday before counting begins.
     ⍝ Code for DayOfWeek is embedded into this function.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'count' ⋄ count←1 ⋄ :EndIf
 JJJ←JJJ+1 0 0 0 0 0 2[1+7|1+JJJ] ⍝ Adjust weekends to Monday
 next←(JJJ>0)×JJJ+count+2×⌊(count+(1+7|1+JJJ)-2)÷5 ⍝ Skip over weekends
∇

∇ next←{count}AddYear JJJ;ymd;y;s
     ⍝ Given a "Julian Day Number", return the number of the date which is
     ⍝ one calendar year (or specified number of years) in the future (or
     ⍝ past).  The month and day remain the same.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'count' ⋄ count←1 ⋄ :EndIf ⍝ Default = 1 = Next year
 s←¯1*0>ymd←GD JJJ ⋄ y←s×⌊(|ymd)÷10000
 s←¯1*0>y←y+count ⍝ Add in specified number of calendar years
 next←(JJJ≠0)×JD s×(10000×|y)+10000||ymd
∇

∇ age←{today}Age JJJ;this;next;bday;start
     ⍝ Compute the age (in calendar years) from the given date(s)
     ⍝ (in Julian Day Number) to today (or other JDN ending date).
     ⍝ Any rank & shape array(s) accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'today' ⋄ today←JD 100⊥3↑⎕TS ⋄ :EndIf
 (start bday)←GD today JJJ ⋄ age←⌊(start-bday)÷10000
 next←10000+this←bday+10000×age ⋄ (this next)←JD this next
 age←(today≠0)×(JJJ≠0)×age+(today-this)÷(JJJ=0)+next-this ⍝ Add fractional year to whole year count
∇

∇ begin←{start}BeginMonth JJJ;ymd;ym;s;y;m
     ⍝ Given a "Julian Day Number", return the date of the beginning of the
     ⍝ calendar month in which it falls.
     ⍝ Months are normally considered to begin on the first (=1) day of the
     ⍝ month, but a different beginning-of-month day number (1-31) may be
     ⍝ specified as an optional left argument.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'start' ⋄ start←1 ⋄ :EndIf ⍝ Default = 1st to begin months
 s←¯1*0>ymd←GD JJJ ⋄ ymd←|ymd
 y←s×⌊ymd÷10000 ⋄ m←100|⌊ymd÷100 ⋄ ym←(m-1)+12×y-1 ⍝ Relative month #
 ym←ym-(100|ymd)<start ⍝ Wrap to previous month if before start day
 m←1+12|ym ⋄ s←¯1*0>y←1+⌊ym÷12
 begin←(start-1)+JD s×(10000×|y)+(100×m)+1
 ym←ym+1 ⍝ February can wrap more than 1 day ahead - limit it
 m←1+12|ym ⋄ s←¯1*0>y←1+⌊ym÷12
 begin←(JJJ≠0)×begin⌊JD s×(10000×|y)+(100×m)+1
∇

∇ begin←{start}BeginWeek JJJ
     ⍝ Given a "Julian Day Number", return the date of the beginning of the
     ⍝ calendar week in which it falls.
     ⍝ Weeks are normally considered to begin on Sunday=1, but a different
     ⍝ beginning-of-week day number (1-7) may be specified as an optional
     ⍝ left argument.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'start' ⋄ start←1 ⋄ :EndIf ⍝ Default = Sunday to begin weeks
 begin←(JJJ≠0)×JJJ-7|(1+7|1+JJJ)-start ⍝ Use embedded version of DayOfWeek
∇

∇ begin←{start}BeginYear JJJ;ymd;y;s
     ⍝ Given a "Julian Day Number", return the date of the beginning of the
     ⍝ calendar year in which it falls.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Years are normally considered to begin on the first day of the first
     ⍝ month (0101) of the year, but to support odd fiscal years a different
     ⍝ beginning-of-year month/day number (0101-1231) may be specified as an
     ⍝ optional left argument.
     ⍝ Alternatively, a single digit may be specified indicating that the
     ⍝ year should begin on a specific day of the first calendar week,
     ⍝ where 1=Sunday ... 7=Saturday.
     ⍝ The default left argument is 0, which indicates the calendar beginning
     ⍝ of the year (the same as 0101).
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     ⍝ Modified 6 September 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'start' ⋄ start←0 ⋄ :EndIf ⋄ start←start+101×start=0 ⍝ Default = 01/01 to begin years
 :If ∨/s←∊start∊⍳7 ⋄ (s/∊start)←s/∊100+1+7|start-DayOfWeek BeginYear JJJ ⋄ :EndIf ⍝ Convert day-of-week
 'Invalid start-of-year specification'⎕SIGNAL 11/⍨∨/(~(∊100|start)∊⍳31)∨~(∊⌊start÷100)∊⍳12
 s←¯1*0>ymd←GD JJJ ⋄ y←s×⌊(|ymd)÷10000
 s←¯1*0>y←y-(10000||ymd)<start ⍝ Wrap to previous year if before start day
 begin←(JJJ≠0)×JD s×start+10000×|y
∇

∇ DOW←DayOfWeek JJJ
     ⍝ Given a "Julian Day Number", return its day of the week (Sun=1).
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 DOW←(JJJ≠0)×1+7|1+JJJ
∇

∇ DOY←{start}DayOfYear JJJ;YMD
     ⍝ Given a "Julian Day Number", return its day in that year.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Years are normally considered to begin on the first day of the first
     ⍝ month (0101) of the calendar year, but to support odd fiscal years a
     ⍝ different beginning-of-year month/day number (0101-1231) may be
     ⍝ specified as an optional left argument.
     ⍝ Alternatively, a single digit may be specified indicating that the
     ⍝ year should begin on a specific day of the first calendar week,
     ⍝ where 1=Sunday ... 7=Saturday.
     ⍝ The default left argument is 0, which indicates the calendar beginning
     ⍝ of the year (the same as 0101).
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     ⍝ Modified 6 September 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'start' ⋄ start←0 ⋄ :EndIf ⋄ start←start+101×start=0 ⍝ Default = 01/01 to begin years
 :If ∨/s←∊start∊⍳7 ⋄ (s/∊start)←s/∊100+1+7|start-DayOfWeek BeginYear JJJ ⋄ :EndIf ⍝ Convert day-of-week
 'Invalid start-of-year specification'⎕SIGNAL 11/⍨∨/(~(∊100|start)∊⍳31)∨~(∊⌊start÷100)∊⍳12
 DOY←(×JJJ)×1+JJJ-start BeginYear JJJ
∇

∇ dates←Daylight year;⎕USING;adjs;fixed;rules;delta;years;y;w
     ⍝ Compute Daylight Savings Time boundaries for the local time zone in the given year(s)
     ⍝ Return one nested result for each item in "year"; each result contains:
     ⍝   [1] Hours to add to time zone during DST; [2] Start of DST; [3] End of DST
     ⍝ See "Describe" for more details.
     ⍝ Written June 30, 2020 by Davin Church of Creative Software Design
     
 years←∪,year ⋄ ⎕USING←'' ⋄ adjs←System.TimeZoneInfo.Local.GetAdjustmentRules
 :If 0∊⍴adjs ⋄ dates←(⍴year)⍴⊂0 0 0 ⋄ :Return ⋄ :EndIf ⍝ If there are no rules just return 0 0 0
 rules←↑adjs.(DaylightTransitionStart DaylightTransitionEnd).(IsFixedDateRule Month Day Week DayOfWeek.value__ TimeOfDay)
 (6⊃¨rules)←(6⊃¨rules).TimeOfDay.TotalHours÷24 ⍝ Convert transition time to day-fraction; Now all-numeric data
 rules←rules[y←adjs.DateStart.Year⍸years;] ⋄ delta←adjs.DaylightDelta.TotalHours[y]
 dates←(2/⍪years),¨(⊂⊂2 4 5)⌷¨rules ⋄ dates←(1+4⊃¨dates){⍵-7|(1+7|1+⍵)-⍺}JD(2↑¨dates),¨7×4⌊w←3⊃¨dates
 dates←w{⍵+7×(⍺=5)∧=/2⊃¨2 GD ⍵+0 7}¨dates ⍝ Adjust for week=5 alternatives
 fixed←,1⊃¨rules ⋄ (fixed/,dates)←fixed/,100⊥¨(2/⍪years),¨(⊂⊂2 3)⌷¨rules ⍝ Set fixed-date rules
 dates←delta,¨↓dates+6⊃¨rules ⋄ dates←dates[years⍳year] ⋄ :If 0=≡year ⋄ dates←⊃dates ⋄ :EndIf
∇

∇ JJJ←Easter year;cyc;cc;yy;x;w;G;Gmd;Jmd
     ⍝ Compute the JDN of the date on which Easter falls in the given year.
     ⍝ Handles dates in both the Gregorian and Julian calendars.
     ⍝ The Gregorian calculation is based on the 1876 method published in
     ⍝ "Butcher's Ecclesiastical Calendar" (don't even ask how it works).
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 G←year>1582 ⋄ cyc←19|year ⋄ cc←⌊year÷100 ⋄ yy←100|year
 x←30|15+(19×cyc)+G×(cc-⌊cc÷4)-⌊(cc+1-⌊(cc+8)÷25)÷3
 w←7|32+(2×4|cc)+(2×⌊yy÷4)-x+4|yy
 Gmd←1+100⊥0 31⊤114+x+w-7×⌊(cyc+(11×x)+(22×w))÷451
 Jmd←1+100⊥0 31⊤114+x+7|34+(2×4|year)+(4×7|year)-x
 JJJ←(year≠0)×JD(¯1*year<0)×(10000×|year)+(Gmd×G)+(Jmd×~G)
∇

∇ isholiday←ExampleHoliday JJJ;fixed;days;months;years;h
     ⍝ Determine if given JDN date is a standard U.S. banking holiday.
     ⍝ --- For use with operator AddWorkday ---
     ⍝ Any rank & shape array(s) accepted.  See "Describe" for more details.
     ⍝ Code for DayOfWeek is embedded into this function.
     
     ⍝ The following holidays are reported by this function:
     ⍝   New Year's Day,     January 1st
     ⍝   MLK Jr.'s Birthday, 3rd Monday in January
     ⍝   President's Day,    3rd Monday in February
     ⍝   Memorial Day,       Last Monday in May
     ⍝   Independence Day,   July 4th
     ⍝   Labor Day,          1st Monday in September
     ⍝   Columbus Day,       2nd Monday in October
     ⍝   Veterans' Day,      November 11th
     ⍝   Thanksgiving Day,   4th Thursday in November
     ⍝   Christmas Day,      December 25th
     ⍝ The above dates are not considered holidays if they fall on a
     ⍝ Saturday, but the following Monday is the observed holiday if the
     ⍝ exact date falls on a Sunday.
     ⍝
     ⍝ (These holidays definitions are not useful prior to the last few
     ⍝ decades of the 20th century, but are still computed back to 1 A.D.)
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 h←⍬ ⋄ years←,⌊(GD JJJ)÷10000 ⍝ Determine all years in question
 years←years[⍋years] ⋄ years←(1,(1↓years)≠¯1↓years)/years ⍝ Unique list
     
     ⍝ *** First check for fixed-date holidays
 days←1+7|1+months←JD 101 704 1111 1225∘.+years×10000
 h←h,(7≠,days)/,months+days=1 ⍝ Ignore Saturdays & move Sundays to Mondays
     
     ⍝ *** Now watch for moveable holidays throughout the year
     ⍝ First, get all beginning-of-month dates and starting days
 days←1+7|1+months←JD 101 201 601 901 1001 1101∘.+years×10000
     ⍝ Shift each to proper day of week and week of month, month-relative
 days←14 14 ¯7 0 7 21+[1]7|2 2 2 2 2 5-[1]days
     ⍝ And add them to beginning-of-month dates to get real holidays
 h←h,,months+days
     
     ⍝ *** Great!  That's all the holidays we're considering...
 isholiday←JJJ∊h ⍝ Just let them know if we have any matches
∇

∇ YMD←{expand}GD JJJ;Y;M;D;t;d;j;j1600;FFF;f;nz;⎕CT
     ⍝ Convert a "Julian Day Number" to a Gregorian-style date (YYYYMMDD).
     ⍝ If optional left argument "expand" is specified as an integer ∊⍳7, then
     ⍝ each result will be separated into component values like ⎕TS and nested
     ⍝ into a vector in each item in the result.  The number provided indicates
     ⍝ the number of elements in each nested vector, usually 3 or 7.
     ⍝ The input values may optionally specify a timestamp value by providing
     ⍝ a fractional number with the fraction representing a particular time of
     ⍝ day (starting at midnight) as a fraction of a whole day.  If a time is
     ⍝ specified in this way, then the returned result will also be fractional
     ⍝ and return the timestamp in the form YYYYMMDD.HHMMSSTTT, or as a nested
     ⍝ multi-item vector (in ⎕TS form) if the left argument is provided (see above).
     ⍝ ⎕DT is used if available, but if timestamps are included then this
     ⍝ function defines xxx.0 as midnight beginning the day instead of noon in
     ⍝ the middle of that day (as ⎕DT determines it), for convenience.
     ⍝ A scalar 0 will be translated to a value of 0 (or vector of 0s), for
     ⍝ convenience of handling missing dates in numeric arrays.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝   Constants: 1721117 ← 1-Jan-0001; 2299160 ← 4-Oct-1582
     ⍝   Constants: 584400 ← (10 + 29-Feb-1600) - 1-Jan-0001
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified April 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 29, 2020 by Davin Church of Creative Software Design
     
 :If 18≤2⊃⎕VFI 3↑2⊃'.'⎕WG'APLVersion' ⍝ Use ⎕DT if it's available
 :AndIf (∧/,JJJ≠0)∧∧/,50 0 ⎕DT JJJ ⍝ ...and within supported range
     JJJ←JJJ-0.5 ⍝ ⎕DT starts at noon instead of midnight as we prefer
     :If 0=⎕NC'expand' ⋄ :OrIf ~(⊃expand)∊⍳7 ⋄ YMD←50 60 ⎕DT JJJ
     :Else ⋄ YMD←(⊃expand)↑¨50 ¯1 ⎕DT JJJ ⋄ :EndIf
 :Else ⍝ Older version of system - simulate ⎕DT and allow for extra situations
     ⎕CT←1E¯16 ⍝ Avoid some millisecond rounding problems
     nz←JJJ≠0 ⋄ :If f←1∊0≠FFF←1||JJJ ⋄ JJJ←(×JJJ)×⌊|JJJ ⋄ :EndIf
     JJJ←(JJJ+10×JJJ>2299160)-1721117 ⋄ j1600←0⌈(j←JJJ-0.25)-584400
     t←⌈0.75×⌊j1600÷36524.25 ⋄ Y←⌊(t+j)÷365.25 ⋄ d←t+JJJ-⌊Y×365.25
     M←(31 30 31 30 31 31 30 31 30 31 31 29/2+⍳12)[d]
     D←d-0 0 0 31 61 92 122 153 184 214 245 275 306 337[M] ⋄ Y←Y+t←M>12 ⋄ M←M-12×t
     :If 2=⎕NC'expand' ⋄ :AndIf ∨/t←(⊃expand)∊⍳7
         YMD←nz×Y,¨M,¨D ⍝ Alternate (expanded) form(s)
         :If 3<⊃expand ⍝ Add the optional time to it (whether it needs it or not)
             YMD←(⊃expand)↑¨YMD,¨nz×(⊂0 60 60 1000)⊤¨⌊0.5+FFF×86400000
         :EndIf
     :Else
         YMD←nz×(¯1*Y≤0)×(10000×|Y)+(100×M)+D ⍝ Normal form
         :If f ⍝ Add the optional time to it (if any time was supplied)
             FFF←(⊂0 100 100 1000)⊥¨(⊂0 60 60 1000)⊤¨⌊0.5+FFF×86400000
             YMD←(×YMD)×(|YMD)+FFF÷1000000000
         :EndIf
     :EndIf
 :EndIf
∇

∇ isleap←IsLeapYear year
     ⍝ Determine if a given year is a leap year.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written September 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 isleap←(year≠0)×(0=4|year)-(year>1582)×-⌿0=100 400∘.|year
∇

∇ JJJ←JD YMD;Y;M;y1600;HMS;⎕CT;UseDT;deep;D;t;hms
     ⍝ Convert a Gregorian-style date (YYYYMMDD) to a "Julian Day Number".
     ⍝ If any item of the input is nested, then that date is assumed to be
     ⍝ separated into a 3-item nested vector containing separate numeric
     ⍝ values for year, month, and day.
     ⍝ Dates may optionally include a "time" portion to produce a "timestamp"
     ⍝ value.  Optionally nested items (as described above) may have 5, 6, or 7
     ⍝ items instead of just 3 to indicate hours, minutes, seconds, or
     ⍝ milliseconds.  Standard integers are extended to allow non-integer
     ⍝ values in the format (YYYYMMDD.HHMMSSTTT).  If either of these optional
     ⍝ formats are used, the result will not be an integer and the fractional
     ⍝ portion will be the numeric fraction of a day representing that time.
     ⍝ ⎕DT is used if available, but xxx.0 is defined as midnight beginning the
     ⍝ day instead of noon in the middle of that day, for convenience.
     ⍝ A scalar 0 (or vector of 0s) will be translated to a value of 0, for
     ⍝ convenience of handling missing dates in numeric arrays.
     ⍝ Any rank & shape array accepted.  See documentation for more details.
     ⍝   Constants: 1721117 ← 1-Jan-0001; 2299160 ← 4-Oct-1582
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 29, 2020 by Davin Church of Creative Software Design
     ⍝ Modified November 2020 by Davin Church of Creative Software Design
     
 :If UseDT←18≤2⊃⎕VFI 3↑2⊃'.'⎕WG'APLVersion' ⍝ Is ⎕DT available here?
 :AndIf UseDT←1≥⍴∪deep←,1≤≡¨YMD ⍝ Only if they're all the same structure
     :If ⊃deep ⋄ UseDT←∧/,¯1 0 ⎕DT YMD ⋄ :Else ⋄ UseDT←∧/,60 0 ⎕DT YMD ⋄ :EndIf ⍝ Make sure it's a valid/supported date
 :EndIf
 :If UseDT ⍝ A bit faster than native code, if everything is nice and neat
     :If ⊃deep ⋄ JJJ←¯1 50 ⎕DT YMD ⋄ :Else ⋄ JJJ←60 50 ⎕DT YMD ⋄ :EndIf ⍝ Alternate input forms
     JJJ←JJJ+0.5 ⍝ ⎕DT starts at noon instead of midnight as we prefer
 :Else ⍝ Older version of system - simulate ⎕DT and allow for extra situations
     Y←M←D←HMS←(⍴YMD)⍴0 ⋄ ⎕CT←1E¯16 ⍝ Avoid some millisecond rounding problems
     :If 1∊t←0<|≡¨YMD ⍝ Alternate (nested/expanded) form?
         HMS←HMS+t×(⌊0.5+(⊂0 60 60 1000)⊥¨4↑¨3↓¨YMD)÷86400000
         Y←Y+t×1⊃¨YMD,¨1 ⋄ M←M+t×2⊃¨YMD,¨⊂1 1 ⋄ D←D+t×3⊃¨YMD,¨⊂1 1 1
     :EndIf
     :If 1∊t←~t ⍝ Compact form?
         hms←10×⊃¨⌊0.5+100000000×1||YMD ⍝ Rounding any timestamp to 10ms
         HMS←HMS+t×((⊂0 60 60 1000)⊥¨(⊂0 100 100 1000)⊤¨hms)÷86400000
         Y←Y+⊃¨t×(×YMD)×⌊|YMD÷10000 ⋄ M←M+⊃¨t×⌊(10000||YMD)÷100 ⋄ D←D+⊃¨t×⌊100||YMD
     :EndIf
     (Y M D)←Y M D-(×Y M D)×1||Y M D ⋄ Y←Y+⌊(M-1)÷12 ⋄ M←1+12|M-1 ⋄ Y←Y-12<M←M+12×M≤2
     JJJ←D+0 0 0 31 61 92 122 153 184 214 245 275 306 337[M]
     y1600←0⌈Y-1600 ⋄ JJJ←JJJ+1721117+(⌊Y×365.25)-(⌊y1600÷100)-⌊y1600÷400
     JJJ←HMS+(∨/¨YMD≠0)×JJJ-10×JJJ>2299160
 :EndIf
∇

∇ local←Local utc;⎕USING
     ⍝ Convert a UTC Julian Day timestamp to a local Julian Day timestamp
     ⍝ See "Describe" for more details.
     ⍝ Written July 1, 2020 by Davin Church of Creative Software Design
     
 ⎕USING←'' ⋄ :If 0≠⍴⍴utc ⋄ local←Local¨utc ⋄ :Return ⋄ :EndIf ⍝ .NET is scalar-oriented
 local←(System.DateTime.SpecifyKind(⎕NEW System.DateTime(⊃7 GD utc))1).ToLocalTime
 local←JD⊂local.(Year Month Day Hour Minute Second Millisecond)
∇

∇ JTS←Now
     ⍝ Return the current timestamp in JJJJJJJ.FFFFFFFFF format.
     ⍝ See "Describe" for more details.
     ⍝
     ⍝ Written January 2003 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 JTS←JD⊂⎕TS
∇

∇ text←pattern Spell JJJ;nonzero
     ⍝ Format a date or timestamp (based on a Julian Day Number) into a specified format.
     ⍝ Since this routine depends on 1200⌶ all data (except the constant 0) must follow
     ⍝ its range restrictions.
     ⍝ Written 30 June 2020 by Davin Church of Creative Software Design
     ⍝ Note:  Requires Dyalog APL v18.0 or later
     
 JJJ←0.5-⍨(,nonzero←(JJJ≠0)∧~JJJ∊⎕NULL)/,JJJ ⍝ Format zeros as ''
 :Trap 0
     text←pattern(1200⌶)50 1 ⎕DT JJJ
 :Else
     ⎕DMX.Message ⎕SIGNAL 11
 :EndTrap
 text←(⍴nonzero)⍴1↓(1,,nonzero)\(⊂''),text
 :If 0=≡nonzero ⋄ text←⊃text ⋄ :EndIf ⍝ Don't enclose scalar results
∇

∇ tz←TimeZone;⎕USING
      ⍝ Return base information about the local time zone
     
 ⎕USING←'' ⋄ tz←System.TimeZoneInfo.Local.(BaseUtcOffset.TotalHours Id DisplayName StandardName DaylightName)
∇

∇ JJJ←Today
     ⍝ Return today's date in JJJJJJJ format.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 JJJ←JD 100⊥3↑⎕TS
∇

∇ utc←UTC local;⎕USING
     ⍝ Convert a local Julian Day timestamp to a UTC Julian Day timestamp
     ⍝ See "Describe" for more details.
     ⍝ Written July 1, 2020 by Davin Church of Creative Software Design
     
 ⎕USING←'' ⋄ :If 0≠⍴⍴local ⋄ utc←UTC¨local ⋄ :Return ⋄ :EndIf ⍝ .NET is scalar-oriented
 utc←(System.DateTime.SpecifyKind(⎕NEW System.DateTime(⊃7 GD local))2).ToUniversalTime
 utc←JD⊂utc.(Year Month Day Hour Minute Second Millisecond)
∇

∇ WOY←{start}WeekOfYear JJJ
     ⍝ Given a "Julian Day Number", return the number of the week in which it falls that year.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Years are normally considered to begin on the first day of the first
     ⍝ month (0101) of the calendar year, but to support odd fiscal years a
     ⍝ different beginning-of-year month/day number (0101-1231) may be
     ⍝ specified as an optional left argument.
     ⍝ Alternatively, a single digit may be specified indicating that the
     ⍝ year should begin on a specific day of the first calendar week,
     ⍝ where 1=Sunday ... 7=Saturday.
     ⍝ The default left argument is 0, which indicates the calendar beginning
     ⍝ of the year (the same as 0101).
     ⍝
     ⍝ Written 5 September 2020 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog September 6, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'start' ⋄ start←0 ⋄ :EndIf
 WOY←⌈(start DayOfYear JJJ)÷7
∇

∇ next←{count}(isholiday AddWorkday)JJJ;chk0;days
⍝ Given a "Julian Day Number", add one (or the specified number of)
⍝ work days and return the new date.  This automatically skips over
⍝ weekends and holidays, so adding 1 to a Friday date gives a Monday
⍝ date, and adding 2 gives a Tuesday date.  Starting dates which fall
⍝ on weekends or holidays are automatically adjusted to the next work
⍝ day before counting begins.
⍝ Holidays are determined by calling the left operand function.
⍝ It should return a 1 for each item of the argument if that date is
⍝ a holiday, and a 0 if it is not.
⍝ See an example of such a function named ExampleHoliday, which
⍝ determines holidays based on the standard rules of U.S. banking.
⍝ Code for DayOfWeek is embedded into this function.
⍝ Any rank & shape array accepted.  See "Describe" for more details.
⍝
⍝ Written in 1998 by Davin Church of Creative Software Design
⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design

 :If 0=⎕NC'count' ⋄ count←1 ⋄ :EndIf
 JJJ←JJJ+1 0 0 0 0 0 2[1+7|1+JJJ] ⍝ Adjust weekends to Monday
 next←(JJJ>0)×JJJ+count+2×⌊(count+(1+7|1+JJJ)-2)÷5 ⍝ Skip over weekends
 :If count<0 ⋄ chk0←⊂⍬ ⋄ :Else ⋄ chk0←0 ⋄ :EndIf ⍝ Check initial date?
 :While 1∊∨/¨count←isholiday¨days←JJJ+(×next-JJJ)×chk0,¨⍳¨|next-JJJ
 :AndIf 1∊×count←+/¨count∧0≠6|7|1+days ⋄ chk0←⊂⍬ ⍝ Except weekends
     count←count×(×next-JJJ)+next=JJJ ⋄ JJJ←next
     next←JJJ+count+2×⌊(count+(1+7|1+JJJ)-2)÷5 ⍝ Skip holidays
 :EndWhile
∇

:EndNamespace 
