# FoxRegEx

`FoxRegEx` is a Visual FoxPro Class library that wrappers the <code>RegEx</code> built-in object in VBScript.

<h2>Overview</h2>

`FoxRegEx` matches any string against special text pattern called `Regular Expression` and returns either an object or a cursor filled  with all the matches.

A regular expression is a string that describes a match pattern. The match pattern provides a template that can be used to test another string, the search string, for a matching sub-string. In its simplest form, the match pattern string is just a sequence of characters that must be matched. For example, the pattern "vfp" matches this exact sequence of characters and only this sequence. More sophisticated regular expressions can match against items such as file names, path names, and Internet URLs. Thus, the RegExp object is frequently used to validate data for correct form and syntax.

# Table of Contents

- [Installation](#installation)
- [Simple Test](#simple-test)
- [Using Cursor](#using-cursor)
- [Using Object](#using-object)
- [Built-in RegEx](#built-in-regex)
	- [URL](#url)
	- [IPv4](#ipv4)
	- [IPv6](#ipv6)
	- [Email](#email)
	- [Youtube-Video-ID](#youtube-video-id)
	- [Youtube-Channel-ID](#youtube-channel-id)
	- [HTML Tag](#html-tag)
	- [Hex Color](#hex-color)
	- [Date](#date)
- [License](#license)


## Installation

```
Just copy the FoxRegEx prg anywhere into your project PATH folder.
```

## Simple Test
```xBase
// declare the FoxRegEx Prg
Set Procedure to "FoxRegEx" Additive

// Instantiate FoxRegEx Object
=AddProperty(_vfp, "FoxRegEx", CreateObject("FoxRegEx"))
// The Pattern property stores the specials characters that defines the math pattern.
_vfp.FoxRegEx.Pattern = "vfp"
// Call the Test() method for quick pattern validations.
?_vfp.FoxRegEx.Test("vfp Rocks!") //Returns boolean
```
## Using Cursor

```xBase
// Set the Global Flag true if you want to match all occurrences.
_vfp.FoxRegEx.Global = .T.
// Turn on IgnoreCase flag for matching lowercase and uppercase.
_vfp.FoxRegEx.IgnoreCase = .T.
// The Pattern property stores the specials characters that defines the math pattern.
_vfp.FoxRegEx.Pattern = "\b\w+\b"
// By setting UseCursor to true you must set two mores flags (CursorName and Session)
_vfp.FoxRegEx.UseCursor = .T.
// CursorName will be the final cursor which contain all the matches.
_vfp.FoxRegEx.CursorName = "cMatches"
// Set the Session property if you are using private sessions.
_vfp.FoxRegEx.Session = _Screen.DataSessionID
// Finally call the Execute() method with the source string.
nCount = _vfp.FoxRegEx.Execute("the mouse and the cat")
If nCount > 0
   Select cMatches
   Browse Fields Id, Value Title "These are the final columns"
Endif
```
## Using Object

```xBase
// Set the Global Flag true if you want to match all occurrences.
_vfp.FoxRegEx.Global = .T.
// Turn on IgnoreCase flag for matching lowercase and uppercase.
_vfp.FoxRegEx.IgnoreCase = .T.
// The Pattern property stores the specials characters that defines the math pattern.
_vfp.FoxRegEx.Pattern = "\b\w+\b"
// Call the Execute() method with the source string.
loMatches = _vfp.FoxRegEx.Execute("the mouse and the cat")
For loItem in loMatches
   ?loItem.Value
Endfor
```

## Built-in RegEx

FoxRegEx comes with some built-in commons validators patterns such as email, URL, Date, etc.

### `URL`
```xBase
_vfp.FoxRegEx.isURL("https://github.com/Irwin1985/FoxRegEx")  // .T.
```
### `IPv4`
```xBase
_vfp.FoxRegEx.isIPv4("192.168.0.1")  // .T.
```
### `IPv6`
```xBase
_vfp.FoxRegEx.isIPv6("2001:db8:0:1:1:1:1:1")  // .T.
```
### `Email`
```xBase
_vfp.FoxRegEx.isEmail("rodriguez.irwin@gmail.com")  // .T.
```
### `Youtube-Video-ID`
```xBase
_vfp.FoxRegEx.isYoutubeVideoID("https://www.youtube.com/watch?v=UUjpNm07vL8")  // .T.
```
### `Youtube-Channel-ID`
```xBase
_vfp.FoxRegEx.isYoutubeChannelID("https://www.youtube.com/c/IrwinRodriguez")  // .T.
```
### `HTML Tag`
```xBase
_vfp.FoxRegEx.isHTMLTag("<vfp>Fox Rules!</vfp>")  // .T.
```
### `Hex Color`
```xBase
_vfp.FoxRegEx.isHexColor("#FFFFFF")  // .T.
```
### `Date`
```xBase
// Provide any valid date format
_vfp.FoxRegEx.isDate("15/11/1985", "dd/mm/YYYY")  // .T.
// using YYYY-mm-dd
_vfp.FoxRegEx.isDate("1985-11-15", "YYYY-mm-dd")  // .T.
// using mm-dd-YYYY
_vfp.FoxRegEx.isDate("11-15-1985", "mm-dd-YYYY")  // .T.
// using short year format
_vfp.FoxRegEx.isDate("11-15-85", "mm-dd-YY")  // .T.
```
## License

FoxRegEx is released under the MIT Licence.
