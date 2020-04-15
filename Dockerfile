FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Uri "http://www.iqfeed.net/iqfeed_client_6_1_0_20.exe" -OutFile iqfeed.exe; \
    Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vc_redist.x86.exe" -OutFile vc_redist.x86.exe; \
    Start-Process -Wait -FilePath vc_redist.x86.exe -ArgumentList "/S" -PassThru; \
    Start-Process -Wait -FilePath iqfeed.exe -ArgumentList "/S" -PassThru; \
    Remove-Item vc_redist.x86.exe -Force; \
    Remove-Item iqfeed.exe -Force

EXPOSE 5009 9100 9200 9300 9400

COPY entrypoint.ps1 entrypoint.ps1
ENTRYPOINT ["powershell", "-Command", "$ErrorActionPreference = 'Stop';", ".\\entrypoint.ps1", ";"]
