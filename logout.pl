#!/usr/bin/perl -w

use LWP;
use Sys::Hostname;
use IO::Socket;
my $host = hostname();
 #the hostname after which you can find out the IP address
my $ipaddr = inet_ntoa(scalar gethostbyname($host || 'localhost'));

$ua = LWP::UserAgent->new;
#timeout in 60 seconds if we can't make a connection
$ua->timeout(60);

#send the HTTP request with the status of 0 and computer name and the host
$request = $ua->post('http://ec2-52-39-117-46.us-west-2.compute.amazonaws.com/statuschange.php',
            	["status" => "0",
            	"workstation" => $ipaddr,
   	 "host" => $host]);

print $host;
print "\n";
print $ipaddr; 
print "\n";
#if successful log 200 status else quit and log error
if ($request->is_success) {
	print "Successfully connected. Receiving info from PHP script:\n";
	$content = $request->content;
    #print "Content-type: text/html\\n\\n";
    print $content;
} else {
      die "Can't get to URL", $request->status_line;
      print "fail";
}

exit;