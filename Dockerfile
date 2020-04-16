FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \

    # Download installers ; \
    Invoke-WebRequest -Uri "http://www.iqfeed.net/iqfeed_client_6_1_0_20.exe" -OutFile iqfeed.exe; \
    Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vc_redist.x86.exe" -OutFile vc_redist.x86.exe; \

    # Install IQFeed ; \
    Start-Process -Wait -FilePath vc_redist.x86.exe -ArgumentList "/S" -PassThru; \
    Start-Process -Wait -FilePath iqfeed.exe -ArgumentList "/S" -PassThru; \

    # Remove installers ; \
    Remove-Item vc_redist.x86.exe -Force; \
    Remove-Item iqfeed.exe -Force; \

    # Forward ports so they ca be accessed from the outside ; \
    netsh interface portproxy add v4tov4 listenport=5009 listenaddress=0.0.0.0 connectaddress=127.0.0.1; \
    netsh interface portproxy add v4tov4 listenport=9100 listenaddress=0.0.0.0 connectaddress=127.0.0.1; \
    netsh interface portproxy add v4tov4 listenport=9200 listenaddress=0.0.0.0 connectaddress=127.0.0.1; \
    netsh interface portproxy add v4tov4 listenport=9300 listenaddress=0.0.0.0 connectaddress=127.0.0.1; \
    netsh interface portproxy add v4tov4 listenport=9400 listenaddress=0.0.0.0 connectaddress=127.0.0.1

EXPOSE 5009 9100 9200 9300 9400

COPY entrypoint.ps1 entrypoint.ps1
ENTRYPOINT powershell -Command $ErrorActionPreference = 'Stop'; .\entrypoint.ps1 &&
CMD cmd /C .\iqfeedconnect.lnk
