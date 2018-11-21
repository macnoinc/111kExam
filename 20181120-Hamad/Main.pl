#!/usr/bin/perl
use lib '/home/user111m/111kExam/20181120-Hamad';
use Alumnos;
use Materias;
use Alumnos_Materias;
use strict;

my $alum = Alumnos->new();
my $subject = Materias->new();
my $alum_subject = Alumnos_Materias->new();
my $op;
menu();


sub menu {


	print "Bienvenido\n";
	do {

		sleep 2;
		print "\nSeleccione lo que desea hacer\n";

		print "\n[1] Agregar estudiante\n";
		print "\n[2] Agregar materia\n";
		print "\n[3] Víncular estudiante con materia\n";
		print "\n[4] Agregar nota a estudiante\n";
		print "\n[5] Agregar amonestación a estudiante\n";
		print "\n[6] Informes\n";
		print "\n[0] Salir";
		print "\n";

		$op = <STDIN>;
		chomp $op;
		if ($op == 1) {
			add_student();
		}elsif ($op == 2){
			add_subject();
		}elsif ($op == 3){
			student_subject();
		}elsif ($op == 4){
			add_grade();
		}elsif ($op ==5){
			add_amonestacion();
		}elsif ($op == 6){
			informes();
		}elsif ($op == 0){
			print "Adios!";
			sleep 2;
		}else{
			print "Opción incorrecta";
		}
	}while ($op != 0)
}

sub add_student {
	print "Agregar alumno\n";
	print "\n\tnombre:";
	my $name = <STDIN>;
	print "\n\tapellido:";
	my $surname = <STDIN>;

	chomp($name);
	chomp($surname);

	$alum->add($name,$surname);
}

sub add_subject {
	print "Agrega una materia\n";
	print "\n\tnombre:";
	my $name = <STDIN>;
	chomp($name);
	$subject->add($name);
}

sub student_subject {
	print "Vincula un alumno y una asignatura\n";
	
	my $stud_id = get_stud_id();
	my $subject_id = get_subject_id();
	$alum_subject->add($stud_id, $subject_id);
}

sub get_stud_id {
	print "\n\tIngresa nombre del alumno: ";
	my $stud_name = <STDIN>;
	chomp($stud_name);
	print "\n\t Ingresa apellido del alumno: ";
	my $stud_surname = <STDIN>;
	chomp($stud_surname);

	return $alum->get_id($stud_name,$stud_surname);

}

sub get_subject_id {
	print "\n\tIngresa el nombre de la materia: ";
	my $subject_name = <STDIN>;
	chomp($subject_name);

	return $subject->get_id($subject_name);

}

sub add_grade {
	print "Agregar nota a alumno\n";

	my $stud_id = get_stud_id();
	my $subject_id = get_subject_id();

	print "\n\tIngresa la nota obtenida: ";
	my $grade = <STDIN>;
	chomp($grade);

	$alum_subject->add_grade($stud_id, $subject_id, $grade);
}

sub add_amonestacion {
	print "Agregar una amonestación\n";
	my $stud_id = get_stud_id();

	print "\n\tIngresa cantidad de amonestaciones: ";
	my $amonestaciones = <STDIN>;
	chomp($amonestaciones);

	$alum->add_amonestacion($stud_id, $amonestaciones);
}









sub informes {
	print "Informes:\n";
	print "-------------------------------\n";
	print "\n\t[0] Para ver todos";
	print "\n\t[1] Para ver promovidos";
	print "\n\t[2] Para ver no promovidos\n";
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
	my $listado = $alum->get_listado();
	my $data;
	my $prom_data;
	my $subject_data;

	print "\nPromovidos\n\n";
	foreach my $id (keys %{$listado}) {
		$subject_data = $alum_subject->get_ind_data($id);
		$prom_data = $alum_subject->get_individual_prom($id);


		if (($prom_data->{$id}->{prom} / $prom_data->{$id}->{numb_subjects}) >= (15/2) && $alum->get_amonestaciones($id)<25) {

			print $listado->{$id}->{name} . " " . $listado->{$id}->{surname};
			print "\n--------------------\n";

			foreach my $id_sub (%{$subject_data}) {
				print $subject->get_name($subject_data->{$id_sub}->{subject_id});
				print ": " . $subject_data->{$id_sub}->{grade} . "\n";
			}

			print "\t + Promedio general: " . ($prom_data->{$id}->{prom} / $prom_data->{$id}->{numb_subjects}) . "\n";
			print "\t + Amonestaciones: " . $alum->get_amonestaciones($id) . "\n";
		}
	}
}

sub show_no_promovidos {
	my $listado = $alum->get_listado();
	my $data;
	my $prom_data;
	my $subject_data;

	print "\nNo promovidos\n\n";
	foreach my $id (keys %{$listado}) {
		$subject_data = $alum_subject->get_ind_data($id);
		$prom_data = $alum_subject->get_individual_prom($id);


		if (($prom_data->{$id}->{prom} / $prom_data->{$id}->{numb_subjects}) < (15/2) || $alum->get_amonestaciones($id)>25) {

			print $listado->{$id}->{name} . " " . $listado->{$id}->{surname};
			print "\n--------------------\n";

			foreach my $id_sub (%{$subject_data}) {
				print $subject->get_name($subject_data->{$id_sub}->{subject_id});
				print ": " . $subject_data->{$id_sub}->{grade} . "\n";
			}

			print "\t + Promedio general: " . ($prom_data->{$id}->{prom} / $prom_data->{$id}->{numb_subjects}) . "\n";
			print "\t + Amonestaciones: " . $alum->get_amonestaciones($id) . "\n";
		}
	}
}


sub show_promedio {
	my $listado = $alum->get_listado();
	my $data;
	my $prom_data;
	my $subject_data;


	print "\nInforme de todos los alumnos\n\n";
	foreach my $id (keys %{$listado}) {
		$subject_data = $alum_subject->get_ind_data($id);
		$prom_data = $alum_subject->get_individual_prom($id);


		print $listado->{$id}->{name} . " " . $listado->{$id}->{surname};
		print "\n--------------------\n";

		foreach my $id_sub (%{$subject_data}) {
			print $subject->get_name($subject_data->{$id_sub}->{subject_id}) . ": ";
			#print $subject->get_name($subject_data->{$id_sub}->{subject_id}) .": ". $subject_data->{$id_sub}->{grade} . "\n";
			print $subject_data->{$id_sub}->{grade} . "\n";
		}
		print "\t + Promedio general: " . ($prom_data->{$id}->{prom} / $prom_data->{$id}->{numb_subjects}) . "\n";
		print "\t + Amonestaciones: " . $alum->get_amonestaciones($id) . "\n";
	}
}
