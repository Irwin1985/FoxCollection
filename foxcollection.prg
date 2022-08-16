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

	Function getLen
		Return This.Items.Count
	Endfunc

	Hidden Function CreatePair(tvKey, tvValue)
		Local loPair
		loPair = Createobject('Empty')
		AddProperty(loPair, 'key', tvKey)
		AddProperty(loPair, 'value', tvValue)
		Return loPair
	Endfunc

Enddefine

* ============================================================ *
* TArray
* ============================================================ *
Define Class TArray As TIterable
	Dimension aCustomArray[1]

	Function Init
		DoDefault()
	Endfunc

	Function Push(tvItem)
		Local lnIndex
		lnIndex = This.getLen() + 1
		Dimension This.aCustomArray[lnIndex]
		This.aCustomArray[lnIndex] = tvItem
	Endfunc

	Function Pop
		Local lnIndex
		lnIndex = This.getLen()
		If lnIndex = 0
			Return
		Endif

		lnIndex = lnIndex - 1
		Dimension This.aCustomArray[lnIndex]
	Endfunc

	Function Get(tnIndex)
		If Between(tnIndex, 1, This.getLen())
			Return This.aCustomArray[tnIndex]
		Endif
		Return .Null.
	Endfunc

	Function Set(tnIndex, tvValue)
		If Between(tnIndex, 1, This.getLen())
			This.aCustomArray[tnIndex] = tvValue
		Endif
	Endfunc

	Function GetDataByIndex
		Return This.aCustomArray[this.nIteratorCounter]
	Endfunc

	Function getLen
		Return Alen(This.aCustomArray, 1)
	Endfunc

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
		If This.nIteratorCounter > This.getLen() Then
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

	Function getLen
		* abstract
	Endfunc

	Function Len_Access
		Return This.getLen()
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