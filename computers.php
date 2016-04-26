<!doctype html>
<html>
<head>
<style>
        #computer_map
        {
                background: url('/ComputerAvailability/Images/RaynorFirst.png');
                background-repeat: no-repeat;

                height: 1000px

        }

        p
        {
                text-align: left;

        }
</style>
</head>
</html>

<?php

#add your database username and password
$user="gots_user";
$password="my_password";
$database="computer_availability";

#connect to the database, I have it as localhost for my case. Might be different for your case. 
$DB = mysql_connect('localhost', $user, $password);
@mysql_select_db($database) or die("Unable to select database");

$total_pc_results = mysql_query("SELECT * FROM compstatus WHERE computer_type='PC'");
$avail_pc_results = mysql_query("SELECT * FROM compstatus WHERE status='0' AND computer_type='PC'");
$pcs = mysql_num_rows($avail_pc_results) . '/' .mysql_num_rows($total_pc_results);

#get the textual data - total numbers and available numbers of MACs
$total_mac_results = mysql_query("SELECT * FROM compstatus WHERE computer_type='MAC'");
$avail_mac_results = mysql_query("SELECT * FROM compstatus WHERE status='0' AND computer_type='MAC'");
$macs = mysql_num_rows($avail_mac_results) . '/' . mysql_num_rows($total_mac_results);

#get all the computer's row of data
$result = mysql_query("SELECT * FROM compstatus");

mysql_close($DB);
?>



<p>PC's available: <?php echo $pcs; ?> Mac's available: <?php echo $macs; ?></p>


<div id="computer_map">



</div>
