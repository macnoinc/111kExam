package alumnos;

use strict;
use DBI;

my $dbh=DBI->connect("DBI:mysql:school", 'user111m', '') or die $DBI::errstr;




sub new{
	my $self=shift;
	my $name= shift;
	my $warning=shift;
	my $active=shift;
	my @subject_name=shift;

	my $this={
		name=>$name,
		warning=>$warning,
		active=>$active,
		subject_name=>@subject_name,

	};

	return bless ($this,$self);
}



sub name{
	my $self= shift;
	my $name=shift;
		if($name){
			$self->{name}=$name;
		}
		return $self->{name};
}

sub warning{
	my $self= shift;
	my $warning=shift;
		if($warning){
			$self->{warning}=$warning;
		}
		return $self->{warning};
}

sub active{
	my $self= shift;
	my $active=shift;
		if($active){
			$self->{active}=$active;
		}
		return $self->{active};
}

sub subject_name{
	my $self= shift;
	my @subject_name=shift;
		if(@subject_name){
			$self->{subject_name}=$subject_name;
		}
		return $self->{subject_name};
}




sub save_alumnos{
	my $self=shift;
	my @alumnos=();
	my $name=$self->{name};
	my $warning=$self->{warning};
	my $active=$self->{active};
	my @subject_name->{subject_name};

	my $sth= $dbh->prepare("insert into alumnos(name, warning, active, subject_name) values ($name,$warning,$active,@subject_name)");
	$sth->execute($name,$warning,$active,@subject_name);

	while (my $row=$sth->fetchrow_array()){
		my $alumno=Alumno->new ($row->{name},$row->{warning},$row->{active}, $row->{subject_name});
		push (@alumnos, alumno); 
	}

	print "done\n";
}



sub list_alumnos{
 
 
 my $self=shift;
 my @all_alumnos=();
 
  my $sql = "SELECT *
             FROM alumnos";
  
  my $sth = $dbh->prepare($sql);
  $sth->execute();
 
  while(my $row = $sth->fetchrow_array()){
      my $alumno = Alumnos->new($row->{name},$row->{warning},$row->{active},$row->{subject_name});
     push (@all_alumnos, $alumno);

  } 

 return @all_alumnos;

}






sub modify_something{

my $self=shift;

	print " write new warning \n";

	my $new_warning=<STDIN>;

	print "change active\n";

	my $new_active=<STDIN>;
	
			my $sql= "UPDATE alumnos
				SET 
    			warning = $new_warning
    			active= $new_active
				WHERE
    			name= $self->{name}";

			my $sth = $dbh->prepare($sql);
 
 			$sth->execute();

 			 
}



sub delete_alumno{

my $self=shift;
	my $sql= "DELETE FROM alumnos WHERE name=$self";
	my $sth = $dbh->prepare($sql);
 
 	$sth->execute();


	print "the student was deleted\n";


}







sub load_warning{
my $self=shift;
print "insert the warning\n";
my $war=<STDIN>;

	for my $student (list_alumnos()){
       if ($studen->{nombre}==$self->{nombre}){
          $student->{warning}= $student->{warning}+$student->{war};
       }
	}
	
}

#no llegue con estos metodos

sub sum_warning{
	
}

sub load_notes{

}

sub get_general_avg{

	

}

sub inform{

}




1;