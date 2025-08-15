&& ========================================================================
&& SUPER PRG - PRUEBAS COMPLETAS DEL FRAMEWORK
&& Framework de Clases Avanzado para Visual FoxPro
&& ========================================================================
&& Autor: Tu Framework VFP
&& Fecha: Agosto 2025
&& Descripción: Pruebas exhaustivas de todas las clases del framework
&& ========================================================================
Clear
Set Talk Off
Set Echo Off

set procedure to f:\desarrollo\github\foxcollection\foxcollection.prg additive
do foxcollection.prg

&& Variables globales para las pruebas
Public gnTestCount, gnPassCount, gnFailCount
gnTestCount = 0
gnPassCount = 0
gnFailCount = 0

&& ========================================================================
&& PRUEBA 1: TObject - Clase Base
&& ========================================================================
StartTest("TObject - Clase Base")

* Crear objetos TObject con diferentes tipos
loObjString = CreateObject("TObject")
loObjString.Value = "Hola Mundo"

loObjNumber = CreateObject("TObject")
loObjNumber.Value = 42.5

loObjDate = CreateObject("TObject")
loObjDate.Value = Date()

loObjLogical = CreateObject("TObject")
loObjLogical.Value = .T.

loObjNull = CreateObject("TObject")
loObjNull.Value = .Null.

* Pruebas básicas
Assertion(loObjString.GetType() = "C", "TObject detecta tipo String")
Assertion(loObjNumber.GetType() = "N", "TObject detecta tipo Number")
Assertion(loObjDate.GetType() = "D", "TObject detecta tipo Date")
Assertion(loObjLogical.GetType() = "L", "TObject detecta tipo Logical")
Assertion(loObjNull.GetType() = "X", "TObject detecta tipo Null")

* Pruebas de ToString
ShowResult(loObjString.ToString(), "String ToString")
ShowResult(loObjNumber.ToString(), "Number ToString")
ShowResult(loObjDate.ToString(), "Date ToString")
ShowResult(loObjLogical.ToString(), "Logical ToString")
ShowResult(loObjNull.ToString(), "Null ToString")

* Pruebas de longitud
Assertion(loObjString.GetLength() = 10, "GetLength de String")
Assertion(loObjNumber.GetLength() > 0, "GetLength de Number")

* Pruebas de comparación
loObjString2 = CreateObject("TObject")
loObjString2.Value = "Hola Mundo"
Assertion(loObjString.Equals(loObjString2), "Equals entre objetos")
Assertion(loObjString.Equals("Hola Mundo"), "Equals con valor directo")

* Pruebas de clonación
loClone = loObjString.Clone()
Assertion(loClone.Value = loObjString.Value, "Clone funciona correctamente")

* Pruebas CompareTo
loNum1 = CreateObject("TObject")
loNum1.Value = 10
loNum2 = CreateObject("TObject")
loNum2.Value = 20
Assertion(loNum1.CompareTo(loNum2) = -1, "CompareTo menor")
Assertion(loNum2.CompareTo(loNum1) = 1, "CompareTo mayor")
Assertion(loNum1.CompareTo(10) = 0, "CompareTo igual")

? ""

&& ========================================================================
&& PRUEBA 2: TString - Manipulación de Cadenas
&& ========================================================================
StartTest("TString - Manipulación Avanzada de Cadenas")
* Crear strings de diferentes formas
loStr1 = ftNewString("  Hola Mundo VFP  ")
loStr2 = ftNewString()
loStr3 = CreateObject("TString", "Visual FoxPro")

* Pruebas básicas
Assertion(loStr1.GetLength() = 18, "GetLength incluye espacios")
Assertion(loStr2.IsBlank(), "String vacío es blank")
Assertion(!loStr1.IsBlank(), "String con contenido no es blank")

* Pruebas de limpieza
ShowResult(loStr1.Trim(), "Trim elimina espacios")
ShowResult(loStr1.StripLeading(), "StripLeading elimina espacios izquierda")
ShowResult(loStr1.StripTrailing(), "StripTrailing elimina espacios derecha")

* Pruebas de transformación
ShowResult(loStr1.ToUpperCase(), "ToUpperCase")
ShowResult(loStr1.ToLowerCase(), "ToLowerCase")
ShowResult(loStr1.ToProperCase(), "ToProperCase")

* Pruebas de subcadenas
ShowResult(loStr1.Head(4), "Head(4) primeros caracteres")
ShowResult(loStr1.Tail(4), "Tail(4) últimos caracteres")
ShowResult(loStr1.Substring(3, 8), "Substring(3,8)")
ShowResult(loStr1.Range(3, 5), "Range(3,5)")

* Pruebas de búsqueda
Assertion(loStr1.IndexOf("Mundo") > 0, "IndexOf encuentra 'Mundo'")
Assertion(loStr1.LastIndexOf("o") > loStr1.IndexOf("o"), "LastIndexOf funciona")
Assertion(loStr1.Contains("VFP"), "Contains encuentra 'VFP'")

