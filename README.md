# ComputerAvailability
Prototype of Computer Availability

Based on this guide: http://journal.code4lib.org/articles/4067  
Also thanks and credits to OSU libraries and their open source code: https://github.com/griggsk/availability-map

I deployed this on AWS, specifically Linux Ubuntu Server

Requirements   
Install these first:
PHP, MySQL, APACHE2, phpmyadmin

What to do   
1. Login to phpmyadmin at http://yourdomain.com/phpmyadmin.   
2. Create database in phpmyadmin called computer_availability.  
3. Select computer_availability. Go to SQL tab, copy and paste the SQL provided to create table in phpmyadmin.  
4. Go to Privileges tab, add user and password for computer_availabilty database.  
5. Put statuschange.php and computers.php on your server. For my case for Ubuntu, at /var/www/html. I used SSH to connect to my server.   
6. Edit statuschange.php. Edit user and password.   
7. Edit computers.php. Edit user and password.  
8. The perl scripts are run on the comptuers. Edit them both so it connects to http://yourdomain.com/statuschange.php.   
9. Run the scripts.   
10. Check database to see if computers are added. Also manunally edit their locations on the map and type of computer whether Mac or PC.  
11. Your map should display at http://yourdomain.com/computers.php. 
