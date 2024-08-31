#!/bin/bash

# Perform the curl request to localhost
res=$(curl -s -w "%{http_code}" -o /tmp/response_body.txt http://localhost/sum/4/2)

# Extract the response body from the temporary file
body=$(cat /tmp/response_body.txt)

# Extract the HTTP status code
status_code=${res: -3}

# Check if the body is not equal to "6" and the status code is 200
if [ "$body" != "6" ] || [ "$status_code" -ne 200 ]; then
  echo "Error"
fi