* Pruebas de comparación
loStrTest = ftNewString("  HOLA MUNDO VFP  ")
Assertion(loStr1.EqualsIgnoreCase(loStrTest.ToLowerCase()), "EqualsIgnoreCase funciona")
Assertion(loStr1.StartsWith("  Hola"), "StartsWith funciona")
Assertion(loStr1.EndsWith("VFP  "), "EndsWith funciona")

* Pruebas de reemplazo
ShowResult(loStr1.Replace("VFP", "2025"), "Replace VFP por 2025")
ShowResult(loStr1.ReplaceFirst("o", "0"), "ReplaceFirst primera 'o'")
ShowResult(loStr1.ReplaceAll("o", "0"), "ReplaceAll todas las 'o'")

* Pruebas de concatenación
ShowResult(loStr1.Concat(" - Año 2025"), "Concat con string")
ShowResult(loStr1.Concat(loStr3), "Concat con otro TString")

* Pruebas de padding
loShort = ftNewString("VFP")
ShowResult(loShort.Padl(10, "*"), "PadL con asteriscos")
ShowResult(loShort.Padr(10, "-"), "PadR con guiones")

* Pruebas de división de palabras
loText = ftNewString("Visual FoxPro es genial")
ShowResult(loText.WordCount(), "WordCount con espacios")
ShowResult(loText.WordCount("-"), "WordCount con guión")

laSplit = loText.Split(" ")
? "Split por espacios:"
For i = 1 To Alen(laSplit)
    ? "   [" + Transform(i) + "] = '" + laSplit[i] + "'"
EndFor

* Pruebas con saltos de línea
loMultiLine = ftNewString("Línea 1" + Chr(13) + Chr(10) + "Línea 2" + Chr(10) + "Línea 3")
laLines = loMultiLine.Lines()
? "Lines detectadas:"
For i = 1 To Alen(laLines)
    ? "   Línea " + Transform(i) + ": '" + laLines[i] + "'"
EndFor

* Pruebas de reversión
loReverse = ftNewString("abcdef")
ShowResult(loReverse.Reverse(), "Reverse de 'abcdef'")

* Pruebas con expresiones regulares (si está disponible)
Try
    Assertion(loStr1.Matches(".*VFP.*"), "Matches con regex simple")
    ? "? Soporte de RegEx disponible"
Catch
    ? "RegEx no disponible en este entorno"
EndTry

? ""

&& ========================================================================
&& PRUEBA 3: TNumber - Operaciones Matemáticas
&& ========================================================================
StartTest("TNumber - Operaciones Matemáticas Avanzadas")

* Crear números
loNum1 = CreateObject("TNumber", 15.75)
loNum2 = CreateObject("TNumber", 4.25)
loNum3 = CreateObject("TNumber", -10)
loNum4 = CreateObject("TNumber", 0)

* Pruebas de conversión
ShowResult(loNum1.GetInteger(), "GetInteger de 15.75")
ShowResult(loNum1.GetFloat(), "GetFloat de 15.75")
ShowResult(loNum1.GetDecimal(1), "GetDecimal(1) de 15.75")

* Operaciones básicas
ShowResult(loNum1.Add(loNum2), "15.75 + 4.25")
ShowResult(loNum1.Add(5), "15.75 + 5")
ShowResult(loNum1.Subtract(loNum2), "15.75 - 4.25")
ShowResult(loNum1.Multiply(2), "15.75 * 2")
ShowResult(loNum1.Divide(3), "15.75 / 3")

* Pruebas de división por cero
Try
    loNum1.Divide(0)
    Assertion(.F., "División por cero debería fallar")
Catch
    Assertion(.T., "División por cero manejada correctamente")
EndTry

* Operaciones avanzadas
ShowResult(loNum1.Power(2), "15.75 ^ 2")
ShowResult(loNum1.Modulo(4), "15.75 MOD 4")
ShowResult(loNum3.Abs(), "Valor absoluto de -10")
ShowResult(loNum1.Sqrt(), "Raíz cuadrada de 15.75")

* Funciones de redondeo
ShowResult(loNum1.Round(1), "Round(1) de 15.75")
ShowResult(loNum1.Ceiling(), "Ceiling de 15.75")
ShowResult(loNum1.Floor(), "Floor de 15.75")

* Funciones trigonométricas
loPi4 = CreateObject("TNumber", Pi()/4)
ShowResult(loPi4.Sin(), "Seno de p/4")
ShowResult(loPi4.Cos(), "Coseno de p/4")
ShowResult(loPi4.Tan(), "Tangente de p/4")

* Funciones logarítmicas
loE = CreateObject("TNumber", Exp(1))
ShowResult(loE.Log(), "Log natural de e")
loLog1 = CreateObject("TNumber", 100)
ShowResult(loLog1.Log10(), "Log10 de 100")
loLog2 = CreateObject("TNumber", 2)
ShowResult(loLog2.Exp(), "e^2")

