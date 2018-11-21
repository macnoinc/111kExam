package Alumnos_Materias;
use DBI;
use strict;

my $dbh = DBI->connect('DBI:mysql:school', 'user111m', '')

          or die $DBI::errstr;

sub new {
      my $class = shift;
      my $self = {};
      bless $self, $class;
      return $self;
}

sub add {
	my ($self, $id_student, $id_subject) = @_;
	my $response = $dbh->prepare("insert into students_subjects (student_id, subject_id) values (?,?)")          or die $dbh->errstr;
	$response->execute($id_student, $id_subject) or die $dbh->errstr;
}

sub add_grade {
	my ($self, $id_student, $id_subject, $grade) = @_;

	my $response = $dbh->prepare("UPDATE students_subjects SET grade = ? where student_id = $id_student and subject_id = $id_subject")          or die $dbh->errstr;
	$response->execute($grade) or die $dbh->errstr;
}

sub get_individual_prom {
	my $self = shift;	
	my $id_student = shift;
	my $response = $dbh->prepare("select student_id, SUM(grade) as prom, COUNT(subject_id) as numb_subjects from students_subjects where student_id = ?")          or die $dbh->errstr;
	$response->execute($id_student) or die $dbh->errstr;
	my $return = $response->fetchall_hashref('student_id');
	return $return;
}

sub get_ind_data {
	my $self = shift;	
	my $id_student = shift;
	my $response = $dbh->prepare("select id, subject_id, grade from students_subjects where student_id = ?")          or die $dbh->errstr;
	$response->execute($id_student) or die $dbh->errstr;

	return $response->fetchall_hashref('id');	
	
}








































1;