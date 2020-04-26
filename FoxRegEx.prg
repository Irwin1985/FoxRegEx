Define Class FoxRegEx As Session
	#Define T_OBJECT 	"O"
	#Define True 		.T.
	#Define False 		.F.

	Hidden oRegEx
	Hidden DataSessionId
	Hidden bCanAssign

	Version		= "2020.04.06.20.34"
	Global 		= False
	Pattern 	= ""
	IgnoreCase 	= False
	Multiline	= False
	UseCursor	= False
	CursorName  = ""
	Session		= 0
&& ======================================================================== &&
&& Function Init
&& ======================================================================== &&
	Function Init
		This.RegExCreated()
	EndFunc
&& ======================================================================== &&
&& Function Destroy
&& ======================================================================== &&
	Function Destroy
		This.oRegEx = .Null.
	EndFunc
&& ======================================================================== &&
&& Function Version_Assign
&& ======================================================================== &&
	Function Version_Assign As Void
		lParameters vNewVal As Variant
		If This.bCanAssign
			This.bCanAssign = False
			This.Version = m.vNewVal
		Endif
	Endfunc
&& ======================================================================== &&
&& Function Version_Access
&& ======================================================================== &&
	Function Version_Access As Void
		Return This.Version
	Endfunc
&& ======================================================================== &&
&& Function Global_Assign
&& ======================================================================== &&
	Function Global_Assign As Void
		lparameters vNewVal As Variant
		If This.RegExCreated() And Type("vNewVal") = "L"
			This.oRegEx.Global = m.vNewVal
		Endif
	EndFunc
&& ======================================================================== &&
&& Function Global_Access
&& ======================================================================== &&
	Function Global_Access As Boolean
		If This.RegExCreated()
			Return This.oRegEx.Global
		Endif
	EndFunc
&& ======================================================================== &&
&& Function Pattern_Assign
&& ======================================================================== &&
	Function Pattern_Assign As Void
		lparameters vNewVal As Variant
		If This.RegExCreated() And Type("vNewVal") = "C"
			This.oRegEx.Pattern = m.vNewVal
		Endif
	EndFunc
&& ======================================================================== &&
&& Function Pattern_Access
&& ======================================================================== &&
	Function Pattern_Access As Boolean
		If This.RegExCreated()
			Return This.oRegEx.Pattern
		Endif
	EndFunc
&& ======================================================================== &&
&& Function IgnoreCase_Assign
&& ======================================================================== &&
	Function IgnoreCase_Assign As Void
		lparameters vNewVal As Variant
		If This.RegExCreated() And Type("vNewVal") = "L"
			This.oRegEx.IgnoreCase = m.vNewVal
		Endif
	EndFunc
&& ======================================================================== &&
&& Function IgnoreCase_Access
&& ======================================================================== &&
	Function IgnoreCase_Access As Boolean
		If This.RegExCreated()
			Return This.oRegEx.IgnoreCase
		Endif
	EndFunc
&& ======================================================================== &&
&& Function MultiLine_Assign
&& ======================================================================== &&
	Function MultiLine_Assign As Void
		lparameters vNewVal As Variant
		If This.RegExCreated() And Type("vNewVal") = "L"
			This.oRegEx.MultiLine = m.vNewVal
		Endif
	EndFunc
&& ======================================================================== &&
&& Function MultiLine_Access
&& ======================================================================== &&
	Function MultiLine_Access As Boolean
		If This.RegExCreated()
			Return This.oRegEx.MultiLine
		Endif
	EndFunc
&& ======================================================================== &&
&& Function UseCursor_Assign
&& ======================================================================== &&
	Function UseCursor_Assign As Void
		lparameters vNewVal As Variant
		If Type("vNewVal") = "L"
			This.UseCursor = m.vNewVal
		Endif
	EndFunc
&& ======================================================================== &&
&& Function UseCursor_Access
&& ======================================================================== &&
	Function UseCursor_Access As Boolean
		Return This.UseCursor
	EndFunc
&& ======================================================================== &&
&& Function Session_Assign
&& ======================================================================== &&
	Function Session_Assign As Void
		lparameters vNewVal As Variant
		If Type("vNewVal") = "N"
			This.Session = m.vNewVal
			Set DataSession To (This.Session)
		Endif
	EndFunc
&& ======================================================================== &&
&& Function Session_Access
&& ======================================================================== &&
	Function Session_Access As Integer
		Return This.Session
	EndFunc
&& ======================================================================== &&
&& Function CursorName_Assign
&& ======================================================================== &&
	Function CursorName_Assign As Void
		lparameters vNewVal As Variant
		If Type("vNewVal") = "C"
			This.CursorName = m.vNewVal
		Endif
	EndFunc