* Pruebas de comparación
Assertion(loNum1.IsPositive(), "15.75 es positivo")
Assertion(loNum3.IsNegative(), "-10 es negativo")
Assertion(loNum4.IsZero(), "0 es zero")

loEven = CreateObject("TNumber", 4)
Assertion(loEven.IsEven(), "4 es par")

loOdd = CreateObject("TNumber", 5)
Assertion(loOdd.IsOdd(), "5 es impar")

loIsInt = CreateObject("TNumber", 10)
Assertion(loIsInt.IsInteger(), "10 es entero")

Assertion(loNum1.IsDecimal(), "15.75 es decimal")

* Pruebas de rango
Assertion(loNum1.IsBetween(10, 20), "15.75 está entre 10 y 20")
ShowResult(loNum1.Clamp(0, 10), "Clamp 15.75 entre 0 y 10")

* Pruebas de formato
ShowResult(loNum1.ToFormattedString(2, .F.), "Formato sin separador miles")

loFormat = CreateObject("TNumber", 1234567.89)
ShowResult(loFormat.ToFormattedString(2, .T.), "Formato con separador miles")

ShowResult(loNum1.ToCurrency("€"), "Formato moneda euros")

loPercent = CreateObject("TNumber", 0.1575)
ShowResult(loPercent.ToPercentage(1), "Formato porcentaje")

* Pruebas de incremento/decremento
loCounter = CreateObject("TNumber", 10)
ShowResult(loCounter.Increment(), "Incrementar de 10")
ShowResult(loCounter.Increment(5), "Incrementar 5 más")
ShowResult(loCounter.Decrement(3), "Decrementar 3")

* Crear copia con nuevo valor
loNewNum = loNum1.WithValue(100)
Assertion(loNewNum.Value = 100, "WithValue crea nueva instancia")
Assertion(loNum1.Value = 15.75, "Original no se modifica")

? ""

&& ========================================================================
&& PRUEBA 4: TArray - Arrays Dinámicos
&& ========================================================================
StartTest("TArray - Arrays Dinámicos")

* Crear array
loArr = ftNewArray()
Assertion(loArr.IsEmpty(), "Array nuevo está vacío")
Assertion(loArr.GetLen() = 0, "Longitud inicial es 0")

* Agregar elementos
loArr.Push("Elemento 1")
loArr.Push("Elemento 2")
loArr.Push(42)
loArr.Push(.T.)
loArr.Push(Date())

Assertion(loArr.GetLen() = 5, "Array tiene 5 elementos")
Assertion(!loArr.IsEmpty(), "Array ya no está vacío")

* Mostrar contenido
ShowObject(loArr, "Array completo")

* Acceso por índice
ShowResult(loArr.Get(1), "Primer elemento")
ShowResult(loArr.Get(3), "Tercer elemento")
Assertion(IsNull(loArr.Get(10)), "Índice fuera de rango retorna null")

* Modificar elementos
loArr.Set(2, "Elemento Modificado")
ShowResult(loArr.Get(2), "Elemento modificado")

* Búsquedas
Assertion(loArr.IndexOf("Elemento 1") = 1, "IndexOf encuentra elemento")
Assertion(loArr.Contains(42), "Contains encuentra número")
Assertion(!loArr.Contains("No existe"), "Contains no encuentra inexistente")

* Insertar elementos
Assertion(loArr.Insert(2, "Insertado"), "Insert en posición 2")
ShowObject(loArr, "Array después de insert")
Assertion(loArr.GetLen() = 6, "Longitud aumentó después de insert")

* Remover elementos
Assertion(loArr.RemoveAt(2), "RemoveAt posición 2")
ShowObject(loArr, "Array después de remove")
Assertion(loArr.GetLen() = 5, "Longitud disminuyó después de remove")

* Pop (sacar último)
lvPopped = loArr.Pop()
ShowResult(lvPopped, "Elemento extraído con Pop")
ShowObject(loArr, "Array después de Pop")

* Iterador
? "Iterando con HasNext/Next:"
loArr.Reset()
lnCount = 0
do While loArr.HasNext() And lnCount < 10  && Prevenir bucle infinito
    lvItem = loArr.Next()
    ? "   Item: " + Transform(lvItem)
    lnCount = lnCount + 1
Enddo

* Métodos de acceso rápido
ShowResult(loArr.First(), "Primer elemento")
ShowResult(loArr.Last(), "Último elemento")

* ForEach
? "Usando ForEach:"
loArr.ForEach("? '   ForEach Item: ' + Transform(m.lvItem)")

* Limpiar
loArr.Clear()
Assertion(loArr.IsEmpty(), "Clear vacía el array")
Assertion(loArr.GetLen() = 0, "Longitud es 0 después de Clear")

? ""

&& ========================================================================
&& PRUEBA 5: TDictionary - Mapas Clave-Valor
&& ========================================================================
StartTest("TDictionary - Mapas Clave-Valor")

* Crear diccionario
loDict = ftNewMap()
Assertion(loDict.IsEmpty(), "Diccionario nuevo está vacío")

