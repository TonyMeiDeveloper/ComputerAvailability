# ComputerAvailability
Prototype of Computer Availability. Backend of Web Application is done. Frontend UI needs more work.   

Based on this guide: http://journal.code4lib.org/articles/4067  
Also thanks and credits to OSU libraries and their open source code: https://github.com/griggsk/availability-map

What it is:      
1. Perl scripts run on computer logins and logouts.      
2. Login and Logout scripts each signifies computer status whether they are available or not.    
3. The scripts send computer status and its computername or IP address to a PHP script running on a server called statuschange.php. It is done using a HTTP POST request.     
4. statuschange.php receives that information and updates the database or create a new computer entry in the table.    
5. The UI or computers.php gets information from the database and use it to display computer availability. computers.php uses a variety of web development languages like HTML, CSS, and Javascript. It also uses Bootstrap and has responsive design elements in CSS for well, responsive design so that the web application works and displays on mobile devices like smartphones and tablets.   

For my case:   
I deployed this on AWS EC2 Instance, specifically Linux Ubuntu Apache2 Server. The Web Application is set up with names, and floors, and images for the library I worked at.       
I tested it and it works on Safari, Firefox, and Internet Explorer browsers. I haven't tested on Opera and Google Chrome, but it should work.   

Requirements:         
Install these first:
PHP, MySQL, APACHE2 or a LAMP Server, etc, PHPMYADMIN, PUTTY if you are on Windows trying to SSH into a server.   

What to do:    
1. Login to phpmyadmin at http://yourdomain.edu/phpmyadmin.   
2. Click the SQL tab. Copy and paste the SQL code and click go to run the SQL code to create the database computer_availability and the table compstatus.    
3. Refresh the page to see your changes. Double check.     
4. Select the database you just created. Go to Privileges tab, add user and password for computer_availabilty database.  
5. Put statuschange.php and computers.php and images on your server. For my case for Ubuntu, at /var/www/html. I used SSH to connect to my server.       
6. Edit statuschange.php. Edit user and password.   
7. Edit computers.php. Edit user and password. You should edit the names of the SQL queries and the queries themselves. You should also edit the maps and their image src locations. Customize the script heavy with names of your locations, delete or add more maps, tabs for floors, etc.   
8. The perl scripts are run on the computers. Edit them both so it connects to http://yourdomain.edu/statuschange.php.   
9. Run the scripts.   
10. Check database in PHPMYADMIN to see if computers are added. Also manually edit their locations (percentages, not px) on the map and type of computer whether Mac or PC and floor which in this case, whether RaynorFirst, RaynorSecond, RaynorLower, RaynorMemorial. Also note that the icons that indicate computers on the map are font icons from FontAwesome.                 
11. Your map should display at http://yourdomain.edu/computers.php or where ever you put computers.php at.         
12. Search online for tutorials on how to secure APACHE2 server and PHPMYADMIN and other things as well. For example, the PHP scripts have user and password information. You need to hide the contents of the PHP scripts and/or other files. Or you can edit the Perl scripts and PHP scripts so where the Perl scripts can pass credentials information to the PHP scripts. Another thing is that statuschange.php receives HTTP POST requests. Maybe you can edit and limit the amount of requests to avoid Denial of Service attacks. Also add and modify the code to check if computers are valid, etc. The more security features, the better.      
