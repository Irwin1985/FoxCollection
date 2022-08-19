If Type('_vfp.ftHelper') = 'U'
	AddProperty(_vfp, 'ftHelper', .Null.)
EndIf

_vfp.ftHelper = CreateObject('AnyToString')

&& ======================================================================== &&
&& ftNewArray
&& ======================================================================== &&
Function ftNewArray
	Return Createobject('TArray')
Endfunc

&& ======================================================================== &&
&& ftNewMap
&& ======================================================================== &&
Function ftNewMap
	Return Createobject('TDictionary')
Endfunc

&& ======================================================================== &&
&& ftNewStringList
&& ======================================================================== &&
Function ftNewStringList
	Return Createobject('TStringList')
Endfunc

&& ======================================================================== &&
&& ftNewStack
&& ======================================================================== &&
Function ftNewStack
	Return Createobject('TStack')
Endfunc

&& ======================================================================== &&
&& ftNewQueue
&& ======================================================================== &&
Function ftNewQueue
	Return Createobject('TQueue')
Endfunc

* ============================================================ *
* TDictionary
* ============================================================ *
Define Class TDictionary As TIterable
	Hidden Items

	Function Init
		DoDefault()
		This.Items = Createobject("Collection")
	Endfunc

	Function Add(tcKey As String, tvValue As variant)
		If !Empty(This.Items.GetKey(tcKey))
			This.Items.Remove(tcKey)
		Endif
		This.Items.Add(tvValue, tcKey)
	Endfunc

	Function Get(tcKey As String) As variant
		Local lnIndex
		lnIndex = This.Items.GetKey(tcKey)
		Return Iif(Empty(lnIndex), .Null., This.Items.Item(lnIndex))
	Endfunc

	Function ContainsKey(tcKey As String) As Boolean
		lnItem = This.Items.GetKey(tcKey)
		Return This.Items.GetKey(tcKey) > 0
	Endfunc

	Function Clear
		This.Items = Createobject("Collection")
	Endfunc

	Function GetDataByIndex
		Local lvKey, lvValue
		lvKey = This.Items.Item(This.nIteratorCounter)
		lvValue = This.Items.GetKey(This.nIteratorCounter)
		Return This.CreatePair(lvKey, lvValue)
	Endfunc

	Function GetLen
		Return This.Items.Count
	Endfunc

	Hidden Function CreatePair(tvKey, tvValue)
		Local loPair
		loPair = Createobject('Empty')
		AddProperty(loPair, 'key', tvKey)
		AddProperty(loPair, 'value', tvValue)
		Return loPair
	EndFunc

	Function ToString		
		If this.GetLen() > 0
			Local lcStr, i
			lcStr = '{'
			For i = 1 to this.GetLen()
				If Len(lcStr) = 1 then
					lcStr = lcStr + _vfp.ftHelper.ToString(this.items.getkey(i)) + ':' + this.ObjToString(this.items.item(i))
				Else
					lcStr = lcStr + ',' + _vfp.ftHelper.ToString(this.items.getkey(i)) + ':' + this.ObjToString(this.items.item(i))
				EndIf				
			EndFor
			lcStr = lcStr + '}'
			Return lcStr
		Else
			Return '{}'
		EndIf
	EndFunc
	
	Function ObjToString(toObj)
		Local lcStr
		lcStr = Space(1)
		Try
			lcStr = toObj.ToString()
		Catch
			lcStr = _vfp.ftHelper.ToString(toObj)
		EndTry
		Return lcStr
	EndFunc

Enddefine

