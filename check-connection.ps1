# Find the running container
$dockerID = docker ps `
    | Select-String -Pattern '([a-z0-9]+) +iqfeed-docker-windows' `
    | ForEach-Object { $_.Matches[0].Groups[1].Value }

# Get the container's IP
$dockerIP = docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $dockerID

# Now check that we can access one of IQFeed client's ports
Test-NetConnection -ComputerName $dockerIP -Port 9100
