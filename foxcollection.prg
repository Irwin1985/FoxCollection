If Type('_vfp.ftHelper') = 'U'
	AddProperty(_vfp, 'ftHelper', .Null.)
EndIf

_vfp.ftHelper = CreateObject('AnyToString')

&& ======================================================================== &&
&& ftNewString
&& ======================================================================== &&
Function ftNewString(tcValue)
	If Pcount() = 1
		Return CreateObject('TString', tcValue)
	EndIf
	Return CreateObject('TString')		
EndFunc

&& ======================================================================== &&
&& ftNewNumber
&& ======================================================================== &&
Function ftNewNumber(tnValue)
	If Pcount() = 1
		Return CreateObject('TNumber', tnValue)
	EndIf
	Return CreateObject('TNumber')
EndFunc

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
		Return lnItem > 0
	endfunc
	
	function Remove(tcKey as String) as Boolean
		local lnIndex
		lnIndex = this.Items.GetKey(tcKey)
		if lnIndex > 0
			this.Items.Remove(lnIndex)
			return .t.
		endif
		return .f.
	endfunc

	Function Clear
		This.Items = Createobject("Collection")
	Endfunc

	Function GetDataByIndex
		Local lvKey, lvValue
		lvKey = This.Items.GetKey(This.nIteratorCounter)
		lvValue = This.Items.Item(This.nIteratorCounter)
		Return This.CreatePair(lvKey, lvValue)
	Endfunc

	Function GetLen
		Return This.Items.Count
	endfunc
	
	function Keys as Collection
		local loKeys, i
		loKeys = createobject("Collection")
		for i = 1 to this.Items.Count
			loKeys.Add(this.Items.GetKey(i))
		next
		
		return loKeys
	endfunc

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
		if this.nIndex <= 0
			return .null.
		endif
		local lvItem
		lvItem = this.aCustomArray[this.nIndex]
		this.nIndex = this.nIndex - 1
		
		If this.nIndex <= 0
			this.nIndex = 0
			Dimension this.aCustomArray[1]
		else
			Dimension This.aCustomArray[this.nIndex]
		endif
		
		return lvItem		
	endfunc		

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

	function Clear
		this.nIndex = 0
		dimension this.aCustomArray[1]
	endfunc
	
	function IndexOf(tvItem)
		local i
		for i = 1 to this.nIndex
			if vartype(this.aCustomArray[i]) == vartype(tvItem) and (this.aCustomArray[i] == tvItem)
				return i
			endif
		next
		
		return 0
	endfunc
	
	function Contains(tvItem)
		return this.IndexOf(tvItem) > 0
	endfunc
	
	function Insert(tnIndex, tvItem)
		if !between(tnIndex, 1, this.nIndex + 1)
			return .f.
		endif
		
		this.nIndex = this.nIndex + 1
		dimension This.aCustomArray[this.nIndex]
		
		local i
		for i = this.nIndex to tnIndex + 1 step -1
			this.aCustomArray[i] = this.aCustomArray[i-1]
		next
		
		this.aCustomArray[tnIndex] = tvItem
		
		return .t.
	endfunc
	
	function RemoveAt(tnIndex)
		if !between(tnIndex, 1, this.nIndex)
			return .f.
		endif
		
		local i
		for i = tnIndex to this.nIndex - 1
			this.aCustomArray[i] = this.aCustomArray[i+1]
		next
		
		this.nIndex = this.nIndex - 1
		if this.nIndex <= 0
			this.nIndex = 0
			dimension this.aCustomArray[1]
		else
			dimension this.aCustomArray[this.nIndex]
		endif
		
		return .t.
	endfunc

	Function ToString
		If this.nIndex > 0
			local array laData[1]
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
	Dimension aResult[1]
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

	Function Clear
	    this.nIndex = 0
	    Dimension this.aCustomArray[1]
	Endfunc

	Function Get(tnIndex)
	    If Between(tnIndex, 1, This.GetLen())
	        Return This.aCustomArray[tnIndex]
	    Endif
	    Return ""
	Endfunc

	Function Set(tnIndex, tcValue)
	    If Type('tcValue') != 'C'
	        Return .F.
	    EndIf
	    If Between(tnIndex, 1, This.GetLen())
	        This.aCustomArray[tnIndex] = tcValue
	        Return .T.
	    Endif
	    Return .F.
	Endfunc

	Function IndexOf(tcItem, tlCaseSensitive)
	    Local i
	    tlCaseSensitive = Iif(Pcount() < 2, .F., tlCaseSensitive)
	    
	    For i = 1 To this.nIndex
	        If tlCaseSensitive
	            If This.aCustomArray[i] == tcItem
	                Return i
	            Endif
	        Else
	            If Upper(This.aCustomArray[i]) == Upper(tcItem)
	                Return i
	            Endif
	        Endif
	    EndFor
	    Return 0
	Endfunc

	Function Contains(tcItem, tlCaseSensitive)
	    Return This.IndexOf(tcItem, tlCaseSensitive) > 0
	Endfunc

	Function Remove(tcItem, tlCaseSensitive)
	    Local lnIndex
	    lnIndex = This.IndexOf(tcItem, tlCaseSensitive)
	    If lnIndex > 0
	        Return This.RemoveAt(lnIndex)
	    Endif
	    Return .F.
	Endfunc

	Function RemoveAt(tnIndex)
	    If !Between(tnIndex, 1, this.nIndex)
	        Return .F.
	    Endif
	    
	    Local i
	    For i = tnIndex To this.nIndex - 1
	        This.aCustomArray[i] = This.aCustomArray[i+1]
	    EndFor
	    
	    this.nIndex = this.nIndex - 1
	    If this.nIndex <= 0
	        this.nIndex = 0
	        Dimension this.aCustomArray[1]
	    Else
	        Dimension This.aCustomArray[this.nIndex]
	    Endif
	    
	    Return .T.
	Endfunc

	Function ToArray
	    If this.nIndex > 0
	        Acopy(this.aCustomArray, this.aResult)
	        Return @this.aResult
	    Else
	        dimension this.aResult[1]
	        Return @this.aResult
	    Endif
	Endfunc

	Function LoadFromString(tcString, tcSeparator)
	    Local lnLines, i
	    tcSeparator = Iif(Pcount() < 2, Chr(13), tcSeparator)
	    
	    This.Clear()
	    lnLines = Alines(laTemp, tcString, .T., tcSeparator)
	    
	    For i = 1 To lnLines
	        This.Add(laTemp[i])
	    EndFor
	Endfunc

	Function ToString
		Return this.Join()
	EndFunc
	
	Function Join(tcSep)
	    If this.nIndex > 0
	        Local lcStr, i, lcVal, lcSeparator
	        lcSeparator = Iif(Pcount() = 0 Or Isnull(tcSep), "", tcSep)
	        lcStr = ""
	        
	        For i = 1 to this.GetLen()
	            lcVal = this.aCustomArray[i]
	            If i = 1 then
	                lcStr = lcVal
	            Else
	                lcStr = lcStr + lcSeparator + lcVal
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
			This.nIteratorCounter = 1
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

	Function Reset
	    This.nIteratorCounter = 1
	Endfunc

	Function Current
	    If Between(This.nIteratorCounter, 1, This.GetLen())
	        Return This.GetDataByIndex()
	    Endif
	    Return .Null.
	Endfunc

	Function IsEmpty
	    Return This.GetLen() = 0
	Endfunc

	Function First
	    If This.GetLen() > 0
	        Local lnOldCounter
	        lnOldCounter = This.nIteratorCounter
	        This.nIteratorCounter = 1
	        Local lvResult
	        lvResult = This.GetDataByIndex()
	        This.nIteratorCounter = lnOldCounter
	        Return lvResult
	    Endif
	    Return .Null.
	Endfunc

	Function Last
	    If This.GetLen() > 0
	        Local lnOldCounter
	        lnOldCounter = This.nIteratorCounter
	        This.nIteratorCounter = This.GetLen()
	        Local lvResult
	        lvResult = This.GetDataByIndex()
	        This.nIteratorCounter = lnOldCounter
	        Return lvResult
	    Endif
	    Return .Null.
	Endfunc

	Function ForEach(tcExpression)
	    Local lnOldCounter, i
	    lnOldCounter = This.nIteratorCounter
	    
	    For i = 1 To This.GetLen()
	        This.nIteratorCounter = i
	        Local lvItem
	        lvItem = This.GetDataByIndex()
	        
	        * Evaluar la expresiÛn pasando el item actual
	        * Ejemplo de uso: obj.ForEach("? m.lvItem")
	        &tcExpression
	    EndFor
	    
	    This.nIteratorCounter = lnOldCounter
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
	    * ImplementaciÛn b·sica que las clases hijas pueden sobrescribir
	    Local lcResult, i, lnOldCounter
	    lnOldCounter = This.nIteratorCounter
	    
	    lcResult = "["
	    For i = 1 To This.GetLen()
	        This.nIteratorCounter = i
	        Local lvItem
	        lvItem = This.GetDataByIndex()
	        
	        If i > 1
	            lcResult = lcResult + ", "
	        Endif
	        
	        Do Case
	            Case Type("lvItem") = "C"
	                lcResult = lcResult + ["] + lvItem + ["]
	            Case Type("lvItem") = "N"
	                lcResult = lcResult + Transform(lvItem)
	            Case Type("lvItem") = "L"
	                lcResult = lcResult + Iif(lvItem, "true", "false")
	            Case Isnull(lvItem)
	                lcResult = lcResult + "null"
	            Otherwise
	                lcResult = lcResult + "object"
	        EndCase
	    EndFor
	    
	    lcResult = lcResult + "]"
	    This.nIteratorCounter = lnOldCounter
	    
	    Return lcResult
	Endfunc
