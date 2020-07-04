:Namespace DT
⍝ === VARIABLES ===

L←⎕av[3+⎕io]
_←⍬
_,←'This text contains a description of a set of date manipulation routines'
_,←L,'written in APL by Davin Church of Creative Software Design.'
_,←L,''
_,←L,'These functions are written for use by Dyalog APL v18.0 and make use of the'
_,←L,'⎕DT and 1200⌶ capabilities available in that version of the interpreter.'
_,←L,'They are designed to provide additional application-oriented capabilities'
_,←L,'beyond those supplied by ⎕DT and in some cases will run in earlier versions'
_,←L,'where ⎕DT is not available.'
_,←L,''
_,←L,'All these functions are designed to process integers that contain dates in'
_,←L,'Julian Day Number form, equivalent to 50∘⎕DT form.  ⎕DT may be used to'
_,←L,'create values in that form from any other desired structure.  Two functions'
_,←L,'are also available here to convert between Julian and Gregorian forms as'
_,←L,'well.  These converters (and most of the other functions) also handle dates'
_,←L,'outside the range supported by ⎕DT.'
_,←L,''
_,←L,'Simple day-based calculations can be performed by simply adding and'
_,←L,'subtracting constants to the JDN, such as applying 2415019 to convert'
_,←L,'between a JDN and the sorts of date values used by Microsoft Office.'
_,←L,'Routines are provided here to perform calculations on calendar months and'
_,←L,'years as well as other sorts of complex calendar operations.'
_,←L,''
_,←L,''
_,←L,'The following routines are currently available:'
_,←L,''
_,←L,'JD          Convert a calendar date (YYYYMMDD) to a Julian Day Number (JJJJJJJ).'
_,←L,'GD          Convert a Julian Day Number (JJJJJJJ) to a calendar date (YYYYMMDD).'
_,←L,'Today       Return today''s date as a Julian Day Number (JJJJJJJ).'
_,←L,'Now         Return a timestamp, like Today but including a fractional time.'
_,←L,'DayOfWeek   Return the day of the week (Sun=1 thru Sat=7) of a JDN (JJJJJJJ).'
_,←L,'DayOfYear   Return the day of the calendar year (1-366) of a JDN (JJJJJJJ).'
_,←L,'IsLeapYear  Is the given year a leap year?'
_,←L,'Age         Return the calendar age from a JDN (JJJJJJJ) as of today.'
_,←L,'BeginWeek   Return the JDN of the Sunday on or just before the given JDN.'
_,←L,'BeginMonth  Return the date of the first of the month of the date given.'
_,←L,'BeginYear   Return the date of the first of the year of the date given.'
_,←L,'AddMonth    Return the date that is one (or more) months from the date given.'
_,←L,'AddYear     Return the date that is one (or more) years from the date given.'
_,←L,'AddWeekday  Return the JDN of the following week day of the given JDN.'
_,←L,'AddWorkday  Return a date as in AddWeekday but also skip holidays.'
_,←L,'ExampleHoliday  For a given date, decide if it is a U.S. national bank holiday.'
_,←L,'Easter      For a given year, return the JDN date of the Easter holiday.'
_,←L,'Spell       For a given date or timestamp, spell it out in any specified format.'
_,←L,'Daylight    Return local Daylight Savings Time rules.'
_,←L,'Local       Convert a UTC JDN timestamp to a local JDN timestamp.'
_,←L,'UTC         Convert a local JDN timestamp to a UTC JDN timestamp.'
_,←L,'TimeZone    Return basic description from the local time zone.'
_,←L,''
_,←L,'Most routines will accept an array of any size, shape, or rank and return an'
_,←L,'array of the same dimensions.  Operations on arrays of dates are fast and'
_,←L,'encouraged.  All date routines (except JD and GD) use the Julian Day Number'
_,←L,'style of date for simplicity.  The YYYYMMDD format is primarily used when'
_,←L,'passing dates to and from other systems.'
_,←L,''
_,←L,'Dates in the (calendar) form of YYYYMMDD are single 8-digit numeric values'
_,←L,'where groups of digits are used to describe the parts of the date.  MM is'
_,←L,'the month number (01-12) and DD is the day number of the month (01-31).  The'
_,←L,'year (YYYY) may take on almost any value, positive or negative.  If the year'
_,←L,'is negative, this is indicated by making the entire date a negative number, but'
_,←L,'without affecting the month or day digits (i.e. they still appear to read as'
_,←L,'the correct decimal values).  Negative dates (years) are used to indicate dates'
_,←L,'prior to 1 A.D.  Since there was no year 0 (A.D. or B.C.), the year number'
_,←L,'(YYYY) of 0 is used to represent the calendar year 1 B.C. so that years can be'
_,←L,'consecutive.  A year number (YYYY) of ¯1 is used to represent the year 2 B.C.,'
_,←L,'and so on.  Dates are using a zero date on the proleptic Julian calendar of'
_,←L,'January 1, 4713 B.C. (¯47120101), and calculations can be performed on all'
_,←L,'dates both before and after that starting point.'
_,←L,''
_,←L,'Important note:  Dates from 15 Oct 1582 and later are assumed to represent'
_,←L,'dates in the Gregorian (reform) calendar and dates from 4 Oct 1582 and earlier'
_,←L,'are assumed to represent dates in the (proleptic) Julian calendar, even those'
_,←L,'that are prior to the official adoption of the Julian calendar in 46 B.C.'
_,←L,'Other variations and complications in the use of historical dates (such as'
_,←L,'those surrounding and immediately following the adoption of the Julian calendar'
_,←L,'system -- 46 B.C. to 4 A.D., or the variable date of switchover to the'
_,←L,'Gregorian calendar) are summarily ignored.'
_,←L,''
_,←L,'The "Julian Day Number" (also called the Julian Day or JD, but *not* the Julian'
_,←L,'Date) form of the dates (JJJJJJJ) is the standard way of consistently measuring'
_,←L,'dates regardless of the local calendar in use at any given time.  Its origin is'
_,←L,'at (Julian proleptic date) January 1, 4713 B.C. where the JD = 0.  In many'
_,←L,'Julian Day Number systems (especially those used by astronomers), dates were'
_,←L,'actually assigned fractional numbers so that a time of day might be so'
_,←L,'indicated.  In such systems, the whole value of the Julian Day represents noon'
_,←L,'on that day, so the previous midnight would be .5 days less and the following'
_,←L,'midnight would be .5 days more.  ⎕DT timestamps follow this convention.  Such'
_,←L,'fractional day numbers are not supported by most of these routines and all'
_,←L,'dates should be considered to be the whole number (noontime for astronomers)'
_,←L,'value for that day.  However, JD and GD have been modified to allow special'
_,←L,'"timestamp" formats for convenience, and these can accept and produce special'
_,←L,'fractional-day values which start at *midnight* (and thus are 12 hours'
_,←L,'different than astronomical/⎕DT day-fractions noted above).'
_,←L,''
_,←L,'The conversion routines were modified slightly so that a Julian Day (JJJJJJJ)'
_,←L,'of zero is returned and accepted when the calendar date (YYYYMMDD) is zero.'
_,←L,'This is to facilitate the handling of "null" (e.g. empty, undefined) dates by'
_,←L,'use of the value zero in either format.  Unfortunately, this means that the'
_,←L,'exact (Julian proleptic) date of January 1, 4713 B.C. (¯47120101) is not'
_,←L,'fully available for use since it also equates to day number zero.  This is not'
_,←L,'expected to pose any difficulties to programmers in the real world, however.'
_,←L,''
_,←L,'The basis for the date conversion algorithms was derived from a detailed'
_,←L,'mathematical analysis by Peter Baum in 1998 and additional formulas and'
_,←L,'algorithms were derived from the current "calendar FAQ".  At that time, Peter''s'
_,←L,'information was available from his web site at'
_,←L,'<http://mysite.verizon.net/aesir_research/date/date0.htm> and the FAQ is usually'
_,←L,'multi-posted to the following Usenet news groups: <sci.astro>, <soc.history>,'
_,←L,'<sci.answers>, <soc.answers>, and <news.answers>.  Wikipedia also has lots of'
_,←L,'useful and detailed information available.  Please consult these extensive'
_,←L,'sources of information for more details on the inner workings of the algorithms'
_,←L,'and the historical use of calendars through the centuries.'
_,←L,''
_,←L,'The syntax of these routines is as follows:'
_,←L,14⍴' '
_,←L,'{JJJJJJJ} ← JD {YYYYMMDD}'
_,←L,'    Converts a calendar-form date to a serial (Julian) day number.  If YYYYMMDD'
_,←L,'    is negative, this indicates that the year itself is negative (not affecting'
_,←L,'    the month or day) and is used to describe a date B.C.  If YYYYMMDD is zero,'
_,←L,'    then the returned JJJJJJJ result will also be zero to facilitate the'
_,←L,'    implementation of "null" dates.  While the example format given above is the'
_,←L,'    primary syntax/usage, alternative syntaxes are also available.  Input dates'
_,←L,'    may be given in "expanded" (⎕TS-like) format where the dates are provided as'
_,←L,'    separate year, month, and day numbers, as long as they are nested together'
_,←L,'    into an enclosed scalar anywhere a simple 8-digit scalar would normally be'
_,←L,'    expected (e.g. ⊂3↑⎕TS).  Also, a time of day may be included to specify a'
_,←L,'    "timestamp" value, either by including a decimal fraction on the date'
_,←L,'    integer with the time in readable form (YYYYMMDD.HHMMSS) or by extending the'
_,←L,'    "expanded" format to have up to 7 items in the nested vector.  In either'
_,←L,'    case, the resulting Julian Day Number will no longer be an integer, but'
_,←L,'    instead will contain the usual day value plus a fractional amount of a day'
_,←L,'    representing the time of day (since midnight) provided.'
_,←L,''
_,←L,'{YYYYMMDD} ← [expand] GD {JJJJJJJ}'
_,←L,'    Converts a serial day number to a calendar-form date.  If JJJJJJJ is zero,'
_,←L,'    the the returned YYYYMMDD result will also be zero to facilitate the'
_,←L,'    implementation of "null" dates.  To further enhance the ability to'
_,←L,'    interface this with other code and systems, it is also possible to have'
_,←L,'    the dates returned as nested numeric vectors which are the usual scalar'
_,←L,'    dates separated into independent year, month, and day values similar'
_,←L,'    to (⊂3↑⎕TS).  This form of output is produced by specifying a scalar 3 as'
_,←L,'    the optional left argument to the function.  If a fractional serial day'
_,←L,'    number is provided, then a fractional result will be returned giving the'
_,←L,'    time in a readable YYYYMMDD.HHMMSS format.  If full timestamps are desired'
_,←L,'    in enclosed ⎕TS form, supply a left argument of 7.  (Any number between'
_,←L,'    1 and 7 may be used instead for shorter nested results if desired.)'
_,←L,''
_,←L,'{JJJJJJJ} ← Today'
_,←L,'    Return the current date (⎕TS) in JJJJJJJ form for use by these routines or'
_,←L,'    any other process that can use "standard" Julian Day Numbers.'
_,←L,'    The implementation is simply "JD 100⊥3↑⎕TS".'
_,←L,''
_,←L,'{JJJJJJJ.FFFFFFFFF} ← Now'
_,←L,'    Return the current date and time (⎕TS) in fractional JJJJJJJ.FFFFFF form'
_,←L,'    for use where a combined timestamp value is preferred.  This is the same as'
_,←L,'    Today (a Julian Day Number), except that it also contains the current time'
_,←L,'    with a fractional portion indicating the time of day (e.g. X.0 = midnight,'
_,←L,'    X.5 = noon, X.75 = 6pm).  This form can be used as a full timestamp and can'
_,←L,'    be processed directly by routines designed for that.  It is also recognized'
_,←L,'    by GD (which can then return a fractional result) & Spell.  The date'
_,←L,'    portion may be extracted with "⌊" and the time portion extracted and'
_,←L,'    converted to seconds with "86400×1|".  The implementation is simply'
_,←L,'    "JD ⊂⎕TS".  Note that most of the other functions here do not accept'
_,←L,'    fractional inputs.'
_,←L,''
_,←L,'{dayofweek} ← DayOfWeek {JJJJJJJ}'
_,←L,'    For any given Julian day number, return the day of the week on which it'
_,←L,'    falls.  Sunday is given as 1 and Saturday as 7.'
_,←L,''
_,←L,'{dayofyear} ← DayOfYear {JJJJJJJ}'
_,←L,'    For any given Julian day number, return the day of that year on which it'
_,←L,'    falls.  January 1 is given as 1 and December 31 as 365 or 366.'
_,←L,''
_,←L,'{isLeap} ← IsLeapYear  {YYYY}'
_,←L,'    For any given year, return a 1 if it is a leap year or a 0 if not.'
_,←L,''
_,←L,'{ageinyears} ← [today←Today] Age {JJJJJJJ}'
_,←L,'    For a given "starting" date, return a calendar age (in calendar years and'
_,←L,'    fractions thereof) that have elapsed from that date until today (or other'
_,←L,'    specified "ending" date in JJJJJJJ format that is supplied as the left'
_,←L,'    argument).  Fractional years are computed by counting days between the last'
_,←L,'    "birthday" and the next, and thus there may not always be exact half and'
_,←L,'    quarter years for some dates.  Previous, next, and nearest whole ages may'
_,←L,'    be extracted by using floor (⌊), ceiling (⌈), and round (⌊.5+),'
_,←L,'    respectively.'
_,←L,''
_,←L,'{JJJJJJJ} ← [startday←1] BeginWeek {JJJJJJJ}'
_,←L,'    For a given date, return the date of the first day (Sunday) of the week'
_,←L,'    containing that date (i.e. the Sunday on or immediately preceeding the'
_,←L,'    date given).  If a week is considered to begin on a different day (on'
_,←L,'    Monday or Saturday for example), then that day number (2, 7, etc.) may'
_,←L,'    be provided as a left argument to the routine to logically shift the'
_,←L,'    notion of the "beginning of the week".'
_,←L,''
_,←L,'{JJJJJJJ} ← [startday←1] BeginMonth {JJJJJJJ}'
_,←L,'    For a given date, return the date of the first day of the calendar month'
_,←L,'    containing that date.  If a month is to be considered to begin on a'
_,←L,'    different day (on the 5th, or the 25th, or other unusual boundary), then'
_,←L,'    that day number (5, 25, etc.) may be provided as a left argument to the'
_,←L,'    routine to logically shift the notion of the "beginning of the month".'
_,←L,''
_,←L,'{JJJJJJJ} ← [startmonthday←0101] BeginYear {JJJJJJJ}'
_,←L,'    For a given date, return the date of the first day of the calendar year'
_,←L,'    containing that date.  If a year is to be considered to begin on a'
_,←L,'    different day (on March 1st, or December 25th, or other unusual boundary'
_,←L,'    such as those representing fiscal tax years), then that month and day'
_,←L,'    (as a 4-digit number: 0301, 1225, etc.) may be provided as a left argument'
_,←L,'    to the routine to logically shift the notion of the "beginning of the year".'
_,←L,''
_,←L,'{JJJJJJJ} ← [months←1] AddMonth {JJJJJJJ}'
_,←L,'    Add one calendar month to the date given and return its date.  Zero, or'
_,←L,'    more than one month may be added, or one or more months may be subtracted,'
_,←L,'    by giving the routine a left argument specifying the number of months to'
_,←L,'    add (subtract if negative).  If the day of the month (e.g. 31st) is not'
_,←L,'    part of the following month (e.g. April), then the first legal day'
_,←L,'    following it is returned instead (e.g. May 1st).'
_,←L,''
_,←L,'{JJJJJJJ} ← [years←1] AddYear {JJJJJJJ}'
_,←L,'    Add one calendar year to the date given and return its date.  Zero, or'
_,←L,'    more than one year may be added, or one or more years may be subtracted, by'
_,←L,'    giving the routine a left argument specifying the number of years to add'
_,←L,'    (subtract if negative).  If the day of the year (e.g. Feb 29th in a leap'
_,←L,'    year) is not part of the resulting year (e.g. it is not a leap year), then'
_,←L,'    the first legal day following it is returned instead (e.g. March 1st).'
_,←L,''
_,←L,'{JJJJJJJ} ← [weekdays←1] AddWeekday {JJJJJJJ}'
_,←L,'    Add one week day (Monday-Friday) to the date given and return its date.'
_,←L,'    Zero, or more than one week day may be added, or one or more week days may'
_,←L,'    be subtracted, by giving the routine a left argument specifying the number'
_,←L,'    of week days to add (subtract if negative).  If the starting date is not a'
_,←L,'    week day, then the starting date is shifted forward to Monday before'
_,←L,'    counting begins.'
_,←L,''
_,←L,'{JJJJJJJ} ← [workdays←1] {holidayfilter} AddWorkday {JJJJJJJ}'
_,←L,'    Add one non-holiday week day to the date given and return its date.'
_,←L,'    Zero or more work days may be added, or one or more work days may be'
_,←L,'    subtracted, by giving the routine a left argument specifying the number'
_,←L,'    of work days to add (subtract if negative).  If the starting date is not a'
_,←L,'    work day, then the starting date is shifted forward to the next legal work'
_,←L,'    day before counting begins.'
_,←L,''
_,←L,'    This routine is identical to the AddWeekday function except that it skips'
_,←L,'    over holidays as well as weekends.  This is an operator instead of a'
_,←L,'    function and it takes as its required left operand a function that'
_,←L,'    determines whether or not a provided Julian day is to be considered a'
_,←L,'    holiday or not.  For each argument date it should return a 1 (for a'
_,←L,'    holiday) or a 0 (for a work day).  The included function ExampleHoliday'
_,←L,'    is an example of this sort of operand and reports official U.S. banking'
_,←L,'    holidays.'
_,←L,''
_,←L,'{isholiday} ← ExampleHoliday {JJJJJJJ}'
_,←L,'    For use as an operand to AddWorkday, an example for determining holidays.'
_,←L,'    Return a 1 if the given date is a recognized U.S. national banking holiday'
_,←L,'    or a 0 otherwise.  The following holidays are recognized (on date'
_,←L,'    observed):'
_,←L,'        New Years Day       Independence Day    Thanksgiving'
_,←L,'        MLK''s Birthday      Labor Day           Christmas'
_,←L,'        President''s Day     Columbus Day'
_,←L,'        Memorial Day        Veterans Day'
_,←L,''
_,←L,'{JJJJJJJ} ← Easter {YYYY}'
_,←L,'    Return the date that Easter falls on in a given year.  This is a difficult'
_,←L,'    calculation.  The rule used is:  Easter Sunday is the first Sunday after'
_,←L,'    the ecclesiastical full moon on or after the ecclesiastical vernal equinox.'
_,←L,'    The ecclesiastical vernal equinox is always March 21st.  The astronomical'
_,←L,'    vernal equinox may actually occur on the 19th or 20th and the'
_,←L,'    ecclesiastical full moon may differ from the actual astronomical full moon'
_,←L,'    by a day either way.  There are also variances to take into account for'
_,←L,'    effective longitude and the effects of the international date line.  The'
_,←L,'    ecclesiastical rules define how these effects are all handled.  This'
_,←L,'    function uses the above rule for Gregorian calendar dates (after 1582) and'
_,←L,'    a simpler calculation for older Julian calendar dates (before 1583).'
_,←L,''
_,←L,'{text} ← {pattern} Spell {JJJJJJJ}'
_,←L,'    Format a given date or timestamp as text.  The format to be used is'
_,←L,'    specified by use of a pattern phrase provided as the left argument.  This'
_,←L,'    is a cover function that calls the system facility 1200⌶ and the pattern'
_,←L,'    to be provided is defined by that facility.  Timestamps to be formatted'
_,←L,'    must fall within the range limits set by 1200⌶ and ⎕DT.  Examples include:'
_,←L,'        MMM D, YYYY'
_,←L,'        YYYY-MM-DD'
_,←L,'        MM/DD/YY'
_,←L,'        t:mmp "on" Dddd, Mmmm Doo, YYYY'
_,←L,''
_,←L,'    Formatted text is returned as a variable-length character vector.  A vector'
_,←L,'    (or matrix) of timestamps is returned as a vector (or matrix) of character'
_,←L,'    vectors.  However, a scalar (not a 1⍴ vector) timestamp value is returned'
_,←L,'    as an unnested character vector for convenience.'
_,←L,'    A "null" timestamp (Julian Day Number = 0.0) or a value of ⎕NULL is'
_,←L,'    formatted as an empty character vector (regardless of the pattern format'
_,←L,'    requested) to conveniently deal with "missing" or "undefined" timestamps.'
_,←L,''
_,←L,'{DST} ← Daylight {YYYY}'
_,←L,'    Return Daylight Savings Time rules for the specified year(s) in the local'
_,←L,'    time zone.  The result is in the same shape as the argument, but with each'
_,←L,'    item being nested and containing three numeric values for that year:'
_,←L,'        [1] Number of hours to add to the time zone during DST'
_,←L,'        [2] The timestamp when DST begins in that year'
_,←L,'        [3] The timestamp when DST ends in that year'
_,←L,'    If the argument is a scalar (not a 1⍴ vector) then the result is returned'
_,←L,'    unnested for convenience.'
_,←L,''
_,←L,'{JJJJJJJ.FFFFFFFFF} ← Local {JJJJJJJ.FFFFFFFFF}'
_,←L,'    Given a UTC (Universal Time) timestamp in JDN form, convert it to a local'
_,←L,'    timezone timestamp in similar form.  This conversion process respects any'
_,←L,'    Daylight Savings Time adjustment that was in effect on that date.'
_,←L,''
_,←L,'{JJJJJJJ.FFFFFFFFF} ← UTC {JJJJJJJ.FFFFFFFFF}'
_,←L,'    Given a local timestamp in JDN form, convert it to a UTC (Universal Time)'
_,←L,'    timezone timestamp in similar form.  This conversion process respects any'
_,←L,'    Daylight Savings Time adjustment that was in effect on that date.'
_,←L,''
_,←L,'{tz} ← TimeZone'
_,←L,'    Return static information about the local time zone.'
_,←L,'    [1] ← Number of standard-time hours offset from UTC (Univeral Time)'
_,←L,'    [2] ← Name of time zone'
_,←L,'    [3] ← Descriptive title of time zone'
_,←L,'    [4] ← Title of standard time zone'
_,←L,'    [5] ← Title of daylight savings time zone'
_,←L,''
_,←L,''
_,←L,''
_,←L,'*** Examples of application use ***'
_,←L,''
_,←L,'    Today+7'
_,←L,'A week from today.'
_,←L,''
_,←L,'    14 ExampleHoliday AddWorkday ⍵'
_,←L,'14 working days from a starting date.'
_,←L,''
_,←L,'    ¯1+AddMonth BeginMonth ⍵'
_,←L,'Find the last day of the month.'
_,←L,''
_,←L,'    6 BeginWeek ⍵'
_,←L,'Find the most-recent Friday.'
_,←L,''
_,←L,'    2 BeginWeek 7+AddMonth BeginMonth ⍵'
_,←L,'The first Monday of next month.'
_,←L,''
_,←L,'    ¯3 ExampleHoliday AddWorkday AddMonth BeginMonth ⍵'
_,←L,'The last day of the month a shipment could be sent to arrive by the first of'
_,←L,'next month, assuming it takes 3 working days to arrive.'
_,←L,''
_,←L,'    2415019+⍵'
_,←L,'Convert a date-value from Microsoft Excel into this notation.'
_,←L,''
_,←L,'    2 BeginWeek 7+BeginYear ⍵'
_,←L,'The first Monday of the year.'
_,←L,''
_,←L,'    6 BeginWeek ¯8+AddMonth BeginMonth ⍵'
_,←L,'The next-to-last Friday of the month.'
_,←L,''
_,←L,'    WW {⍵+7×(⍺=5)∧=/BeginMonth ⍵+0 7} DOW BeginWeek JD⊂YYYY,MM,7×4⌊WW'
_,←L,'Compute the date from a year, month, week (up to 5), and day-of-week.'
_,←L,''
Describe←_