&& ======================================================================== &&
&& Function CursorName_Access
&& ======================================================================== &&
	Function CursorName_Access As String
		Return This.CursorName
	EndFunc
&& ======================================================================== &&
&& Function Test
&& ======================================================================== &&
	Function Test (tcSourceText As String) As Boolean ;
		HelpString "Evaluates the RegEx and returns true if matches."
		If This.RegExCreated()
			Return This.oRegEx.Test(tcSourceText)
		Endif
	EndFunc
&& ======================================================================== &&
&& Function Execute
&& ======================================================================== &&
	Function Execute(tcSource As String) As Variant ;
		HelpString "Executes the RegEx and returns either an Object or a cursor with the matches."
		Try
			Local loEx As Exception, lvResult As Variant, loMatches As Object
			lvResult = 0
			If This.RegExCreated()
				loMatches = This.oRegEx.Execute(tcSource)
				If This.UseCursor And loMatches.Count > 0
					This.CursorName = evl(This.CursorName, Sys(2015))
					Create Cursor (This.CursorName) (id i autoinc, value c(250))
					For each loMatch in loMatches
						If Type("loMatch") = T_OBJECT
							Select (This.CursorName)
							Append Blank In (This.CursorName)
							Replace value With loMatch.Value In (This.CursorName)
						Endif
						loMatch = .Null.
						Release loMatch
					EndFor
					lvResult = loMatches.Count
				Else
					lvResult = loMatches
				Endif
			Endif			
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx, loMatches
			Release loEx, loMatches
		Endtry
		Return lvResult
	EndFunc
&& ======================================================================== &&
&& Function Replace
&& ======================================================================== &&
	Function Replace As String HelpString "Search and Replaces any match on the current string. Returns the replaced string."
		lParameters tcSource As String, tcReplacement As String
		Try
			Local loEx As Exception, lcReplacedText As String
			lcReplacedText = ""
			If This.RegExCreated()
				lcReplacedText = This.oRegEx.Replace(tcSource, tcReplacement)
			Endif
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx
			Release loEx
		Endtry
		Return lcReplacedText
	EndFunc