Enddefine

&& ======================================================================== &&
&& TStack
&& ======================================================================== &&
Define Class TStack As Custom
	Hidden Stack(1)
	Hidden StackCounter
	dimension aResult[1]

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
	        lcSupportedTypes As String, lnStackIndex As Integer, lcItemType As String
	    
	    lbFound = .F.
	    lnStackIndex = 0
	    lcSupportedTypes = "CINYDTL"
	    
	    If !This.Empty()
	        * Buscar desde el tope hacia abajo (orden LIFO)
	        For nIndex = This.StackCounter To 1 Step -1
	            lnStackIndex = lnStackIndex + 1
	            lvItem = This.Stack[nIndex]
	            lcItemType = Type("lvItem")
	            
	            If lcItemType != "U"
	                Do Case
	                Case lcItemType == "O" And Type("tvData") == "O"
	                    * ComparaciÛn de objetos por referencia o por Name si existe
	                    If lvItem == tvData
	                        lbFound = .T.
	                    Else
	                        If Type("lvItem.Name") == "C" And Type("tvData.Name") == "C"
	                            lbFound = (tvData.Name == lvItem.Name)
	                        Endif
	                    Endif
	                Case lcItemType $ lcSupportedTypes And Type("tvData") $ lcSupportedTypes
	                    lbFound = (tvData == lvItem)
	                Endcase
	            Endif
	            
	            If lbFound
	                Exit
	            Endif
	        Endfor
	    Endif
	    
	    Return Iif(lbFound, lnStackIndex, -1)
	Endfunc

	Hidden Function IncreaseStack As Void
		This.StackCounter = This.StackCounter + 1
		Dimension This.Stack[This.StackCounter]
	Endfunc

	Hidden Function DecreaseStack As Void
		If !This.Empty()
			This.StackCounter = This.StackCounter - 1
			If This.StackCounter > 0
				Dimension This.Stack[This.StackCounter]
			else
				dimension this.Stack[1]
			Endif
		Endif
	Endfunc

	Function Size As Integer
		Return This.StackCounter
	endfunc
	
	function Capacity as Integer
		return alen(this.stack, 1)
	endfunc

	Function Clear As Void
	    This.StackCounter = 0
	    Dimension This.Stack(1)
	Endfunc

	Function ToArray As Variant
	    If This.Empty()
	        dimension this.aResult[1]
	        this.aResult[1] = .Null.
	        Return @this.aResult
	    Else
	        dimension this.aResult[This.StackCounter]
	        Local i
	        For i = 1 To This.StackCounter
	            this.aResult[i] = This.Stack[This.StackCounter - i + 1]  && Orden LIFO
	        EndFor
	        Return @this.aResult
	    Endif
	Endfunc

	Function ToString As String
	    Local lcResult As String, i As Integer, lvItem As Variant
	    
	    If This.Empty()
	        Return "Stack: []"
	    Endif
	    
	    lcResult = "Stack: ["
	    
	    * Mostrar desde el tope hacia abajo
	    For i = This.StackCounter To 1 Step -1
	        lvItem = This.Stack[i]
	        
	        If i < This.StackCounter
	            lcResult = lcResult + ", "
	        Endif
	        
	        Do Case
	            Case Type("lvItem") = "C"
	                lcResult = lcResult + ["] + lvItem + ["]
	            Case Type("lvItem") = "N"
	                lcResult = lcResult + Transform(lvItem)
	            Case Type("lvItem") = "L"
	                lcResult = lcResult + Iif(lvItem, "true", "false")
	            Case Isnull(lvItem)
	                lcResult = lcResult + "null"
	            Case Type("lvItem") = "O"
	                lcResult = lcResult + "object"
	            Otherwise
	                lcResult = lcResult + Transform(lvItem)
	        EndCase
	    EndFor
	    
	    lcResult = lcResult + "] (top?bottom)"
	    Return lcResult
	Endfunc

	Function Contains As Boolean
	    Lparameters tvData As Variant
	    Return (This.Search(tvData) > 0)
	Endfunc

	Function PopAll As Variant
	    dimension this.aResult[1]
	    Local i, lnCount
	    
	    If This.Empty()
	        this.aResult[1] = .Null.
	        Return @this.aResult
	    Endif
	    
	    lnCount = This.StackCounter
	    Dimension this.aResult[lnCount]
	    
	    For i = 1 To lnCount
	        this.aResult[i] = This.Pop()
	    EndFor
	    
	    Return @this.aResult
	Endfunc

	Hidden Function GetStackValue As variant
		Local lvData As variant
		lvData = .Null.
		If Not This.Empty()
			lvData = This.Stack[This.StackCounter]
		Endif
		Return lvData
	endfunc	
