Define Class FoxRegExTest As FxuTestCase Of FxuTestCase.prg

	#If .F.
		Local This As FoxRegExTest Of FoxRegExTest.prg
	#Endif
	icTestPrefix = "test"
	setProcAct = ""
	RegEx = .Null.
&& ======================================================================== &&
&& Function Setup
&& ======================================================================== &&
	Function Setup
		This.setProcAct = Set("Procedure")
		Set Procedure To "FoxRegEx" Additive
		This.RegEx = Createobject("FoxRegEx")
	Endfunc
&& ======================================================================== &&
&& Function TearDown
&& ======================================================================== &&
	Function TearDown
		Local lcSetProcAct As String
		lcSetProcAct = This.setProcAct
		This.RegEx = .Null.
		Clear Class FoxRegEx
		Release Procedure FoxRegEx.prg
		Set Procedure To (lcSetProcAct)
	Endfunc
&& ======================================================================== &&
&& Function TestRegExObject
&& ======================================================================== &&
	Function TestRegExObject As Void
		If This.AssertNotNull(This.RegEx, "Object RegEx Does Not Exist")
			This.PrintOk("TestRegExObject")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestVersion
&& ======================================================================== &&
	Function TestVersion As Void
		This.RegEx.Version = "123"
		This.MessageOut("Current Version: " + This.RegEx.Version)
	Endfunc
&& ======================================================================== &&
&& Function TestGlobal
&& ======================================================================== &&
	Function TestGlobal As Void
		This.RegEx.Global = .T.
		If This.AssertTrue(This.RegEx.Global, "test failed")
			This.PrintOk("TestGlobal")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestPattern
&& ======================================================================== &&
	Function TestPattern As Void
		Local lcPattern As String
		lcPattern = "vfp"
		This.RegEx.Pattern = lcPattern
		If This.AssertTrue(This.RegEx.Pattern == lcPattern, "test failed")
			This.PrintOk("TestPattern")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIgnoreCase
&& ======================================================================== &&
	Function TestIgnoreCase As Void
		This.RegEx.IgnoreCase = .T.
		If This.AssertTrue(This.RegEx.IgnoreCase, "test failed")
			This.PrintOk("TestIgnoreCase")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestMultiLine
&& ======================================================================== &&
	Function TestMultiLine As Void
		This.RegEx.MultiLine = .T.
		If This.AssertTrue(This.RegEx.MultiLine, "test failed")
			This.PrintOk("TestMultiLine")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestUseCursor
&& ======================================================================== &&
	Function TestUseCursor As Void
		This.RegEx.UseCursor = .T.
		If This.AssertTrue(This.RegEx.UseCursor, "test failed")
			This.PrintOk("TestUseCursor")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestCursorName
&& ======================================================================== &&
	Function TestCursorName As Void
		This.RegEx.CursorName = "myCursor"
		If This.AssertTrue(This.RegEx.CursorName == "myCursor", "test failed")
			This.PrintOk("TestCursorName")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestSession
&& ======================================================================== &&
	Function TestSession As Void
		This.RegEx.Session = _Screen.DataSessionId
		If This.AssertTrue(This.RegEx.Session = _Screen.DataSessionId, "test failed")
			This.PrintOk("TestUseCursor")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestRegExTest
&& ======================================================================== &&
	Function TestRegExTest As Void
		This.RegEx.Global 		= .T.
		This.RegEx.IgnoreCase 	= .T.
		This.RegEx.Pattern 		= "vfp"
		If This.AssertTrue(This.RegEx.Test("vfp rocks!"), "test failed")
			This.PrintOk("TestRegExTest")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestExecuteAndReturnCursor
