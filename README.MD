SQL é unha linguaxe de consultas utilizada pra interatuar con bases de datos. Esta linguaxe (formada ou organizada en varias sublinguaxes) permítenos crear,consultar, modificar e eliminar a información almaceada nas bases de datos de forma declarativa. Entre as súas maiores ventaxas podémonos atopar con que é moi fácil e intuitiva de aprender, é unha linguaxe con unha rodaxe detrás (Non é unha linguaxe que esté "de moda") e a súa evolución non está ligada a ningun fabricante nin organización senon ás necesidades da súa comunidade. 

As sublinguaxes ou subdivisións de SQL son:

 - [**DDL** (Data definition language): Crea modifica e elimina táboas. Céntrase na estructura, non nos propios datos.](DDL/README.MD)
 - **DML** (Data Manipularion language): Borra, modifica e inserta novos datos. Centrada nos propios datos.
 - **DQL** (Data query language): A súa única instrucción é o SELECT. É a sublinguaxe máis extensa e na que mais nos centraremos nestes apuntes. 
 - **TCL** (Transactino control language): Permite executar varias operacións, e executalas só no caso de que se executen todas. (Non podo, nunha transferencia bancaria, quitar cartos dunha conta e non ser capaz a metelos noutra e que os cartos "desaparezan". Por exemplo)
 - **DCL** (Data control language): Xestiona a qué partes da base de datos pode e non pode acceder cada usuario.
 - **SCL** (Session control language): Utilízase para manexar dinámicamente propiedades dunha sesión de usuario.
  
## SELECT
As consultas mais básicas que podemos facer con SELECT permítennos obter unha ou varias columnas dunha táboa da que xa dispoñemos. Por exemplo (Basándonos nas tablas de SQLZoo)
````SQL
SELECT *
FROM world
````
Devolveríanos a lista de países, pero non solo os nomes. Devolvería todas as filas. É dicir, estamos obtendo a táboa world enteira.
Vemos que tamén estamos utilizando o vocablo clave "FROM". Este permítenos seleccionar de qué táboa queremos extraer os datos. Mais adiante profundizaremos nel pra obter datos de mais de unha táboa simultaneamente.
Esta sería a consulta "mínima" que podemos realizar en DQL.

````SQL
SELECT name
FROM world
````
Esta sí que nos permitiría seleccionar únicamente os nomes dentro de toda a tabla world.
````SQL
SELECT name, population
FROM world
````
E esta devolveríanos dúas columnas, os nomes xunto cá población correspondente. 

## DISTINCT
Tamen podemos xogar un pouco pra obter datos que non esten repetidos, por exemplo
````SQL
SELECT DISTINCT continent
FROM world
````
Esta devolveríanos unha lista dos continentes. Cada país almacena o continente ó que pertenece pero aquí só temos unha tupla por cada continente.

## WHERE
Permítenos establecer condicións. Solo as tuplas que cumplan as condicions que nos establecemos serán seleccionadas.
````SQL
SELECT  *
FROM world
WHERE name = 'China'
````
Esta permítenos seleccionar únicamente a entrada de china.
````SQL
SELECT name
FROM world
WHERE population > 1000000
````
Esto permitenos seleccionar os países con mais de 10 millóns de habitantes.

## Operadores lóxicos
AND, OR, NOT, NOR, son operadores lóxicos que podemos utilizar dentro do WHERE para facer consultas un pouco mais complexas
````SQL
SELECT name
FROM world
WHERE population > 1000000 
      AND continent = "Europe"
````
Esta faría o mismo que a anterior mais únicamente pra os países europeos.

## Outros operadores

 - **BETWEEN**: Selecciona só entre os valores que están antes e despois desta palabra clave, ambos inclusive
 - **IN**: Intenta matchear o que lle damos cás apariencias nun array:
 ````SQL
SELECT *
FROM world
WHERE name IN ("Germany", "France", "Italy", "Netherlands", "Luxemburg", "Belgium")
````
Permítenos seleccionar ós países fundadores da Comunidade Europea. 
 - **LIKE**: Permitenos comparar expresións regulares:
````SQL
SELECT *
FROM world
WHERE name LIKE "_ _"
````
Permítenos seleccionar os países que contan con un espacio no seu nome
## **CONCAT**
 Permitenos unir cadeas
