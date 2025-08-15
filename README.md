# FoxCollection 🚀

**Una librería moderna y robusta para Visual FoxPro que revoluciona el manejo de estructuras de datos**

Formas de apoyar:
1. Donativo en Paypal [![DONATE!](http://www.pngall.com/wp-content/uploads/2016/05/PayPal-Donate-Button-PNG-File-180x100.png)](https://www.paypal.com/donate/?hosted_button_id=LXQYXFP77AD2G)
2. Patrocinio en [Patreon](www.patreon.com/IrwinRodriguez)
3. Seguir este proyecto (es gratis) [Stargazer](https://github.com/Irwin1985/JSONFox/stargazers)

    Gracias por tu apoyo!

### Project Manager

**Irwin Rodríguez** (Toledo, Spain)

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/Irwin1985/FoxCollection)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![VFP](https://img.shields.io/badge/Visual%20FoxPro-9.0%2B-orange.svg)](https://www.microsoft.com/en-us/download/details.aspx?id=14839)

## 📋 **¿Qué es FoxCollection?**

FoxCollection es una librería que alberga tipos de datos avanzados y modernos para Visual FoxPro, proporcionando una API consistente y potente para el manejo de:

- **🔤 Strings** - Manipulación avanzada de cadenas con 25+ métodos
- **🔢 Numbers** - Operaciones matemáticas avanzadas y conversiones
- **📚 Arrays** - Arrays dinámicos con funcionalidad completa
- **📝 StringList** - Listas especializadas para strings
- **🗂️ Diccionarios (Maps)** - Estructuras clave-valor eficientes
- **📚 Pilas (Stack)** - Estructura LIFO (Last In, First Out)
- **🚶 Colas (Queue)** - Estructura FIFO (First In, First Out)
- **🔧 Serialización JSON** - Conversión avanzada a JSON con detección de referencias circulares

## 🆕 **Novedades en v2.0.0**

> **Nota**: Tenía muchas mejoras desarrolladas localmente que no había subido al repositorio. Gracias al reporte de un usuario, he aprovechado para consolidar y publicar todos estos avances.

### ✨ **Nuevas Características**
- 🧪 **Suite de pruebas completa** con 12 categorías de tests exhaustivos
- 🔤 **TString mejorado** con 25+ métodos de manipulación de texto
- 🔢 **Nueva clase TNumber** con operaciones matemáticas, trigonométricas y logarítmicas
- 🔄 **Serialización JSON avanzada** con detección de referencias circulares
- 🎯 **API más consistente** con herencia de TObject y TIterable
- 🚀 **Optimizaciones de rendimiento** y gestión de memoria mejorada
- 📊 **Sistema ToString()** personalizado para todas las clases

## 📦 **Instalación**

```bash
# Clonar el repositorio
git clone https://github.com/Irwin1985/FoxCollection.git
```

```xbase
* Agregar a tu proyecto VFP
Set Procedure to "FoxCollection" Additive
do FoxCollection.prg
```

## 🚀 **Guía de Inicio Rápido**

### 🔤 **TString - Manipulación Avanzada de Cadenas**

```xbase
* Crear strings
loTexto = ftNewString("  Visual FoxPro es GENIAL  ")
loVacio = ftNewString()  && String vacío

* Información básica
? loTexto.GetLength()        && 26 (incluye espacios)
? loTexto.IsBlank()          && .F.
? loTexto.WordCount()        && 4 palabras

* Limpieza y transformación
? loTexto.Trim()             && "Visual FoxPro es GENIAL"
? loTexto.StripLeading()     && "Visual FoxPro es GENIAL  "
? loTexto.StripTrailing()    && "  Visual FoxPro es GENIAL"
? loTexto.ToUpperCase()      && "  VISUAL FOXPRO ES GENIAL  "
? loTexto.ToLowerCase()      && "  visual foxpro es genial  "
? loTexto.ToProperCase()     && "  Visual Foxpro Es Genial  "

* Extracción de subcadenas
? loTexto.Head(8)            && "  Visual"
? loTexto.Tail(8)            && "GENIAL  "
? loTexto.Substring(3, 8)    && "Visual "
? loTexto.Range(3, 6)        && "Visual"

* Búsqueda y verificación
? loTexto.IndexOf("FoxPro")     && Posición donde aparece
? loTexto.LastIndexOf("o")      && Última posición de "o"
? loTexto.Contains("FoxPro")    && .T.
? loTexto.StartsWith("  Visual") && .T.
? loTexto.EndsWith("GENIAL  ")  && .T.

* Reemplazos
? loTexto.Replace("FoxPro", "Fox Pro")     && Reemplaza todas las ocurrencias
? loTexto.ReplaceFirst("o", "0")           && Solo la primera ocurrencia
? loTexto.ReplaceAll("o", "0")             && Todas las ocurrencias

* Concatenación
? loTexto.Concat(" 2025")                  && Con string
loOtro = ftNewString(" Framework")
? loTexto.Concat(loOtro)                   && Con otro TString

* División de texto
laPalabras = loTexto.Split(" ")            && Array con palabras
laLineas = loTexto.Lines()                 && Array con líneas

* Padding
loCorto = ftNewString("VFP")
? loCorto.Padl(10, "*")      && "*******VFP"
? loCorto.Padr(10, "-")      && "VFP-------"

* Comparaciones avanzadas
? loTexto.Equals("  Visual FoxPro es GENIAL  ")    && .T.
? loTexto.EqualsIgnoreCase("  VISUAL FOXPRO ES GENIAL  ") && .T.

* Utilidades especiales
? loTexto.Reverse()          && Invierte la cadena
? loTexto.Matches(".*FoxPro.*") && Expresiones regulares (si disponible)
```

### 🔢 **TNumber - Operaciones Matemáticas Avanzadas**

```xbase
* Crear números
loNum1 = ftNewNumber(15.75)
loNum2 = ftNewNumber(4.25)
loNegativo = ftNewNumber(-10)

* Conversiones
? loNum1.GetInteger()        && 15
? loNum1.GetFloat()          && 15.75
? loNum1.GetDecimal(1)       && 15.8

* Operaciones básicas
? loNum1.Add(loNum2)         && 20.00
? loNum1.Add(5)              && 20.75
? loNum1.Subtract(loNum2)    && 11.50
? loNum1.Multiply(2)         && 31.50
? loNum1.Divide(3)           && 5.25
? loNum1.Power(2)            && 248.0625
? loNum1.Modulo(4)           && 3.75

* Funciones matemáticas
? loNegativo.Abs()           && 10
? loNum1.Sqrt()              && 3.97
? loNum1.Ceiling()           && 16
? loNum1.Floor()             && 15
? loNum1.Round(1)            && 15.8

* Funciones trigonométricas
loPi4 = ftNewNumber(Pi()/4)
? loPi4.Sin()                && 0.71
? loPi4.Cos()                && 0.71
? loPi4.Tan()                && 1.00

* Funciones logarítmicas
loE = ftNewNumber(Exp(1))
? loE.Log()                  && 1.00
lo100 = ftNewNumber(100)
? lo100.Log10()              && 2.00
lo2 = ftNewNumber(2)
? lo2.Exp()                  && 7.39

* Verificaciones
? loNum1.IsPositive()        && .T.
? loNegativo.IsNegative()    && .T.
? loNum1.IsEven()            && .F. (15 es impar)
? loNum1.IsOdd()             && .T.
? loNum1.IsInteger()         && .F.
? loNum1.IsDecimal()         && .T.

* Rangos
? loNum1.IsBetween(10, 20)   && .T.
? loNum1.Clamp(0, 10)        && 10 (limitado a máximo 10)

* Formato
? loNum1.ToFormattedString(2, .F.)  && "15.75"
? loNum1.ToFormattedString(2, .T.)  && "15.75" (con separadores de miles si aplica)
? loNum1.ToCurrency("€")            && "€15.75"
loPercent = ftNewNumber(0.1575)
? loPercent.ToPercentage(1)         && "15.8%"

* Incremento/Decremento
loContador = ftNewNumber(10)
? loContador.Increment()     && 11 (modifica el objeto)
? loContador.Increment(5)    && 16
? loContador.Decrement(3)    && 13

* Crear copia
loNuevo = loNum1.WithValue(100)  && Nueva instancia con valor 100
```

### 📚 **TArray - Arrays Dinámicos**

```xbase
* Crear array
laItems = ftNewArray()

* Agregar elementos
laItems.Push("Elemento 1")
laItems.Push("Elemento 2")
laItems.Push(42)
laItems.Push(.T.)
laItems.Push(Date())

* Información básica
? laItems.GetLen()           && 5
? laItems.IsEmpty()          && .F.

* Acceso por índice
? laItems.Get(1)             && "Elemento 1"
? laItems.Get(10)            && .Null. (fuera de rango)

* Modificar elementos
laItems.Set(2, "Modificado")
? laItems.Get(2)             && "Modificado"

* Búsquedas
? laItems.IndexOf(42)        && Posición del número 42
? laItems.Contains(.T.)      && .T.

* Insertar y remover
laItems.Insert(2, "Insertado")  && Insertar en posición 2
laItems.RemoveAt(3)             && Remover por índice

* Pop (extraer último)
lvUltimo = laItems.Pop()
? lvUltimo                   && Último elemento extraído

* Iteración
laItems.Reset()              && Reiniciar iterador
Do While laItems.HasNext()
    lvItem = laItems.Next()
    ? "Item:", lvItem
Enddo

* Métodos de acceso rápido
? laItems.First()            && Primer elemento
? laItems.Last()             && Último elemento

* ForEach con expresión
laItems.ForEach("? 'Item: ' + Transform(m.lvItem)")

* Limpiar
laItems.Clear()
```

### 🗂️ **TDictionary - Mapas Clave-Valor**

```xbase
* Crear diccionario
loEmpleado = ftNewMap()

* Agregar elementos
loEmpleado.Add("nombre", "Ana García")
loEmpleado.Add("edad", 28)
loEmpleado.Add("salario", 45000)
loEmpleado.Add("activo", .T.)

* Información básica
? loEmpleado.GetLen()        && 4
? loEmpleado.IsEmpty()       && .F.

* Acceso por clave
? loEmpleado.Get("nombre")   && "Ana García"
? loEmpleado.Get("inexistente") && .Null.

* Verificar existencia
? loEmpleado.ContainsKey("salario")  && .T.

* Modificar (sobrescribir)
loEmpleado.Add("edad", 29)   && Sobrescribe el valor

* Obtener todas las claves
loClaves = loEmpleado.Keys()
For i = 1 To loClaves.Count
    ? "Clave:", loClaves.Item(i)
EndFor

* Remover elementos
loEmpleado.Remove("activo")  && Retorna .T. si se removió

* Iteración con pares clave-valor
Do While loEmpleado.HasNext()
    loPair = loEmpleado.Next()
    ? loPair.Key, "=>", loPair.Value
Enddo

* Limpiar
loEmpleado.Clear()
```

### 📝 **TStringList - Lista Especializada de Cadenas**

```xbase
* Crear lista
laColores = ftNewStringList()

* Agregar strings (solo acepta strings)
laColores.Add("Rojo")
laColores.Add("Verde")
laColores.Add("Azul")
laColores.Add(123)           && Se ignora (no es string)

* Acceso y modificación
? laColores.Get(1)           && "Rojo"
laColores.Set(2, "Verde Claro")  && Solo acepta strings

* Búsquedas case-sensitive/insensitive
? laColores.IndexOf("Rojo")         && Posición (case-sensitive)
? laColores.IndexOf("ROJO", .T.)    && 0 (no encuentra, case-sensitive)
? laColores.IndexOf("ROJO", .F.)    && Posición (case-insensitive)

? laColores.Contains("Azul")        && .T.
? laColores.Contains("AZUL", .F.)   && .T. (case-insensitive)

* Remover
laColores.Remove("Verde Claro")     && Por valor
laColores.RemoveAt(2)               && Por índice

* Cargar desde string
laColores.LoadFromString("Uno,Dos,Tres", ",")      && Con comas
laColores.LoadFromString("Línea1" + Chr(13) + "Línea2")  && Con CR

* Unir con separadores
? laColores.Join()           && Sin separador
? laColores.Join(", ")       && "Uno, Dos, Tres"
? laColores.Join(" | ")      && "Uno | Dos | Tres"

* Convertir a array VFP
laArray = laColores.ToArray()

* Iteración
Do While laColores.HasNext()
    lcItem = laColores.Next()
    ? "String:", lcItem
Enddo
```

### 📚 **TStack - Pila LIFO (Last In, First Out)**

```xbase
* Crear stack
loHistorial = ftNewStack()

* Push elementos
loHistorial.Push("Acción 1")
loHistorial.Push("Acción 2")
loHistorial.Push("Acción 3")

* Información básica
? loHistorial.Size()         && 3
? loHistorial.Empty()        && .F.

* Peek (ver tope sin extraer)
? loHistorial.Peek()         && "Acción 3"

* Pop elementos (LIFO)
? loHistorial.Pop()          && "Acción 3" (último en entrar, primero en salir)
? loHistorial.Pop()          && "Acción 2"

* Búsquedas
? loHistorial.Search("Acción 1")  && Posición desde el tope
? loHistorial.Contains("Acción 1") && .T.

* Convertir a array (orden LIFO)
laStackArray = loHistorial.ToArray()

* Extraer todo
laTodo = loHistorial.PopAll()

* Limpiar
loHistorial.Clear()
```

### 🚶 **TQueue - Cola FIFO (First In, First Out)**

```xbase
* Crear queue
loTareas = ftNewQueue()

* Enqueue elementos
loTareas.Enqueue("Tarea 1")
loTareas.Enqueue("Tarea 2")
loTareas.Enqueue("Tarea 3")

* Información básica
? loTareas.Size()            && 3
? loTareas.IsEmpty()         && .F.

* Peek (ver frente sin extraer)
? loTareas.Peek()            && "Tarea 1"

* Rear (ver final)
? loTareas.Rear()            && "Tarea 3"

* Dequeue elementos (FIFO)
? loTareas.Dequeue()         && "Tarea 1" (primero en entrar, primero en salir)
? loTareas.Dequeue()         && "Tarea 2"

* Extract (extraer desde el final)
? loTareas.Extract()         && "Tarea 3"

* Búsquedas
? loTareas.Search("Tarea 2") && Posición en la cola
? loTareas.Contains("Tarea 2") && .T.

* Reservar capacidad (optimización)
loTareas.Reserve(1000)       && Pre-asigna espacio

* Convertir a array (orden FIFO)
laQueueArray = loTareas.ToArray()

* Limpiar
loTareas.Clear()
```

## 🔄 **Serialización JSON Avanzada**

```xbase
* El framework incluye _vfp.ftHelper para serialización JSON

* Serializar objeto simple
loObj = CreateObject("Empty")
AddProperty(loObj, "nombre", "Juan")
AddProperty(loObj, "edad", 30)
lcJson = _vfp.ftHelper.ToString(loObj)
? lcJson  && {"nombre":"Juan","edad":30}

* Serializar arrays
Dimension laData[3]
laData[1] = "A"
laData[2] = 42
laData[3] = .T.
lcJson = _vfp.ftHelper.ToString(@laData)
? lcJson  && ["A",42,true]

* Serializar nuestras clases
loStr = ftNewString("Hola")
lcJson = _vfp.ftHelper.ToString(loStr)

loDict = ftNewMap()
loDict.Add("framework", "VFP")
loDict.Add("año", 2025)
lcJson = _vfp.ftHelper.ToString(loDict)

* JSON formateado (pretty-print)
lcJsonFormatted = _vfp.ftHelper.ToStringFormatted(loDict, "PHGNUCIBR", 2)

* Validar JSON
llValido = _vfp.ftHelper.ValidateJson(lcJson)

* Estadísticas de serialización
loStats = _vfp.ftHelper.GetStats(loDict)
? "Objetos:", loStats.Objects
? "Arrays:", loStats.Arrays
? "Propiedades:", loStats.Properties
? "Profundidad:", loStats.MaxDepth

* Detección de referencias circulares
loCirc1 = CreateObject("Empty")
loCirc2 = CreateObject("Empty")
AddProperty(loCirc1, "ref", loCirc2)
AddProperty(loCirc2, "ref", loCirc1)
lcJson = _vfp.ftHelper.ToString(loCirc1)
* Resultado incluirá "<circular reference>"
```

## 🧪 **Suite de Pruebas Completa**

El framework incluye una suite de pruebas exhaustiva:

```xbase
* Ejecutar todas las pruebas
Do FoxCollectionTests  && Archivo de pruebas incluido

* Las pruebas cubren:
* ✅ TObject - Funcionalidad base (ToString, Equals, Clone, etc.)
* ✅ TString - Todos los 25+ métodos de manipulación
* ✅ TNumber - Operaciones matemáticas, trigonométricas, logarítmicas
* ✅ TArray - Arrays dinámicos con todas las operaciones
* ✅ TStringList - Listas especializadas de strings
* ✅ TDictionary - Mapas clave-valor con iteración
* ✅ TStack - Pilas LIFO con búsquedas
* ✅ TQueue - Colas FIFO con operaciones avanzadas
* ✅ Serialización JSON - Incluyendo referencias circulares
* ✅ Casos de uso complejos - Integración de múltiples clases
* ✅ Pruebas de rendimiento - Arrays y diccionarios grandes
* ✅ Funciones de conveniencia - API ftNew*
```

## 🎯 **Casos de Uso Reales**

### 📊 **Sistema de Empleados**
```xbase
loEmpleados = ftNewArray()

For i = 1 To 5
    loEmpleado = ftNewMap()
    loEmpleado.Add("id", i)
    loEmpleado.Add("nombre", "Empleado " + Transform(i))
    loEmpleado.Add("salario", 1000 + (i * 500))
    loEmpleado.Add("activo", i <= 3)
    loEmpleados.Push(loEmpleado)
EndFor

* Serializar a JSON
lcEmpleadosJson = _vfp.ftHelper.ToStringFormatted(loEmpleados)
```

### 📝 **Análisis de Texto**
```xbase
loTexto = ftNewString("Visual FoxPro es poderoso y versátil")
loAnalisis = ftNewMap()

loAnalisis.Add("longitud", loTexto.GetLength())
loAnalisis.Add("palabras", loTexto.WordCount())
loAnalisis.Add("contiene_foxpro", loTexto.Contains("FoxPro"))
loAnalisis.Add("mayusculas", loTexto.ToUpperCase())

laPalabras = loTexto.Split(" ")
loPalabrasLista = ftNewStringList()
For i = 1 To Alen(laPalabras)
    loPalabrasLista.Add(laPalabras[i])
EndFor
loAnalisis.Add("palabras_separadas", loPalabrasLista.Join(" | "))
```

### 🧮 **Calculadora con Historial**
```xbase
loHistorial = ftNewStack()
loNum1 = ftNewNumber(100)
loNum2 = ftNewNumber(25)

lnResultado = loNum1.Add(loNum2)
loHistorial.Push("100 + 25 = " + Transform(lnResultado))

lnResultado = loNum1.Multiply(2)
loHistorial.Push("100 * 2 = " + Transform(lnResultado))

* Ver historial (LIFO)
Do While !loHistorial.Empty()
    ? loHistorial.Pop()
Enddo
```

## 🚀 **Características Técnicas**

### 🏗️ **Arquitectura**
- **TObject**: Clase base con funcionalidad común (ToString, Equals, Clone)
- **TIterable**: Clase base para colecciones con iteradores uniformes
- **Herencia consistente**: Todas las clases heredan comportamiento común

### 🔄 **Iteradores Uniformes**
Todas las colecciones implementan:
- `HasNext()` - Verifica si hay más elementos
- `Next()` - Obtiene el siguiente elemento
- `Reset()` - Reinicia el iterador
- `First()` - Primer elemento
- `Last()` - Último elemento
- `ForEach(expression)` - Ejecuta expresión para cada elemento 'm.lvItem'

### 🛡️ **Manejo de Errores**
- Validación de tipos en constructores
- Manejo seguro de divisiones por cero
- Verificación de rangos en arrays
- Detección de referencias circulares en serialización

### 🚀 **Optimizaciones**
- Gestión eficiente de memoria
- Redimensionamiento inteligente de arrays
- Lazy loading donde es apropiado
- Pre-asignación de capacidad en colas

## 📚 **Documentación de Métodos**

### TString (25+ métodos)
- **Información**: `GetLength()`, `IsBlank()`, `WordCount()`
- **Transformación**: `ToUpperCase()`, `ToLowerCase()`, `ToProperCase()`, `Trim()`, `Strip()`, `StripLeading()`, `StripTrailing()`, `Reverse()`
- **Extracción**: `Head()`, `Tail()`, `Substring()`, `Range()`
- **Búsqueda**: `IndexOf()`, `LastIndexOf()`, `Contains()`, `StartsWith()`, `EndsWith()`
- **Manipulación**: `Replace()`, `ReplaceFirst()`, `ReplaceAll()`, `Concat()`
- **División**: `Split()`, `Lines()`
- **Padding**: `Padl()`, `Padr()`
- **Comparación**: `Equals()`, `EqualsIgnoreCase()`
- **Regex**: `Matches()` (si disponible)

### TNumber (30+ métodos)
- **Conversión**: `GetInteger()`, `GetFloat()`, `GetDecimal()`
- **Aritmética**: `Add()`, `Subtract()`, `Multiply()`, `Divide()`, `Power()`, `Modulo()`
- **Matemáticas**: `Abs()`, `Sqrt()`, `Ceiling()`, `Floor()`, `Round()`
- **Trigonometría**: `Sin()`, `Cos()`, `Tan()`, `Asin()`, `Acos()`, `Atan()`
- **Logaritmos**: `Log()`, `Log10()`, `Exp()`
- **Verificación**: `IsPositive()`, `IsNegative()`, `IsZero()`, `IsEven()`, `IsOdd()`, `IsInteger()`, `IsDecimal()`
- **Rangos**: `IsBetween()`, `Clamp()`
- **Formato**: `ToFormattedString()`, `ToCurrency()`, `ToPercentage()`
- **Utilidades**: `Increment()`, `Decrement()`, `WithValue()`

## 📝 **Changelog**

### v2.0.0 (2025-08-XX)
- 🚀 **Refactorización completa** del framework
- ✨ **Nueva clase TNumber** con 30+ operaciones matemáticas
- 🔤 **TString expandido** a 25+ métodos de manipulación
- 🧪 **Suite de pruebas exhaustiva** con 12 categorías
- 🔄 **Serialización JSON avanzada** con detección de referencias circulares
- 🏗️ **Arquitectura mejorada** con herencia TObject/TIterable
- 🎯 **API más consistente** en todas las clases
- 🚀 **Optimizaciones de rendimiento** significativas
- 📊 **ToString() personalizado** para debugging
- 🛡️ **Manejo de errores robusto**


**SIN GARANTÍA**

EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, INCLUYENDO PERO NO LIMITADO A LAS GARANTÍAS DE COMERCIABILIDAD, IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O TITULARES DE DERECHOS DE AUTOR SERÁN RESPONSABLES DE NINGÚN RECLAMO, DAÑO U OTRA RESPONSABILIDAD, YA SEA EN UNA ACCIÓN CONTRACTUAL, AGRAVIO O DE OTRA MANERA, QUE SURJA DE, FUERA DE O EN RELACIÓN CON EL SOFTWARE O EL USO U OTRAS NEGOCIOS EN EL SOFTWARE.