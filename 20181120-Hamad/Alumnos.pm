package Alumnos;
use DBI;
use strict;

my $dbh = DBI->connect('DBI:mysql:school', 'user111m', '')

          or die $DBI::errstr;

sub new {
      my ($class, $name, $surname) = @_;
      my $self = {};
      if ($name, $surname){
      	$self = {
      		name => $name,
      		surname => $surname
      	};
      }

      bless $self, $class;
      return $self;
}

sub add {
	my ($self, $name, $surname) = @_;
	my $response = $dbh->prepare("insert into students (name, surname, amonestaciones) values (?,?,?)")          or die $dbh->errstr;
	$response->execute($name, $surname, 0) or die $dbh->errstr;
}
sub remove {
	my $self = shift;
	my $id = shift;
	my $response = $dbh->prepare("delete from students where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
} 
sub modify {
	my $self = shift;
	my ($id, $name, $surname, $amonestaciones) = @_;
	my $response = $dbh->prepare("UPDATE students SET name = $name, surname = $surname, amonestaciones = $amonestaciones WHERE id = $id")          or die $dbh->errstr;
	$response->execute() or die $dbh->errstr;
}
sub get_id{
	my ($self, $name, $surname) = @_;
	my $response = $dbh->prepare("select id from students where name = ? and surname = ? ")          or die $dbh->errstr;
	$response->execute($name, $surname) or die $dbh->errstr;
	#return $response->fetchall_hashref('id');
	my $return = $response->fetchrow_hashref;
	return $return->{id};
}
sub add_amonestacion {
	my ($self, $id, $amonestaciones) = @_;
	my $response = $dbh->prepare("UPDATE students set amonestaciones = amonestaciones + ? where id=$id");
	$response->execute($amonestaciones);
}

sub get_amonestaciones {
	my $self = shift;	
	my $id = shift;
	my $response = $dbh->prepare("select amonestaciones from students where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
	my $return = $response->fetchrow_hashref;
	return $return->{amonestaciones};
}


#my $sth = $dbh->prepare(q{
#
#  INSERT INTO sales (product_code, qty, price) VALUES (?, ?, ?)
#
#}) or die $dbh->errstr;

sub get_listado {
	my $response = $dbh->prepare("select * from students")          or die $dbh->errstr;
	$response->execute() or die $dbh->errstr;
	return $response->fetchall_hashref('id');
}

sub informe {
	my $self = shift;	
	my $id = shift;
	my $response = $dbh->prepare("select name, surname, amonestaciones from students where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
	return $response->fetchrow_hashref;
}





































1;