#!/usr/bin/perl

my $directory = $ARGV[0];

#Function to make an array unique (thanks to stackoverflow)
sub uniq {
    my %seen = ();
    my @r = ();
    foreach my $a (@_) {
        unless ($seen{$a}) {
            push @r, $a;
            $seen{$a} = 1;
        }
    }
    return @r;
}

opendir (DIR, $directory) or die $!;

@runArray = ();

while (my $file = readdir(DIR)) {
   if($file =~ m/_[xyz]\_(.+_\d+)\.txt/) {
      push(@runArray, $1);
   }
}

@runArray = uniq(@runArray);

foreach(@runArray){
   if($_ =~ m/WALKING_\d/){
      print "$_ 1\n";
   }
   if($_ =~ m/WALKING_UPSTAIRS_\d/){
      print "$_ 2\n";
   }
   if($_ =~ m/WALKING_DOWNSTAIRS_\d/){
      print "$_ 3\n";
   }
   if($_ =~ m/SITTING_\d/){
      print "$_ 4\n";
   }
   if($_ =~ m/STANDING_\d/){
      print "$_ 5\n";
   }
   if($_ =~ m/LAYING_\d/){
      print "$_ 6\n";
   }
}

closedir(DIR);

