/**
 *
 * DBMS             :  ORACLE
 * Esquema          :  EDUCA
 * Descripci�n      :  Modelo de Base de Datos de control acad�mico sencillo
 * Script           :  Crea el esquema y sus respectivas tablas
 * Creao por        :  Ing. Eric Gustavo Coronel Castillo
 * Email            :  gcoronelc@gmail.com
 * Sitio Web        :  www.desarrollasoftware.com
 * Blog             :  http://gcoronelc.blogspot.com
 * Cursos virtuales :  https://gcoronelc.github.io/
 * Fecha            :  22-NOV-2017
 * 
**/


-- =============================================
-- CRACI�N DEL USUARIO
-- =============================================

-- Valido pa partir de la version 12

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;


DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER EDUCA CASCADE';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'EDUCA';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/

CREATE USER EDUCA IDENTIFIED BY admin;

ALTER USER EDUCA QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE, CREATE VIEW TO EDUCA;


-- =============================================
-- CONECTARSE CON EL USUARIO EDUCA
-- =============================================

CONNECT EDUCA/admin



-- ======================================================
-- TABLA ALUMNO
-- ======================================================

CREATE TABLE ALUMNO
( 
	alu_id               INT  NOT NULL ,
	alu_nombre           varchar2(100)  NOT NULL ,
	alu_direccion        varchar2(100)  NOT NULL ,
	alu_telefono         varchar2(20)  NULL ,
	alu_email            varchar2(50)  NULL 	
);


-- ======================================================
-- TABLA CURSO
-- ======================================================

CREATE TABLE CURSO
( 
	cur_id               INT NOT NULL ,
	cur_nombre           varchar2(100)  NOT NULL ,
	cur_vacantes         int  NOT NULL ,
	cur_matriculados     int  NOT NULL ,
	cur_profesor         varchar2(100)  NULL ,
	cur_precio           decimal(10,2)  NOT NULL 
);



-- ======================================================
-- TABLA MATRICULA
-- ======================================================


CREATE TABLE MATRICULA
( 
	cur_id               INT  NOT NULL ,
	alu_id               INT  NOT NULL ,
	mat_fecha            date  NOT NULL ,
	mat_precio           decimal(10,2)  NOT NULL ,
	mat_cuotas           int  NOT NULL ,
	mat_nota             int  NULL 
);


-- ======================================================
-- TABLA PAGO
-- ======================================================

CREATE TABLE PAGO
( 
	cur_id               INT  NOT NULL ,
	alu_id               INT  NOT NULL ,
	pag_cuota            int  NOT NULL ,
	pag_fecha            date  NOT NULL ,
	pag_importe          decimal(10,2)  NOT NULL 
);


-- ======================================================
-- RESTRICCIONES DE LA TABLA ALUMNO
-- ======================================================

ALTER TABLE ALUMNO
	ADD CONSTRAINT PK_ALUMNO 
	PRIMARY KEY (alu_id);


ALTER TABLE ALUMNO
	ADD CONSTRAINT U_ALUMNO_EMAIL 
	UNIQUE (alu_email);


ALTER TABLE ALUMNO
	ADD CONSTRAINT U_ALUMNO_NOMBRE 
	UNIQUE (alu_nombre);


