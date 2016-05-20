#!/usr/bin/perl -w


use LWP;
use Sys::Hostname;
use IO::Socket;
#my $host = hostname();
 #the hostname after which you can find out the IP address
#my $ipaddr = inet_ntoa(scalar gethostbyname($host || 'localhost'));


#Get Computer Name
my $ComputerName= qx(networksetup -getcomputername);
#Parse out what you need
@ComputerNameArray=split(' ', $ComputerName);
#print $ComputerName;
#print $ComputerNameArray[4];


#Determine Floor based on the computername
if(index($ComputerName,"2-0")!=-1)
{
	$floor="RaynorSecond";
}
else
{
	$floor="RaynorLower";
}


#Determine positions of the pod that the Mac belongs to
if(index($ComputerName,"2-0")!=-1)
{
	$left_pos="50";
	$top_pos="11";
}
elsif(index($ComputerName,"-A")!=-1)
{
	$left_pos="44";
	$top_pos="21";
}
else #Macs in Pod B
{
	$left_pos="54";
	$top_pos="21";
}





#HTTP Post Request
$ua = LWP::UserAgent->new;
#timeout in 60 seconds if we can't make a connection
$ua->timeout(60);
#send the HTTP request with the status of 0 and computer name and the host
$ua->post('enterdomain/statuschange.php',
            	["status" => "0",
            	"workstation" => 'Mac '. $ComputerNameArray[$#ComputerNameArray],
   	 			"computertype" => "Mac",
   	 			"configuration" => "Mac",
   	 			"floor" => $floor,
   	 			"left_pos" => $left_pos,
   	 			"top_pos" => $top_pos
   	 			]);

exit;
