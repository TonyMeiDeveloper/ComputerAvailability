<?php
        header("refresh: 10;");
?>

<!doctype html>
<html lang="en">
<head>

<title>Computer Availability</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

<script type="text/javascript">


</script>

<style type="text/css">
        #RaynorFirstFloorMap
        {
                background: url('/ComputerAvailability/Images/RaynorFirst.png');
                background-repeat: no-repeat;
                height: 610px;


        }
</style>

</head>


<?php

#add your database username and password
$user="yourusername";
$password="yourpassword";
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



<body>

<div class="container">
  <h2>Computer Availability</h2>

  <ul class="nav nav-tabs" id="myTab">
    <li class="active"><a data-toggle="tab" href="#home">Raynor First Floor</a></li>
    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in  active">
      <h3>Raynor First Floor</h3>
      <p>PC's available: <?php echo $pcs; ?> Mac's available: <?php echo $macs; ?></p>
      
        <div id="RaynorFirstFloorMap">
                <?php

                        $type=null;
                        $status=null;

                        while($row = mysql_fetch_array($result))
                        {

                                #check computer type
                                if($row['computer_type']=='Mac')
                                {
                                        $type="fa fa-apple";
                                }
                                else
                                {
                                        $type="fa fa-windows";
                                }

                                #check computer status
                                if($row['status']==0)
                                {
                                        $status="green";
                                }
                                else
                                {
                                        $status="red";
                                }

                                #error checking
                                if($row['left_pos']==0 && $row['top_pos']==0)
                                {
                                        #don't do anything because you haven't add position for the computer yet in database
                                }
                                else
                                {
                                        echo '<i class="'.$type.'" aria-hidden="true" style="color:'.$status.';position:relative;left:'.$row['left_pos'].'px;top:'.$row['top_pos'].'px;"></i>';
                                }





                        }

                ?>
</div>

    </div>


    <div id="menu1" class="tab-pane fade">
      <h3>Menu 1</h3>
      <p>Insert Second Floor</p>
    </div>

    <div id="menu2" class="tab-pane fade">
      <h3>Menu 2</h3>
      <p>Insert Lower Level</p>
    </div>

    <div id="menu3" class="tab-pane fade">
      <h3>Menu 3</h3>
      <p>Insert Memorial Level</p>
    </div>

  </div>
<i class="fa fa-windows" aria-hidden="true" style="color:green;"></i> PC Available     <i class="fa fa-windows" aria-hidden="true" style="color:red;"></i> PC Busy     <i class="fa fa-apple" aria-hidden="true" style="color:green;"></i> Mac Available     <i class="fa fa-apple" aria-hidden="true" style="color:red;"></i> Mac Busy

    <br>
        Page auto refreshes every 10 seconds

</div>

</body>

</html>
