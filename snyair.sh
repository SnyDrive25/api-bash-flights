#!/bin/bash

iata='AF14'
#depIata=''

curl -s "https://app.goflightlabs.com/flights?access_key=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiNTcyMDg2ZDgwOWVmMzAzYWJhMjkwMmEzODBhMWNlMWFiYWI4OWJkMjBmMzgxNmI1MmIyMjQ1YjM4Y2I0N2FiZGYxOWVlZDgwMzgxNjE1ZmQiLCJpYXQiOjE2NzE2MzEwNDQsIm5iZiI6MTY3MTYzMTA0NCwiZXhwIjoxNzAzMTY3MDQ0LCJzdWIiOiIxOTMyOSIsInNjb3BlcyI6W119.sv-E0pOYH14dyfzDrPQWAEMJLQWUT5ja4-yf4zXPds-j5G2iZ53nOAoxzyUaGvdxEHFcacPgFGit95a48nAMNw&flightIata=$iata&limit=10" > data.json

iataCode=$(grep -oP '"aircraft":{"iataCode":"\K[^"]+' data.json)
depIata=$(grep -Po '"departure":.*?[^\\]",' data.json | grep -Po '"iataCode":"\K[^"]*')
arrIata=$(grep -Po '"arrival":.*?[^\\]",' data.json | grep -Po '"iataCode":"\K[^"]*')
altitude=$(grep -oP '"altitude":\K\d+\.\d+' data.json)
speed=$(grep -oP '"horizontal":\K\d+\.\d+' data.json)

mydate=$(date +"%F - %H:%M")

echo -e "[$mydate]\n\nIATA Code = $iataCode\nDeparture IATA Code = $depIata\nArrival IATA Code = $arrIata\nAltitude = $altitude\nSpeed = $speed"

# Insert the new record
curl -X POST https://api.airtable.com/v0/appKbA12GVyZvlbMu/anomalies -H "Authorization: Bearer keyZAgEqSGNdXIWLd" -H "Content-Type: application/json" --data '{"fields": {"iataCode": "'"$iataCode"'","Departure": "'"$depIata"'", "Arrival": "'"$arrIata"'", "Altitude": "'"$altitude"'", "Speed": "'"$speed"'", "Date": "'"$mydate"'"},"typecast": true}'
