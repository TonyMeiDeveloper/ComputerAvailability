'GET COMPUTER DESCRIPTION
'Reference: http://forum.sysinternals.com/display-computer-description_topic11157.html
strDescription="."
Set objWMIService = GetObject("winmgmts:\\" & strDescription & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("SELECT Description FROM Win32_OperatingSystem",,48)
For Each objItem in colItems
 'Wscript.Echo"" & objItem.Description
 strDescription = strDescription & objItem.Description
Next

'PARSE INFORMATION

'Get Computer Name
'Reference: http://www.robvanderwoude.com/vbstech_network_names_computer.php
'Set wshShell = CreateObject( "WScript.Shell" )
'strComputerName = wshShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
vasplit=Split(strDescription," ")
vasplit(0)=Replace(vasplit(0),".","") 'Remove the period set before
if InStr(1,strDescription,"TESTR1-BK6")>0 then
	strComputerName="R1-BK6"
elseif InStr(1,strDescription,"PUBSCAN")>0 then
	strComputerName=Replace(vasplit(0),"PUBSCAN","")
elseif InStr(1,strDescription,"PUBSPEC")>0 then
	strComputerName=Replace(vasplit(0),"PUBSPEC","")
elseif InStr(1,strDescription,"R1-IC1")>0 then
	strComputerName="R1-IC1"
elseif InStr(1,strDescription,"PUBWIDE")>0 then
	strComputerName=Replace(vasplit(0),"PUBWIDE","")	
elseif InStr(1,strDescription,"PUBSCAN")>0 then
	strComputerName=Replace(vasplit(0),"PUBSCAN","")
elseif InStr(1,strDescription,"PUB")>0 then
	strComputerName=Replace(vasplit(0),"PUB","")
end if




'Get Configuration
strConfiguration="."

if InStr(1,strDescription,"R1-IC1")>0 then
	strConfiguration="Special Apps Station"
elseif InStr(1,strDescription,"TESTR1-BK6")>0 then
	strConfiguration="Legacy Apps Station"	
elseif InStr(1,strDescription,"PUBSCAN")>0 then
	strConfiguration="Scanner Stations"
elseif InStr(1,strDescription,"PUBSPEC")>0 then
	strConfiguration="Digital Media Studio"
else
	strConfiguration="Standard PC"
end if









'Get Floor
if InStr(1,strDescription,"R1-")>0 then
	strFloor="RaynorFirst"
end If
	
if InStr(1,strDescription,"R2-")>0 then
	strFloor="RaynorSecond"
end If

if InStr(1,strDescription,"R0-")>0 then
	strFloor="RaynorLower"
end If

if InStr(1,strDescription,"M2-")>0 then
	strFloor="Memorial"
end If


'Get General Position of the Pod it belongs to
if InStr(1,strComputerName,"1-A")>0 then
	strLeftPos="33"
	strTopPos="15"
elseif InStr(1,strComputerName,"1-B")>0 then
	strLeftPos="42"
	strTopPos="15"
elseif InStr(1,strComputerName,"1-C")>0 then
	strLeftPos="51"
	strTopPos="15"
elseif InStr(1,strComputerName,"1-D")>0 then
	strLeftPos="61"
	strTopPos="15"
elseif InStr(1,strComputerName,"1-E")>0 then
	strLeftPos="71"
	strTopPos="15"
elseif InStr(1,strComputerName,"1-F")>0 then
	strLeftPos="81"
	strTopPos="15"
elseif InStr(1,strComputerName,"1-G")>0 then
	strLeftPos="75"
	strTopPos="24"
elseif InStr(1,strComputerName,"1-H")>0 then
	strLeftPos="77"
	strTopPos="33"
elseif InStr(1,strComputerName,"1-J")>0 then
	strLeftPos="67"
	strTopPos="33"	
elseif InStr(1,strComputerName,"1-L")>0 then
	strLeftPos="76"
	strTopPos="60"	
elseif InStr(1,strComputerName,"1-M")>0 then
	strLeftPos="65"
	strTopPos="60"	
elseif InStr(1,strComputerName,"1-N")>0 then
	strLeftPos="81"
	strTopPos="71"
elseif InStr(1,strComputerName,"1-P")>0 then
	strLeftPos="60"
	strTopPos="75"
elseif InStr(1,strComputerName,"1-Q")>0 then
	strLeftPos="50"
	strTopPos="75"	
elseif InStr(1,strComputerName,"1-R")>0 then
	strLeftPos="37"
	strTopPos="75"
elseif InStr(1,strComputerName,"1-S")>0 then
	strLeftPos="37"
	strTopPos="69"
elseif InStr(1,strComputerName,"2-A")>0 then
	strLeftPos="53"
	strTopPos="21"	
elseif InStr(1,strComputerName,"2-B")>0 then
	strLeftPos="66"
	strTopPos="21"	
elseif InStr(1,strComputerName,"2-C")>0 then
	strLeftPos="70"
	strTopPos="11"	
elseif InStr(1,strComputerName,"2-D")>0 then
	strLeftPos="60"
	strTopPos="11"		
elseif InStr(1,strComputerName,"0-0")>0 then
	strLeftPos="35"
	strTopPos="21"		
elseif InStr(1,strComputerName,"M2")>0 then
	strLeftPos="17"
	strTopPos="40"	
elseif InStr(1,strComputerName,"R1-IC1")>0 then
	strLeftPos="60"
	strTopPos="60"
elseif InStr(1,strComputerName,"R1-BK6")>0 then
	strLeftPos="60"
	strTopPos="33"		
else
	strLeftPos="89"
	strTopPos="45"	
end If	
	
	
	
'START HTTPPOST REQUEST 
'Reference http://www.computerhope.com/forum/index.php?topic=126519.0

'URL to open, specify your domain for your server....
sUrl = "enteryourdomain/statuschange.php"
'POST Request to send.
sRequest = "status=1&workstation=" & strComputerName & "&computertype=PC" & "&configuration=" &strConfiguration & "&floor=" &strFloor & "&left_pos=" &strLeftPos & "&top_pos=" &strTopPos
HTTPPost sUrl, sRequest

Function HTTPPost(sUrl, sRequest)
  set oHTTP = CreateObject("Microsoft.XMLHTTP")
  oHTTP.open "POST", sUrl,false
  oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  oHTTP.setRequestHeader "Content-Length", Len(sRequest)
  oHTTP.send sRequest
  HTTPPost = oHTTP.responseText
 End Function