Enddefine

&& ======================================================================== &&
&& TQueue
&& ======================================================================== &&
Define Class TQueue As Custom
	Hidden aQueueList(1)
	Hidden nQueueCounter
	dimension aResult[1]

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
	    Local lvItem As variant, i As Integer, j As Integer
	    lvItem = .Null.
	    
	    If This.nQueueCounter > 0
	        * Guardar el primer elemento (FIFO)
	        lvItem = This.aQueueList[1]
	        
	        * Mover todos los elementos una posiciÛn hacia adelante
	        For i = 1 To This.nQueueCounter - 1
	            This.aQueueList[i] = This.aQueueList[i + 1]
	        EndFor
	        
	        * Decrementar contador y redimensionar
	        This.nQueueCounter = This.nQueueCounter - 1
	        
	        If This.nQueueCounter > 0
	            Dimension This.aQueueList[This.nQueueCounter]
	        Else
	            * Queue vacÌo
	            Dimension This.aQueueList(1)
	            This.aQueueList[1] = .Null.
	        Endif
	    Endif
	    
	    Return lvItem
	Endfunc

	Function Extract As variant
	    Local lvItem As variant
	    lvItem = .Null.
	    
	    If This.nQueueCounter > 0
	        * Extraer desde el final (˙ltimo elemento agregado)
	        lvItem = This.aQueueList[This.nQueueCounter]
	        This.nQueueCounter = This.nQueueCounter - 1
	        
	        If This.nQueueCounter > 0
	            Dimension This.aQueueList[This.nQueueCounter]
	        Else
	            * Queue vacÌo
	            Dimension This.aQueueList(1)
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

	Function IsEmpty As Boolean
	    Return (This.nQueueCounter = 0)
	Endfunc

	Function Size As Integer
	    Return This.nQueueCounter
	Endfunc

	Function Capacity As Integer
	    Return Alen(This.aQueueList, 1)
	Endfunc

	* MÈtodo para pre-asignar capacidad y evitar redimensionamientos frecuentes
	Function Reserve As Void
	    Lparameters tnCapacity As Integer
	    If tnCapacity > Alen(This.aQueueList, 1)
	        Dimension This.aQueueList[tnCapacity]
	    Endif
	Endfunc

	Function Rear As Variant
	    Local lvRear As Variant
	    lvRear = .Null.
	    If This.nQueueCounter > 0
	        lvRear = This.aQueueList[This.nQueueCounter]
	    Endif
	    Return lvRear
	Endfunc

	Function Contains As Boolean
	    Lparameters tvData As Variant
	    Local i As Integer, lbFound As Boolean
	    lbFound = .F.
	    
	    For i = 1 To This.nQueueCounter
	        If This.aQueueList[i] == tvData
	            lbFound = .T.
	            Exit
	        Endif
	    EndFor
	    
	    Return lbFound
	Endfunc

	Function Search As Integer
	    Lparameters tvData As Variant
	    Local i As Integer
	    
	    For i = 1 To This.nQueueCounter
	        Do Case
	        Case Type("This.aQueueList[i]") == "O" And Type("tvData") == "O"
	            If This.aQueueList[i] == tvData
	                Return i
	            Endif
	        Case This.aQueueList[i] == tvData
	            Return i
	        Endcase
	    EndFor
	    
	    Return -1  && No encontrado
	Endfunc

	Function ToArray As Variant
	    If This.IsEmpty()
	        dimension this.aResult[1]
	        this.aResult[1] = .Null.
	        Return @this.aResult
	    Else
	        dimension this.aResult[This.nQueueCounter]
	        Local i As Integer
	        For i = 1 To This.nQueueCounter
	            this.aResult[i] = This.aQueueList[i]
	        EndFor
	        Return @this.aResult
	    Endif
	Endfunc

	Function ToString As String
	    Local lcResult As String, i As Integer, lvItem As Variant
	    
	    If This.IsEmpty()
	        Return "Queue: [] (empty)"
	    Endif
	    
	    lcResult = "Queue: ["
	    
	    For i = 1 To This.nQueueCounter
	        lvItem = This.aQueueList[i]
	        
	        If i > 1
	            lcResult = lcResult + ", "
	        Endif
	        
	        Do Case
	            Case Type("lvItem") = "C"
	                lcResult = lcResult + ["] + lvItem + ["]
	            Case Type("lvItem") = "N"
	                lcResult = lcResult + Transform(lvItem)
	            Case Type("lvItem") = "L"
	                lcResult = lcResult + Iif(lvItem, "true", "false")
	            Case Isnull(lvItem)
	                lcResult = lcResult + "null"
	            Case Type("lvItem") = "O"
	                lcResult = lcResult + "object"
	            Otherwise
	                lcResult = lcResult + Transform(lvItem)
	        EndCase
	    EndFor
	    
	    lcResult = lcResult + "] (front?rear)"
	    Return lcResult
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
	Hidden Array aObjectStack(1)
	Hidden nStackLevel
	
	Function Init
		This.lCentury = Set("Century") == "OFF"
		This.cDateAct = Set("Date")
		Set Century On
		Set Date Ansi
		Mvcount = 60000
	    This.nStackLevel = 0
	    Dimension This.aObjectStack(1)		
	Endfunc

	Function ToString(toRefObj, tcFlags)
		lPassByRef = .T.
		Try
			External Array toRefObj
		Catch
			lPassByRef = .F.
		Endtry
		This.cFlags = Evl(tcFlags, USER_DEFINED_PEMS)
		If lPassByRef
			Return This.AnyToStr(@toRefObj)
		Else
			Return This.AnyToStr(toRefObj)
		Endif
	Endfunc

	Function AnyToStr As Memo
	    Lparameters tValue As variant
	    
	    * Declarar TODAS las variables locales al inicio
	    Local Array aLista(1), aCopia(1), gaMembers(1)
	    Local lcProp As String, llIsCollection As Boolean, i As Integer
	    Local j As Integer, k As Integer, lcStr As String, lnTot As Integer
	    Local lcArray As String, lcComma As String
	    
	    Try
	        External Array tValue
	    Catch
	    Endtry
	    
	    Do Case
		Case Type("tValue", 1) = 'A'
		    Try
		        If Alen(tValue, 2) == 0
		            * Array unidimensional
		            lcArray = '['
		            For k = 1 To Alen(tValue)
		                If k > 1
		                    lcArray = lcArray + ','
		                Endif
		                
		                Try
		                    * Verificar si el elemento es un array
		                    If Type("tValue[k]", 1) = 'A'
		                        =Acopy(tValue[k], aLista)
		                        lcArray = lcArray + This.AnyToStr(@aLista)
		                    Else
		                        lcArray = lcArray + This.AnyToStr(tValue[k])
		                    Endif
		                Catch
		                    lcArray = lcArray + '"<array element error>"'
		                Endtry
		            Endfor
		            lcArray = lcArray + ']'
		        Else
		            * Array multidimensional
		            lcArray = '['
		            For k = 1 To Alen(tValue, 1)
		                If k > 1
		                    lcArray = lcArray + ','
		                Endif
		                
		                lcArray = lcArray + '['
		                For j = 1 To Alen(tValue, 2)
		                    If j > 1
		                        lcArray = lcArray + ','
		                    Endif
		                    
		                    Try
		                        If Type("tValue[k,j]", 1) = 'A'
		                            =Acopy(tValue[k, j], aLista)
		                            lcArray = lcArray + This.AnyToStr(@aLista)
		                        Else
		                            lcArray = lcArray + This.AnyToStr(tValue[k, j])
		                        Endif
		                    Catch
		                        lcArray = lcArray + '"<array element error>"'
		                    Endtry
		                Endfor
		                lcArray = lcArray + ']'
		            Endfor
		            lcArray = lcArray + ']'
		        Endif
		    Catch
		        lcArray = '["<array processing error>"]'
		    Endtry
		    Return lcArray
	    Case Vartype(tValue) = 'O'
	        * Verificar referencia circular
	        If This.IsCircularReference(tValue)
	            Return '"<circular reference>"'
	        Endif
	        
	        * Agregar objeto al stack
	        This.PushObject(tValue)
	        
	        lcStr = '{'

	        * Verificar si el objeto es v·lido
	        Try
	            lnTot = Amembers(gaMembers, tValue, 0, This.cFlags)
	        
	            For j = 1 To lnTot
	                lcProp = Lower(Alltrim(gaMembers[j]))
	                lcStr = lcStr + Iif(Len(lcStr) > 1, ',', '') + '"' + lcProp + '":'
	                
	                Try
	                    * Intentar como array primero
	                    =Acopy(tValue.&gaMembers[j], aCopia)
	                    lcStr = lcStr + This.AnyToStr(@aCopia)
	                Catch
	                    Try
	                        * Si no es array, serializar directamente
	                        lcStr = lcStr + This.AnyToStr(tValue.&gaMembers[j])
	                    Catch
	                        * Si falla todo, marcar como inaccesible
	                        lcStr = lcStr + '"<inaccessible>"'
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
	                lcComma = Iif(Right(lcStr, 1) != '{', ',', '')
	                lcStr = lcStr + lcComma + '"Collection":['
	                For i = 1 To tValue.Count
	                    lcStr = lcStr + Iif(i > 1, ',', '') + This.AnyToStr(tValue.Item(i))
	                Endfor
	                lcStr = lcStr + ']'
	            Endif
	            *//> Collection based class object support                
	        Catch
	            lcStr = lcStr + '"error":"Object serialization failed"'
	        Finally
	            This.PopObject()
	        Endtry
	        
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
			tcString = Strtran(tcString,"¬≤","\u00b2")
			tcString = Strtran(tcString,'√†','\u00e0')
			tcString = Strtran(tcString,'√°','\u00e1')
			tcString = Strtran(tcString,'√®','\u00e8')
			tcString = Strtran(tcString,'√©','\u00e9')
			tcString = Strtran(tcString,'√¨','\u00ec')
			tcString = Strtran(tcString,'√≠','\u00ed')
			tcString = Strtran(tcString,'√≤','\u00f2')
			tcString = Strtran(tcString,'√≥','\u00f3')
			tcString = Strtran(tcString,'√π','\u00f9')
			tcString = Strtran(tcString,'√∫','\u00fa')
			tcString = Strtran(tcString,'√º','\u00fc')
			tcString = Strtran(tcString,'√Ä','\u00c0')
			tcString = Strtran(tcString,'√Å','\u00c1')
			tcString = Strtran(tcString,'√à','\u00c8')
			tcString = Strtran(tcString,'√â','\u00c9')
			tcString = Strtran(tcString,'√å','\u00cc')
			tcString = Strtran(tcString,'√ç','\u00cd')
			tcString = Strtran(tcString,'√í','\u00d2')
			tcString = Strtran(tcString,'√ì','\u00d3')
			tcString = Strtran(tcString,'√ô','\u00d9')
			tcString = Strtran(tcString,'√ö','\u00da')
			tcString = Strtran(tcString,'√ú','\u00dc')
			tcString = Strtran(tcString,'√±','\u00f1')
			tcString = Strtran(tcString,'√ë','\u00d1')
			tcString = Strtran(tcString,'¬©','\u00a9')
			tcString = Strtran(tcString,'¬Æ','\u00ae')
			tcString = Strtran(tcString,'√ß','\u00e7')
		Endif

		Return '"' +tcString + '"'
	endfunc

	Function ToStringFormatted As String
	    Lparameters toRefObj, tcFlags As String, tnIndent As Integer
	    Local lcJson As String, lcFormatted As String
	    
	    lcJson = This.ToString(toRefObj, tcFlags)
	    lcFormatted = This.FormatJson(lcJson, Evl(tnIndent, 2))
	    
	    Return lcFormatted
	Endfunc

	Function FormatJson As String
	    Lparameters tcJson As String, tnIndent As Integer
	    Local lcResult As String, lcChar As String, nLevel As Integer
	    Local i As Integer, lInString As Boolean, lEscape As Boolean
	    Local lcIndent As String
	    
	    lcResult = ""
	    nLevel = 0
	    lInString = .F.
	    lEscape = .F.
	    tnIndent = Evl(tnIndent, 2)
	    
	    For i = 1 To Len(tcJson)
	        lcChar = Substr(tcJson, i, 1)
	        
	        Do Case
	        Case lEscape
	            lcResult = lcResult + lcChar
	            lEscape = .F.
	            
	        Case lcChar = "\" And lInString
	            lcResult = lcResult + lcChar
	            lEscape = .T.
	            
	        Case lcChar = '"'
	            lcResult = lcResult + lcChar
	            lInString = !lInString
	            
	        Case lInString
	            lcResult = lcResult + lcChar
	            
	        Case lcChar $ "{["
	            lcResult = lcResult + lcChar + Chr(13) + Chr(10)
	            nLevel = nLevel + 1
	            lcResult = lcResult + Space(nLevel * tnIndent)
	            
	        Case lcChar $ "}]"
	            lcResult = Left(lcResult, Len(lcResult) - (nLevel * tnIndent))
	            nLevel = nLevel - 1
	            lcResult = lcResult + Chr(13) + Chr(10) + Space(nLevel * tnIndent) + lcChar
	            If i < Len(tcJson) And !Substr(tcJson, i+1, 1) $ "}],:"
	                lcResult = lcResult + Chr(13) + Chr(10) + Space(nLevel * tnIndent)
	            Endif
	            
	        Case lcChar = ","
	            lcResult = lcResult + lcChar + Chr(13) + Chr(10) + Space(nLevel * tnIndent)
	            
	        Case lcChar = ":"
	            lcResult = lcResult + lcChar + " "
	            
	        Case lcChar $ " " + Chr(9) + Chr(10) + Chr(13)
	            * Ignorar espacios en blanco fuera de strings
	            
	        Otherwise
	            lcResult = lcResult + lcChar
	        Endcase
	    Endfor
	    
	    Return lcResult
	endfunc
	
	Function ValidateJson As Boolean
	    Lparameters tcJson As String
	    Local i As Integer, nBraces As Integer, nBrackets As Integer
	    Local lInString As Boolean, lEscape As Boolean, lcChar As String
	    
	    nBraces = 0
	    nBrackets = 0
	    lInString = .F.
	    lEscape = .F.
	    
	    For i = 1 To Len(tcJson)
	        lcChar = Substr(tcJson, i, 1)
	        
	        Do Case
	        Case lEscape
	            lEscape = .F.
	            
	        Case lcChar = "\" And lInString
	            lEscape = .T.
	            
	        Case lcChar = '"'
	            lInString = !lInString
	            
	        Case !lInString
	            Do Case
	            Case lcChar = "{"
	                nBraces = nBraces + 1
	            Case lcChar = "}"
	                nBraces = nBraces - 1
	            Case lcChar = "["
	                nBrackets = nBrackets + 1
	            Case lcChar = "]"
	                nBrackets = nBrackets - 1
	            Endcase
	        Endcase
	        
	        * Verificar que no haya desbalance
	        If nBraces < 0 Or nBrackets < 0
	            Return .F.
	        Endif
	    Endfor
	    
	    Return (nBraces = 0 And nBrackets = 0 And !lInString)
	Endfunc

	Function GetStats As Object
	    Lparameters toRefObj
	    Local loStats As Object
	    loStats = Createobject("Empty")
	    
	    Addproperty(loStats, "Objects", 0)
	    Addproperty(loStats, "Arrays", 0)
	    Addproperty(loStats, "Properties", 0)
	    Addproperty(loStats, "MaxDepth", 0)
	    Addproperty(loStats, "CurrentDepth", 0)
	    
	    This.CountElements(toRefObj, @loStats)
	    
	    Return loStats
	Endfunc

	Function CountElements As Void
	    Lparameters tValue, toStats As Object
	    toStats.CurrentDepth = toStats.CurrentDepth + 1
	    toStats.MaxDepth = Max(toStats.MaxDepth, toStats.CurrentDepth)
	    
	    Do Case
	    Case Type("tValue", 1) = 'A'
	        toStats.Arrays = toStats.Arrays + 1
	        Local i As Integer
	        For i = 1 To Alen(tValue)
	            This.CountElements(tValue[i], @toStats)
	        Endfor
	        
	    Case Vartype(tValue) = 'O'
	        toStats.Objects = toStats.Objects + 1
	        Local Array gaMembers(1)
	        Local lnTot As Integer, j As Integer
	        
	        Try
	            lnTot = Amembers(gaMembers, tValue, 0, This.cFlags)
	            toStats.Properties = toStats.Properties + lnTot
	            
	            For j = 1 To lnTot
	                Try
	                    This.CountElements(tValue.&gaMembers[j], @toStats)
	                Catch
	                Endtry
	            Endfor
	        Catch
	        Endtry
	    Endcase
	    
	    toStats.CurrentDepth = toStats.CurrentDepth - 1
	Endfunc
	
	Function IsCircularReference As Boolean
	    Lparameters toObject As Object
	    Local i As Integer
	    
	    For i = 1 To This.nStackLevel
	        If This.aObjectStack[i] == toObject
	            Return .T.
	        Endif
	    EndFor
	    Return .F.
	Endfunc

	Function PushObject As Void
	    Lparameters toObject As Object
	    This.nStackLevel = This.nStackLevel + 1
	    If This.nStackLevel > Alen(This.aObjectStack)
	        Dimension This.aObjectStack[This.nStackLevel]
	    Endif
	    This.aObjectStack[This.nStackLevel] = toObject
	Endfunc

	Function PopObject As Void
	    If This.nStackLevel > 0
	        This.aObjectStack[This.nStackLevel] = .Null.
	        This.nStackLevel = This.nStackLevel - 1
	    Endif
	Endfunc	
