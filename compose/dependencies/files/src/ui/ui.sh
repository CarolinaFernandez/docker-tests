#!/bin/bash

token=""

while [[ -z ${token} ]]; do
    sleep 5;
    token=$(curl http://api:5000/token)
done

echo "Token retrieved: ${token}" > tokenfile

sleep 5m