````SQL
SELECT name
FROM world
WHERE name = CONCAT(name, ' City');
````
Esta selecciona aqueles paises nos que os seu nome acaba en " City".
## REPLACE

Permítenos reemplazar ocurrencias
````SQL
SELECT REPLACE(name, ' City', '')
FROM world
WHERE name = CONCAT(name, ' City');
````
Esta mostraíanos os países anteriores pero no nome non estaría incluído o sufixo -City.

## ROUND
Redondea un valor ós decimais desexados
````SQL
SELECT name, ROUND(gdp/population, 2)
FROM world
````
## LENGTH
````SQL
SELECT name, LENGTH(name) AS'Longo'
FROM world
````
Nos devuelve los países y cómo de largo es su nombre
## AS
  No apartado anterior vimos que aparece "AS". Isto permítenos decir qué nome queremos que teña unha columna xerada por un reductor.
 

## SUM
 Permite sumar todos os valores dunha columna
````SQL
SELECT SUM(population)
FROM world
````
 Darianos a poboación mundial

## AVG
 ````SQL
SELECT AVG(population
FROM world
````
Darianos a poboación media por país.

## COUNT
````SQL
SELECT COUNT(name)
FROM world
````
Daríanos o número de países.

## LIMIT
Permitenos limitar o número de tuplas do noso resultado
````SQL
SELECT name
FROM world
WHERE population > 100000000
LIMIT 4;
````
Permitenos coller países con mais de 100 millóns de habitantes, pero sólo 4.

## GROUP BY
Permítenos agrupar as tuplas polo valor dalgunha fila.
````SQL
SELECT continent, COUNT(population)
FROM world
GROUP BY continent;
````
Esta consulta mostrarianos o número de habitantes de cada continente.

## HAVING
Permítenos utilizar funcións de agregado sobre columnas sobre as que fixemos GROUP BY.
Por exemplo:

````SQL
SELECT continent
FROM world
GROUP BY continent
HAVING COUNT(population) > 2000000000;
````
Permítenos seleccionar continentes que teñen únicamente mais de 2000 millóns de habitantes.

## JOIN
Sírvenos pra sacar valores de mais dunha táboa.
````SQL
SELECT name
  FROM movie JOIN casting ON casting.movieid = movie.id
             JOIN actor   ON casting.actorid = actor.id
  WHERE title='Alien'
  ````
  Devolverianos os actores que traballaron en 'Alien'
Modificacións do **JOIN**:
-   **INNER JOIN**: Fíltranse os valores nulos.
-   **LEFT JOIN**:  Devolve tódo-los resultados da táboa esquerda e os que cumplan a condicion (ON) da táboa dereita. 
-   **RIGHT JOIN**: Devolve tódo-los resultados da táboa dereita e os que cumplan a condicion (ON) da táboa esquerda. 

## NULL
Ás veces atoparémonos con valores nulos. Podemos comparalos con "IS NULL" e "IS NOT NULL". 
Mais aló deso deberiamos utilizar inner, left e rigth JOINs, asi como a función COALESCE, pra evitar erros inesperados nas nosas consultas. 

## COALESCE
Permitenos asignar un valor por defecto a un dato no caso de que este sexa nulo. Por exemplo:
````SQL
SELECT name, COALESCE(dept, 'Sin departamento.') AS 'Departamento'
FROM teacher;
  ````
  Esta consulta permitiríanos ter profesores que non estén asignados a ningún departamento e inda asi mostrar os valores correctamente tras facer o select.

## CONSULTAS DENTRO DE OUTRAS CONSULTAS
É posible ter un select dentro de outro. Esto permitiríanos por exemplo, obter o país con mais [poboación | área | gdp] dunha lista de países dada. 
````SQL
SELECT name
FROM world
WHERE population >= ALL(SELECT population
			FROM world);
  ````
Esto, xunto con todo o que xa vimos, podenos levar a consultas bastante complexas como:
````SQL
SELECT title, name
  FROM movie JOIN casting ON movie.id = casting.movieid
             JOIN actor   ON actor.id = casting.actorid
  WHERE ord=1
    AND movieid IN (SELECT movieid 
                    FROM casting JOIN actor ON casting.actorid = actor.id
                    WHERE name='Julie Andrews')
````
Que mostraría o actor ou actriz principal de todas as películas nas que participou 'Julie Andrews'.