EndDefine

Define Class TString as TObject

	Dimension aWords[1]
	Function init(tcStartValue)
		If Pcount() = 1
			If Type('tcStartValue') == 'C'
				this.Value = tcStartValue
			Else
				Error 'Invalid data type for string.'
			EndIf
		Else
			this.Value = ""
		EndIf
	EndFunc
	
	Function EqualsIgnoreCase(tvObject)
		Do case
		case vartype(tvObject) == vartype(this.value)
			Return Lower(tvObject) == Lower(this.value)
		Case Type('tvObject') = 'O' And Type('tvObject.Value') = 'C'
			Return Lower(tvObject.Value) == Lower(this.value)
		endcase					
		Return .f.
	EndFunc	
	
	Function Head(tnSpaces)
		Return Left(this.value, tnSpaces)
	EndFunc
	
	Function Tail(tnSpaces)
		Return Right(this.value, tnSpaces)
	EndFunc
	
	Function padl(tnSize, tcPadCharacters)
		Return Padl(this.value, tnSize, tcPadCharacters)
	EndFunc
		
	Function padr(tnSize, tcPadCharacters)
		Return Padr(this.value, tnSize, tcPadCharacters)
	EndFunc
	
	Function WordCount(tcDelimiter)
		Return GetWordCount(this.value, iif(empty(tcDelimiter), space(1), tcDelimiter))
	EndFunc
	
	Function Split(tcDelimiter)
		Local tcWord, i
		For i = 1 to GetWordCount(this.value, tcDelimiter)
			Dimension this.aWords[i]
			this.aWords[i] = GetWordNum(this.value, i, tcDelimiter)
		EndFor
		Return @this.aWords
	EndFunc
	
	Function StartsWith(tvObject)
	    Do Case
	    Case Type('tvObject') = 'C'
	        Return Left(This.Value, Len(tvObject)) == tvObject
	    Case Type('tvObject') = 'O' And Type('tvObject.Value') = 'C'
	        Return Left(This.Value, Len(tvObject.Value)) == tvObject.Value
	    EndCase
	    Return .F.
	EndFunc

	Function EndsWith(tvObject)
	    Do Case
	    Case Type('tvObject') = 'C'
	        Return Right(This.Value, Len(tvObject)) == tvObject
	    Case Type('tvObject') = 'O' And Type('tvObject.Value') = 'C'
	        Return Right(This.Value, Len(tvObject.Value)) == tvObject.Value
	    EndCase
	    Return .F.
	EndFunc

	Function IndexOf(tcChar)
	    Return At(tcChar, this.value)
	EndFunc
	
	Function LastIndexOf(tcChar)
		Local lnIndex, lnPos, lnOccur
		lnPos = 0
		lnOccur = 0
		Do while .t.
			lnOccur = lnOccur + 1
			lnIndex = At(tcChar, this.value, lnOccur)
			If lnIndex > lnPos
				lnPos = lnIndex
			Else
				exit
			EndIf
		EndDo
		Return lnPos
	endfunc
	
	Function Range(tnStart, tnLength)
	    Return Substr(This.Value, tnStart, tnLength)
	EndFunc
	
	Function Substring(tnStart, tnEnd)
		Do case
		case Pcount() = 1
			Return Substr(this.value, tnStart, Len(this.value))
		Case Pcount() = 2
			Return this.range(tnStart, tnEnd)
		EndCase
		Return Space(1)
	endfunc		

	Function SubstringRange(tnStart, tnEnd)
	    Return Substr(This.Value, tnStart, tnEnd - tnStart + 1)
	endfunc
	
	Function Concat(tvObject)
		Do case
		case Type('tvObject') == 'C'
			Return this.value + tvObject
		Case Type('tvObject') == 'O' and Type('tvObject.name') == 'C' and Lower(tvObject.Name) == 'tstring'
			Return this.value + tvObject.Value
		endcase
		Return Space(1)
	EndFunc
	
	Function Replace(tcOldChar, tcNewChar)
		Return Strtran(this.value, tcOldChar, tcNewChar)
	EndFunc
	
	Function Matches(tcPattern)  && Cambiar par·metro
	    Local loRegEx, lbResult
	    
	    Try
	        loRegEx = CreateObject("VBScript.RegExp")
	        loRegEx.IgnoreCase = .T.
	        loRegEx.Global = .T.
	        loRegEx.Pattern = tcPattern
	        lbResult = loRegEx.Test(This.Value)
	    Catch
	        lbResult = .F.
	    Finally
	        If Type("loRegEx") = "O"
	            loRegEx = .Null.
	        EndIf
	    EndTry
	    
	    Return lbResult
	EndFunc
	
	Function Contains(tvObject)
		Do case
		case Type('tvObject') == 'C'
			Return tvObject $ this.value
		Case Type('tvObject') == 'O' and Type('tvObject.name') == 'C' and Lower(tvObject.Name) == 'tstring'
			Return tvObject.Value $ this.value
		endcase
		Return .F.
	EndFunc
	
	Function ReplaceFirst(tvObject, tcReplacement)
		Do case
		case Type('tvObject') == 'C'
			Return Strtran(this.value, tvObject, tcReplacement, 1)
		Case Type('tvObject') == 'O' and Type('tvObject.name') == 'C' and Lower(tvObject.Name) == 'tstring'
			Return Strtran(this.value, tvObject.Value, tcReplacement, 1)
		endcase
		Return Space(1)
	EndFunc
	
	Function ReplaceAll(tvObject, tcReplacement)
		Do case
		case Type('tvObject') == 'C'					
			Return Strtran(this.value, tvObject, tcReplacement)
		Case Type('tvObject') == 'O' and Type('tvObject.name') == 'C' and Lower(tvObject.Name) == 'tstring'
			Return Strtran(this.value, tvObject.Value, tcReplacement)
		endcase
		Return Space(1)
	EndFunc
	
	Function ToLowerCase
		Return Lower(this.value)
	EndFunc
	
	Function ToUpperCase
		Return Upper(this.value)
	EndFunc
	
	Function ToProperCase
		Return Proper(This.value)
	EndFunc
	
	Function Trim
		Return Alltrim(this.value)
	EndFunc
	
	Function Strip
		Return Alltrim(This.Value)
	endfunc	
	
	Function StripLeading
		Return Ltrim(this.value)
	EndFunc
	
	Function StripTrailing
		Return Rtrim(This.Value)
	EndFunc
	
	Function IsBlank
		Return Empty(this.value)
	EndFunc 
	
	Function Lines
	    Local i, lcValue, lnCount
	    * Normalizar saltos de lÌnea: convertir LF a CR
	    lcValue = Strtran(This.Value, Chr(13) + Chr(10), Chr(13))  && CRLF -> CR
	    lcValue = Strtran(lcValue, Chr(10), Chr(13))               && LF -> CR
	    
	    lnCount = GetWordCount(lcValue, Chr(13))
	    For i = 1 To lnCount
	        Dimension This.aWords[i]
	        This.aWords[i] = GetWordNum(lcValue, i, Chr(13))
	    endfor
	    
	    Return @This.aWords
	EndFunc
	
	Function Reverse
		Local lcValue, i
		lcValue = ''
		For i = Len(Alltrim(this.value)) to 1 step -1
			lcValue = lcValue + Substr(this.value, i, 1)
		EndFor
		
		Return lcValue
	EndFunc	
	
    Function ToString
        Return This.Value
    EndFunc	

    Function GetLength
        Return Len(This.Value)
    endfunc
    	
