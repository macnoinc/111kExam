#!usr/bin/perl
package Materias;
use strict;
use DBI;
use Data::Dumper;
my $data_source = "DBI:mysql:examen";

my $dbh = DBI->connect($data_source, 'user111m', '') or die $DBI::errstr;



sub new{
	my $self = shift;
	my $id_materia=shift;
	my $nombre_asignatura =shift;
	my $calificacion = shift;
	

	my $this ={

		id_materia => $id_materia,
		nombre_asignatura => $nombre_asignatura,
		calificacion => $calificacion
		
	};
	return bless($this,$self);
}



sub id_materia{

	my $self = shift;
	my $id_materia = shift;
	if($id_materia){
		$self ->{id_materia} = $id_materia;
	}return $self ->{id_materia};
}
sub nombre_asignatura{

	my $self = shift;
	my $nombre_asignatura = shift;
	if($nombre_asignatura){
		$self ->{nombre_asignatura} = $nombre_asignatura;
	}return $self ->{nombre_asignatura};
}
sub calificacion{

	my $self = shift;
	my $calificacion = shift;
	if($calificacion){
		$self ->{calificacion} = $calificacion;
	}return $self ->{calificacion};
}

sub mostrar_materias{
	my $self = shift;
	my @materias =();

	my $sth = $dbh->prepare("SELECT * FROM materias") || die "Error:" . $dbh->errstr . "\n";     
    $sth->execute ||  die "Error:" . $sth->errstr . "\n";

    print "ESTE ES EL LISTADO DE LOS ALUMNOS.\n";

    while ( my $row = $sth->fetchrow_hashref ) {
    	  my $mat = Materias -> new($row->{id_materia},$row->{nombre_asignatura},$row->{calificacion});

    	  push (@materias,$mat);
    	}

    	return @materias;

	}




	1;