* Agregar elementos
loDict.Add("nombre", "Juan Pérez")
loDict.Add("edad", 30)
loDict.Add("activo", .T.)
loDict.Add("fecha", Date())
loDict.Add("salario", 5000.50)

Assertion(loDict.GetLen() = 5, "Diccionario tiene 5 elementos")
Assertion(!loDict.IsEmpty(), "Diccionario ya no está vacío")

* Mostrar contenido completo
ShowObject(loDict, "Diccionario completo")

* Acceso por clave
ShowResult(loDict.Get("nombre"), "Obtener nombre")
ShowResult(loDict.Get("edad"), "Obtener edad")
Assertion(IsNull(loDict.Get("inexistente")), "Clave inexistente retorna null")

* Verificar existencia de claves
Assertion(loDict.ContainsKey("nombre"), "ContainsKey encuentra clave existente")
Assertion(!loDict.ContainsKey("apellido"), "ContainsKey no encuentra clave inexistente")

* Modificar valores (sobrescribir)
loDict.Add("edad", 31)  && Sobrescribe
ShowResult(loDict.Get("edad"), "Edad modificada")
Assertion(loDict.GetLen() = 5, "Longitud no cambia al sobrescribir")

* Obtener todas las claves
loKeys = loDict.Keys()
? "Claves en el diccionario:"
For i = 1 To loKeys.Count
    ? "   [" + Transform(i) + "] = '" + loKeys.Item(i) + "'"
EndFor

* Remover elementos
Assertion(loDict.Remove("activo"), "Remove elimina clave existente")
Assertion(!loDict.Remove("inexistente"), "Remove no afecta clave inexistente")
Assertion(loDict.GetLen() = 4, "Longitud disminuye después de Remove")

* Iterador con pares clave-valor
? "Iterando pares clave-valor:"
loDict.Reset()

do While loDict.HasNext()
    loPair = loDict.Next()
    ? "   " + Transform(loPair.Key) + " => " + Transform(loPair.Value)
Enddo

* ForEach con pares
? "ForEach con pares:"
loDict.ForEach("? '   ' + Transform(m.lvItem.Key) + ' = ' + Transform(m.lvItem.Value)")

* Diccionario anidado
loPersona = ftNewMap()
loPersona.Add("nombre", "María")
loPersona.Add("edad", 25)

loDireccion = ftNewMap()
loDireccion.Add("calle", "Av. Principal 123")
loDireccion.Add("ciudad", "Madrid")

loPersona.Add("direccion", loDireccion)

ShowObject(loPersona, "Diccionario anidado")

* Limpiar
loDict.Clear()
Assertion(loDict.IsEmpty(), "Clear vacía el diccionario")

? ""

&& ========================================================================
&& PRUEBA 6: TStringList - Lista de Cadenas
&& ========================================================================
StartTest("TStringList - Lista Especializada de Cadenas")

* Crear lista de strings
loStrList = ftNewStringList()
Assertion(loStrList.IsEmpty(), "StringList nueva está vacía")

* Agregar strings
loStrList.Add("Visual")
loStrList.Add("FoxPro")
loStrList.Add("2025")
loStrList.Add("Framework")

* Intentar agregar no-string (debe ignorarse)
loStrList.Add(123)  && Se ignora porque no es string
Assertion(loStrList.GetLen() = 4, "No-strings son ignorados")

ShowObject(loStrList, "StringList completa")

* Acceso y modificación
ShowResult(loStrList.Get(1), "Primer string")
Assertion(loStrList.Set(2, "Fox Pro"), "Set modifica string existente")
Assertion(!loStrList.Set(2, 456), "Set rechaza no-strings")

* Búsquedas case-sensitive e insensitive
Assertion(loStrList.IndexOf("Visual") = 1, "IndexOf case-sensitive")
Assertion(loStrList.IndexOf("VISUAL", .T.) = 0, "IndexOf case-sensitive no encuentra")
Assertion(loStrList.IndexOf("VISUAL", .F.) = 1, "IndexOf case-insensitive encuentra")

Assertion(loStrList.Contains("Framework"), "Contains encuentra string")
Assertion(loStrList.Contains("FRAMEWORK", .F.), "Contains case-insensitive")
Assertion(!loStrList.Contains("FRAMEWORK", .T.), "Contains case-sensitive no encuentra")

* Remover strings
Assertion(loStrList.Remove("2025"), "Remove elimina string existente")
Assertion(!loStrList.Remove("inexistente"), "Remove no afecta string inexistente")
ShowObject(loStrList, "Después de Remove")

Assertion(loStrList.RemoveAt(2), "RemoveAt elimina por índice")
ShowObject(loStrList, "Después de RemoveAt")

* Cargar desde string con separadores
loStrList.Clear()
loStrList.LoadFromString("Uno,Dos,Tres,Cuatro", ",")
ShowObject(loStrList, "Cargado desde string con comas")

loStrList.LoadFromString("Línea1" + Chr(13) + "Línea2" + Chr(13) + "Línea3")
ShowObject(loStrList, "Cargado desde string con CR")

