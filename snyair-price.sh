#!/bin/bash

curl -X GET "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=$1&destination=$2&departureDate=$3&oneWay=$4" -H "Authorization: Bearer ApjU0sEenniHCgPDrndzOSWFk5mN" > data2.json

res=$(grep -o '"amount": "[0-9.]\+"' data2.json)

echo -e "\nBonjour $res\n"

curl -s --data chat_id="5716818874" --data-urlencode "text=Prix très bas pour un vol CDG-JFK ($ $res) le $3 " "https://api.telegram.org/bot5711757703:AAEK9nWX--WUyD2kPjpgiGTjRNps0zVErJ8/sendMessage?parse_mode"