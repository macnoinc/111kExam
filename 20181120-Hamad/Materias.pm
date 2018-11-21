package Materias;
use DBI;
use strict;

my $dbh = DBI->connect('DBI:mysql:school', 'user111m', '')

          or die $DBI::errstr;

sub new {
      my ($class, $name) = @_;
      my $self = {};
      if ($name){
      	$self = {
      		name => $name,
      	};
      }

      bless $self, $class;
      return $self;
  }

sub add {
	my ($self, $name) = @_;
	my $response = $dbh->prepare("insert into subjects (name) values (?)")          or die $dbh->errstr;
	$response->execute($name) or die $dbh->errstr;
}

sub remove {
	my $self = shift;	
	my $id = shift;
	my $response = $dbh->prepare("delete from subjects where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
}

sub modify {
	my ($self, $id, $name, $get_grades) = @_;
	my $response = $dbh->prepare("UPDATE subjects SET name VALUES (?)WHERE id = $id")          or die $dbh->errstr;
	$response->execute($name) or die $dbh->errstr;
}

 
sub get_id{
	my $self = shift;	
	my $name = shift;
	my $response = $dbh->prepare("select id from subjects where name = ?")          or die $dbh->errstr;
	$response->execute($name) or die $dbh->errstr;
	#return $response->fetchall_hashref('id');
	my $return = $response->fetchrow_hashref;
	return $return->{id};
}

sub get_listado {
	my $response = $dbh->prepare("select * from subjects")          or die $dbh->errstr;
	$response->execute() or die $dbh->errstr;
	return $response->fetchall_hashref('id');
}

sub get_name {
	my ($self, $id_subjects) = @_;	
	my $response = $dbh->prepare("select name from subjects where id = ?")          or die $dbh->errstr;
	$response->execute($id_subjects) or die $dbh->errstr;
	my $return = $response->fetchrow_hashref;

	return $return->{name};
}













































1;