* Join con diferentes separadores
ShowResult(loStrList.Join(), "Join sin separador")
ShowResult(loStrList.Join(" | "), "Join con pipe")
ShowResult(loStrList.Join(", "), "Join con coma y espacio")

* Convertir a array
laStringArray = loStrList.ToArray()
? "Array convertido:"
For i = 1 To Alen(laStringArray)
    ? "   [" + Transform(i) + "] = '" + laStringArray[i] + "'"
EndFor

* Iterador
? "Iterando StringList:"
loStrList.Reset()
do While loStrList.HasNext()
    lcItem = loStrList.Next()
    ? "   String: '" + lcItem + "'"
Enddo

? ""

&& ========================================================================
&& PRUEBA 7: TStack - Pila LIFO
&& ========================================================================
StartTest("TStack - Estructura de Datos LIFO")

* Crear stack
loStack = ftNewStack()
Assertion(loStack.Empty(), "Stack nuevo está vacío")
Assertion(loStack.Size() = 0, "Tamaño inicial es 0")

* Push elementos
loStack.Push("Primero")
loStack.Push("Segundo")
loStack.Push(42)
loStack.Push(.T.)
loStack.Push(Date())

Assertion(loStack.Size() = 5, "Stack tiene 5 elementos")
Assertion(!loStack.Empty(), "Stack ya no está vacío")

ShowObject(loStack, "Stack completo")

* Peek (ver tope sin extraer)
ShowResult(loStack.Peek(), "Peek del tope")
Assertion(loStack.Size() = 5, "Peek no modifica tamaño")

* Pop elementos (LIFO)
? "Extrayendo elementos (LIFO):"
do While !loStack.Empty()
    lvItem = loStack.Pop()
    ? "   Pop: " + Transform(lvItem) + " (Quedan: " + Transform(loStack.Size()) + ")"
Enddo

Assertion(loStack.Empty(), "Stack vacío después de Pop todo")

* Llenar de nuevo para más pruebas
loStack.Push("A")
loStack.Push("B")
loStack.Push("C")
loStack.Push("B")  && Duplicado para probar búsqueda

* Búsquedas
Assertion(loStack.Search("B") = 1, "Search encuentra 'B' en tope (posición 1)")
Assertion(loStack.Search("A") = 4, "Search encuentra 'A' en fondo (posición 4)")
Assertion(loStack.Search("X") = -1, "Search no encuentra elemento inexistente")

Assertion(loStack.Contains("C"), "Contains encuentra elemento")
Assertion(!loStack.Contains("Z"), "Contains no encuentra inexistente")

* Convertir a array
laStackArray = loStack.ToArray()
? "Stack como array (orden LIFO):"
For i = 1 To Alen(laStackArray)
    ? "   [" + Transform(i) + "] = '" + Transform(laStackArray[i]) + "'"
EndFor

* PopAll (extraer todo)
laAllItems = loStack.PopAll()
? "PopAll extrajo:"
For i = 1 To Alen(laAllItems)
    ? "   [" + Transform(i) + "] = '" + Transform(laAllItems[i]) + "'"
EndFor
Assertion(loStack.Empty(), "PopAll vacía el stack")

* Clear
loStack.Push("Test")
loStack.Clear()
Assertion(loStack.Empty(), "Clear vacía el stack")

? ""

&& ========================================================================
&& PRUEBA 8: TQueue - Cola FIFO
&& ========================================================================
StartTest("TQueue - Estructura de Datos FIFO")

* Crear queue
loQueue = ftNewQueue()
Assertion(loQueue.IsEmpty(), "Queue nueva está vacía")
Assertion(loQueue.Size() = 0, "Tamaño inicial es 0")

* Enqueue elementos
loQueue.Enqueue("Primero")
loQueue.Enqueue("Segundo")
loQueue.Enqueue(42)
loQueue.Enqueue(.T.)
loQueue.Enqueue(Date())

Assertion(loQueue.Size() = 5, "Queue tiene 5 elementos")
Assertion(!loQueue.IsEmpty(), "Queue ya no está vacía")

ShowObject(loQueue, "Queue completa")

* Peek (ver frente sin extraer)
ShowResult(loQueue.Peek(), "Peek del frente")
Assertion(loQueue.Size() = 5, "Peek no modifica tamaño")

* Rear (ver final)
ShowResult(loQueue.Rear(), "Rear del final")

* Dequeue elementos (FIFO)
? "Extrayendo elementos (FIFO):"
do While !loQueue.IsEmpty()
    lvItem = loQueue.Dequeue()
    ? "   Dequeue: " + Transform(lvItem) + " (Quedan: " + Transform(loQueue.Size()) + ")"
Enddo

Assertion(loQueue.IsEmpty(), "Queue vacía después de Dequeue todo")

* Llenar de nuevo para más pruebas
loQueue.Enqueue("A")
loQueue.Enqueue("B")
loQueue.Enqueue("C")
loQueue.Enqueue("B")  && Duplicado