EndDefine

Define Class TNumber As TObject
    
    Function Init(tnStartValue)
        If Pcount() = 1
            If Type('tnStartValue') = 'N'
                This.Value = tnStartValue
            Else
                Error 'Invalid data type for Number.'
            EndIf
        Else
            This.Value = 0.0
        EndIf
    EndFunc    
    
    * MÈtodos de conversiÛn
    Function GetInteger
        Return Int(This.Value)
    EndFunc
    
    Function GetFloat
        Return This.Value
    EndFunc
    
    Function GetDouble
        Return This.Value
    EndFunc
    
    Function GetDecimal(tnDecimals)
        Local lnDecimals
        lnDecimals = Evl(tnDecimals, 2)
        Return Round(This.Value, lnDecimals)
    EndFunc
    
    * Operaciones matem·ticas b·sicas
	Function Add(tnValue)
	    Do Case
	    Case Type('tnValue') = 'N'
	        Return This.Value + tnValue
	    Case Type('tnValue') = 'O' And Type('tnValue.Value') = 'N'
	        Return This.Value + tnValue.Value
	    EndCase
	    Return This.Value
	EndFunc

	Function AddAndReturn(tnValue)
	    Local loResult
	    loResult = This.Clone()
	    loResult.Value = This.Add(tnValue)
	    Return loResult
	endfunc
    
    Function Subtract(tnValue)
        Do Case
        Case Type('tnValue') = 'N'
            Return This.Value - tnValue
        Case Type('tnValue') = 'O' And Type('tnValue.Value') = 'N'
            Return This.Value - tnValue.Value
        EndCase
        Return This.Value
    EndFunc
    
    Function Multiply(tnValue)
        Do Case
        Case Type('tnValue') = 'N'
            Return This.Value * tnValue
        Case Type('tnValue') = 'O' And Type('tnValue.Value') = 'N'
            Return This.Value * tnValue.Value
        EndCase
        Return This.Value
    EndFunc
    
    Function Divide(tnValue)
        Local lnDivisor
        Do Case
        Case Type('tnValue') = 'N'
            lnDivisor = tnValue
        Case Type('tnValue') = 'O' And Type('tnValue.Value') = 'N'
            lnDivisor = tnValue.Value
        Otherwise
            Return This.Value
        EndCase
        
        If lnDivisor = 0
            Error 'Division by zero'
        EndIf
        
        Return This.Value / lnDivisor
    EndFunc
    
    Function Power(tnExponent)
        Do Case
        Case Type('tnExponent') = 'N'
            Return This.Value ^ tnExponent
        Case Type('tnExponent') = 'O' And Type('tnExponent.Value') = 'N'
            Return This.Value ^ tnExponent.Value
        EndCase
        Return This.Value
    EndFunc
    
    Function Modulo(tnValue)
        Local lnDivisor
        Do Case
        Case Type('tnValue') = 'N'
            lnDivisor = tnValue
        Case Type('tnValue') = 'O' And Type('tnValue.Value') = 'N'
            lnDivisor = tnValue.Value
        Otherwise
            Return This.Value
        EndCase
        
        If lnDivisor = 0
            Error 'Division by zero in modulo operation'
        EndIf
        
        Return Mod(This.Value, lnDivisor)
    EndFunc
    
    * Funciones matem·ticas avanzadas
    Function Abs
        Return Abs(This.Value)
    EndFunc
    
    Function Sqrt
        If This.Value < 0
            Error 'Cannot calculate square root of negative number'
        EndIf
        Return Sqrt(This.Value)
    EndFunc
    
    Function Ceiling
        Return Ceiling(This.Value)
    EndFunc
    
    Function Floor
        Return Floor(This.Value)
    EndFunc
    
    Function Round(tnDecimals)
        Local lnDecimals
        lnDecimals = Evl(tnDecimals, 0)
        Return Round(This.Value, lnDecimals)
    EndFunc
    
    * Funciones trigonomÈtricas
    Function Sin
        Return Sin(This.Value)
    EndFunc
    
    Function Cos
        Return Cos(This.Value)
    EndFunc
    
    Function Tan
        Return Tan(This.Value)
    EndFunc
    
    Function Asin
        If Abs(This.Value) > 1
            Error 'Value out of range for arcsine'
        EndIf
        Return Asin(This.Value)
    EndFunc
    
    Function Acos
        If Abs(This.Value) > 1
            Error 'Value out of range for arccosine'
        EndIf
        Return Acos(This.Value)
    EndFunc
    
    Function Atan
        Return Atan(This.Value)
    EndFunc
    
    * Funciones logarÌtmicas
    Function Log
        If This.Value <= 0
            Error 'Cannot calculate logarithm of non-positive number'
        EndIf
        Return Log(This.Value)
    EndFunc
    
    Function Log10
        If This.Value <= 0
            Error 'Cannot calculate logarithm of non-positive number'
        EndIf
        Return Log10(This.Value)
    EndFunc
    
    Function Exp
        Return Exp(This.Value)
    EndFunc
    
    * MÈtodos de comparaciÛn
    Function IsPositive
        Return This.Value > 0
    EndFunc
    
    Function IsNegative
        Return This.Value < 0
    EndFunc
    
    Function IsZero
        Return This.Value = 0
    EndFunc
    
    Function IsEven
        Return Mod(Int(This.Value), 2) = 0
    EndFunc
    
    Function IsOdd
        Return Mod(Int(This.Value), 2) = 1
    EndFunc
    
    Function IsInteger
        Return This.Value = Int(This.Value)
    EndFunc
    
    Function IsDecimal
        Return This.Value != Int(This.Value)
    EndFunc
    
    * MÈtodos de rango
    Function IsBetween(tnMin, tnMax)
        Return This.Value >= tnMin And This.Value <= tnMax
    EndFunc
    
    Function Clamp(tnMin, tnMax)
        Return Max(tnMin, Min(tnMax, This.Value))
    EndFunc
    
    * MÈtodos de formato
    Function ToFormattedString(tnDecimals, tlThousandSeparator)
        Local lcResult, lnDecimals, llThousands
        lnDecimals = Evl(tnDecimals, 2)
        llThousands = Evl(tlThousandSeparator, .F.)
        
        If llThousands
            lcResult = Transform(This.Value, "@$ 999,999,999." + Replicate("9", lnDecimals))
        Else
            lcResult = Transform(This.Value, "@R " + Replicate("9", 10) + "." + Replicate("9", lnDecimals))
        EndIf
        
        Return AllTrim(lcResult)
    EndFunc
    
    Function ToCurrency(tcSymbol)
        Local lcSymbol
        lcSymbol = Evl(tcSymbol, "$")
        Return lcSymbol + This.ToFormattedString(2, .T.)
    EndFunc
    
    Function ToPercentage(tnDecimals)
        Local lnDecimals
        lnDecimals = Evl(tnDecimals, 2)
        Return Transform(This.Value * 100, "@R 999." + Replicate("9", lnDecimals)) + "%"
    EndFunc
    
    * Sobrescribir ToString para mejor formato
    Function ToString
        If This.IsInteger()
            Return Transform(Int(This.Value))
        Else
            Return AllTrim(Transform(This.Value))
        EndIf
    EndFunc
    
    * MÈtodo para crear una copia con nuevo valor
    Function WithValue(tnNewValue)
        Local loNew
        loNew = CreateObject(This.Class, tnNewValue)
        Return loNew
    EndFunc
    
    * Incremento y decremento
    Function Increment(tnStep)
        Local lnStep
        lnStep = Evl(tnStep, 1)
        This.Value = This.Value + lnStep
        Return This.Value
    EndFunc
    
    Function Decrement(tnStep)
        Local lnStep
        lnStep = Evl(tnStep, 1)
        This.Value = This.Value - lnStep
        Return This.Value
    EndFunc
    
