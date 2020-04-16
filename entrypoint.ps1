# Create a shortcut to run IQFeed client
$Shell = New-Object -ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut("C:\iqfeedconnect.lnk")
$ShortCut.TargetPath="C:\Program Files (x86)\DTN\IQFeed\iqconnect.exe"
$ShortCut.Arguments="-product $env:product -version $env:version -login $env:login -password $env:password -autoconnect -savelogininfo"
$ShortCut.WorkingDirectory = "C:\Program Files (x86)\DTN\IQFeed";
$ShortCut.Save()
