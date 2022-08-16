# FoxCollection
Es una librería que alberga varios tipos de datos compuestos de uso diario. 

```
Agrega FoxCollection.prg en cualquier carpeta que tenga visibilidad desde tu PATH.
```

## Simple Test
```xBase
Set Procedure to "FoxCollection" Additive

&& Ejemplo de Array
Local laFrutas, loDict
laFrutas = ftNewArray()
laFrutas.Push("Mango")
laFrutas.Push("Manzana")
laFrutas.Push("Banana")
laFrutas.Push("Mora")
laFrutas.Push(1985)
laFrutas.Push(.T.)
laFrutas.Push(.F.)

?laFrutas.Get(1) && obtiene el primer elemento
?laFrutas.Get(30) && obtiene el elemento 30 (si no existe devuelve .Null.)
?laFrutas.Len && retorna la longitud del array
laFrutas.Pop() && recorta el array de izquierda a derecha (sentido LIFO)
?laFrutas.Len

laFrutas.Set(2, "Manzana Golden") && actualiza el contenido del elemento 2 del array.

?laFrutas.Get(2)

* Iterar sobre el array
Do While laFrutas.hasNext()
	lcFruta = laFrutas.Next() && devuelve el siguiente elemento
	? lcFruta
Enddo
```

## Ejemplo de Diccionario
```xBase
loDict = ftNewMap()

loDict.Add("nombre", "Irwin Rodriguez") && agrega una clave y un valor al diccionario.
? loDict.Get("nombre") && obtiene el elemento asociado a la clave "nombre"

If loDict.ContainsKey("salario") && devuelve .T. si la clave existe.
	? loDict.Get("salario")
Else
	? "El salario no existe, agregando clave salario..."
	loDict.Add("salario", 2000)
	? loDict.Get("salario")
Endif

loDict.Add('edad', 36)
loDict.Add('direccion', 'Calle sin nombre')
loDict.Add('casado', .F.)
loDict.Add('hombre', .T.)

? "================================"
Local loPair
Do While loDict.HasNext()
	loPair = loDict.Next() && Next devuelve un objeto tipo Pair (key, value)
	? "Key: ", loPair.Key, " Value: ", loPair.Value
Enddo
```

## Ejemplo de Pila (Stack)
Las pilas funcionan con el principio LIFO donde el último elemento en entrar es el primero en salir.
```xBase
loStack = ftNewStack()

* Push: agrega un lemento en la pila.
loStack.Push("Hello")
loStack.Push("World")
loStack.Push(1985)
loStack.Push(.T.)

* Pop: elimina un elemento desde el tope de la pila en sentido LIFO (Last In First Out)
lvResult = loStack.Pop()
?lvResult

* Empty: determina si la pila está vacía.
? loStack.Empty()
```


## Ejemplo de Cola (Queue)
Las colas funcionan con el principio FIFO donde el primer elemento en entrar es el primero en salir.
```xBase
loQueue = ftNewQueue()

loQueue.Enqueue("John")
loQueue.Enqueue("Doe")
loQueue.Enqueue(1985)
loQueue.Enqueue(.T.)

// Dequeue
?"El primer elemento es: ", loQueue.Dequeue()
```
