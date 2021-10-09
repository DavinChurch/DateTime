# Introduction to DateTime

These are date-manipulation routines for calculating with dates as Julian Day Numbers (not Julian Dates) using Dyalog APL.  They support and use ⎕DT (and 1200⌶ at present) from Dyalog APL v18.0 and later, but almost all of the functionality is available in earlier versions of APL as well.

Simple calculations with serial date numbers such as these simply involve adding and subtracting a number of days, but these tools are available for more complicated calculations such as adding/subtracting calendar months, years, weekdays, and working days, and finding the day of week/month/year, the beginning of weeks, months, years, calendar ages, and similar functionality.  Timestamps are also supported for some processes by using a fractional date, and time-sensitive functions are available for changing between local and UTC time zones, determining time zones, daylight savings time adjustments, and so on.

The basic functionality begins with two functions that convert back and forth between Julian Day Number and Gregorian Date, for interfacing with other systems.  These functions use ⎕DT if it is available or will calculate it in ordinary APL if it isn't.  Most of the remaining tools perform calculations directly on the Julian Day Numbers.

1200⌶ is also used by a cover function (Spell) to format dates and times.  Spell is expected to be updated when 1200⌶ is one day integrated into ⎕DT itself.

Complete documentation for these tools is available here, as is a suite of testing tools.

# Repository Organization

This is a member of the [APLTree project](https://github.com/aplteam/apltree) and is also available via the [Tatin package manager](https://github.com/aplteam/Tatin).

## The Distribution Directory

This directory contains a workspace copy of the code for those that desire that form.  However, it is expected that most distribution will be done with the individual source code text files in the Source directory. A namespace script is also available here for those that prefer that distribution mechanism.

## The Documentation Directory

This directory contains a PDF file with extensive documentation on the toolkit and its components.  It begins with an introduction to the facilities available, including a list of tool names and their purpose.  General information and background on date-handling follows.  The bulk of the document contains an alphabetical list of tools with their usage syntax and individual descriptions.  Following that is a short list of examples in some of the ways that the tools can be used, including combining tools together for a particular purpose.  The last section is a quick reference guide on the syntax of each of the tools for easy reference when a reminder is needed.

## The Source/DateTime Directory

This directory is intended to be imported as a complete static namespace and contains all the code needed to use this package.  It contains no external dependencies.

## The Source/Testing Directory

This directory is its own namespace which contains facilities for testing all the DateTime functions, which are expected to be found in the #.DateTime namespace.  This code is provided only for testing the main toolkit and is not needed for any application use.

Most of the functions herein are named after the corresponding public routines in DateTime.  Simply execute the desired function here to test the corresponding DateTime routine.  If multiple functions are to be tested, the `Test` function may be invoked with a list of function names (in almost any reasonable structure and format) as a right argument.  These names may include an `*` wild-card character, so `Test '*'` will execute all the functions in the workspace.

For more details on using `Test` and the testing engine, see the [Tester package](https://github.com/DavinChurch/Tester) in the companion repository.