'GET COMPUTER DESCRIPTION
'Reference: http://forum.sysinternals.com/display-computer-description_topic11157.html
strDescription = "."
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
strComputerName="."
if InStr(1,strDescription,"PUBSCAN")>0 then
	strComputerName=Replace(strDescription,"PUBSCAN","")
elseif InStr(1,strDescription,"PUBSPEC")>0 then
	strComputerName=Replace(strDescription,"PUBSPEC","")
elseif InStr(1,strDescription,"R1-IC1")>0 then
	strComputerName="R1-IC1"
elseif InStr(1,strDescription,"PUBWIDE")>0 then
	strComputerName=Replace(strDescription,"PUBWIDE","")	
elseif InStr(1,strDescription,"PUBSCAN")>0 then
	strComputerName=Replace(strDescription,"PUBSCAN","")
else
	
end if




'Get Configuration
strConfiguration="."

if InStr(1,strDescription,"PUBSCAN")>0 then
	strConfiguration="Scanner Stations"
elseif InStr(1,strDescription,"PUBSPEC")>0 then
	strConfiguration="Digital Media Studio"
elseif InStr(1,strDescription,"R1-IC1")>0 then
	strConfiguration="Special Apps Station"
else
	strConfiguration="Standard PC"
end if









'Get Floor
strFloor="."

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

'START HTTPPOST REQUEST 
'Reference http://www.computerhope.com/forum/index.php?topic=126519.0

'URL to open, specify your domain for your server....
sUrl = "http://ec2-52-40-21-169.us-west-2.compute.amazonaws.com/statuschange.php"
'POST Request to send.
sRequest = "status=1&workstation=" & strComputerName & "&computertype=PC" & "&configuration=" &strConfiguration & "&floor=" &strFloor
HTTPPost sUrl, sRequest

Function HTTPPost(sUrl, sRequest)
  set oHTTP = CreateObject("Microsoft.XMLHTTP")
  oHTTP.open "POST", sUrl,false
  oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
  oHTTP.setRequestHeader "Content-Length", Len(sRequest)
  oHTTP.send sRequest
  HTTPPost = oHTTP.responseText
 End Function
