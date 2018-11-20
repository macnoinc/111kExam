
package materias;
use strict;
use DBI;

my $dbh=DBI->connect("DBI:mysql:school", 'user111m', '') or die $DBI::errstr;

sub new{
	my $self=shift;
	my $alumno= shift;
	my $name=shift;
	my $note=shift;
	my $active=shift;

	my $this={
		alumno=>$alumno,
		name=>$name,
		note=>$note,
		active=>$active,

	};

	return bless ($this,$self);
}


sub alumno{
	my $self= shift;
	my $alumno=shift;
		if($alumno){
			$self->{alumno}=$alumno;
		}
		return $self->{alumno};
}

sub name{
	my $self= shift;
	my $alumno=shift;
		if($alumno){
			$self->{alumno}=$alumno;
		}
		return $self->{alumno};
}

sub note{
	my $self= shift;
	my $note=shift;
		if($note){
			$self->{note}=$note;
		}
		return $self->{note};
}

sub active{
	my $self= shift;
	my $active=shift;
		if($active){
			$self->{active}=$active;
		}
		return $self->{active};
}




sub save_materias{
	my $self=shift;
	my @materias=();
	my $alumno=$self->{alumno};
	my $name=$self->{name};
	my $note=$self->{note};
	my $active=$self->{active};
	
	my $sth= $dbh->prepare("insert into subject (alumno, name, note, active) values ($alumno,$name,$note,$active)");
	$sth->execute($alumno,$name,$note,$active);


	while (my $row=$sth->fetchrow_array()){
		my $materia=Materias->new ($row->{alumno},$row->{name},$row->{note}, $row->{active});
		push (@materias, materia); 
	}

	print "done\n";
}


sub list_materias{
 
 
 my $self=shift;
 my @all_materias=();
 
  my $sql = "SELECT *
             FROM subject";
  
  my $sth = $dbh->prepare($sql);
  $sth->execute();
 
  while(my $row = $sth->fetchrow_array()){
      my $materia = Materias->new($row->{alumno},$row->{name},$row->{note},$row->{active});
     push (@all_materias, $materia);

  } 

 return @all_materias;

}






sub modify_something_subject{

my $self=shift;

	print " write new note \n";

	my $new_note=<STDIN>;

	print "change active\n";

	my $new_active=<STDIN>;
	
			my $sql= "UPDATE subject
				SET 
    			note = $new_note
    			active= $new_active
				WHERE
    			name= $self->{name}";

			my $sth = $dbh->prepare($sql);
 
 			$sth->execute();

 			 
}



sub delete_materia{

my $self=shift;
	my $sql= "DELETE FROM subject WHERE name=$self";
	my $sth = $dbh->prepare($sql);
 
 	$sth->execute();


	print "the subject was deleted\n";


}


sub load_note{
	
}









1;