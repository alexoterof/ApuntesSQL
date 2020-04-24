DROP SCHEMA IF EXISTS NavesEspaciais;
CREATE SCHEMA NavesEspaciais;
USE NavesEspaciais;

CREATE TABLE Servizo(
  Clave_Servizo Integer(10),
  Nome_Servizo VARCHAR(15),
  PRIMARY KEY(Clave_Servizo, Nome_Servizo)
 );
 
 CREATE TABLE Dependencia(
  Codigo_Dependencia Integer(10) PRIMARY KEY,
  Nome_Dependencia VARCHAR(15) NOT NULL UNIQUE,
  Clave_Servizo Integer(10),
  Nome_Servizo VARCHAR(15),
  Funcion VARCHAR(30) NOT NULL,
  Localizacion VARCHAR(30) NOT NULL,
  CONSTRAINT `Fk_Dependencia_Servizo`
    FOREIGN KEY (Clave_Servizo, Nome_Servizo)
    REFERENCES Servizo(Clave_Servizo, Nome_Servizo)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

 CREATE TABLE Camara(
  Codigo_Dependencia Integer(10) PRIMARY KEY,
  Categoria varchar(30) NOT NULL,
  Capacidade INT NOT NULL,
  CONSTRAINT `FK_Camara_Dependencia`
    FOREIGN KEY(Codigo_Dependencia)
    REFERENCES Dependencia(Codigo_Dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Tripulacion(
  Codigo_Tripulacion Integer(10) PRIMARY KEY,
  Nome_Tripulacion VARCHAR(15),
  Codigo_Camara Integer(10) NOT NULL,
  Codigo_Dependencia Integer(10) NOT NULL,
  Categoria varchar(30) NOT NULL,
  Antigüidade varchar(30) DEFAULT 0,
  Procedencia varchar(30),
  Adm varchar(30) NOT NULL,
  CONSTRAINT `FK_Tripulacion_Camara`
    FOREIGN KEY(Codigo_Camara)
    REFERENCES Camara(Codigo_Dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `FK_Tripulacion_Dependencia`
    FOREIGN KEY(Codigo_Dependencia)
    REFERENCES Dependencia(Codigo_Dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Planeta(
  Codigo_Planeta Integer(10) PRIMARY KEY,
  Nome_Planeta VARCHAR(15) NOT NULL UNIQUE,
  galaxia varchar(20) NOT NULL,
  coordenadas varchar(40) NOT NULL UNIQUE
);

CREATE TABLE Visita(
  Codigo_Tripulacion Integer(10),
  Codigo_Planeta Integer(10),
  Data_Visita DATE,
  Tempo INT NOT NULL,
  PRIMARY KEY(Codigo_Tripulacion, Codigo_Planeta, Data_Visita),
  CONSTRAINT `FK_Visita_Tripulacion`
    FOREIGN KEY(Codigo_Tripulacion)
    REFERENCES Tripulacion(Codigo_Tripulacion)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `FK_Visita_Planeta`
    FOREIGN KEY(Codigo_Planeta)
    REFERENCES Planeta(Codigo_Planeta)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

 CREATE TABLE Raza(
  Nome_Raza VARCHAR(15) PRIMARY KEY,
  Altura INT NOT NULL,
  Anchura INT NOT NULL,
  Peso INT NOT NULL,
  Poboacion_Total INT NOT NULL
);

CREATE TABLE Habita(
  Codigo_Planeta Integer(10),
  Nome_Raza VARCHAR(15),
  Poboacion_Parcial INT,
  PRIMARY KEY(Codigo_Planeta, Nome_Raza),
  CONSTRAINT `FK_Habita_Raza`
    FOREIGN KEY (Nome_Raza)
    REFERENCES Raza (Nome_Raza)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_Habita_Planeta`
    FOREIGN KEY(Codigo_Planeta)
    REFERENCES Planeta(Codigo_Planeta)
    ON UPDATE CASCADE
    ON DELETE CASCADE
  #queda pendiente a foreign key de codigo planeta, referenciado da táboa planeta
);