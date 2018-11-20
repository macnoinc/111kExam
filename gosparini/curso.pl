#!/urs/bin/perl
use lib '/home/user111m/gosparini/111kExam/gosparini';
use strict;
use DBI;
use Data::Dumper;
use Alumno;
use Materia;


my $nombre_alumno;
my $apellido_alumno;
my $promedia_general;
my $amonestaciones;
my $nombre_materia;
my $nota_alumno;
my $id_alumno;

my $corte = 1;

while ($corte != 0) {
	
	print "Bienvenidos \n";
	print "\n";

	print "Percione 1 si desea ingresar un alumno";
	print "\n";
    
    print "Precione 2 si desea modificar un alumno";
    print "\n";
    
    print "Precione 3 si  dar la baja de un alumno";
    print "\n";

    print "_______________________________________________________";
    print "\n";


    print "Percione 4 si desea ingresar un materia";
	print "\n";
    
    print "Precione 5 si desea modificar un materia";
    print "\n";
    
    print "Precione 6 si  dar la baja de un materia";
    print "\n";

    print "_______________________________________________________";
    print "\n";


    print "Precione  7 si desea carga amonestaciones a un alumno";
    print "\n";
     

    print "Precione  8 de desea carga nota a una materia";
    print "\n";

    my $opcion = <STDIN>;
    chomp($opcion);


 
if ($opcion == 1){
	
		print "Ingrese datos del alumno\n";
		print "\n";
		add_alumno();

			 
			
		}
if($opcion == 2) {
			
		print "Ingrese los datos del Alumno a modificar\n";
		print "\n";
		



		}
if ($opcion == 3){
			
		print "Ingrese el nombre de Alumno a dar de baja\n";
		print "\n";
		

					}
if ($opcion == 4){
			
		print "Ingrese datos de la materia\n";
		print "\n";
		add_materia();


}

if ($opcion == 5) {

	print "Modoficacion de datos de materia\n "
	

}
if ($opcion == 6) {

    print "Dar de baja Materia\n"
}

if ($opcion == 7) {

    print "Cargue amonestaciones a un alumno\n"
}

if ($opcion == 8) {

    print "Cargar nota \n"
}





if ($opcion == 0){
			
		print "Saliendo del sistema\n";
		print "\n";
		exit;
		}
}


sub add_alumno{	
	
	print "Ingrese el nombre del Alumno\n";
    $nombre_alumno = <STDIN>;
	chomp($nombre_alumno);
	print "________________\n";

	print "Ingrese el apellido del Alumno\n";  
    $apellido_alumno = <STDIN>;
    chomp($apellido_alumno);
    print "________________\n";

    print "Ingrese el promedio general del Alumno\n";
    $promedia_general =<STDIN>;
    chomp($promedia_general);
    print "________________\n";

    print "Ingrese cantidad de amonestaciones\n";
    $amonestaciones = <STDIN>;
    chomp($amonestaciones);
    print "________________\n";

   

   my $alumno = Alumno -> new($nombre_alumno,$apellido_alumno,$promedia_general,$amonestaciones);
   $alumno ->add_alumno();
   
   } 

sub add_materia{	
	
	print "Ingrese el nombre de la Materia\n";
    $nombre_materia = <STDIN>;
	chomp($nombre_materia);
	print "________________\n";

	print "Ingrese la nota de alumno\n";  
    $nota_alumno = <STDIN>;
    chomp($nota_alumno);
    print "________________\n";

    print "Ingrese el el numero de identificacion \n";
    $id_alumno =<STDIN>;
    chomp($id_alumno);
    print "________________\n";

    

   

   my $materia = Materi -> new($nombre_materia,$nota_alumno,$id_alumno);
   $materia ->add_materia();
   
   } 



1;