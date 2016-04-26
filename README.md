# ComputerAvailability
Prototype of Computer Availability

Based on this guide: http://journal.code4lib.org/articles/4067  
Also thanks and credits to OSU libraries and their open source code: https://github.com/griggsk/availability-map

What it is      
Perl scripts run on login or logout and signifies computer status and sends that information and its computername or IP address to a PHP script running on a server. The PHP script, which in this case, is statuschange.php gets that information and updates the database. The UI or computers.php gets information from the database and use it to display computer availability. 


I deployed this on AWS, specifically Linux Ubuntu Server    
Requirements         
Install these first:
PHP, MySQL, APACHE2, phpmyadmin

What to do   
1. Login to phpmyadmin at http://yourdomain.edu/phpmyadmin.   
2. Create database in phpmyadmin called computer_availability.  
3. Select computer_availability. Go to SQL tab, copy and paste the SQL provided to create table in phpmyadmin.  
4. Go to Privileges tab, add user and password for computer_availabilty database.  
5. Put statuschange.php and computers.php and images on your server. For my case for Ubuntu, at /var/www/html. I used SSH to connect to my server.       
6. Edit statuschange.php. Edit user and password.   
7. Edit computers.php. Edit user and password. You should edit the maps and put your maps and their url locations.       
8. The perl scripts are run on the comptuers. Edit them both so it connects to http://yourdomain.edu/statuschange.php.   
9. Run the scripts.   
10. Check database to see if computers are added. Also manually edit their locations on the map and type of computer whether Mac or PC.           
11. Your map should display at http://yourdomain.edu/computers.php.        
12. Search online for tutorials on how to secure apache2 server and phpmyadmin and other things as well. For example, the PHP scripts have user and password information. You need to hide the contents of the PHP scripts. Or you can edit the Perl scripts and PHP scripts so where the Perl scripts can pass credentials information to the PHP scripts. 