⎕ex¨ 'L' '_'

⍝ === End of variables definition ===

(⎕IO ⎕ML ⎕WX ⎕CT)←1 1 3 1E¯13

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
     ⍝ Years are normally considered to begin on the first day of the first
     ⍝ month (=0101) of the year, but to support odd fiscal years a different
     ⍝ beginning-of-year month/day number (0101-1231) may be specified as an
     ⍝ optional left argument.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 :If 0=⎕NC'start' ⋄ start←101 ⋄ :EndIf ⍝ Default = 01/01 to begin years
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

∇ DOY←DayOfYear JJJ;YMD
     ⍝ Given a "Julian Day Number", return its day in that year.
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified 9 March 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 YMD←GD JJJ ⋄ DOY←(JJJ≠0)×1+JJJ-JD(×YMD)×101+10000×⌊|YMD÷10000
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
 :AndIf (∧/,1721426≤JJJ)∧∧/,3182088≥JJJ ⍝ ...and within range
     JJJ←JJJ-0.5 ⍝ ⎕DT starts at noon instead of midnight as we prefer
     :If 0=⎕NC'expand' ⋄ :OrIf ~(⊃expand)∊⍳7 ⋄ YMD←50 60 ⎕DT JJJ
     :Else ⋄ YMD←(⊃expand)↑¨50 ¯1 ⎕DT JJJ ⋄ :EndIf
 :Else ⍝ Older version of system - simulate ⎕DT
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

