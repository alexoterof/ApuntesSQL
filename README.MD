SQL é unha linguaxe de consultas utilizada para interactuar con bases de datos. Esta linguaxe (formada ou organizada en varias sublinguaxes) permítenos crear,consultar, modificar e eliminar a información almacenada nas bases de datos de forma declarativa. Entre as súas maiores vantaxes podémonos atopar con que é moi fácil e intuitiva de aprender, é unha linguaxe con unha rodaxe detrás (non é unha linguaxe que esté "de moda") e a súa evolución non está ligada a ningún fabricante nin organización senón ás necesidades da súa comunidade. 

As sublinguaxes ou subdivisións de SQL son:

 - [**DDL**](DDL/README.MD) (Data definition language): Crea modifica e elimina táboas. Céntrase na estructura, non nos propios datos.
 - [**DML**](DML/README.MD) (Data Manipularion language): Borra, modifica e inserta novos datos. Centrada nos propios datos.
 - [**DQL**](DQL/README.MD) (Data query language): A súa única instrucción é o SELECT. É a sublinguaxe máis extensa e na que máis nos centraremos nestes apuntes.
 - **TCL** (Transactino control language): Permite executar varias operacións, e executalas só no caso de que se executen todas. Por exemplo non se pode, nunha transferencia bancara, quitar cartos dunha conta non sendo capaz de insertalos noutra, "desaparezendo" estes cartos.
 - **DCL** (Data control language): Xestiona a qué partes da base de datos pode e non pode acceder cada usuario.
 - **SCL** (Session control language): Utilízase para manexar dinámicamente propiedades dunha sesión de usuario.
 
 

 # Instalacion MariaDB
 Instruccions [neste](https://gist.github.com/alexoterof/6c89485485752bc05673702f519488e6) Gist.

# Exercicios
  [**DDL**](exercicios/DDL1/README.MD) Ámbolos dous exercicios propostos (Proxectos de investigación e naves espacias)
  [**Mariadb**](exercicios/mariadbInspection/README.MD) Comandos útiles para bucear no contido do noso server mariadb