* Extract (extraer desde el final - diferente a Dequeue)
lvExtracted = loQueue.Extract()
ShowResult(lvExtracted, "Extract desde el final")
ShowObject(loQueue, "Queue después de Extract")

* Búsquedas
Assertion(loQueue.Search("A") = 1, "Search encuentra 'A' en posición 1")
Assertion(loQueue.Search("C") = 3, "Search encuentra 'C' en posición 3")
Assertion(loQueue.Search("X") = -1, "Search no encuentra inexistente")

Assertion(loQueue.Contains("B"), "Contains encuentra elemento")
Assertion(!loQueue.Contains("Z"), "Contains no encuentra inexistente")

* Convertir a array
laQueueArray = loQueue.ToArray()
? "Queue como array (orden FIFO):"
For i = 1 To Alen(laQueueArray)
    ? "   [" + Transform(i) + "] = '" + Transform(laQueueArray[i]) + "'"
EndFor

* Reserve (pre-asignar capacidad)
loQueue.Reserve(100)
Assertion(loQueue.Capacity() >= 100, "Reserve aumenta capacidad")

* Clear
loQueue.Clear()
Assertion(loQueue.IsEmpty(), "Clear vacía la queue")

? ""

&& ========================================================================
&& PRUEBA 9: AnyToString - Serialización JSON
&& ========================================================================
StartTest("AnyToString - Serialización JSON Avanzada")
* Crear objeto complejo para serializar
loComplexObj = CreateObject("Empty")
AddProperty(loComplexObj, "nombre", "Juan Pérez")
AddProperty(loComplexObj, "edad", 30)
AddProperty(loComplexObj, "activo", .T.)
AddProperty(loComplexObj, "salario", 5000.75)
AddProperty(loComplexObj, "fechaNac", {^1993-05-15})
AddProperty(loComplexObj, "notas", .Null.)

* Serializar objeto simple
lcJson = _vfp.ftHelper.ToString(loComplexObj)
ShowResult(lcJson, "Objeto simple serializado")

* Serializar array simple
Dimension laSimple[3]
laSimple[1] = "Uno"
laSimple[2] = 42
laSimple[3] = .T.
lcJsonArray = _vfp.ftHelper.ToString(@laSimple)
ShowResult(lcJsonArray, "Array simple serializado")

* Serializar array multidimensional
Dimension laMatrix[2,3]
laMatrix[1,1] = "A1"
laMatrix[1,2] = "B1"
laMatrix[1,3] = "C1"
laMatrix[2,1] = "A2"
laMatrix[2,2] = "B2"
laMatrix[2,3] = "C2"
lcJsonMatrix = _vfp.ftHelper.ToString(@laMatrix)
ShowResult(lcJsonMatrix, "Array multidimensional")

* Serializar nuestras clases custom
loStr = ftNewString("Hola Framework")
lcJsonString = _vfp.ftHelper.ToString(loStr)
ShowResult(lcJsonString, "TString serializado")

loNum = CreateObject("TNumber", 42.5)
lcJsonNumber = _vfp.ftHelper.ToString(loNum)
ShowResult(lcJsonNumber, "TNumber serializado")

loArr = ftNewArray()
loArr.Push("Item1")
loArr.Push(123)
loArr.Push(.T.)
lcJsonArray = _vfp.ftHelper.ToString(loArr)
ShowResult(lcJsonArray, "TArray serializado")

loDict = ftNewMap()
loDict.Add("framework", "VFP")
loDict.Add("version", 2025)
loDict.Add("awesome", .T.)
lcJsonDict = _vfp.ftHelper.ToString(loDict)
ShowResult(lcJsonDict, "TDictionary serializado")

* Objeto con estructura anidada compleja
loNested = CreateObject("Empty")
AddProperty(loNested, "usuario", loComplexObj)
AddProperty(loNested, "configuracion", loDict)
AddProperty(loNested, "items", loArr)
AddProperty(loNested, "mensaje", loStr)
AddProperty(loNested, "contador", loNum)

lcJsonNested = _vfp.ftHelper.ToString(loNested)
ShowResult(lcJsonNested, "Objeto anidado complejo")

* Formato pretty-print
lcJsonFormatted = _vfp.ftHelper.ToStringFormatted(loNested, "PHGNUCIBR", 2)
? "JSON Formateado:"
? lcJsonFormatted

* Validar JSON generado
Assertion(_vfp.ftHelper.ValidateJson(lcJsonNested), "JSON generado es válido")

* Estadísticas de serialización
loStats = _vfp.ftHelper.GetStats(loNested)
? "Estadísticas de serialización:"
? "   Objetos: " + Transform(loStats.Objects)
? "   Arrays: " + Transform(loStats.Arrays)
? "   Propiedades: " + Transform(loStats.Properties)
? "   Profundidad máxima: " + Transform(loStats.MaxDepth)

