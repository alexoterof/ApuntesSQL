#Imos a crear un dominio. Funciona en postgreSQL, pero non en mySQL, comentámolo
/*
CREATE DOMAIN CHAR(9)    CHAR(9);
CREATE DOMAIN CHAR(5) CHAR(5);
CREATE DOMAIN Nome_Valido VARCHAR(30);
*/
DROP SCHEMA IF EXISTS ProxectoInvestigacion;
CREATE DATABASE ProxectoInvestigacion;
USE ProxectoInvestigacion;
CREATE TABLE Sede(
  Nome_Sede VARCHAR(30) PRIMARY KEY,
  Campus VARCHAR(30) NOT NULL
);

CREATE TABLE Departamento(
  Nome_Departamento VARCHAR(30) PRIMARY KEY,
  Telefono CHAR(9) NOT NULL, #No es un inte pq en verdad non vas querer facer unha suma de telefonos ou algo do estilo
  Director CHAR(9)
  #FK(Director)
);

CREATE TABLE Ubicacion(
  Nome_Sede VARCHAR(30),
  Nome_Departamento VARCHAR(30),
  CONSTRAINT `PK_Ubicación`
    PRIMARY KEY (Nome_Sede, Nome_Departamento),
  CONSTRAINT `FK_Sede_Ubiacion`
    FOREIGN KEY (Nome_Sede)
    REFERENCES Sede(Nome_Sede) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Departamento_Ubicacion`
    FOREIGN KEY (Nome_Departamento) 
    REFERENCES Departamento (Nome_Departamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    #Sede(Nome_Sede) é optativo, se poñemos solo Sede vamos directamente á clave primaria
);

CREATE TABLE Grupo(
  Nome_Grupo VARCHAR(30),
  Nome_Departamento VARCHAR(30),
  Area VARCHAR(30) NOT NULL,
  Lider CHAR(9),
  PRIMARY KEY (Nome_Grupo, Nome_Departamento),
  CONSTRAINT `FK_Departamento_Grupo`
    FOREIGN KEY (Nome_Departamento) 
    REFERENCES Departamento (Nome_Departamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Profesor(
  DNI CHAR(9) PRIMARY KEY,
  Nome_Profesor VARCHAR(30) NOT NULL,
  Titulacion VARCHAR(29) NOT NULL,
  Experiencia INTEGER,
  Nome_Grupo VARCHAR(30),
  Nome_Departamento VARCHAR(30),

  CONSTRAINT FK_Grupo_Profesor FOREIGN KEY (Nome_Grupo, Nome_Departamento)
    REFERENCES Grupo (Nome_Grupo, Nome_Departamento) 
    ON DELETE SET NULL ON UPDATE NO ACTION
);

CREATE TABLE Proxecto(
  Codigo_Proxecto CHAR(5) PRIMARY KEY,
  Nome_Proxecto VARCHAR(30) UNIQUE NOT NULL,
  Orzamento NUMERIC NOT NULL,
  Data_Inicio DATE,
  Data_Fin DATE,        
  N_Gr VARCHAR(30),
  N_Dep VARCHAR(30),
  CHECK (Data_Fin IS NULL || (Data_Fin IS NOT NULL AND (Data_Inicio < Data_Fin))),                 
  #haberia que asegurarse de que ningunha das datas é nulo pero pra este exame non importa
  CONSTRAINT `FK_Proxecto_Grupo`
    FOREIGN KEY (N_Gr, N_Dep)
    REFERENCES Grupo (Nome_Grupo, Nome_Departamento)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

ALTER TABLE Departamento ADD 
CONSTRAINT `FK_Profesor_Departamento`
	FOREIGN KEY (Director) 
	REFERENCES Profesor (DNI)
	ON DELETE SET NULL
	ON UPDATE CASCADE;

ALTER TABLE Grupo
ADD CONSTRAINT `FK_Profesor_Grupo`
  FOREIGN KEY (Lider)
  REFERENCES Profesor (DNI)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
  
CREATE TABLE Participa (
  DNI CHAR(9),
  Codigo_Proxecto CHAR(5),
  Data_Inicio DATE NOT NULL,
  Data_Cese DATE,
  Dedicación INTEGER NOT NULL,
  PRIMARY KEY (DNI, Codigo_Proxecto),
  CHECK (Data_Cese IS NULL || (Data_Cese IS NOT NULL AND (Data_Cese > Data_Inicio))), 
  FOREIGN KEY (DNI)
    REFERENCES Profesor (DNI)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY (Codigo_Proxecto)
    REFERENCES Proxecto (Codigo_Proxecto)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

 #Prestar atencion ós ordes de creación das taboas. Pode preguntar en que orde é mellor crear duas tablas pra non ter que facer 
 #alter table mais tarde. Por exemplo entre programa e financia, é mellor facer antes programa, pra poder referenciar en financia
 #directamente no create table
 CREATE TABLE Programa(
  Nome_Programa VARCHAR(30) PRIMARY KEY
  );

 CREATE TABLE Financia(
  Nome_Programa VARCHAR(30),
  Codigo_Proxecto CHAR(5),
  Numero_Programa CHAR(5) NOT NULL,
  Cantidade_Financiada NUMERIC NOT NULL,
  PRIMARY KEY (Nome_Programa, Codigo_Proxecto)
);
#ESTO É UN EXEMPLO
/*Vamos a facer as claves foraneas como alter table pq si
ALTER TABLE Financia
  DROP COLUMN Cantidade_Financiada;
ALTER TABLE Financia
  ADD COLUMN Cantidade_Financiada MONEY CHAR(5);
  */
  
ALTER TABLE Financia ADD 
CONSTRAINT `FK_Programa_Financia`
  FOREIGN KEY (Nome_Programa)
    REFERENCES Programa(Nome_Programa)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
  
ALTER TABLE Financia 
ADD CONSTRAINT `FK_Proxecto_Financia`
  FOREIGN KEY (Codigo_Proxecto)
    REFERENCES Proxecto (Codigo_Proxecto)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
      
/*QUE SUCEDE SI INTENTAMOS UTILIZAR UN CONSTRAINT DE CHECK PRA FACER COMPROBACIONS DE 2 TABOAS DISTINTAS?


CREATE ASSERTION O_Orzamento_Inclue_Todo_O_Financiado
  #pseudocodigo. Nin se fai asi nin funciona
  CHECK(Proxecto-Orzamento >=
        SUM(Financia.Cantidade_Financiada);
*/
    
# CASO DE QUE POR EXEMPLO FACEMOS MAL A CLAVE FORÁNEA E QUEREMOS CAMBIALA (ON UPDATE)

/*  
  ALTER TABLE Profesor 
     DROP CONSTRAINT FK_Grupo_Profesor;
     
  ALTER TABLE Profesor 
    ADD CONSTRAINT FK_Grupo_Profesor
      FOREIGN KEY (N_Grupo, N_Departamento)
      REFERENCES Grupo(Nome_Grupo, Nome_Departamento)
      ON DELETE SET NULL 
      ON UPDATE SET NULL;
*/