∇ JJJ←JD YMD;Y;M;y1600;HMS;⎕CT
     ⍝ Convert a Gregorian-style date (YYYYMMDD) to a "Julian Day Number".
     ⍝ If any item of the input is nested, then that date is assumed to be
     ⍝ separated into a 3-item nested vector containing separate numeric
     ⍝ values for year, month, and day.  Such nested vectors will be converted
     ⍝ to unnested/combined values before processing (as with 100⊥¨).
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
     ⍝ Any rank & shape array accepted.  See "Describe" for more details.
     ⍝   Constants: 1721117 ← 1-Jan-0001; 2299160 ← 4-Oct-1582
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Modified April 2010 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 29, 2020 by Davin Church of Creative Software Design
     
 :If 18≤2⊃⎕VFI 3↑2⊃'.'⎕WG'APLVersion' ⍝ Use ⎕DT if it's available
 :AndIf (0 1∊⍨≡YMD)∨(∧/,1≤⊃¨YMD)∧∧/,4000≥⊃¨YMD ⍝ ...and within range
 :AndIf (1<≡YMD)∨(∧/,10101≤⊃¨YMD)∧∧/,40000228≥⊃¨YMD
     :If 1<|≡YMD ⋄ JJJ←¯1 50 ⎕DT YMD ⋄ :Else ⋄ JJJ←60 50 ⎕DT YMD ⋄ :EndIf ⍝ Alternate input forms
     JJJ←JJJ+0.5 ⍝ ⎕DT starts at noon instead of midnight as we prefer
 :Else ⍝ Older version of system - simulate ⎕DT
     ⎕CT←1E¯16 ⍝ Avoid some millisecond rounding problems
     :If 1<|≡YMD ⍝ Select which alternate input form used
         HMS←(⌊0.5+(⊂0 60 60 1000)⊥¨4↑¨3↓¨YMD)÷86400000
         YMD←(¯1*0>⊃¨YMD)×100⊥¨(3⌊⍴¨,¨YMD)↑¨|YMD
     :ElseIf 1∊0≠HMS←⌊0.5+1000000000×1||YMD ⍝ Did they give us a timestamp?
              ⍝ Separate out & fractionalize optional timestamp
         YMD←⌊YMD ⋄ HMS←((⊂0 60 60 1000)⊥¨(⊂0 100 100 1000)⊤¨HMS)÷86400000
     :EndIf
     Y←(×YMD)×⌊|YMD÷10000 ⋄ M←⌊(YMD←10000||YMD)÷100 ⋄ Y←Y-12<M←M+12×M≤2
     JJJ←(100|YMD)+0 0 0 31 61 92 122 153 184 214 245 275 306 337[M]
     y1600←0⌈Y-1600 ⋄ JJJ←JJJ+1721117+(⌊Y×365.25)-(⌊y1600÷100)-⌊y1600÷400
     JJJ←HMS+(YMD≠0)×JJJ-10×JJJ>2299160
 :EndIf
