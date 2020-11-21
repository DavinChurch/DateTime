# Introduction to DateTime

These are date-manipulation routines for calculating with dates as Julian Day Numbers (not Julian Dates) using Dyalog APL.  They support and use ⎕DT and 1200⌶ from Dyalog APL v18.0 and later, but almost all of the functionality is available in earlier versions of APL as well.

Simple calculations with serial date numbers such as these simply involve adding and subtracting a number of days, but these tools are available for more complicated calculations such as adding/subtracting calendar months, years, weekdays, and working days, and finding the day of week/month/year, the beginning of weeks, months, years, calendar ages, and similar functionality.  Timestamps are also supported for some processes by using a fractional date, and time-sensitive functions are available for changing between local and UTC time zones, determining time zones, daylight savings time adjustments, and so on.

The basic functionality begins with two functions that convert back and forth between Julian Day Number and Gregorian Date, for interfacing with other systems.  These functions use ⎕DT if it is available or will calculate it in ordinary APL if it isn't.  Most of the remaining tools perform calculations directly on the Julian Day Numbers.

1200⌶ is also used by a cover function to format dates and times.  This is expected to be updated when 1200⌶ is one day integrated into ⎕DT itself.

Complete documentation for these tools is available here, as is a suite of testing tools.

# Repository Organization

This is a member of the APLTree project at https://github.com/aplteam/apltree.

## The Distribution Directory

This directory contains a workspace copy of the code for those that desire that form.  However, it is expected that most distribution will be done with the individual source code text files in the Source directory.

## The Documentation Directory

This directory contains a PDF file with extensive documentation on the toolkit and its components.  It begins with an introduction to the facilities available, including a list of tool names and their purpose.  General information and background on date-handling follows.  The bulk of the document contains an alphabetical list of tools with their usage syntax and individual descriptions.  Following that is a short list of examples in some of the ways that the tools can be used, including combining tools together for a particular purpose.  The last section is a quick reference guide on the syntax of each of the tools for easy reference when a reminder is needed.

## The Source/DateTime Directory

This directory is intended to be imported as a complete static namespace and contains all the code needed to use this package.  It contains no external dependencies.

## The Source/Testing Directory

This directory is its own namespace which contains facilities for testing all the DateTime functions, which are expected to be found in the #.DateTime namespace.  This code is provided only for testing the main toolkit and is not needed for any application use.

Most of the functions herein are named after the corresponding public routines in DateTime.  Simply execute the desired function here to test the corresponding DateTime routine.  If multiple functions are to be tested, the `Test` function may be invoked with a list of function names (in almost any reasonable structure and format) as a right argument.  These names may include an `*` wild-card character, so `Test '*'` will execute all the functions in the workspace.  An optional left argument may be specified to temporarily override the global `StopOnError` setting _(see below)_.  `Test` will return a completion message unless errors are being counted, in which case it will return that count.

### Testing engine

The testing engine itself is also resident in this namespace.  It consists of three standalone operators.  These may be extracted separately and used for simple argument/result testing anywhere.  The left operand of each operator is the function to be tested.  The right operand is the expected result.  The derived function uses the provided left and right arguments and passes them directly to the function being tested.  The three routines are:

Tester | Used to...
------ | ----------
`Pass` | Make sure the tested function returns the expected right operand, if a value is specified.  A boolean function may be specified instead which is called monadically with the result to determine if the result is correct.
`Pass_` | Make sure the tested function does NOT return an explicit result in this case.  The right operand must be a boolean function to determine if the tested function produced proper side-effects, or `{1}` is sufficient if no explicit test is to be performed.
`Fail` | Make sure the tested function exits with a `⎕SIGNAL` as validated by the right operand.  The right operand may be text to match `⎕DM`, a numeric (array) for `⎕EN` to be a member of, or a boolean function (provided both of these values) to determine if the failure was as expected.

These routines all respect the setting of an optional global variable named `StopOnError`, which may be set to any of the following values:
`StopOnError` | Function
---- | ----------
`0` | Do not stop, just report invalid results.
`1` | Stop in the testing function on the line that did not validate. _\[Default\]_
`2` | Stop in the tested function at the original error without any error trapping.
`¯1` | Do not stop, and increment global variable "Errors" if it exists.

#### Writing new testing functions
Create one or more functions with any desired names that uses these operators for each function call to be tested.  For instance, if a function to be tested is:
```
      3 Plus 4
7
```
Use the simple command:
```
      3 (Plus Pass 7) 4
```
Testing routines may include other code as needed to prepare the tests to be performed, loop through multiple tests, or perform any other desired actions.  A niladic function may be tested by enclosing it in a d-fn and passing a dummy argument.  Remember that when invoking operators, the right operand has short scope and probably needs to be enclosed in parentheses if an expression is being used.
