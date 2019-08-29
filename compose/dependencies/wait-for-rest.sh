#!/bin/bash

# Taken from https://gist.github.com/rgl/f90ff293d56dbb0a1e0f7e7e89a81f42

url=$1
http_code=$2
period=$3
timeout=$4

[[ -z ${url} ]] && echo "No URL provided" && exit 1
[[ -z ${http_code} ]] && echo "No expected HTTP code provided" && exit 1
[[ -z ${period} ]] && echo "No period (seconds between attempts) provided" && exit 1
[[ -z ${timeout} ]] && echo "No timeout provided" && exit 1

timeout ${timeout} bash -c "while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' ${url})" != "${http_code}" ]]; do sleep ${period}; done" && echo 0 || echo 1
