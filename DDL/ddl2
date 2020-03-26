
CREATE SCHEMA NavesEspaciais;

CREATE DOMAIN CodigoValido as Integer(10);
CREATE DOMAIN NomeValido as VARCHAR(15);

CREATE TABLE Servizo(
  Clave_Servizo CodigoValido,
  Nome_Servizo nomeValido,
  PRIMARY KEY(Clave_Servizo, Nome_Servizo)
 );
 
 CREATE TABLE Dependencia(
  Codigo_Dependencia CodigoValido PRIMARY KEY,
  Nome_Dependencia NomeValido NOT NULL UNIQUE,
  Clave_Servizo,
  Nome_Servizo
  Funcion varchar(30) NOT NULL,
  Localizacion varchar(30) NOT NULL,
  ADD CONSTRAINT Fk_Dependencia_Servizo
    FOREIGN KEY(Clave_Servizo, Nome_Servizo)
    REFERENCES "NavesEspaciais".Servizo(Clave_Servizo, Nome_Servizo)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
 
 CREATE TABLE Raza(
  Nome_Raza NomeValido PRIMARY KEY,
  Altura real,
  Anchura real,
  Peso real,
  Poboacion_Total BigInt,
);

CREATE TABLE Habita(
  Codigo_Planeta CodigoValido
  Nome_Raza NomeValido,
  Poboacion_Parcial int,
  FOREIGN KEY(Nome_Raza)
    REFERENCES "NavesEspaciais".Raza (Nome_Raza)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  PRIMARY KEY(Codigo_Planeta, Nome_Raza)
  --queda pendiente a foreign key de codigo planeta, referenciado da táboa planeta
);

CREATE TABLE Planeta(
  Codigo_Planeta CodigoValido,
  Nome_Planeta NomeValido NOT NULL UNIQUE,
  galaxia varchar(20),
  coordenadas varchar(40) NOT NULL UNIQUE,
  PRIMARY KEY(Codigo_Planeta)
);

ALTER TABLE "NavesEspaciais".Habita
  ADD CONSTRAINT fk_habita_planeta
    FOREIGN KEY(Codigo_Planeta)
    REFERENCES "NavesEspaciais".Habita(Codigo_Planeta)
    ON UPDATE CASCADE,
    ON DELETE CASCADE;
  
CREATE TABLE Camara(
  Codigo_Dependencia CodigoValido NPRIMARY KEY,
  Categoria varchar(30),
  Capacidade smallInt,
  ADD CONSTRAINT FK_Camara_Dependencia,
    FOREIGN KEY(Codigo_Dependencia)
    REFERENCES "NavesEspaciais".Dependencia(Codigo_Dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)

CREATE TABLE Tripulacion(
  Codigo_Tripulacion CodigoValido PRIMARY KEY,
  Nome_Tripulacion NomeValido,
  Codigo_Camara CodigoValido NOT NULL,
  Codigo_Dependencia CodigoValido NOT NULL,
  Categoria varchar(30),
  Antigüidade varchar(30),
  Procedencia varchar(30),
  Adm varchar(30),
  ADD CONSTRAINT FK_Tripulacion_Camara
    FOREIGN KEY(Codigo_Camara)
    REFERENCES "NavesEspaciales".Camara(Codigo_Dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  ADD CONSTRAINT FK_Tripulacion_Dependencia
    FOREIGN KEY(Codigo_Dependencia)
    REFERENCES "NavesEspaciais".Dependencia(Codigo_Dependencia)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE Visita(
  Codigo_Tripulacion CodigoValido,
  Codigo_Planeta CodigoValido,
  Data_Visita DATE,
  Tempo,
  PRIMARY KEY(Codigo_Tripulacion, Codigo_Planeta, Data_Visita),
  ADD CONSTRAINT FK_Visita_Tripulacion
    FOREIGN KEY(Codigo_Tripulacion)
    REFERENCES "NavesEspaciais".Tripulacion(Codigo_Tripulacion)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  ADD CONSTRAINT FK_Visita_Planeta
    FOREIGN KEY(Codigo_Planeta)
    REFERENCES "NavesEspaciais".Planeta(Codigo_Planeta)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
 