* Probar referencias circulares
loCircular1 = CreateObject("Empty")
loCircular2 = CreateObject("Empty")
AddProperty(loCircular1, "ref", loCircular2)
AddProperty(loCircular2, "ref", loCircular1)
AddProperty(loCircular1, "name", "Circular1")
AddProperty(loCircular2, "name", "Circular2")

lcCircular = _vfp.ftHelper.ToString(loCircular1)
Assertion("<circular reference>" $ lcCircular, "Referencias circulares detectadas")
ShowResult(lcCircular, "Objeto con referencia circular")

? ""

&& ========================================================================
&& PRUEBA 10: Funciones de Conveniencia
&& ========================================================================
StartTest("Funciones de Conveniencia - API Fluida")

* Probar todas las funciones ft*
loStr = ftNewString("Framework VFP")
loArr = ftNewArray()
loMap = ftNewMap()
loStrList = ftNewStringList()
loStack = ftNewStack()
loQueue = ftNewQueue()

Assertion(Type("loStr") = "O", "ftNewString crea objeto")
Assertion(Type("loArr") = "O", "ftNewArray crea objeto")
Assertion(Type("loMap") = "O", "ftNewMap crea objeto")
Assertion(Type("loStrList") = "O", "ftNewStringList crea objeto")
Assertion(Type("loStack") = "O", "ftNewStack crea objeto")
Assertion(Type("loQueue") = "O", "ftNewQueue crea objeto")

* Verificar que son del tipo correcto
Assertion(Lower(loStr.Class) = "tstring", "ftNewString crea TString")
Assertion(Lower(loArr.Class) = "tarray", "ftNewArray crea TArray")
Assertion(Lower(loMap.Class) = "tdictionary", "ftNewMap crea TDictionary")
Assertion(Lower(loStrList.Class) = "tstringlist", "ftNewStringList crea TStringList")
Assertion(Lower(loStack.Class) = "tstack", "ftNewStack crea TStack")
Assertion(Lower(loQueue.Class) = "tqueue", "ftNewQueue crea TQueue")

? ""

&& ========================================================================
&& PRUEBA 11: Casos de Uso Complejos - Integración
&& ========================================================================
StartTest("Casos de Uso Complejos - Integración del Framework")

* Caso 1: Procesamiento de datos de empleados
? "CASO 1: Sistema de Empleados"
loEmpleados = ftNewArray()

* Crear empleados
For i = 1 To 3
    loEmpleado = ftNewMap()
    loEmpleado.Add("id", i)
    loEmpleado.Add("nombre", "Empleado " + Transform(i))
    loEmpleado.Add("salario", 1000 + (i * 500))
    loEmpleado.Add("activo", i <= 2)
    loEmpleados.Push(loEmpleado)
EndFor

ShowObject(loEmpleados, "Lista de empleados")

* Caso 2: Procesamiento de texto avanzado
? "CASO 2: Análisis de Texto"
loTexto = ftNewString("Visual FoxPro es un lenguaje de programación poderoso y versátil")
loAnalisis = ftNewMap()

loAnalisis.Add("original", loTexto.ToString())
loAnalisis.Add("longitud", loTexto.GetLength())
loAnalisis.Add("palabras", loTexto.WordCount())
loAnalisis.Add("mayusculas", loTexto.ToUpperCase())
loAnalisis.Add("minusculas", loTexto.ToLowerCase())
loAnalisis.Add("contiene_foxpro", loTexto.Contains("FoxPro"))
loAnalisis.Add("empieza_con_visual", loTexto.StartsWith("Visual"))

laPalabras = loTexto.Split(" ")
loPalabrasLista = ftNewStringList()
For i = 1 To Alen(laPalabras)
    loPalabrasLista.Add(laPalabras[i])
EndFor
loAnalisis.Add("lista_palabras", loPalabrasLista.Join(" | "))

ShowObject(loAnalisis, "Análisis de texto completo")

* Caso 3: Calculadora con historial
? "CASO 3: Calculadora con Historial"
loCalculadora = ftNewMap()
loHistorial = ftNewStack()
loOperaciones = ftNewQueue()

loNum1 = CreateObject("TNumber", 100)
loNum2 = CreateObject("TNumber", 25)

* Realizar operaciones y guardar historial
lnResultado = loNum1.Add(loNum2)
loHistorial.Push("100 + 25 = " + Transform(lnResultado))
loOperaciones.Enqueue("suma")

lnResultado = loNum1.Multiply(2)
loHistorial.Push("100 * 2 = " + Transform(lnResultado))
loOperaciones.Enqueue("multiplicacion")

lnResultado = loNum1.Divide(4)
loHistorial.Push("100 / 4 = " + Transform(lnResultado))
loOperaciones.Enqueue("division")

loCalculadora.Add("historial", loHistorial.ToString())
loCalculadora.Add("operaciones_pendientes", loOperaciones.ToString())
loCalculadora.Add("total_operaciones", loHistorial.Size())

ShowObject(loCalculadora, "Estado de la calculadora")

* Caso 4: Sistema de configuración
? "CASO 4: Sistema de Configuración"
loConfig = ftNewMap()

