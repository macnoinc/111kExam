package Carga_alumnos;
use DBI;
use Data::Dumper;

my $data_source = "DBI:mysql:Colegio";

my $dbh = DBI->connect($data_source, 'user111m', '') or die DBI::errstr;

sub new{
    my $self = shift;
    my $documento = shift;
    my $nombre = shift;
    my $apellido = shift;
    my $amonestaciones = shift;
    my $promedio = shift;

    my $this={
        documento=> $documento,
        nombre=> $nombre,
        apellido=> $apellido,
        amonestaciones=> $amonestaciones,
        promedio=> $promedio
       };

    return bless($this, $self);
}
sub get_set_documento{
    my $self =shift;
    my $documento = shift;

    if($documento){
        $self{documento}=$documento;
    }
    
    return $self->{documento};
}

sub get_set_nombre{
    my $self =shift;
    my $nombre = shift;

    if($nombre){
        $self{nombre}=$nombre;
    }

    return $self->{nombre};
}
sub get_set_apellido{
    my $self =shift;
    my $apellido = shift;

    if($apellido){
        $self{apellido}=$apellido;
    }
    
    return $self->{apellido};
}
sub get_set_amonestaciones{
    my $self =shift;
    my $amonestaciones = shift;

    if($amonestaciones){
        $self{amonestaciones}=$amonestaciones;
    }
    
    return $self->{amonestaciones};
}
sub get_set_promedio{
    my $self =shift;
    my $promedio = shift;

    if($promedio){
        $self{promedio}=$promedio;
    }
    
    return $self->{promedio};
}

sub insert_alumno{
    my $self = shift;
    my $documento = $self->{documento};
    my $nombre = $self->{nombre};
    my $apellido = $self->{apellido};
    my $amonestaciones = $self->{amonestaciones};
    my $promedio = $self->{promedio};

    my $sql= "INSERT INTO Alumnos
              (documento, nombre, apellido, amonestaciones, promedio)
              VALUES (?, ?, ?, ?, ?)";
    
    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute($documento,$nombre,$apellido,$amonestaciones,$promedio) or die $dbh->errstr;
}

sub select_alumno{
    my $documento = shift;
        
    my $sql = "select * from Alumnos WHERE documento = ?";

    my $sth = $dbh->prepare($sql) || die "Error: no se encuentra nombre la base de datos" . $dbh->errstr . "\n";     
    $sth->execute($documento) ||  die "Error: no se puede ejecutar este comando" . $sth->errstr . "\n";
    
    my @row = $sth->fetchrow_array;
           
    my $datos_alumno = Carga_alumnos->new($row[0],$row[1],$row[2],$row[3],$row[4]);
    
    return $datos_alumno;

}

sub carga_amonestaciones{
    my $self = shift;
    my $amonestaciones = shift;
    my $documento = $self->{documento};

    print Dumper($amonestaciones);

    my $sql = "UPDATE Alumnos
               SET amonestaciones = (amonestaciones + ?)
               WHERE documento = ?";

    my $sth = $dbh->prepare($sql) or die $dbh->errstr;

    $sth->execute($amonestaciones, $documento) or die $dbh->errstr;


    }





























1;