* ============================================================ *
* TArray
* ============================================================ *
Define Class TArray As TIterable
	Dimension aCustomArray[1]
	nIndex = 0
	
	Function Init
		DoDefault()
	Endfunc

	Function Push(tvItem)
		this.nIndex = this.nIndex + 1
		Dimension This.aCustomArray[this.nIndex]
		This.aCustomArray[this.nIndex] = tvItem
	Endfunc

	Function Pop
		this.nIndex = this.nIndex - 1
		If this.nIndex <= 0
			this.nIndex = 0
			Dimension this.aCustomArray[1]
			Return
		Endif

		Dimension This.aCustomArray[this.nIndex]
	Endfunc

	Function Get(tnIndex)
		If Between(tnIndex, 1, This.GetLen())
			Return This.aCustomArray[tnIndex]
		Endif
		Return .Null.
	Endfunc

	Function Set(tnIndex, tvValue)
		If Between(tnIndex, 1, This.GetLen())
			This.aCustomArray[tnIndex] = tvValue
		Endif
	Endfunc

	Function GetDataByIndex
		Return This.aCustomArray[this.nIteratorCounter]
	Endfunc

	Function GetLen
		Return this.nIndex		
	Endfunc

	Function ToString
		If this.nIndex > 0
			Acopy(this.aCustomArray, laData)
			Return _vfp.ftHelper.ToString(@laData)
		Else
			Return '[]'
		EndIf
	Endfunc

Enddefine

* ============================================================ *
* TStringList
* ============================================================ *
Define Class TStringList As TIterable
	Dimension aCustomArray[1]
	nIndex = 0
	
	Function Init
		DoDefault()
	Endfunc

	Function Add(tcItem)
		If Type('tcItem') != 'C'
			Return
		EndIf
		this.nIndex = this.nIndex + 1
		Dimension This.aCustomArray[this.nIndex]
		This.aCustomArray[this.nIndex] = tcItem
	Endfunc

	Function GetDataByIndex
		Return This.aCustomArray[this.nIteratorCounter]
	Endfunc

	Function GetLen
		Return this.nIndex
	Endfunc

	Function ToString
		Return this.Join()
	EndFunc
	
	Function Join(tcSep)
		If this.nIndex > 0
			Local lcStr, i, lcVal
			lcStr = Space(1)
			For i = 1 to this.GetLen()
				lcVal = this.aCustomArray[i]
				If i = 1 then
					lcStr = lcVal
				Else
					lcStr = lcStr + Iif(!Empty(tcSep), tcSep + lcVal, lcVal)
				EndIf				
			EndFor
			Return lcStr
		Else
			Return ''
		EndIf
	EndFunc

Enddefine

* ============================================================ *
* TIterable
* ============================================================ *
Define Class TIterable As Custom
	Hidden nIteratorCounter
	Len = 0

	Function Init
		This.nIteratorCounter = 1
	Endfunc

	Function hasNext
		If This.nIteratorCounter > This.GetLen() Then
			This.nIteratorCounter = 0
			Return .F.
		Endif
		Return .T.
	Endfunc

	Function Next
		Local lvValue
		lvValue = This.GetDataByIndex()
		This.nIteratorCounter = This.nIteratorCounter + 1
		Return lvValue
	Endfunc

	Function GetDataByIndex
		* abstract
	Endfunc

	Function GetLen
		* abstract
	Endfunc

	Function Len_Access
		Return This.GetLen()
	Endfunc

	Function ToString

	Endfunc

Enddefine

