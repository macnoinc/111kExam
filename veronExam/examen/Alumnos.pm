#!usr/bin/perl
package Alumnos;
use strict;
use DBI;
use Data::Dumper;


my $data_source = "DBI:mysql:examen";

my $dbh = DBI->connect($data_source, 'user111m', '') or die $DBI::errstr;

sub new{
	my $self = shift;
	my $id_alumno=shift;
	my $nombre =shift;
	my $apellido = shift;
	my $amonestacion = shift;

	my $this ={

		id_alumno => $id_alumno,
		nombre_alumno => $nombre,
		apellido_alumno => $apellido,
		amonestacion => $amonestacion

	};
	return bless($this,$self);
}


sub id_alumno{

	my $self = shift;
	my $id_alumno = shift;
	if($id_alumno){
		$self ->{id_alumno} = $id_alumno;
	}return $self ->{id_alumno};
}
sub nombre_alum{

	my $self = shift;
	my $nombre = shift;
	if($nombre){
		$self ->{nombre_alumno} = $nombre;
	}return $self ->{nombre_alumno};
}
sub apellido{

	my $self = shift;
	my $apellido = shift;
	if($apellido){
		$self ->{apellido_alumno} = $apellido;
	}return $self ->{apellido_alumno};
}
sub amonestacion{

	my $self = shift;
	my $amonestacion = shift;
	if($amonestacion){
		$self ->{amonestacion} = $amonestacion;
	}return $self ->{amonestacion};
}



sub mostrar_alumnos{
	my $self = shift;
	my @alumnos =();

	my $sth = $dbh->prepare("SELECT * FROM alumnos") || die "Error:" . $dbh->errstr . "\n";     
    $sth->execute ||  die "Error:" . $sth->errstr . "\n";

    print "ESTE ES EL LISTADO DE LOS ALUMNOS.\n";

    while ( my $row = $sth->fetchrow_hashref ) {
    	  my $alum = Alumnos -> new($row->{id_alumno},$row->{nombre_alumno},$row->{apellido_alumno}
    	  	,$row->{amonestacion});

    	  push (@alumnos,$alum);
    	}

    	return @alumnos;

	}






1;