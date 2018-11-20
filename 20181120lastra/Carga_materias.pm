package Carga_materias;
use Carga_alumnos;
use DBI;
use Data::Dumper;

my $data_source = "DBI:mysql:Colegio";

my $dbh = DBI->connect($data_source, 'user111m', '') or die DBI::errstr;

sub new{
    my $self = shift;
    my $materia = shift;
    my $documento_alumno = shift;
    my $nota_alumno = shift;
    

    my $this={
        materia=> $materia,
        documento_alumno=> $documento_alumno,
        nota_alumno=> $nota_alumno,
        
       };

    return bless($this, $self);
}
sub get_set_materia{
    my $self =shift;
    my $materia = shift;

    if($materia){
        $self{materia}=$materia;
    }
    
    return $self->{materia};
}

sub get_set_documento_alumno{
    my $self =shift;
    my $documento_alumno = shift;

    if($documento_alumno){
        $self{documento_alumno}=$documento_alumno;
    }

    return $self->{documento_alumno};
}
sub get_set_nota_alumno{
    my $self =shift;
    my $nota_alumno = shift;

    if($nota_alumno){
        $self{nota_alumno}=$nota_alumno;
    }
    
    return $self->{nota_alumno};
}


sub insert_materia{
    my $self = shift;
    my $materia = $self->{materia};
    my $documento_alumno = $self->{documento_alumno};
    my $nota_alumno = $self ->{nota_alumno};

        
    my $sql= "INSERT INTO Materias
              (materia, documento_alumno, nota_alumno)
              VALUES ( ? ,?, ?)";
    
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute($materia, $documento_alumno, $nota_alumno) or die $dbh->errstr;
}

sub select_materia{
    my $materia = shift;
        
    my $sql = "select * from Materias WHERE materia = ?";

    my $sth = $dbh->prepare($sql) || die "Error: no se encuentra nombre la base de datos" . $dbh->errstr . "\n";     
    $sth->execute($materia) ||  die "Error: no se puede ejecutar este comando" . $sth->errstr . "\n";
    
    my @row = $sth->fetchrow_array;
           
    my $datos_materia = insert_materia->new($row[0],$row[1],$row[2]);
    
    return $datos_materia;




#NO PUDE HACER FUNCIONAR ESTA QUERY, PERDI MUCHO TIEMPO EN ESTO NO ENCUENTRO EL ERROR
sub creates_materia{
    my $self = shift;
    my $materia = $self->{materia};
    
    print Dumper($materia);
    
    my $sql= "CREATE TABLE ? (documento_alumno int(1),nota_alumno tinyint(1);";
                
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute($materia) or die $dbh->errstr;
}























1;



