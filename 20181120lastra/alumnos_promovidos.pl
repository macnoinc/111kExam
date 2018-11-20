use lib '/home/user111m/exam/111kExam/20181120lastra';
use Carga_alumnos;
use Carga_materias;
use Data::Dumper;





my $opcion = 1;
while ($opcion != 0){
    print "Welcome, please select an option \n";
    print "To add an student press 1 \n";
    print "To give amonestaciones an student press 2 \n";
    print "To modify an student press 3 \n";
    print "To add a matter press 4 \n";
    print "To delete an matter press 5 \n";
    print "To modify an matter press 6 \n";

    $opcion = <STDIN>;
    if ( $opcion > 4 || $opcion < 0) {

        print "You push a wrong number! \n";

    }
    if($opcion == 1){

        print "You are in section add student \n";
        print "please follow the instrcution bellow \n";

        print "insert first name ";
        $first_name = <STDIN>;
        $first_name = trim($first_name);
        print "insert last name ";
        $last_name = <STDIN>;
        $last_name = trim($last_name);
        print "insert document ";
        $document = <STDIN>;
        $document = trim($document);

        my $alum = Carga_alumnos::select_alumno($document);

        if (!$alum->get_set_documento){
            my $alumno = Carga_alumnos-> new($document,$first_name,$last_name,undef,undef);

            $alumno-> insert_alumno();
        }

    }
    if($opcion == 2){

        print "insert the document of the student for give amonestaciones \n";
        $document = <STDIN>;
        $document = trim($document);

        my $alum = Carga_alumnos::select_alumno($document);

        if ($alum->get_set_documento){

            print "cuantas amonestaciones quiere darle al alumno?";
            $amonestaciones = <STDIN>;
            $amonestaciones = trim($amonestaciones);
            print Dumper($amonestaciones);
            
            my $alum->carga_amonestaciones($amonestaciones);
        }

    }

    if($opcion == 4){

        print "You are in section add student \n";
        print "please follow the instrcution bellow \n";

        print "insert matter name ";
        $materia = <STDIN>;
        $materia = trim($materia);
        
        my $materia = Carga_materias::select_materia($materia);

        if (!$alum->get_set_materia){
            my $materia = Carga_materia-> new($materia,undef,undef);

            $materia-> insert_materia();
        }

    }



}




sub trim {
    my @args = @_;
    my $trim = $args[0];
    $trim =~ s/^\s+//g;
    $trim =~ s/\s+$//g;
    return $trim;
}


1;