&& ======================================================================== &&
&& TStack
&& ======================================================================== &&
Define Class TStack As Custom
	Hidden Stack(1)
	Hidden StackCounter

	Function Init
		This.StackCounter = 0
	Endfunc

	Function Push
		Lparameters tvData As variant
		If Type("tvData") != "U"
			This.IncreaseStack()
			This.Stack[This.StackCounter] = tvData
		Endif
	Endfunc

	Function Pop As variant
		Local lvData As variant
		lvData = This.GetStackValue()
		If Not Isnull(lvData)
			This.DecreaseStack()
		Endif
		Return lvData
	Endfunc

	Function Peek As variant
		Local lvData As variant
		lvData = This.GetStackValue()
		Return lvData
	Endfunc

	Function Empty As Boolean
		Return (This.StackCounter = 0)
	Endfunc

	Function Search As variant
		Lparameters tvData As variant
		Local lvItem As variant, lbFound As Boolean, nIndex As Integer, ;
			lcSupportedTypes As String, lnStackIndex As Integer
		lvItem  = .Null.
		lbFound = .F.
		nIndex  = 0
		lnStackIndex = 0
		lcSupportedTypes = "CINYDTL"
		If Not This.Empty()
			For nIndex = Alen(This.Stack, 1) To 1 Step -1
				lnStackIndex = lnStackIndex + 1
				lvItem = This.Stack[nIndex]
				lcItemType = Type("lvItem")
				If lcItemType != "U"
					Do Case
					Case lcItemType == "O" And Type("tvData") == "O"
						If Type("lvItem.Name") == "C" And Type("tvData.Name") == "C"
							lbFound = (tvData.Name == lvItem.Name)
						Endif
					Case lcItemType $ lcSupportedTypes And Type("tvData") $ lcSupportedTypes
						lbFound = (tvData == lvItem)
					Otherwise
					Endcase
				Endif
				If lbFound
					Exit
				Endif
			Endfor
		Else
		Endif
		Return Iif(lnStackIndex > 0, lnStackIndex, -1)
	Endfunc

	Hidden Function IncreaseStack As Void
		This.StackCounter = This.StackCounter + 1
		Dimension This.Stack(This.StackCounter)
	Endfunc

	Hidden Function DecreaseStack As Void
		If Not This.Empty()
			This.StackCounter = This.StackCounter - 1
			If This.StackCounter > 0
				Dimension This.Stack(This.StackCounter)
			Endif
		Else
			This.Stack[This.StackCounter] = .Null.
		Endif
	Endfunc

	Function Size As Integer
		Return Alen(This.Stack, 1)
	Endfunc

	Hidden Function GetStackValue As variant
		Local lvData As variant
		lvData = .Null.
		If Not This.Empty()
			lvData = This.Stack[This.StackCounter]
		Endif
		Return lvData
	Endfunc
Enddefine

&& ======================================================================== &&
&& TQueue
&& ======================================================================== &&
Define Class TQueue As Custom
	Hidden aQueueList(1)
	Hidden nQueueCounter

	Function Init
		This.nQueueCounter = 0
	Endfunc

	Function Enqueue(tvItem As variant) As variant
		This.nQueueCounter = This.nQueueCounter + 1
		Dimension This.aQueueList(This.nQueueCounter)
		This.aQueueList[This.nQueueCounter] = tvItem
		Return This.aQueueList[This.nQueueCounter]
	Endfunc

	Function Dequeue As variant
		Local lvItem As variant, lnTotItems As Integer
		lvItem = .Null.
		If This.nQueueCounter > 0
			lvItem = This.aQueueList[1]
			If Alen(This.aQueueList) > 1
				For i = 1 To Alen(This.aQueueList) - 1
					Dimension newCopy(i)
					newCopy[i] = This.aQueueList[i + 1]
				Endfor
				This.nQueueCounter = 0
				For j = 1 To Alen(newCopy)
					This.Enqueue(newCopy[j])
				Endfor
				Release newCopy
			Else
				This.nQueueCounter = 0
				This.aQueueList[1] = .Null.
			Endif
		Endif
		Return lvItem
	Endfunc

	Function Extract As variant
		Local lvItem As variant
		lvItem = .Null.
		If This.nQueueCounter > 0
			lvItem = This.aQueueList[Alen(This.aQueueList)]
			This.nQueueCounter = This.nQueueCounter - 1
			If Alen(This.aQueueList) > 1
				Dimension This.aQueueList[This.nQueueCounter]
			Else
				This.aQueueList[1] = .Null.
			Endif
		Endif
		Return lvItem
	Endfunc

	Function Clear As Void
		This.nQueueCounter = 0
		Dimension This.aQueueList(1)
	Endfunc

	Function Count As Integer
		Return This.nQueueCounter
	Endfunc

	Function Peek As variant
		Local lvPeek As variant
		lvPeek = .Null.
		If This.nQueueCounter > 0
			lvPeek = This.aQueueList[1]
		Endif
		Return lvPeek
	Endfunc
