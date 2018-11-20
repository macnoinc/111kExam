create database curso;
use curso;

create table alumnos (id INT(8) NOT NULL AUTO_INCREMENT, 
	                nombre_alumno VARCHAR (40) NOT NULL,
	                apellido_alumno VARCHAR (40) NOT NULL, 
	                promedia_general DOUBLE NOT NULL,
	                amonestaciones INT (8) NULL,
	                CONSTRAINT PK_alumno PRIMARY KEY (id));



 create table materias (id INT(8) NOT NULL AUTO_INCREMENT,
                       nombre_materia VARCHAR (40) NOT NULL,
                       nota_materia DECIMAL (2,2) NOT NULL,
                       id_alumno INT (8) NOT NULL,
                       CONSTRAINT PK_materia PRIMARY KEY (id));


ALTER TABLE materias ADD CONSTRAINT fk_id_alumno FOREIGN KEY (id_alumno) REFERENCES alumnos(id);

insert into alumnos (nombre_alumno , apellido_alumno , promedia_general , amonestaciones ) VALUES ('Gido' , 'Matos', 8.50, 0);

insert into alumnos (nombre_alumno , apellido_alumno , promedia_general , amonestaciones ) VALUES ('Mari' , 'Grieco', 9.50, 2);






