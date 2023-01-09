# binarysearch_RISCV
Compilación de algoritmo de binary search de Rosetta Code,

Compilation of the binary search algorithm in Rosetta Code.

# ¿Qué hace binary search?

Binary Search es un algoritmo para encontrar un elemento numérico dentro de un arreglo de números ordenados de menor a mayor usando los índices de los elementos y sus valores, para más información están las siguientes ligas : 

https://www.geeksforgeeks.org/binary-search/

https://en.wikipedia.org/wiki/Binary_search_algorithm

https://stackoverflow.com/questions/540165/where-is-binary-search-used-in-practice


# Código en C

![image](https://user-images.githubusercontent.com/66481799/208310374-6b353892-36d2-47f9-b74a-35aa54f2c34c.png)

fuente : https://rosettacode.org/wiki/Binary_search#C

# Marcos 

![image](https://user-images.githubusercontent.com/66481799/209091236-0f582959-9190-42dd-a849-fca2a2247a7c.png)
bsearch function frame

![image](https://user-images.githubusercontent.com/66481799/209091373-e8fbdd50-6999-431f-aa70-ddeb041c3a59.png)
bsearch_r function frame

![image](https://user-images.githubusercontent.com/66481799/209091517-2ea8b802-f527-4af7-af16-688865cc8c29.png)
main function frame

![image](https://user-images.githubusercontent.com/66481799/209091938-d74e1412-8939-4c82-88a5-fc6edcffb616.png)
program function frame

# Código compilado en RISC-V 


bsearch function


bsearch_r function 


main function

para revisar que funciona se puede usar un esquema como el incluido en el pdf "Pruebas" con diferentes arreglos.

# Código Máquina 

Venus RISC-V Simulator muestra el código ensamblado, para verlo completo, ver archivo : "venusoriginal".
Ésto es durante depuración.


# Uso en el procesador

Después de obtener solamente el código máquina, es decir, sin PC o las instrucciones optimizadas, se debe revisar cómo hacerlo encajar en el procesador, porque el código supera el tamaño de la memoria, no se podría usar en éste estado. Aquí una comparación con el código original de la ROM, donde se ve que el máximo del código es el de la línea subrayada y las líneas restantes no caben.  

![limite](https://user-images.githubusercontent.com/66481799/209178742-c93ff430-4bb0-47f4-992b-bdaebc57d3bb.png)

Insertándolo directamente como en las siguientes imagenes, dice que ha decodificado 174 de 128 palabras, lo que significa que no se han agregado todas las palabras porque no caben en la ROM. Entonces aunque se puede pegar no funcionará como el programa original.

![noerrorformat](https://user-images.githubusercontent.com/66481799/209178401-05136f7b-0ce2-43e3-bc93-ccd4beeff0c1.png)

![noerrorformat2](https://user-images.githubusercontent.com/66481799/209178425-fafe5cfd-d5bf-4ba6-ba3c-2ae7b7199c53.png)






