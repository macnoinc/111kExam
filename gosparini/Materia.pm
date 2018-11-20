package Materia;
use strict;
use DBI;
use Data::Dumper;
use Alumno;


my $dbh = DBI->connect("DBI:mysql:curso", "user111m", "");


sub new {
	my $self = shift;
	my $nombre_materia = shift;
	my $nota_alumno =shift;
	my $id_alumno= shift;

	my $this ={
		nombre_materia => $nombre_materia,
		nota_alumno => $nota_alumno, 
		id_alumno => $id_alumno,

	};

	return bless($this, $self);
}
sub add_materia {
    my $self = shift;
   my $sql= "INSERT  INTO materia(nombre_materia, nota_materia, id_alumno)  VALUES (?,?,?)";
	my $sth = $dbh->prepare($sql);
    $sth->execute($self->{nombre_materia}, $self->{nota_materia}, $self->{id_alumno})
}


sub nombre_materia {
	my $self = shift;
    my $nombre_materia = shift;
    if($nombre_materia){
    	$self->{nombre_materia} = $ nombre_materia;
    }
    return $self->{nombre_materia};
}

sub nota_alumno {
	my $self = shift;
    my $nota_alumno = shift;
    if($nota_alumno){
    	$self->{nota_alumno} = $nota_alumno;
    }
    return $self->{nota_alumno};
}

sub id_alumno {
    my $self = shift;
    my $id_alumno = shift;
    if ($id_alumno) {
    	$self->{id_alumno} = $id_alumno;
     }

    return $self->{id_alumno};
}



1;