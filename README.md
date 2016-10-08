#CIFRADO DE VIGENÉRE

Para solucionar este problema hemos elegido el lenguaje de programación Ruby puesto que es fácil la manipulación de cadenas de caracteres y el programa se ejecuta desde la terminal usando **ruby cracker.rb**

Lo primero que hemos hecho, fue calcular cuántas funciones de desplazamiento hay, es decir la longitud de clave. Para calcularla hemos empleado el método de Índice de coincidencia de Friedman que mide la probabilidad de que dos elementos aleatorios sean iguales. 

Para cada posible valor la de clave (sabiendo que el valor máximo es 8), dividimos el texto en tantos bloques como es la longitud de la clave. Calculamos el Índice de Friedman para cada bloque y hacemos la media. Con la longitud de clave igual a 8, obtenemos en índice de 0.074 y es el que más se aproxima al valor esperado.

A continuación, dividimos el criptograma en 8 cadenas y desciframos cada una de ellas. En la función descrifrar, calculamos el porcentaje de aparición de cada letra y ordenamos todas las letras según este criterio. La letra que más se repite, será la E cifrada, por lo tanto se calcula la distancia que hay en el alfabeto entre estas dos letras. Para asegurarse de que la distancia calculada es correcta, sumamos esta distancia a la segunda letra que más se repite en la cadena y obtenemos la A, es decir la segunda letra más repetida en español.  Una vez que sabemos el desplazamiento que se ha hecho, sumamos la distancia a cada una de las letras y así desciframos las cadenas.

Al final, unimos todas la cadenas, las imprimimos en la pantalla y obtenemos el texto del capítulo VIII del libro de Don Quijote de la Mancha.

