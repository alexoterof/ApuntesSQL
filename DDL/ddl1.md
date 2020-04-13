recordar que en las especificaciones, donde hay asterisco significa que puede ser nulo

--
````SQL

Imos a crear un dominio.
CREATE DOMAIN Tipo_DNI    CHAR(9);
CREATE DOMAIN Tipo_Codigo CHAR(5);
CREATE DOMAIN Nome_Valido VARCHAR(30);

CREATE TABLE Sede(
  Nome_Sede Nome_Valido PRIMARY KEY,
  Campus    Nome_Valido NOT NULL
);
CREATE TABLE Departamento(
  Nome_Departamento Nome_Valido PRIMARY KEY,
  Telefono          CHAR(9) NOT NULL,               --No es un inte pq en verdad non vas querer facer unha suma de telefonos ou algo do estilo
  Director          Tipo_DNI
  --FK(Director)
);

CREATE TABLE Ubicacion(
  Nome_Sede         Nome_Valido,
  Nome_Departamento Nome_Valido,
  PRIMARY KEY(Nome_Sede, Nome_Departamento),
  CONSTRAINT FK_Sede_Ubicacion
    FOREIGN KEY (Nome_Sede)
    REFERENCES Sede(Nome_Sede) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,                 --Sede(Nome_Sede) é optativo, se poñemos solo Sede vamos directamente á clave primariaç
  CONSTRAINT FK_Departamento_Ubicacion
    FOREING KEY (Nome_Departamento)
    REFERENCES Departamento)
    ON DELETE CASCADE 
    ON UPDATE CASCADE
);

CREATE TABLE GRUPO(
  Nome_Grupo        Nome_Valido,
  Nome_Departamento Nome_Valido,
  Area              Nome_Valido NOT NULL,
  Lider             Tipo_DNI,
  PRIMARY KEY (Nome_Grupo, Nome_Departamento)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  --FK (LIDER)
);

CREATE TABLE Profesor(
  DNI Tipo_DNI PRIMARY KEY,
  Nome_Profesor Nome_Valido NOT NULL,
  Titulacion VARCHAR(29) NOT NULL,
  Experiencia INTEGER,
  Grupo Nome_Valido,
  PRIMARY KEY(DNI),
  N_Grupo Nome_Valido,
  N_Departamento Nome_Valido,
  CONSTRAINT FK_Grupo_Profesor
    FOREIGN KEY (N_Grupo, N_Departamento)
      REFERENCES (Nome_Grupo, Nome_Departamento)
      ON DELETE SET NULL
      ON UPDATE CASCADE
);

ALTER TABLE departamento
ADD CONSTRAINT fk_profesor_departamento
	FOREIGN KEY (Director) 
	REFERENCES "proxectoClase".profesor (DNI)
	ON DELETE SET NULL
	ON UPDATE CASCADE;
	
CREATE TABLE participa (
	DNI Tipo_DNI,
	Código_Proxecto Tipo_Código,
	Data_Inicio date NOT NULL,
	Data_Cese date,
	Dedicación char(20) NOT NULL,
	PRIMARY KEY(DNI,Código_Proxecto),
	CHECK (Data_Inicio < Data_Cese)
);





    
CREATE TABLE Proxecto(
  Codigo_Proxecto Tipo_Codigo PRIMARY KEY,
  Nome_Proxecto   Nome_Valido NOT NULL,
  Orzamento       MONEY NOT NULL,
  Data_Inicio     DATE NOT NULL,
  Data_Fin        DATE CHECK (Data_Inicio < Data_Fin)           
  N_Gr Nome_Valido,
  N_Dep Nome_Valido,
  UNIQUE (Nome_Proxecto),
  CHECK (Data_Inicio < Data_Fin)                 //haberia que asegurarse de que ningunha das datas é nulo pero pra este exame non importa
)
//Vamos a facer con alter table a clave foránea
ALTER TABLE Proxecto 
  ADD CONSTRAINT FK_Grupo_Proxect
    FOREIGN KEY (N_Grupo, N_Departamento)
    REFERENCES Grupo(Nome_Grupo, Nome_Departamento)     //Pregunta de exame. Non matchea por nomes. Senon por dominio/Tipo de datos
    ON DELETE CASCADE
    ON UPDATE CASCADE;
 //Prestar atencion ós ordes de creación das taboas. Pode preguntar en que orde é mellor crear duas tablas pra non ter que facer 
 //alter table mais tarde. Por exemplo entre programa e financia, é mellor facer antes programa, pra poder referenciar en financia
 //directamente no create table
 
 CREATE TABLE Programa(
  Nome_Programa Nome_Valido PIMARY KEY
  );
 CREATE TABLE Financia(
  Nome_Programa Nome_Valido,
  Codigo_Proxecto Tipo_Codigo,
  Numero_Programa Tipo_Codigo NOT NULL,
  Cantidade_Financiada Char(5) NOT NULL, //Esta mal a propositol, pra despois ver como cambialo
  PRIMARY KEY (Nome_Programa, Codigo_Proxecto),
);
//Vamos a facer as claves foraneas como alter table pq si
ALTER TABLE Financia
  DROP COLUMN Cantidade_Financiada;
ALTER TABLE Financia
  ADD COLUMN Cantidade_Financiada MONEY NOT NULL;
  
ALTER TABLE Financia
  ADD CONSTRAINT FK_Programa_Financia
    ADD FOREIGN KEY (Nome_programa)
      REFERENCES Programa
      ON DELETE CASCADE
      ON UPDATE CASCADE;
  
ALTER TABLE Financia
  ADD CONSTRAINT FK_Proxecto_Financia
    FOREIGN KEY (Codigo_Proxecto)
      REFERENCES Proxecto
      ON DELETE CASCADE
      ON UPDATE CASCADE;
      
//QUE SUCEDE SI INTENTAMOS UTILIZAR UN CONSTRAINT DE CHECK PRA FACER COMPROBACIONS DE 2 TABOAS DISTINTAS?

/*
CREATE ASSERTION O_Orzamento_Inclue_Todo_O_Financiado
  --pseudocodigo. Nin se fai asi nin funciona
  CHECK(Proxecto-Orzamento >=
        SUM(Financia.Cantidade_Financiada);

    



````
-- CASO DE QUE POR EXEMPLO FACEMOS MAL A CLAVE FORÁNEA E QUEREMOS CAMBIALA (ON UPDATE)

    
  ALTER TABLE Profesor 
     DROP CONSTRAINT FK_Grupo_Profesor;
     
  ALTER TABLE Profesor 
    ADD CONSTRAINT FK_Grupo_Profesor
      FOREIGN KEY (N_Grupo, N_Departamento)
      REFERENCES Grupo(Nome_Grupo, Nome_Departamento)
      ON DELETE SET NULL 
      ON UPDATE SET NULL;






