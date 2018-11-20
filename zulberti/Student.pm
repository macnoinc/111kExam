
package Student;
use DBI;
use strict;
use Data::Dumper;

my $dsn = "DBI:mysql:appColegio";
my $user = "user111m"; 
my $password = "";
my $dbh = DBI->connect($dsn,$user,$password);



sub new{

	my $self = shift;
	my $first_name = shift;
	my $last_name = shift;
	my $amonestaciones = shift;
	my $id = shift;

	my $this = {

		first_name => $first_name,
		last_name => $last_name,
		amonestaciones => $amonestaciones,
		id => $id

	};

	return bless($this, $self);
}


sub first_name { #getter and setter

	my $self=shift;
	my $first_name = shift;

	if($first_name){

		$self->{first_name} = $first_name;

	}

	return $self->{first_name};

}
sub last_name { #getter and setter

	my $self=shift;
	my $last_name = shift;

	if($last_name){

		$self->{last_name} = $last_name;

	}

	return $self->{last_name};

}
sub amonestaciones { #getter and setter

	my $self=shift;
	my $amonestaciones = shift;

	if($amonestaciones){

		$self->{amonestaciones} = $amonestaciones;

	}

	return $self->{amonestaciones};

}


sub select_student_by_id{

	my $id= shift;
	my $sql = "select * from students where id like '$id';";
	my $sth = $dbh -> prepare($sql);
	$sth->execute();
	my $row = $sth -> fetchrow_hashref;
	my $student = Student->new($row->{first_name},$row->{last_name},$row->{amonestaciones},$row->{id});
	return $student;

}

sub select_all_students{

	my $self = shift;
	my @students = ();
	my $sql = "select * from students";
	my $sth = $dbh -> prepare($sql);
	$sth->execute();

	
	while(my $row = $sth->fetchrow_hashref){ 
		push (@students, Student->new($row->{first_name},$row->{last_name},$row->{amonestaciones},$row->{id}));
	}


	return @students;

}

# ----------- SAVE DATA ---------------------

sub save_data{

	my $self = shift;
	my $first_name = $self->{first_name};
	my $last_name = $self->{last_name};
	my $amonestaciones = $self->{amonestaciones};
	my $id = $self->{id};
	print Dumper($self);
	my $sql = "insert into students (first_name,last_name,amonestaciones,id) values ('$first_name','$last_name','$amonestaciones','$id');";
	my $sth = $dbh -> prepare($sql);
	$sth -> execute();

}

# ------------ SET DATA STUDENT -------------


sub update_amonestaciones{
	my $self = shift;
	my $sql = "update student set amonestaciones = '$self->{amonestaciones}' where id like '$self->{id}';";
	my $sth = $dbh -> prepare($sql);
	$sth -> execute();
}
sub amonestacion{
	my $self = shift;
	$self-> {amonestaciones} = $self-> {amonestaciones} +1;

}

sub get_prom{

	my $self = shift;
	my $id = $self->{id};
	my $sql = "select sum(note) from matters where student_fk like '$id';";
	my $sth = $dbh -> prepare($sql);
	$sth -> execute();
	my $notas = $sth -> fetchrow_hashref;
	my $sql2 = "select count(name) from matters where student_fk like '$id';";
	my $sth2 = $dbh -> prepare($sql);
	$sth2 -> execute();
	my $materias = $sth2 -> fetchrow_hashref;
	my $prom = $notas/$materias;
	
	return $prom;

}



1;