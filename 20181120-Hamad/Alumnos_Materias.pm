package Alumnos_Materias
use DBI;
use strict;

my $dbh = DBI->connect('DBI:mysql:school', 'user111m', '')

          or die $DBI::errstr;


sub add {
	my ($id_student, $id_subject) = @_;
	my $response = $dbh->prepare("insert into students_subjects (id_student, id_subject) values (?,?)")          or die $dbh->errstr;
	$response->execute($id_student, $id_subject) or die $dbh->errstr;
}

sub add_grade {
	my ($id_student, $id_subject, $grade) = @_;
	my $response = $dbh->prepare("insert into students_subjects (grade) values (?) where id_student = $id_student and id_subject = $id_subject")          or die $dbh->errstr;
	$response->execute($grade) or die $dbh->errstr;
}

sub get_individual_prom {
	my ($id_student) = shift;
	my $response = $dbh->prepare("select SUM(grade) as prom, COUNT(id_subject) as numb_subjects from students_subjects where id_student = $id_student")          or die $dbh->errstr;
	$response->execute($grade) or die $dbh->errstr;
	return $response->fetchall_hashref('id');
}

sub get_ind_data {
	my $id_student = shift;
	my $response = $dbh->prepare("select subject_id, grade from students_subjects where id_student = ?")          or die $dbh->errstr;
	$response->execute($id_student) or die $dbh->errstr;
	return $response->fetchall_hashref('id'); 	
}








































1;