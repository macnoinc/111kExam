package Matter;
use DBI;
use strict;
use Data::Dumper;

my $dsn = "DBI:mysql:appColegio";
my $user = "user111m"; 
my $password = "";
my $dbh = DBI->connect($dsn,$user,$password);



sub new{

	my $self = shift;
	my $name = shift;
	
	my $this = {

		name => $name

	};

	return bless($this, $self);
}

sub name {
	my $self = shift;
	return $self -> {name};
}

sub save_data{

	my $self = shift;
	my $name = $self->{name}; 
	my $sql = "insert into matters (name,student_fk) value ('$name');";
	my $sth = $dbh -> prepare($sql);
	$sth -> execute();

}



sub select_all_matters{

	my @matters = ();
	my $sql = "select * from matters";
	my $sth = $dbh -> prepare($sql);
	$sth->execute();
	
	while(my $row = $sth -> fetchrow_hashref){ 
		push (@matters, Matter->new($row->{name}));
	}

	return @matters;

}
sub update_note{
	my $self = shift;
	my $note = shift;
	my $sql = "update matters set note = '$self->{note}' where dni like '$self->{id}';";
	my $sth = $dbh -> prepare($sql);
	$sth -> execute();
}