&& ======================================================================== &&
	Function TestExecuteAndReturnCursor As Void
		Local lcPattern As String, lcString As String
		lcPattern = "[a-z]{4}"
		lcString  = "If you see it in your mind, you will have it in your hands!"

		With This.RegEx
			.Global 	= .T.
			.IgnoreCase = .T.
			.Pattern 	= lcPattern
			.UseCursor 	= .T.
			.CursorName = "qRegEx"
			.Session	= _Screen.DataSessionId
		Endwith

		If This.AssertTrue(This.RegEx.Execute(lcString) > 0, "test failed")
			Set DataSession To (_Screen.DataSessionId)
			If Used("qRegEx")
				This.Messageout("These are the matches for the RegEx(" + lcPattern + ")")
				Select qRegEx
				Scan
					This.Messageout(Transform(qRegEx.Id) + " => " + Alltrim(qRegEx.Value))
				Endscan
				Use In (Select("qRegEx"))
				This.PrintOk("TestExecuteAndReturnCursor")
			Endif
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestExecuteAndReturnObject
&& ======================================================================== &&
	Function TestExecuteAndReturnObject As Void
		Local lcPattern As String, lcString As String, loMatches As Object, nCount As Integer
		lcPattern = "\b[a-z]{4}\b"
		lcString  = "If you see it in your mind, you will have it in your hands!"
		loMatches = .Null.
		nCount    = 0

		With This.RegEx
			.Global 	= .T.
			.IgnoreCase = .T.
			.Pattern 	= lcPattern
		Endwith
		loMatches = This.RegEx.Execute(lcString)

		If This.AssertNotNull(loMatches, "test failed")
			This.Messageout("These are the matches for the RegEx(" + lcPattern + ")")
			For Each loItem In loMatches
				nCount = nCount + 1
				This.Messageout(Transform(nCount) + " => " + Alltrim(loItem.Value))
			Endfor
			This.PrintOk("TestExecuteAndReturnObject")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestReplace
&& ======================================================================== &&
	Function TestReplace As Void
		Local lcPattern As String, lcString As String, lcResult As String, lcReplacement As String
		lcPattern     = "\b[a-z]{4}\b"
		lcString      = "If you see it in your mind, you will have it in your hands!"
		lcReplacement = "bla"
		With This.RegEx
			.Global 	= .T.
			.IgnoreCase = .T.
			.Pattern 	= lcPattern
		Endwith
		lcResult = This.RegEx.Replace(lcString, lcReplacement)

		If This.AssertTrue(lcResult != lcString, "test failed")
			This.Messageout("Original Text: " + lcString)
			This.Messageout("Replaced Text: " + lcResult)
			This.PrintOk("TestReplace")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsURL
&& ======================================================================== &&
	Function TestIsURL As Void
		Local lcSource As String
		lcSource = "https://github.com/Irwin1985/FoxRegEx"
		If This.AssertTrue(This.RegEx.isURL(lcSource), "test failed")
			This.PrintOk("TestIsURL")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsIPv4
&& ======================================================================== &&
	Function TestIsIPv4 As Void
		Local lcSource As String
		lcSource = "192.168.0.1"
		If This.AssertTrue(This.RegEx.isIPv4(lcSource), "test failed")
			This.PrintOk("TestIPv4")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsIPv6
&& ======================================================================== &&
	Function TestIsIPv6 As Void
		Local lcSource As String
		lcSource = "2001:db8:0:1:1:1:1:1"
		If This.AssertTrue(This.RegEx.isIPv6(lcSource), "test failed")
			This.PrintOk("TestIPv6")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsYoutubeID
&& ======================================================================== &&
	Function TestIsYoutubeVideoID As Void
		Local lcSource As String
		lcSource = "https://www.youtube.com/watch?v=Cw73N5hTR7s&list=RD5DkZmdDXBXU&index=16"
		If This.AssertTrue(This.RegEx.isYoutubeVideoID(lcSource), "test failed")
			This.PrintOk("TestIsYoutubeID")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsYoutubeChannelID
&& ======================================================================== &&
	Function TestIsYoutubeChannelID As Void
		Local lcSource As String
		lcSource = "https://www.youtube.com/c/IrwinRodriguez"
		If This.AssertTrue(This.RegEx.isYoutubeChannelID(lcSource), "test failed")
			This.PrintOk("TestIsYoutubeChannelID")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsEmail
