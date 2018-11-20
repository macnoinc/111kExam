#!/usr/bin/perl

use Lid '/home/user111m/111kExam/victoria/vicky';
use strict;
use Data::Dumper;
use Alumnos;
use Materias;
use DBI;

print " welcome \n";
print " to work about students push 1\n";
print " to work about students push 2\n";
print "if you want to close the aplication push 3\n";
my $election=<STDIN>;

	if ($election==1){

	print "if you whant to add a new student push 1 \n";
	print "if you whant to delete one student push 2 \n";
	print "if you whant to modify one student push 3\n";
	print "if you want to add a new warning push 4 \n";
	print " if you want to load notes push 5 \n";
	print " if you want a list about all students push 6\n";
	print "if you want to an inform about each student push 7\n";
	my $second_election=<STDIN>;

		if ($second_election==1){
			print " insert name of student\n";
			my $name=<STDIN>;
			print " insert warning of student\n";
			my $warning=<STDIN>;
			print " insert name of student\n";
			my $active=<STDIN>;
			print " insert name of student\n";
			my @subject_name=_@;

          my $operation= Alumnos->save_alumnos($name, $warning,$active,@subject_name);
		}
# no llegue a poner el ingreso de cada dato para pasarlo como parametro a la funcion
		if ($second_election==2){
          my $operation= Alumnos->delete_alumno();
		}

		if ($second_election==3){
          my $operation= Alumnos->modify_something();
		}

		if ($second_election==4){
          my $operation= Alumnos->load_warning();
		}

		if ($second_election==5){
          my $operation= Alumnos->load_notes();
		}

		if ($second_election==6){
          my $operation= Alumnos->list_alumnos();
		}

		if ($second_election==7){
          my $operation= Alumnos->inform();
		}


	}

		if ($election==2){
			print "if you whant to add a new subject push 1\n";
			print "if you whant to delete one subject push 2\n";
			print "if you whant to modify one subject push 3\n";
			print " if you want a list about all subject push 4\n";
			my $third_election=<STDIN>;

			if ($third_election==1){

				print " insert name of student\n";
				my $name=<STDIN>;
				print " insert warning of student\n";
				my $warning=<STDIN>;
				print " insert name of student\n";
				my $active=<STDIN>;
				print " insert name of student\n";
				my @subject_name=_@;

          		my $operation2= Materias->save_materias($alumno,$name,$note,$active);
          	
			}
#no llegiue a poner que el usuario indique la materia a borrar, modificar, etc para pasarla por parametro a la funcion 
			
			if ($third_election==2){
				my $operation= Materias->delete_materia();
			}

			if ($third_election==3){
          	my $operation= Materias->modify_something_subject();
			}

			if ($third_election==4){
          	my $operation= Materias->list_materias();
			}

		}

			if ($election==3){
	
				exit;
			}






# cree una base de datos llamada school, y cree en ella dos tablas, alumnos: con (primary key id, name), warning, active, y (subject_name foreign key)
# y la tabla subject con ((primary key id), (foreign key alumno), note y active )
# no llegue a probarlo, y no pude terminarlo, me faltan algunos metodos, otrso que tienen consultas con inner join de ambas tablas


1;