* Configuración de base de datos
loDbConfig = ftNewMap()
loDbConfig.Add("servidor", "localhost")
loDbConfig.Add("puerto", 1433)
loDbConfig.Add("base_datos", "MiApp")
loDbConfig.Add("usuario", "admin")
loDbConfig.Add("timeout", 30)

* Configuración de interfaz
loUiConfig = ftNewMap()
loUiConfig.Add("tema", "oscuro")
loUiConfig.Add("idioma", "es")
loUiConfig.Add("fuente_tamaño", 12)
loUiConfig.Add("mostrar_tooltips", .T.)

* Lista de módulos activos
loModulos = ftNewStringList()
loModulos.Add("ventas")
loModulos.Add("inventario")
loModulos.Add("reportes")
loModulos.Add("configuracion")

loConfig.Add("base_datos", loDbConfig)
loConfig.Add("interfaz", loUiConfig)
loConfig.Add("modulos_activos", loModulos.Join(","))
loConfig.Add("version", "2.1.0")
loConfig.Add("fecha_instalacion", Date())

ShowObject(loConfig, "Configuración completa del sistema")

* Serializar configuración completa
lcConfigJson = _vfp.ftHelper.ToStringFormatted(loConfig)
? "Configuración en JSON:"
? lcConfigJson

? ""

&& ========================================================================
&& PRUEBA 12: Rendimiento y Estrés
&& ========================================================================
StartTest("Pruebas de Rendimiento y Estrés")

* Prueba de rendimiento con arrays grandes
? "Prueba de rendimiento - Array grande"
loArrayGrande = ftNewArray()
lnInicio = Seconds()

For i = 1 To 1000
    loArrayGrande.Push("Item " + Transform(i))
EndFor

lnTiempo = Seconds() - lnInicio
? "   1000 Push operations: " + Transform(lnTiempo, "999.999") + " segundos"

* Búsquedas en array grande
lnInicio = Seconds()
For i = 1 To 100
    llFound = loArrayGrande.Contains("Item 500")
EndFor
lnTiempo = Seconds() - lnInicio
? "   100 Contains operations: " + Transform(lnTiempo, "999.999") + " segundos"

* Prueba con diccionario grande
? "Prueba de rendimiento - Diccionario grande"
loDictGrande = ftNewMap()
lnInicio = Seconds()

For i = 1 To 1000
    loDictGrande.Add("key" + Transform(i), "Value " + Transform(i))
EndFor

lnTiempo = Seconds() - lnInicio
? "   1000 Add operations: " + Transform(lnTiempo, "999.999") + " segundos"

* Serialización de objeto grande
lnInicio = Seconds()
lcJsonGrande = _vfp.ftHelper.ToString(loDictGrande)
lnTiempo = Seconds() - lnInicio
? "   Serialización JSON: " + Transform(lnTiempo, "999.999") + " segundos"
? "   Tamaño JSON: " + Transform(Len(lcJsonGrande)) + " caracteres"

? ""

&& ========================================================================
&& RESUMEN FINAL DE PRUEBAS
&& ========================================================================
? Replicate("=", 80)
? "RESUMEN FINAL DE PRUEBAS"
? Replicate("=", 80)
? "Total de pruebas ejecutadas: " + Transform(gnTestCount)
? "Pruebas exitosas: " + Transform(gnPassCount)
? "Pruebas fallidas: " + Transform(gnFailCount)
? "Porcentaje de éxito: " + Transform((gnPassCount * 100) / (gnPassCount + gnFailCount), "999.99") + "%"
? ""

If gnFailCount = 0
    ? "¡TODAS LAS PRUEBAS PASARON EXITOSAMENTE!"
    ? "El framework está listo para producción"
Else
    ? "Hay " + Transform(gnFailCount) + " pruebas que requieren atención"
EndIf

? ""
? "FRAMEWORK VFP 2025 - PRUEBAS COMPLETADAS"
? Replicate("=", 80)

* Limpiar variables globales
Release gnTestCount, gnPassCount, gnFailCount

? ""
? "Presiona cualquier tecla para continuar..."
Inkey(0)

&& ========================================================================
&& FUNCIONES DE UTILIDAD PARA TESTING
&& ========================================================================

Function StartTest(tcTestName)
    ? Replicate("=", 80)
    ? "INICIANDO PRUEBA: " + tcTestName
    ? Replicate("=", 80)
    gnTestCount = gnTestCount + 1
EndFunc

Function Assertion(tlCondition, tcMessage)
    If tlCondition
        ? "PASS: " + tcMessage
        gnPassCount = gnPassCount + 1
    else
        ? "FAIL: " + tcMessage
        gnFailCount = gnFailCount + 1
    EndIf
EndFunc

Function ShowResult(tcResult, tcDescription)
    ? tcDescription + ": " + Transform(tcResult)
EndFunc

Function ShowObject(toObj, tcDescription)
    ? tcDescription + ": " + toObj.ToString()
EndFunc