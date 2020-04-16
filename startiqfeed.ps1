While ($true) {
    Start-Process -Wait -FilePath 'C:\Program Files (x86)\DTN\IQFeed\iqconnect.exe' -ArgumentList "-product $env:product -version $env:version -login $env:login -password $env:password -autoconnect -savelogininfo"
    Start-Sleep -Seconds 1
}