∇

∇ local←Local utc
     ⍝ Convert a UTC Julian Day timestamp to a local Julian Day timestamp
     ⍝ See "Describe" for more details.
     ⍝ Written July 1, 2020 by Davin Church of Creative Software Design
     
 :If 0≠⍴⍴utc ⋄ local←Local¨utc ⋄ :Return ⋄ :EndIf ⍝ .NET is scalar-oriented
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

∇ tz←TimeZone
      ⍝ Return base information about the local time zone
     
 tz←System.TimeZoneInfo.Local.(BaseUtcOffset.TotalHours Id DisplayName StandardName DaylightName)
∇

∇ JJJ←Today
     ⍝ Return today's date in JJJJJJJ format.  See "Describe" for more details.
     ⍝
     ⍝ Written in 1998 by Davin Church of Creative Software Design
     ⍝ Converted from APL+Win to Dyalog June 30, 2020 by Davin Church of Creative Software Design
     
 JJJ←JD 100⊥3↑⎕TS
∇

∇ utc←UTC local
     ⍝ Convert a local Julian Day timestamp to a UTC Julian Day timestamp
     ⍝ See "Describe" for more details.
     ⍝ Written July 1, 2020 by Davin Church of Creative Software Design
     
 :If 0≠⍴⍴local ⋄ utc←UTC¨local ⋄ :Return ⋄ :EndIf ⍝ .NET is scalar-oriented
 utc←(System.DateTime.SpecifyKind(⎕NEW System.DateTime(⊃7 GD local))2).ToUniversalTime
 utc←JD⊂utc.(Year Month Day Hour Minute Second Millisecond)
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
