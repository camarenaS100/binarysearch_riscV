# binarysearch_RISCV
Compilación de algoritmo de binary search de Rosetta Code,

Compilation of the binary search algorithm in Rosetta Code.

# Descripción de archivos en el repositorio 

![image](https://user-images.githubusercontent.com/66481799/212404675-d655f7e2-cf27-4fc6-88bb-2674f80ef13f.png)


- binsearch.c :  código del algoritmo binary search conseguido de Rosetta Code 
- binsearch_ro.c : código modificado del código binsearch.c, éste no tiene la función no recursiva
- bs_sr_betasamplewcx.txt : código ensamblado por Venus de compilación del código binsearch_ro.c
- bsearch.s : código compilado en lenguaje ensamblador RISC-V de binsearch.c
- bsearch_ro.s : código compilado en lenguaje ensamblador RISC-V de binsearch_ro.c
- sample_a.txt : ejemplo de código para procesador.

# ¿Qué hace binary search?

Binary Search es un algoritmo para encontrar un elemento numérico dentro de un arreglo de números ordenados de menor a mayor usando los índices de los elementos y sus valores, para más información están las siguientes ligas : 

https://www.geeksforgeeks.org/binary-search/

https://en.wikipedia.org/wiki/Binary_search_algorithm

https://stackoverflow.com/questions/540165/where-is-binary-search-used-in-practice


# Código en C

![image](https://user-images.githubusercontent.com/66481799/208310374-6b353892-36d2-47f9-b74a-35aa54f2c34c.png)

fuente : https://rosettacode.org/wiki/Binary_search#C

# Código en C para función recursiva

![image](https://user-images.githubusercontent.com/66481799/212400408-93b62b90-e9b3-437e-a46a-1d1a5329d19f.png)


Éste es un código sencillo que contiene prints en posiciones del proceso para entender qué sucede y probar diferentes arreglos para comparar con sus contrapartes calculadas manualmente o por otro programa. Algunas partes se deben reemplazar manualmente para que sea usado en general.
Además es recomendable revisar el pdf de Pruebas donde se ve su ejecución en diferentes arreglos.


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

![image](https://user-images.githubusercontent.com/66481799/212399546-aba43121-a711-40d6-b0db-bc4844fec1b3.png)

bsearch function

![image](https://user-images.githubusercontent.com/66481799/212399650-7fd0b5f7-a10b-4bd1-9f4f-b515dd8d7ba2.png)

bsearch_r function 

![image](https://user-images.githubusercontent.com/66481799/212399800-72171b80-0e86-4a5b-8f74-c12cbce1eaa7.png)

main function

Para comprobar que funciona se puede usar un esquema como el incluido en el pdf "Pruebas" con diferentes arreglos.






