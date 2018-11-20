package Alumno;
use strict;
use DBI;
use Data::Dumper;
use Materia;

my $dbh = DBI->connect("DBI:mysql:curso", "user111m", "");

sub new{
	my $self = shift;
	my $id = shift;
	my $nombre_alumno = shift;
	my $apellido_alumno = shift;
	my $promedia_general = shift;
	my $amonestaciones = shift;

	my $this = {
		id =>$id,
		nombre_alumno => $nombre_alumno,
		apellido_alunno => $apellido_alumno,
		promedia_general => $promedia_general,
		amonestaciones => $amonestaciones,
	};

	return bless($this,$self);
}
	

sub add_alumno {
    my $self = shift;    
   my $sql= "INSERT  INTO  alumnos(nombre_alumno, apellido_alumno, promedia_general, amonestaciones)  VALUES (?,?,?,?)";
	my $sth = $dbh->prepare($sql);
    $sth->execute($self->{nombre_alumno}, $self->{apellido_alumno}, $self->{promedia_general}, $self->{amonestaciones})
}

#sub modificar_alumnos{
#	my $self = shift;
#	my $sql = "U"
#}
#intento por obtener el id para la relacion de las table obiamente no logrado
sub ontener_id{
	my $self= shift;
	my $sql = "SELECT * form alumnos";
	my $sth = $dbh->prepare($sql);
	$sth -> execute();
	my $row = $sth->fetchrow_hashref;

    return ($row->{id});


}

sub nombre_alumno {
	my $self = shift;
    my $nombre_alumno = shift;
    if($nombre_alumno){
    	$self->{nombre_alumno} = $nombre_alumno;
    }
    return $self->{nombre_alumno};
}

sub apellido_alumno {
	my $self = shift;
    my $apellido_alumno = shift;
    if($apellido_alumno){
    	$self->{apellido_alumno} = $apellido_alumno;
    }
    return $self->{apellido_alumno};
}

sub promedia_general {
	my $self = shift;
	my $promedia_general = shift;
	if ($promedia_general){
		$self->{promedia_general} = $promedia_general;
	}
	return $self->{promedia_general};
}

sub amonestaciones {
	my $self = shift;
	my $amonestaciones = shift;
	if($amonestaciones){
		$self->{amonestaciones} = $amonestaciones;
	}
	return $self->{amonestaciones};
}

1;
