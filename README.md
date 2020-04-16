# README

This runs IQFeed client as a Windows container.

## Building

    docker build -t iqfeed-docker-windows .

## Running

    docker run -e "product=[PRODUCT]" -e "version=[VERSION]" -e "login=[LOGIN]" -e "password=[PASSWORD]" -ti -p "5009:5009" -p "9100:9100" -p "9200:9200" -p "9300:9300" -p "9400:9400" iqfeed-docker-windows

Replace `[PRODUCT]`, `[VERSION]`, `[LOGIN]` and `[PASSWORD]` with appropriate
values provided by your application and/or DTN IQFeed.

## Testing

To check that IQFeed client is running correctly, run the docker container and
then run:

    .\check-connection.ps1
