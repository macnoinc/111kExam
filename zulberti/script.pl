#!/usr/bin/perl

use lib '/home/user111m/matias/111kExam/zulberti';
use Student;
use Matter;
use strict;
use Data::Dumper;




sub menu{

	my $selector = 1;

	while($selector != 0){
		print "MENU PRINCIPAL\n";
		
		print "Para crear un alumno ingrse: 1\n";
		print  "Imprimir lista de alumnos ingrese: 2\n";
		print "Imprimir lista de materias ingrese: 3\n";
		print "Para saber si el alumno pasa de curso: 4\n";	
		print "Para salir ingrese: 0\n";
		$selector=trim_input();


		if ($selector == 1){

			print "Ingrese nombre:\n";
			my $first_name = trim_input();
			print "Ingrese apellido:\n";
			my $last_name = trim_input();
			print "Ingrese dni:\n";
			my $dni = trim_input();
			my $amonestaciones = 0;
			create_stundent($first_name,$last_name,$amonestaciones,$dni);
			
		}
		elsif($selector == 2){

			print_students();

		}
		elsif($selector == 3){

			print_matters();

		}
		elsif($selector == 4){

			print "Ingrese el dni del alumno:\n";
			my $dni = trim_input();

			if (promedio($dni)>7.5){
				print "El alumno tiene un promedio de ". promedio($dni) . "pasa el curso.\n";
			}
			else{

				print "El alumno tiene un promedio de ". promedio($dni) . " no pasa de curso.\n"; 
			}

		}
	}
	
}
sub print_students{

	my @students = Student::select_all_students();

	print "ALUMNOS\n";
	foreach my $student (@students) {
		print "NOMBRE: ".$student -> first_name()."\n";
		print "APELLIDO: ".$student -> last_name()."\n";
		print "AMONESTACIONES: ".$student -> amonestaciones()."\n";

	}
}
sub print_matters{

	my @matters = Matter::select_all_matters();

	print "MATERIAS\n";
	foreach my $matter (@matters) {
	print $matter->name()."\n";
		
	}



}
sub create_stundent{

	my $first_name = shift;
	my $last_name = shift;
	my $amonestaciones = shift;
	my $dni = shift;

	my $new_student = Student -> new($first_name,$last_name,$amonestaciones,$dni);
	$new_student -> save_data();
}
sub create_matter{

	my $name = shift;
	my $new_matter = Matter->new($name);
	$new_matter->save_data();

}
sub add_note{

	my $dni = shift;
	my $note = shift;
	my $new_student = Student::select_student_by_id($dni);
	$new_student -> update_note();


}
sub promedio{
	my $dni = shift;
	my $new_student = Student::select_student_by_id($dni);
	return $new_student -> get_prom($dni);
}

sub add_amonestacion{
	my $dni = shift;
	my $new_student = Student::select_student_by_id($dni);
	$new_student -> amonestacion();
	$new_student -> update_amonestaciones();


}
sub trim_input{

	my $input = <STDIN>;
	$input =~ s/^\s+//;
	$input =~ s/\s+$//;


	return $input;
}

menu();

1;






__END__


# Esta es la creacion de la tabla materia en la base de datos
create table matters ( name varchar (15) not null primary key, note int (2), 
student_fk int(2), foreign key (student_fk) references students(id));

# Esta es la creacion de la tabla alumnos en la base de datos

create table students (  first_name varchar (15) not null, 
last_name varchar (15) not null, amonestaciones tinyint, id int (9) not null primary key);