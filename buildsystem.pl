#!perl -w

use strict;
use File::Find;
use File::Basename;
use File::Copy;


# Configuration section
#name of the job queue for this job listener
my $job_queue = "c:\\temp\\jobs\\requests";

#name of completed job requests
my $completed_queue = "c:\\temp\\jobs\\completed";

#name of value in file that is to be executed
my $exec_line = "execfile";

#job file extensions
my $ext_request = ".req";
my $ext_inprogress = ".inp";
my $ext_completed = ".cmp";

my @candidates;

#------------------------------------------------
# function InputJobs
#callback used by Find::File
sub InputJobs {
	if ( /($ext_request)$/i) {
		push @candidates, $File::Find::name;
	}
}

#------------------------------------------------
# function GetJob
# finds a job to process, renames it, and returns the changed filename to the caller.
sub GetJob {

	my $job_filename = undef;

	@candidates = ();
	find(\&InputJobs, $job_queue);

	@candidates = sort @candidates;

	# If there's anything left in candidates, pick one...
	$job_filename = shift @candidates;

	#job_filename is the job request filename, if one exists.
	$job_filename
}

#------------------------------------------------
# function StartJob
# Takes the request ticket filename as a param.
# Renames the file to the in-progress filename, and returns
# the in-progress filename. If that file can't be found,
# returns undef.
sub StartJob {
	
	my $source_filename = shift @_;
	my $dest_filename = $source_filename;

	#FIXME
	#Should remove offending file here.
	if (!(-f $source_filename)) {
		printf "$source_filename is not a file!\n";
		return undef;
	}

	$dest_filename =~ s/($ext_request)$/$ext_inprogress/i;

	#Now, rename from source_filename to dest_filename
	#if that works, return dest_filename.
	if (rename($source_filename, $dest_filename)) {
		return $dest_filename;
	} else {
		print "Rename of $source_filename to $dest_filename failed.\n";
		return undef;
	}		
}


#-------------------------------------------------
# function RunJob
# Opens the job ticket, sets params, and calls the appropos batch file.
sub RunJob {

	my $job_request = shift @_;


	#To do
	#Open the file, read the guts,
	#run the guts.

	if (!open(REQUEST, "<$job_request")) {
		print "Failed to open $job_request.\n";
		return 0; # Caller should try to whack file.
	}

	# Read the goods from the job ticket
	chomp(my @request = <REQUEST>);

	close (REQUEST);
	
	my %request_args;

	foreach (@request) {
		next if (/^#/); #ignore comments in the request file
		if (/(.*)=(.*)/) {
			$request_args{$1} = $2;
		}
	}


	#Now, we can add all of these options to the enviroment, and then try
	#to exec the "execfile" key.
	
	foreach(keys(%request_args)) {
		$ENV{$_} = $request_args{$_};
	}

	#Run the job. The environment will be inherited.
	system "$request_args{$exec_line}";

	#Now, unset the env variables.
	foreach(keys(%request_args)) {
		delete $ENV{$_};
	}	

	#Once the job is completed, move the ticket to the "completed" folder.
	my ($base,$path,$type) = fileparse ($job_request, $ext_inprogress);
	
	#$base should now have the filename
	my $dest_filename = $completed_queue . '/' . $base . $ext_completed;

	print "Moving $job_request to $dest_filename.\n";
	move ($job_request, $dest_filename);		

	return 1;

}


#-------------------------------------------------
# main loop (which is infinite)

fileparse_set_fstype("MSWin32");

while (1) {

	#REMOVE BEFORE FLIGHT
	print "Sleeping 2 seconds...\n";
	sleep 2;

	#Check for a new job

	my $new_job = &GetJob($job_queue);
	next unless defined ($new_job);

	print "Request ticket is $new_job\n";

	#Try to rename the file
	#Go back to top if file isn't there anymore.
	$new_job = &StartJob($new_job);
	next unless defined ($new_job);

	#$new_job has the the name of the in-progress job.
	#We can now read $new_job and start the build.
	#FIXME: We should inspect the return code from RunJob
	#and take action if necessary.
	RunJob($new_job);

}