Enddefine

* AnyToString
Define Class AnyToString As Custom
	#Define USER_DEFINED_PEMS	'U'
	#Define ALL_MEMBERS			"PHGNUCIBR"
	lCentury = .F.
	cDateAct = ''
	nOrden   = 0
	cFlags 	 = ''

	Function Init
		This.lCentury = Set("Century") == "OFF"
		This.cDateAct = Set("Date")
		Set Century On
		Set Date Ansi
		Mvcount = 60000
	Endfunc

	Function ToString(toRefObj, tcFlags)
		lPassByRef = .T.
		Try
			External Array toRefObj
		Catch
			lPassByRef = .F.
		Endtry
		This.cFlags = Evl(tcFlags, ALL_MEMBERS)
		If lPassByRef
			Return This.AnyToStr(@toRefObj)
		Else
			Return This.AnyToStr(toRefObj)
		Endif
	Endfunc

	Function AnyToStr As Memo
		Lparameters tValue As variant
		Try
			External Array tValue
		Catch
		Endtry
		Do Case
		Case Type("tValue", 1) = 'A'
			Local k, j, lcArray
			If Alen(tValue, 2) == 0
				*# Unidimensional array
				lcArray = '['
				For k = 1 To Alen(tValue)
					lcArray = lcArray + Iif(Len(lcArray) > 1, ',', '')
					Try
						=Acopy(tValue[k], aLista)
						lcArray = lcArray + This.AnyToStr(@aLista)
					Catch
						lcArray = lcArray + This.AnyToStr(tValue[k])
					Endtry
				Endfor
				lcArray = lcArray + ']'
			Else
				*# Multidimensional array support
				lcArray = '['
				For k = 1 To Alen(tValue, 1)
					lcArray = lcArray + Iif(Len(lcArray) > 1, ',', '')

					* # begin of rows
					lcArray = lcArray + '['
					For j = 1 To Alen(tValue, 2)
						If j > 1
							lcArray = lcArray + ','
						Endif
						Try
							=Acopy(tValue[k, j], aLista)
							lcArray = lcArray + This.AnyToStr(@aLista)
						Catch
							lcArray = lcArray + This.AnyToStr(tValue[k, j])
						Endtry
					Endfor
					lcArray = lcArray + ']'
					* # end of rows
				Endfor
				lcArray = lcArray + ']'
			Endif
			Return lcArray

		Case Vartype(tValue) = 'O'
			Local j, lcStr, lnTot
			Local Array gaMembers(1)

			lcStr = '{'
			lnTot = Amembers(gaMembers, tValue, 0, This.cFlags)
			For j=1 To lnTot
				lcProp = Lower(Alltrim(gaMembers[j]))
				lcStr = lcStr + Iif(Len(lcStr) > 1, ',', '') + '"' + lcProp + '":'
				Try
					=Acopy(tValue. &gaMembers[j], aCopia)
					lcStr = lcStr + This.AnyToStr(@aCopia)
				Catch
					Try
						lcStr = lcStr + This.AnyToStr(tValue. &gaMembers[j])
					Catch
						lcStr = lcStr + "{}"
					Endtry
				Endtry
			Endfor

			*//> Collection based class object support
			llIsCollection = .F.
			Try
				llIsCollection = (tValue.BaseClass == "Collection" And tValue.Class == "Collection" And tValue.Name == "Collection")
			Catch
			Endtry
			If llIsCollection
				lcComma   = Iif(Right(lcStr, 1) != '{', ',', '')
				lcStr = lcStr + lcComma + '"Collection":['
				For i=1 To tValue.Count
					lcStr = lcStr + Iif(i>1,',','') + This.AnyToStr(tValue.Item(i))
				Endfor
				lcStr = lcStr + ']'
			Endif
			*//> Collection based class object support

			lcStr = lcStr + '}'
			Return lcStr
		Otherwise
			Return This.GetValue(tValue, Vartype(tValue))
		Endcase
	Endfunc

	Function Destroy
		If This.lCentury
			Set Century Off
		Endif
		lcDateAct = This.cDateAct
		Set Date &lcDateAct
	Endfunc

	Function GetValue As String
		Lparameters tcvalue As String, tctype As Character
		Do Case
		Case tctype $ "CDTBGMQVWX"
			Do Case
			Case tctype = "D"
				tcvalue = '"' + Strtran(Dtoc(tcvalue), ".", "-") + '"'
			Case tctype = "T"
				tcvalue = '"' + Strtran(Ttoc(tcvalue), ".", "-") + '"'
			Otherwise
				If tctype = "X"
					tcvalue = "null"
				Else
					tcvalue = This.getstring(tcvalue)
				Endif
			Endcase
			tcvalue = Alltrim(tcvalue)
		Case tctype $ "YFIN"
			tcvalue = Strtran(Transform(tcvalue), ',', '.')
		Case tctype = "L"
			tcvalue = Iif(tcvalue, "true", "false")
		Endcase
		Return tcvalue
	Endfunc

	Function getstring As String
		Lparameters tcString As String, tlParseUtf8 As Boolean
		tcString = Allt(tcString)
		tcString = Strtran(tcString, '\', '\\' )
		tcString = Strtran(tcString, Chr(9),  '\t' )
		tcString = Strtran(tcString, Chr(10), '\n' )
		tcString = Strtran(tcString, Chr(13), '\r' )
		tcString = Strtran(tcString, '"', '\"' )

		If tlParseUtf8
			tcString = Strtran(tcString,"&","\u0026")
			tcString = Strtran(tcString,"+","\u002b")
			tcString = Strtran(tcString,"-","\u002d")
			tcString = Strtran(tcString,"#","\u0023")
			tcString = Strtran(tcString,"%","\u0025")
			tcString = Strtran(tcString,"²","\u00b2")
			tcString = Strtran(tcString,'à','\u00e0')
			tcString = Strtran(tcString,'á','\u00e1')
			tcString = Strtran(tcString,'è','\u00e8')
			tcString = Strtran(tcString,'é','\u00e9')
			tcString = Strtran(tcString,'ì','\u00ec')
			tcString = Strtran(tcString,'í','\u00ed')
			tcString = Strtran(tcString,'ò','\u00f2')
			tcString = Strtran(tcString,'ó','\u00f3')
			tcString = Strtran(tcString,'ù','\u00f9')
			tcString = Strtran(tcString,'ú','\u00fa')
			tcString = Strtran(tcString,'ü','\u00fc')
			tcString = Strtran(tcString,'À','\u00c0')
			tcString = Strtran(tcString,'Á','\u00c1')
			tcString = Strtran(tcString,'È','\u00c8')
			tcString = Strtran(tcString,'É','\u00c9')
			tcString = Strtran(tcString,'Ì','\u00cc')
			tcString = Strtran(tcString,'Í','\u00cd')
			tcString = Strtran(tcString,'Ò','\u00d2')
			tcString = Strtran(tcString,'Ó','\u00d3')
			tcString = Strtran(tcString,'Ù','\u00d9')
			tcString = Strtran(tcString,'Ú','\u00da')
			tcString = Strtran(tcString,'Ü','\u00dc')
			tcString = Strtran(tcString,'ñ','\u00f1')
			tcString = Strtran(tcString,'Ñ','\u00d1')
			tcString = Strtran(tcString,'©','\u00a9')
			tcString = Strtran(tcString,'®','\u00ae')
			tcString = Strtran(tcString,'ç','\u00e7')
		Endif

		Return '"' +tcString + '"'
	Endfunc
Enddefine
