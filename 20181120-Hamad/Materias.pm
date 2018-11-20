package materias;
use DBI;
use strict;

my $dbh = DBI->connect('DBI:mysql:school', 'user111m', '')

          or die $DBI::errstr;



sub add {
	my $name = shift;
	my $response = $dbh->prepare("insert into subjects (name) values (?)")          or die $dbh->errstr;
	$response->execute($name) or die $dbh->errstr;
}

sub remove {
	my $id = shift;
	my $response = $dbh->prepare("delete from subjects where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
}

sub modify {
	my ($id, name, $get_grades) = @_;
	my $response = $dbh->prepare("UPDATE students SET name, surname, amonestaciones	VALUES (?,?,?)WHERE id = $id");          or die $dbh->errstr;
	$response->execute($name, $surname, $amonestaciones) or die $dbh->errstr;
}

} 
sub get_id{
	my $name = shift;
	my $response = $dbh->prepare("select id from subjects where name = ?")          or die $dbh->errstr;
	$response->execute($name) or die $dbh->errstr;
	#return $response->fetchall_hashref('id');
	return $response->fetchrow_hashref;
}

sub get_listado {
	my $response = $dbh->prepare("select * from subjects")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
	return $response->fetchall_hashref('id');
}

sub get_name {
	my $id_subjects = shift;
	my $response = $dbh->prepare("select name from subjects where id = ?")          or die $dbh->errstr;
	$response->execute($id) or die $dbh->errstr;
	return $response->fetchrow_hashref;
}













































1;