&& ======================================================================== &&
&& Function isURL
&& ======================================================================== &&
	Function isURL As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^((https?|ftp|file):\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isIPv4
&& ======================================================================== &&
	Function isIPv4 As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isIPv6
&& ======================================================================== &&
	Function isIPv6 As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isYoutubeVideoID
&& ======================================================================== &&
	Function isYoutubeVideoID As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^https?:\/\/(?:youtu\.be\/|(?:[a-z]{2,3}\.)?youtube\.com\/watch(?:\?|#\!)v=)([\w-]{11}).*$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isYoutubeChannelID
&& ======================================================================== &&
	Function isYoutubeChannelID As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^https?:\/\/(www\.)?youtube.com\/(channel|c)\/[-_a-z0-9]{1,22}$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isEmail
&& ======================================================================== &&
	Function isEmail As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^[\w\.\-_+]+[@][\w\.-_]+[.][\w\-_]+$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isHTMLTag
&& ======================================================================== &&
	Function isHTMLTag As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^<([a-z1-6]+)([^<]+)*(?:>(.*)<\/\1>| *\/>)$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isHexColor
&& ======================================================================== &&
	Function isHexColor As Boolean
		lParameters tcSource As String
		Local lcPattern As String
		Text To lcPattern NoShow
^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$
		EndText
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Function isDate
&& ======================================================================== &&
	Function isDate As Boolean
		lParameters tcSource As String, tcDateFormat As String
		Try
			#Define DAY_FORMAT			"dd"
			#Define MONTH_FORMAT		"mm"
			#Define LONG_YEAR_FORMAT	"yyyy"
			#Define SHORT_YEAR_FORMAT	"yy"

			Local ;
				loEx 		As Exception, ;
				lcPattern 	As String, ;
				lcDelimiter As Character, ;
				lcFirstStr	As String, ;
				lcSecondStr As String, ;
				lcThirdStr  As String
			
			tcDateFormat = evl(tcDateFormat, "dd/mm/YYYY")
			lcDelimiter  = This.GetDateDelimiter(tcDateFormat)
			This.SplitDateMembers(tcDateFormat, lcDelimiter, @lcFirstStr, @lcSecondStr, @lcThirdStr)
			Do Case
			Case lower(lcFirstStr) == DAY_FORMAT
				lcPattern = "(0?[1-9]|[12]\d|3[01])\" + lcDelimiter
				If lcSecondStr == MONTH_FORMAT
					lcPattern = lcPattern + "(0?[1-9]|1[0-2])\" + lcDelimiter + "\d{" + Alltrim(Str(len(lcThirdStr))) + "}"
				Else
					lcPattern = lcPattern + "\d{" + Alltrim(Str(len(lcSecondStr))) + "}\" + lcDelimiter + "(0?[1-9]|1[0-2])"
				Endif
			Case lower(lcFirstStr) == MONTH_FORMAT
				lcPattern = "(0?[1-9]|1[0-2])\" + lcDelimiter
				If lcSecondStr == DAY_FORMAT
					lcPattern = lcPattern + "(0?[1-9]|[12]\d|3[01])\" + lcDelimiter + "\d{" + Alltrim(Str(len(lcThirdStr))) + "}"
				Else
					lcPattern = lcPattern + "\d{" + Alltrim(Str(len(lcSecondStr))) + "}\" + lcDelimiter + "(0?[1-9]|[12]\d|3[01])"
				Endif
			Case lower(lcFirstStr) == SHORT_YEAR_FORMAT Or lower(lcFirstStr) == LONG_YEAR_FORMAT
				lcPattern = "\d{" + Alltrim(Str(len(lcFirstStr))) + "}\" + lcDelimiter
				If lcSecondStr == DAY_FORMAT
					lcPattern = lcPattern + "(0?[1-9]|[12]\d|3[01])\" + lcDelimiter + "(0?[1-9]|1[0-2])"
				Else
					lcPattern = lcPattern + "(0?[1-9]|1[0-2])\" + lcDelimiter + "(0?[1-9]|[12]\d|3[01])"
				Endif
			EndCase
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx
			Release loEx
		Endtry
		Return This.GenericTest(tcSource, lcPattern)
	EndFunc
&& ======================================================================== &&
&& Protected Function GetDateDelimiter
&& ======================================================================== &&
	Protected Function GetDateDelimiter As Character
		lParameters tcDateFormat As String
		Try
			Local loEx As Exception, lcDelimiter As String, lcChar As Character
			lcDelimiter = ""
			lcChar      = ""
			For nPos = 1 to Len(tcDateFormat)
				lcChar = SubStr(tcDateFormat, nPos, 1)
				If Not IsAlpha(lcChar)
					lcDelimiter = lcChar
					Exit
				Endif
			EndFor		
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx
			Release loEx
		Endtry
		Return lcDelimiter
	EndFunc
&& ======================================================================== &&
&& Protected Function SplitDateMembers
&& ======================================================================== &&
	Protected Function SplitDateMembers As Void
		lParameters ;
			tcDateFormat 	As String, ;
			tcDelimiter 	As Character, ;
			tcFirstMember	As String, ;
			tcSecondMember	As String, ;
			tcThirdMember	As String
		Try
			Local loEx As Exception
			tcFirstMember	= GetWordNum(tcDateFormat, 1, tcDelimiter)
			tcSecondMember	= GetWordNum(tcDateFormat, 2, tcDelimiter)
			tcThirdMember	= GetWordNum(tcDateFormat, 3, tcDelimiter)
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx
			Release loEx
		Endtry
	EndFunc
&& ======================================================================== &&
&& Protected Function GenericTest
&& ======================================================================== &&
	Protected Function GenericTest
		lParameters tcSource As String, tcPattern As String
		Try
			Local loEx As Exception, lbSucceed As Boolean
			If This.RegExCreated()
				With This.oRegEx
					.Global 	= .T.
					.IgnoreCase = .T.
					.Pattern 	= tcPattern
				Endwith
				lbSucceed = This.Test(tcSource)
			Endif
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx
			Release loEx
		Endtry
		Return lbSucceed
	EndFunc
&& ======================================================================== &&
&& Protected Function RegExCreated
&& ======================================================================== &&
	Protected Function RegExCreated As Boolean
		Try
			Local loEx As Exception
			If Type("This.oRegEx") != T_OBJECT
				This.oRegEx = CreateObject("VBScript.RegExp")
			Endif
		Catch To loEx
			This.ShowMessageError(loEx, .T.)
		Finally
			Store .Null. To loEx
			Release loEx
		Endtry
		Return (Type("This.oRegEx") = T_OBJECT)
	EndFunc
&& ======================================================================== &&
&& Protected Function ShowMessageError
&& ======================================================================== &&
	Protected Function ShowMessageError As Void
		Lparameters toException As Exception, tbWait As Boolean
		Local lcMsg As Memo
		TEXT to lcMsg noshow pretext 7 textmerge
	 		ERROR:	<<Str(toException.ErrorNo)>>
			MENSAJE:	<<toException.Message>>
			LINEA:	<<Str(toException.Lineno)>>
			PROGRAMA:	<<toException.Procedure>>
		ENDTEXT
		If tbWait
			Wait lcMsg Window
		Else
			Wait lcMsg Window Nowait
		Endif
	Endfunc
EndDefine