&& ======================================================================== &&
	Function TestIsEmail As Void
		Local lcSource As String
		lcSource = "rodriguez.irwin@gmail.com"
		If This.AssertTrue(This.RegEx.isEmail(lcSource), "test failed")
			This.PrintOk("TestIsEmail")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsDateWithFormatmmddYYYYHyphen
&& ======================================================================== &&
	Function TestIsDateWithFormatmmddYYYYHyphen As Void
		Local lcSource As String, lcFormat As String
		lcSource = "05-18-20"
		lcFormat = "mm-dd-YY"
		If This.AssertTrue(This.RegEx.isDate(lcSource, lcFormat), "test failed")
			This.PrintOk("TestIsDateWithFormatmmddYYYYHyphen")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsDateWithFormatmmddYYYYSlash
&& ======================================================================== &&
	Function TestIsDateWithFormatmmddYYYYSlash As Void
		Local lcSource As String, lcFormat As String
		lcSource = "05/18/20"
		lcFormat = "mm/dd/YY"
		If This.AssertTrue(This.RegEx.isDate(lcSource, lcFormat), "test failed")
			This.PrintOk("TestIsDateWithFormatmmddYYYYSlash")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsDateWithFormatYYYYmmddHyphen
&& ======================================================================== &&
	Function TestIsDateWithFormatYYYYmmddHyphen As Void
		Local lcSource As String, lcFormat As String
		lcSource = "2020-12-31"
		lcFormat = "YYYY-mm-dd"
		If This.AssertTrue(This.RegEx.isDate(lcSource, lcFormat), "test failed")
			This.PrintOk("TestIsDateWithFormatYYYYmmddHyphen")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsDateWithFormatYYYYmmddSlash
&& ======================================================================== &&
	Function TestIsDateWithFormatYYYYmmddSlash As Void
		Local lcSource As String, lcFormat As String
		lcSource = "2019/07/01"
		lcFormat = "YYYY/mm/dd"
		If This.AssertTrue(This.RegEx.isDate(lcSource, lcFormat), "test failed")
			This.PrintOk("TestIsDateWithFormatYYYYmmddSlash")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsDateWithFormatddmmYYYYHyphen
&& ======================================================================== &&
	Function TestIsDateWithFormatddmmYYYYHyphen As Void
		Local lcSource As String, lcFormat As String
		lcSource = "12-12-2020"
		lcFormat = "dd-mm-YYYY"
		If This.AssertTrue(This.RegEx.isDate(lcSource, lcFormat), "test failed")
			This.PrintOk("TestIsDateWithFormatddmmYYYYHyphen")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsDateWithFormatddmmYYYYSlash
&& ======================================================================== &&
	Function TestIsDateWithFormatddmmYYYYSlash As Void
		Local lcSource As String, lcFormat As String
		lcSource = "12/12/2020"
		lcFormat = "dd/mm/YYYY"
		If This.AssertTrue(This.RegEx.isDate(lcSource, lcFormat), "test failed")
			This.PrintOk("TestIsDateWithFormatddmmYYYYSlash")
		Endif
	EndFunc
&& ======================================================================== &&
&& Function TestIsHTMLTag
&& ======================================================================== &&
	Function TestIsHTMLTag As Void
		Local lcSource As String, lcFormat As String
		lcSource = "<regex>RegEx Rules!</regex>"
		If This.AssertTrue(This.RegEx.isHTMLTag(lcSource), "test failed")
			This.PrintOk("TestIsHTMLTag")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestIsHexColor
&& ======================================================================== &&
	Function TestIsHexColor As Void
		Local lcSource As String, lcFormat As String
		lcSource = "#FFFFFF"
		If This.AssertTrue(This.RegEx.isHexColor(lcSource), "test failed")
			This.PrintOk("TestIsHexColor")
		Endif
	Endfunc
&& ======================================================================== &&
&& Function TestOk
&& ======================================================================== &&
	Function PrintOk As Void
		Lparameters tcFunctionName As String
		This.Messageout("(" + tcFunctionName + ") tested Ok")
	Endfunc
Enddefine