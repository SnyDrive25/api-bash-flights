#!/bin/bash

curl -X GET "https://test.api.amadeus.com/v1/analytics/itinerary-price-metrics?originIataCode=$1&destinationIataCode=$2&departureDate=$3&currencyCode=USD&oneWay=$4" -H "Authorization: Bearer fleI0htH7JFN1nOwDaOi21Yejr4A" > data2.json

res=$(grep -o '"amount": "[0-9.]\+"' data2.json)

echo -e "\n$res\n"