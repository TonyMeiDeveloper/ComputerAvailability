<!doctype html>
<html>
<head>

  <title>Computer Availability</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>



<style>
        #RaynorFirstFloorMap
        {
                background: url('/ComputerAvailability/Images/RaynorFirst.png');
                background-repeat: no-repeat;
                height:1000px;
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



<body>

<div class="container">
  <h2>Computer Availability</h2>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#home">Raynor First Floor</a></li>
    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
      <h3>Raynor First Floor</h3>
      <p>PC's available: <?php echo $pcs; ?> Mac's available: <?php echo $macs; ?></p>

        <div id="RaynorFirstFloorMap">
                <?php


                        while($row = mysql_fetch_array($result))
                        {

                                #check computer status
                                if($row['status']==0)
                                {
                                        echo '<img src="/ComputerAvailability/Images/Mac_open_30px.jpg" style="position:relative;left:'.$row['left_pos'].'px;top:'.$row['top_pos'].'px;"/>';
                                }
                                else
                                {
                                        echo '<img src="/ComputerAvailability/Images/Mac_in_use_30px.jpg" style="position:relative;left:'.$row['left_pos'].'px;top:'.$row['top_pos'].'px;"/>';
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
</div>

</body>