EndDefine


Define Class TObject As Custom
    Value = .Null.
    
    Function ToString
        Local lcResult As String
        Try
            Do Case
            Case VarType(This.Value) = 'C'
                lcResult = This.Value
            Case VarType(This.Value) = 'N'
                lcResult = Transform(This.Value)
            Case VarType(This.Value) = 'D'
                lcResult = Dtoc(This.Value)
            Case VarType(This.Value) = 'T'
                lcResult = Ttoc(This.Value)
            Case VarType(This.Value) = 'L'
                lcResult = Iif(This.Value, "True", "False")
            Case VarType(This.Value) = 'X'
                lcResult = "Null"
            Otherwise
                lcResult = Transform(This.Value)
            EndCase
        Catch
            lcResult = "<error converting to string>"
        EndTry
        Return lcResult
    EndFunc
    
    Function GetType
        Return vartype(This.Value)
    EndFunc    
    
    Function GetLength
        Local lnResult As Integer
        Try
            Do Case
            Case Type('This.Value') = 'C'
                lnResult = Len(This.Value)
            Case Type('This.Value') = 'N'
                lnResult = Len(Transform(This.Value))
            Case Type('This.Value',1) = 'A'
                lnResult = Alen(This.Value)
            Otherwise
                lnResult = 0
            EndCase
        Catch
            lnResult = 0
        EndTry
        Return lnResult
    EndFunc
    
    Function IsEmpty
        Local llResult As Boolean
        Try
            llResult = Empty(This.Value)
        Catch
            llResult = .T.
        EndTry
        Return llResult
    EndFunc
    
    Function Equals(tvObject)
        Local llResult As Boolean
        llResult = .F.
        
        Try
            Do Case
            Case Type('tvObject') = Type('This.Value')
                llResult = (tvObject == This.Value)
            Case Type('tvObject') = 'O' And Type('tvObject.Value') != 'U'
                llResult = (tvObject.Value == This.Value)
            EndCase
        Catch
            llResult = .F.
        EndTry
        
        Return llResult
    EndFunc
    
    * MÈtodos adicionales ˙tiles
    Function Clone
        Local loClone As Object
        loClone = CreateObject(This.Class)
        loClone.Value = This.Value
        Return loClone
    EndFunc
    
    Function GetHashCode
        * ImplementaciÛn simple de hash code
        Local lcString As String, lnHash As Integer, i As Integer
        lcString = This.ToString()
        lnHash = 0
        
        For i = 1 To Len(lcString)
            lnHash = lnHash + Asc(Substr(lcString, i, 1))
        EndFor
        
        Return lnHash
    EndFunc
    
    Function CompareTo(tvObject)
        * Retorna: -1 si menor, 0 si igual, 1 si mayor
        Local lnResult As Integer
        lnResult = 0
        
        Try
            Do Case
            Case Type('tvObject') = Type('This.Value')
                Do Case
                Case This.Value < tvObject
                    lnResult = -1
                Case This.Value > tvObject
                    lnResult = 1
                Otherwise
                    lnResult = 0
                EndCase
            Case Type('tvObject') = 'O' And Type('tvObject.Value') != 'U'
                Do Case
                Case This.Value < tvObject.Value
                    lnResult = -1
                Case This.Value > tvObject.Value
                    lnResult = 1
                Otherwise
                    lnResult = 0
                EndCase
            EndCase
        Catch
            lnResult = 0
        EndTry
        
        Return lnResult
    EndFunc
    
EndDefine