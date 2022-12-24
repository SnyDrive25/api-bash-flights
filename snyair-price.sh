#!/bin/bash

depart='CDG'
arrivee='JFK'
datedepart='2023-03-21'

curl -X GET "https://test.api.amadeus.com/v1/analytics/itinerary-price-metrics?originIataCode=$depart&destinationIataCode=$arrivee&departureDate=$datedepart&currencyCode=USD&oneWay=true" -H "Authorization: Bearer fleI0htH7JFN1nOwDaOi21Yejr4A" > data.json

res=$(grep -o '"amount": "[0-9.]\+"' data.json)

echo -e "\n$res\n"