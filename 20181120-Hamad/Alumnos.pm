package alumnos;
use DBI;
use strict;

my $dbh = DBI->connect('DBI:mysql:school', 'user111m', '')

          or die $DBI::errstr;

sub add {
	my ($name, $surname) = @_;
	my $response = $dbh->prepare("insert into students (name, surname) values (?,?)")          or die $dbh->errstr;
	$response->execute($name, $surname) or die $dbh->errstr;
}
sub remove {
	my $id = shift;
	my $response = $dbh->prepare("delete from students where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
} 
sub modify {
	my ($id, $name, $surname, $amonestaciones) = @_;
	my $response = $dbh->prepare("UPDATE students SET name = $name, surname = $surname, amonestaciones = $amonestaciones WHERE id = $id")          or die $dbh->errstr;
	$response->execute() or die $dbh->errstr;
}
sub get_id{
	my ($name, $surname) = @_;
	my $response = $dbh->prepare("select id from students where name = ? , surname = ?")          or die $dbh->errstr;
	$response->execute($name, $surname) or die $dbh->errstr;
	#return $response->fetchall_hashref('id');
	return $response->fetchrow_hashref;
}
sub add_amonestacion {
	my ($id, $amonestaciones) = @_;
	my $response = $dbh->prepare("UPDATE students set amonestaciones values (?) where id=$id");
	$response->execute($amonestaciones);
}

sub get_amonestaciones {
	my $id = shift;
	my $response = $dbh->prepare("select amonestaciones from students where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
	return $response->fetchrow_hashref;
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
	my $id = shift;
	my $response = $dbh->prepare("select name, surname, amonestaciones from students where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
	return $response->fetchrow_hashref;
}





































1;