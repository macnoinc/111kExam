#!usr/bin/perl
use lib '/home/user111m/juanveron/111k/111kExam/veronExam/examen';
use strict;
use Data::Dumper;
use Alumnos;
use Materias;

my $opcion = 1;
while ($opcion != 0){
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Bienvenidos al Registro Académico de Alumnos:\n";	
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Para ver un listado detallado de todos los alumnos pulse 1:\n";
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Para ver el listado completo de las materias pulse 2:\n";
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Para cargar amonestaciones a un alumno pulse 3:\n";
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Para cargar una nota a un alumno pulse 4:\n";
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Para pedir un informe detallado sobre un alumno pulse 5:\n";
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";
	print "Para salir del menú pulse 6:\n";
	print "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*\n";

		$opcion = <STDIN>;
		$opcion =trim($opcion);
    if ( $opcion > 6 ||  $opcion < 0) {


    	print "HA INGRESADO UN VALOR INVALIDO, INTENTE NUEVAMENTE\n";
		system("clear");


    }
    if($opcion == 1){

    	print traer_alumnos();

    }
    if($opcion == 2){

    	print traer_materias();


    }
    if($opcion == 3){

    	set_amonestacion();

    }
    if($opcion == 4){

    	set_nota();


    }
    if($opcion == 5){

    	print informe_alumno();


    }
    if($opcion == 6){

    	print "NOS VIMOS EN DISNEY!!!\n";


    }
    print "Adiós.\n";

}


sub trim {
    my @args = @_;
    my $trimm = $args[0];
    $trimm =~ s/^\s+//g;
    $trimm =~ s/\s+$//g;
    return $trimm;
}


sub traer_alumnos{

	my @alumnos = Alumnos::mostrar_alumnos();
	foreach my $alum (@alumnos) {
		print $alum->id_alumno()."\n";
		print $alum->nombre_alum()."\n";
		print $alum->apellido_alum()."\n";
		print $alum->amonestacion()."\n";
	}
		print dumper(@alumnos);
			print "\n";



}

sub traer_materias{

	my @materias = Materias::mostrar_materias();
	foreach my $matt (@materias) {
		print $matt->id_materia()."\n";
		print $matt->nombre_asignatura()."\n";
		print $matt->calificacion()."\n";
		
	}
		print dumper(@materias);
		print "\n";



}



















1;
