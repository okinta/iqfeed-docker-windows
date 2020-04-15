# Find the host's IP address
$hostIP = (
    Get-NetIPConfiguration |
    Where-Object {
        $_.IPv4DefaultGateway -ne $null -and
        $_.NetAdapter.Status -ne "Disconnected"
    }
).IPv4Address.IPAddress

# Forward requests from the host to local running IQFeed client
powershell -Command netsh interface portproxy add v4tov4 listenport=5009 listenaddress=$hostIP connectaddress=127.0.0.1 | Out-Null
powershell -Command netsh interface portproxy add v4tov4 listenport=9100 listenaddress=$hostIP connectaddress=127.0.0.1 | Out-Null
powershell -Command netsh interface portproxy add v4tov4 listenport=9200 listenaddress=$hostIP connectaddress=127.0.0.1 | Out-Null
powershell -Command netsh interface portproxy add v4tov4 listenport=9300 listenaddress=$hostIP connectaddress=127.0.0.1 | Out-Null
powershell -Command netsh interface portproxy add v4tov4 listenport=9400 listenaddress=$hostIP connectaddress=127.0.0.1 | Out-Null

# Create a shortcut to run IQFeed client
$Shell = New-Object -ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut("C:\iqfeedconnect.lnk")
$ShortCut.TargetPath="C:\Program Files (x86)\DTN\IQFeed\iqconnect.exe"
$ShortCut.Arguments="-product $env:product -version $env:version -login $env:login -password $env:password -autoconnect -savelogininfo"
$ShortCut.WorkingDirectory = "C:\Program Files (x86)\DTN\IQFeed";
$ShortCut.Save()
