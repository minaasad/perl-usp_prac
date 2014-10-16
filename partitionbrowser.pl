#!/usr/bin/perl
use strict;
use warnings;

my $numArgs = @ARGV;

if ($numArgs < 1)
{
	print "\n Partition file argument missing\n\n";
	exit 0;
}

open (INFILE, $ARGV[0]) || die "partition file invalid\n";
if ($numArgs == 1)
#only one option is available
{
	#cannot be invoked without any options
	#only show numbe of partitions
	my $counter = 0;
	while (<INFILE>)
	{
		$counter ++;
	}
	
	print "\n Total number of partitions: " . $counter . "\n\n";	
}
else
#a second argument/option is available
{
	if($ARGV[1] eq "-f")
       	{
		#display unique file systems in use
		my $partition;
        	my $mountPoint;
        	my $fileSystemType;
        	my $permissions;
        	my $totalSpace;
        	my $usedSpace;
        	while (<INFILE>)
        	{
                	#each line is assumed to be completely valid
                	#no validation required

                	my ($A1, $A2, $A3, $A4, $A5, $A6) = split(/ /, $_);
                	$partition = $A1;
                	$mountPoint = $A2;
                	$fileSystemType = $A3;
               		$permissions = $A4;
               		$totalSpace = $A5;
                	$usedSpace = $A6;
        	}
	}	
	elsif($ARGV[1] eq "-w")
        {
		#display number of read-write partitions
		my $counter = 0;
		while (<INFILE>)
       		{
                	#each line is assumed to be completely valid
                	#no validation required

                	my ($A1, $A2, $A3, $A4, $A5, $A6) = split(/ /, $_);
                	my $permissions = $A4;
			
			if($permissions eq "rw")
			{
				$counter ++;
			}
	        }
		print "\n Number of read-write partitions: $counter\n\n";
        }
	elsif($ARGV[1] eq "-a")
        {
		#display overall space available in read-write partitions
		my $overallSpaceAvailable = 0;
	        while (<INFILE>)
        	{
                	#each line is assumed to be completely valid
                	#no validation required

                	my ($A1, $A2, $A3, $A4, $A5, $A6) = split(/ /, $_);
			my $permissions = $A4;
			
			if($permissions eq "rw")
			{
				my $totalSpace = $A5;
                        	my $usedSpace = $A6;
				my $availableSpace = ($totalSpace - $usedSpace);
				$overallSpaceAvailable += $availableSpace;
			}
        	}
		print "\n Overall Space Available in RW partitions: $overallSpaceAvailable\n\n";
        }
	elsif($ARGV[1] eq "-p")
        {
		#display partition permission and available space
		if($numArgs < 3)
		{
			print "\n Missing partition name\n\n";
			exit 0;
		}
		else
		{
			my $matchesFound = 0;
			while (<INFILE>)
                	{
                        	#each line is assumed to be completely valid
                        	#no validation required

                        	my ($A1, $A2, $A3, $A4, $A5, $A6) = split(/ /, $_);
                        	my $partition = $A1;

                        	if($partition eq $ARGV[2])
                        	{
                                	#found a match
					$matchesFound ++;
					my $permissions = $A4;
                        		my $totalSpace = $A5;
                        		my $usedSpace = $A6;
					my $availableSpace = ($totalSpace - $usedSpace);
					print "\n Partition:\t\t$partition\n";
					print " Permission(s):\t\t$permissions\n";
					print " Available Space:\t$availableSpace\n\n";
                        	}
                	}
			
			if($matchesFound < 1)
                        {
                        	print "\n No partition matches found.\n\n";
                        }
		}
        }
	elsif($ARGV[1] eq "-s")
        {
		print "\nHello! \n\n My name is:\t\tMina Asad"
		."\n Student id:\t\t11609551\n"
		." Completion date:\t"
		."16/Oct/2014\n\nThank you.\n\n";
        }
	else
	{
		print "unrecognised second argument\n";
	}
}

exit 0;
