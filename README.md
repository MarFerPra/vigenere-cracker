#CIFRADO DE VIGENÉRE

Para solucionar este problema hemos elegido el lenguaje de programación Ruby puesto que es fácil la manipulación de cadenas de caracteres y el programa se ejecuta desde la terminal usando **ruby cracker.rb**

##Descripción de solución 

Lo primero que hemos hecho, fue calcular cuántas funciones de desplazamiento hay, es decir la longitud de clave. Hemos empleado el método de Índice de coincidencia de Friedman que mide la probabilidad de que dos elementos aleatorios sean iguales. Este índice se calcula en la función *indice_friedman_subcadena(cadena)* cuyo código se puede ver en la siguiente imagen.


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/1_indice_friedman.png)


Para cada letra del alfabeto contamos cuántas veces está en la cadena que se pasa como parámetro a la función y calculamos el Índice de Friedman usando su correspondiente fórmula. Obtenemos el Índice de Friedman de la cadena sumando los Índice de Friedman de todas las letras que estén en la cadena.

Seguimos con el cálculo de la longitud de clave en la función *encontrar_clave(criptograma)*. Dividimos el texto en tantos bloques como es la longitud de la clave, sabiendo que su longitud máxima es 8. Calculamos el Índice de Friedman para cada bloque usando la función *indice_friedman_subcadena(cadena)*. 


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/2.1_encontrar_clave.png)


Calculamos la media de los índices obtenidos y con la longitud de la clave igual a 8 obtenemos el índice de 0.074 y es el que más se aproxima al valor esperado.


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/2.2_encontrar_clave.png)


A continuación hacemos la función para descifrar cadena donde usamos el conocimiento de que las letras más repetidas en un texto español son la 'E' y la 'A'. Entonces creamos un array unique_chars que contiene todas las letras de cadena sin repetición y lo usamos para calcular el porcentaje de aparición de cada en la cadena. Ordenamos todas las letras según el porcentaje de mayor a menor. 


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/3.1_descifrar.png)


Encontramos la letra más repetida que será la E cifrada, por lo tanto calculamos la distancia que hay en el alfabeto entre estas dos letras. Si nos sale un número positivo, significa que el desplazamiento en el alfabeto que se ha hecho para cifrar las letras fue hacia la izquierda y si es negativo, el desplazamiento fue hacia la derecha. Para asegurarse de que la distancia calculada es correcta, sumamos esta distancia a la segunda letra que más se repite en la cadena y obtenemos la A, es decir la segunda letra más repetida en español.


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/3.2_descifrar.png)


Una vez que sabemos el desplazamiento que se ha hecho, sumamos la distancia a cada una de las letras y así desciframos toda la cadena.


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/3.3_descifrar.png)


Todas las funciones descritas anteriormente se llaman desde el programa principal main. Antes de nada, abrimos y leemos el archivo con nuestro criptograma y encontramos longitud de la clave. A partir del criptograma construimos tantas cadenas como sea la longitud de la clave y desciframos cada una de ellas.


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/4.1_cracker.png)


Al final, unimos todas la cadenas, las imprimimos en la pantalla y obtenemos el texto del capítulo VIII del libro de Don Quijote de la Mancha.


![Captura de pantalla](https://github.com/VierkaJ/vigenere-cracker/blob/master/images/4.2_cracker.png)


