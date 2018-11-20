#!/usr/bin/perl
use lib '/home/user111m/20181120-Hamad';
use Alumnos;
use Materias;
use Alumnos_Materias;
use strict;

print "AAAA";
menu();


sub menu {

	print "Bienvenido\n";
	print "\nSelecciona lo que desea hacer\n";
	add_student();

	print "\nBien!\n";
	add_subject();

	print "\nOtra más!\n";
	add_subject();

	print "\nCorrecto!\n";
	student_subject();

	print "\nAgrega la otra materia\n";
	student_subject();

	print "\nAgrega una nota al alumno\n";
	add_grade();

	print "\nAgrega una amonestación\n";
	add_amonestacion();

	print "\nInforme de alumno\n";
	informes();
}

sub add_student {
	print "Agregar alumno!\n";
	print "\n\tnombre:";
	my $name = <STDIN>;
	print "\n\tapellido:"
	my $surname = <STDIN>;

	chomp($name);
	chomp($surname);

	Alumnos::add($name,$surname);
}

sub add_subject {
	print "Agrega una materia\n";
	print "\n\tnombre:"
	my $name = <STDIN>;
	chomp($name);
	Materias::add($name);
}

sub student_subject {
	print "Vincula un alumno y una asignatura\n";
	
	my $stud_id = get_stud_id();
	my $subject_id = get_subject_id();
	Alumnos_Materias::add($stud_id, $subject_id);
}

sub get_stud_id {
	print "\n\tIngresa nombre del alumno";
	my $stud_name = <STDIN>;
	chomp($stud_name);
	print "\n\t Ingresa apellido del alumno";
	my $stud_surname = <STDIN>;
	chomp($stud_surname);

	return Alumnos::get_id($stud_name,$stud_surname);

}

sub get_subject_id {
	print "\n\tIngresa el nombre de la materia:";
	my $subject_name = <STDIN>;
	chomp($subject_name);

	return Materias::get_id($subject_name);

}

sub add_grade {
	print "Agregar nota a alumno\n";

	my $stud_id = get_stud_id();
	my $subject_id = get_subject_id();

	print "\n\tIngresa la nota obtenida";
	my $grade = <STDIN>;
	chomp($grade);

	Alumnos_Materias::add_grade($stud_id, $subject_id, $grade);
}

sub add_amonestacion {
	print "Agregar una amonestación\n";
	my $stud_id = get_stud_id();

	print "\n\tIngresa cantidad de amonestaciones";
	my $amonestaciones = <STDIN>;
	chomp($amonestaciones);

	Alumnos::add_amonestacion($stud_id, $amonestaciones);
}








sub show_promedio {
	my $listado = Alumnos::getlistado();
	my $data;
	my $prom_data;

	print "\nInforme de todos los alumnos\n";
	foreach my $id = (%{$listado}) {
		$subject_data = Alumnos_Materias::get_ind_data($id);
		$prom_data = Alumnos_Materias::get_individual_prom($id)

		print $listado->{$id}->{name} . " " . $listado->{$id}->{surname};
		print "\n--------------------\n";

		foreach my $id_sub (%{$subject_data}) {
			print Materias::get_name($subject_data->{$id}->{subject_id};
			print ": " . $subject_data->{$id}->{grade} . "\n";
		}
		print "\t + Promedio general: " . ($prom_data->{prom}/$prom_data->{numb_subjects}) . "\n";
		print "\t + Amonestaciones: " . Alumnos::get_amonestaciones($id) . "\n";
	}
}

sub informes {
	print "Informes:\n";
	print "-------------------------------\n";
	print "\n\t[0] Para ver todos";
	print "\n\t[1] Para ver promovidos";
	print "\n\t[2] Para ver no promovidos";
	my $op = <STDIN>;
	chomp($op);

	if ($op == 1) { #Promovidos
		show_promovidos();
	}elsif ($op == 2) { #No promovidos
		show_no_promovidos();
	}else { #Todos
		show_promedio();
	}
}

sub show_promovidos {
	my $listado = Alumnos::getlistado();
	my $data;
	my $prom_data;

	print "\nPromovidos\n";
	foreach my $id = (%{$listado}) {
		$subject_data = Alumnos_Materias::get_ind_data($id);
		$prom_data = Alumnos_Materias::get_individual_prom($id)


		if (($prom_data->{prom} / $prom_data->{numb_subjects}) >= (15/2) && Alumnos::get_amonestaciones($id)<25) {

			print $listado->{$id}->{name} . " " . $listado->{$id}->{surname};
			print "\n--------------------\n";

			foreach my $id_sub (%{$subject_data}) {
				print Materias::get_name($subject_data->{$id}->{subject_id};
				print ": " . $subject_data->{$id}->{grade} . "\n";
			}

			print "\t + Promedio general: " . ($prom_data->{prom} / $prom_data->{numb_subjects}) . "\n";
			print "\t + Amonestaciones: " . Alumnos::get_amonestaciones($id) . "\n";
		}
	}
}

sub show_no_promovidos {
	my $listado = Alumnos::getlistado();
	my $data;
	my $prom_data;

	print "\nNo promovidos\n";
	foreach my $id = (%{$listado}) {
		$subject_data = Alumnos_Materias::get_ind_data($id);
		$prom_data = Alumnos_Materias::get_individual_prom($id)


		if (($prom_data->{prom} / $prom_data->{numb_subjects}) < (15/2) || Alumnos::get_amonestaciones($id)>25) {

			print $listado->{$id}->{name} . " " . $listado->{$id}->{surname};
			print "\n--------------------\n";

			foreach my $id_sub (%{$subject_data}) {
				print Materias::get_name($subject_data->{$id}->{subject_id};
				print ": " . $subject_data->{$id}->{grade} . "\n";
			}

			print "\t + Promedio general: " . ($prom_data->{prom} / $prom_data->{numb_subjects}) . "\n";
			print "\t + Amonestaciones: " . Alumnos::get_amonestaciones($id) . "\n";
		}
	}
}