-- ======================================================
-- DATOS DE LA TABLA ALUMNO
-- ======================================================

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 1,'YESENIA VIRHUEZ','LOS OLIVOS','986412345','yesenia@hotmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 2,'OSCAR ALVARADO FERNANDEZ','MIRAFLORES',NULL,'oscar@gmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 3,'GLADYS REYES CORTIJO','SAN BORJA','875643562','gladys@hotmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 4,'SARA RIEGA FRIAS','SAN ISIDRO',NULL,'sara@yahoo.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 5,'JHON VELASQUEZ DEL CASTILLO','LOS OLIVOS','78645345','jhon@movistar.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 6,'RODRIGUEZ ROJAS, RENZO ROBERT','SURCO','673465235','rrodrigiez@gmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 7,'CALERO MORALES, EMELYN DALILA','LA MOLINA','896754652','ecalero@peru.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 8,'KAREN FUENTES','San Isidro','555-5555','KAFUENTES@HOTMAIL.COM');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES( 9,'Yamina Ruiz','San Isidro','965-4521','yami_ruiz@gmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES(10,'MARIA EULALIA VELASQUEZ TORVISCO','SURCO','6573456','mvelasques@gmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES(11,'FIORELLA LIZET VITELLA REYES','SAN BORJA','5468790','fvitela@outlook.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES(12,'JOSELIN DEL PILAR AVALOS QUISPE','SURCO','956325897','javalos@gmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES(13,'JOEL BENJAMIN CHECA SIANCAS','MIRAFLORES','905623657','jcheca@outlook.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES(14,'GUSTAVO ALONSO MONDRAGON TENORIO','SAN ISIDRO','978547123','gmondragon@gmail.com');

INSERT INTO ALUMNO (alu_id, alu_nombre, alu_direccion, alu_telefono, alu_email )
VALUES(15,'MARIELA LIZETH PARIONA APARI','CHORRILLOS','99654123','mpariona@outlook.com');

COMMIT;


-- ======================================================
-- RESTRICCIONES DE LA TABLA CURSO
-- ======================================================

-- CLAVE PRIMARIA

ALTER TABLE CURSO
	ADD CONSTRAINT pk_curso 
	PRIMARY KEY (cur_id);


-- El nombre del curso es �nico

ALTER TABLE CURSO
	ADD CONSTRAINT u_curso_nombre 
	UNIQUE (cur_nombre);


-- Vacantes mayor que cero

ALTER TABLE CURSO
	ADD CONSTRAINT  chk_curso_vacantes
	CHECK  ( cur_vacantes > 0 ); 


-- Matriculados mayor o igual que cero, y menor o igual que las vacantes

ALTER TABLE CURSO
	ADD CONSTRAINT  chk_curso_matriculados
	CHECK  ( cur_matriculados >= 0 AND cur_matriculados <= cur_vacantes ) ;


-- Precio mayor que cero
ALTER TABLE CURSO
	ADD CONSTRAINT  chk_curso_precio
	CHECK  ( cur_precio > 0 );



-- Matriculados por defecto es CERO

ALTER TABLE CURSO
  MODIFY cur_matriculados default 0;


-- ======================================================
-- DATOS DE LA TABLA CURSO
-- ======================================================

INSERT INTO CURSO(CUR_ID,CUR_NOMBRE,CUR_VACANTES,CUR_PRECIO,CUR_PROFESOR)
VALUES(1,'SQL Server Implementaci�n',24,1000.0,'Gustavo coronel');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(2,'SQL Server Administraci�n',24,1000.0,' ');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(3,'Inteligencia de Negocios',24,1500.0,'Sergio Matsukawa');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(4,'Programaci�n Transact-SQL',24,1200.0,NULL);

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(5,'Java Fundamentos',24,1600.0,'Gustavo Coronel');

INSERT INTO CURSO(cur_id,cur_nombre,cur_vacantes,cur_precio,cur_profesor)
VALUES(6,'Java Cliente-Servidor',24,1600.0,'Gustavo Coronel');

INSERT INTO CURSO(CUR_ID,CUR_NOMBRE,CUR_VACANTES,CUR_PRECIO,CUR_PROFESOR)
VALUES(7,'GESTION DE PROYECTOS',24,2200.0,'RICARDO MARCELO');

INSERT INTO CURSO(CUR_ID,CUR_NOMBRE,CUR_VACANTES,CUR_PRECIO,CUR_PROFESOR)
VALUES(8,'ORACLE DATABASE SQL',24,2600.0,'GUSTAVO CORONEL');

INSERT INTO CURSO(CUR_ID,CUR_NOMBRE,CUR_VACANTES,CUR_PRECIO,CUR_PROFESOR)
VALUES(9,'ORACLE DATABASE PL-SQL',24,2600.0,'GUSTAVO CORONEL');

COMMIT;


-- ======================================================
-- RESTRICCIONES DE LA TABLA MATRICULA
-- ======================================================

ALTER TABLE MATRICULA
	ADD CONSTRAINT PK_MATRICULA 
	PRIMARY KEY (cur_id,alu_id);


ALTER TABLE MATRICULA
	ADD CONSTRAINT FK_MATRICULA_CURSO 
	FOREIGN KEY (cur_id) 
	REFERENCES CURSO(cur_id);


ALTER TABLE MATRICULA
	ADD CONSTRAINT FK_MATRICULA_ALUMNO 
	FOREIGN KEY (alu_id) 
	REFERENCES ALUMNO(alu_id);


ALTER TABLE MATRICULA
	ADD CONSTRAINT  CHK_MATRICULA_PRECIO
	CHECK  ( MAT_PRECIO > 0.0 );


ALTER TABLE MATRICULA
	ADD CONSTRAINT  CHK_MATRICULA_CUOTAS
	CHECK  ( MAT_CUOTAS > 0 );


ALTER TABLE MATRICULA
	ADD CONSTRAINT  CHK_MATRICULA_NOTA
	CHECK  ( (MAT_NOTA = NULL) OR (MAT_NOTA BETWEEN 0 AND 20) );


-- ======================================================
-- DATOS DE LA TABLA MATRICULA
-- ======================================================


DECLARE 

   fecha DATE;
   
BEGIN

  fecha :=  sysdate;

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(1, 5, fecha - 20, 800.0, 1, 15);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(1, 3, fecha - 20, 1000.0, 2, 18);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(1, 4, fecha - 19, 1200.0, 3, 12);
  
  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(1, 8, fecha - 19, 1200.0, 3, null);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(2, 1,fecha - 21,800.0,1,16);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(2, 2, fecha - 21,1000.0,2,10);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(2, 3, fecha - 18, 1300.0, 3, 14);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(2, 4, fecha - 18, 400.0, 1, 18);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(2, 5, fecha - 16, 750.0, 1, null);

  INSERT INTO MATRICULA ( cur_id, alu_id, mat_fecha, mat_precio, mat_cuotas, mat_nota ) 
  VALUES(3, 7, fecha - 10, 950.0, 2, null);

END;
/

COMMIT;

-- ======================================================
-- Actualizar la columna matriculados en la tabla curso
-- ======================================================

UPDATE CURSO
SET cur_matriculados = (
	SELECT COUNT(*) FROM MATRICULA
	WHERE MATRICULA.cur_id = CURSO.cur_id );

COMMIT;	

-- ======================================================
-- RESTRICCIONES EN LA TABLA PAGO
-- ======================================================

-- Clave Primaria

ALTER TABLE PAGO
	ADD CONSTRAINT PK_PAGO 
	PRIMARY KEY (cur_id,alu_id,pag_cuota);


-- Clave For�nea

ALTER TABLE PAGO
	ADD CONSTRAINT FK_PAGO_MATRICULA 
	FOREIGN KEY (cur_id,alu_id) 
	REFERENCES MATRICULA(cur_id,alu_id);



-- ======================================================
-- DATOS EN LA TABLA PAGO
-- ======================================================


DECLARE 

   fecha DATE;
   
BEGIN

  fecha :=  sysdate;
  
  insert into PAGO values(1,3,1,fecha-20,500);
  insert into PAGO values(1,3,2,fecha-10,500);
  insert into PAGO values(1,4,1,fecha-19,400);
  insert into PAGO values(1,4,2,fecha-9,400);
  insert into PAGO values(2,1,1,fecha-21,800);
  insert into PAGO values(2,2,1,fecha-20,500);
  insert into PAGO values(2,3,1,fecha-18,430);
  insert into PAGO values(2,3,2,fecha-10,430);
  insert into PAGO values(2,4,1,fecha-18,400);
  insert into PAGO values(2,5,1,fecha-16,750);

END;
/

COMMIT;


-- ======================================================
-- FIN
-- ======================================================

-- Formatenado la salida

set pagesize 1000
set linesize 600

column cur_id format 99999
column cur_nombre format a32
column cur_profesor format a20
column cur_precio format 99,999.00

column alu_id format 99999
column alu_nombre format a35
column alu_direccion format a15
column alu_telefono format a15
column alu_email format a25

column mat_precio format 99,999.00
column pag_importe format 99,999.00

-- Consultando las tablas

select * from ALUMNO;
select * from CURSO;
select * from MATRICULA;
select * from PAGO;

