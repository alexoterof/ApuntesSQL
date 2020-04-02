<a name="comezo"></a>
A sublinguaxe DML(Data Manipulation Language) permítenos levar a cabo operacions de consultas e modificación dos datos contidos no SXBD. 
As tres instruccions de esta sublinguaxe que veremos son *INSERT*, *DELETE* e *UPDATE*

# INSERT
A estructura básica de insert é a seguinte: 

~~~~sql
INSERT INTO <nome-da-taboa> [<columna1>,<columna2>...]
    VALUES 
        --tupla 1
        ((<dato1>,<dato2>, ...) | SELECT(...))
        ...
        ...
        --tupla n
        ((<datoN>,<datoN>, ...) | SELECT(...));
~~~~

Esta consulta permite varios modificadores como [AS alias], ON CONFLICT...
Podemos ver unha lista completa das posibilidades de *INSERT* [aquí](https://www.postgresql.org/docs/9.5/sql-insert.html)].

# UPDATE
Sirve pra modificar as tuplas xa existentes. Podemos modificar todos os valores dunha columna ou utilizar un predicado con *WHERE* pra controlar qué valores se modifican.
Por exemplo:
~~~~sql
UPDATE usuarios
    SET privilegios = "root"
    WHERE nombre = "admin";
~~~~

# DELETE 
Utilizámolo pra eliminar rexistros de unha táboa. 
Si facemos algo do estilo
~~~~sql
DELETE FROM usuarios;
~~~~
Estariamos eliminando todas as tuplas da táboa mais, igual que en *UPDATE*, podemos utilizar un predicado con *WHERE* pra ter control sobre qué estamos eliminando. 
~~~~sql
DELETE FROM usuarios
    WHERE nombre = "alexoterof";
~~~~

Para ver todas as posibilidades de esta sublinguaxe, clickar [aqui](https://www.postgresql.org/docs/9.5/dml.html)

[Voltar ó comezo](#comezo)
