#!/usr/bin/env bash



curl -X POST $APA_SUMMARY_ENDPOINT
APA_SUMMARY_ENDPOINT="https://www.google.com.au"
echo "$start_time    Hit target endpoint: $APA_SUMMARY_ENDPOINT"
status_code=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$APA_SUMMARY_ENDPOINT")

if [[ $status_code == "200" ]]; then
    echo "successful call. Endpoint Status received: $status_code"
else
    if [[ $status_code == "400" ]]; then
        echo "Bad Request. Endpoint Status received: $status_code"
    else
        if [[ $status_code == "401" ]]; then

        else
            if [[ $status_code == "403" ]]; then

            else

            fi
        fi

    fi
fi
case $status_code in
    (2*)
        echo "successful call. Endpoint Status received: $status_code"
        ;;
    (400)
        echo "Bad Request. Endpoint Status received: $status_code"
        ;;
    (401)
        echo "Unauthorized call. Endpoint Status received: $status_code"
        ;;
    (403)
        echo "Forbidden call. Endpoint Status received: $status_code"
        ;;
    (404)
        echo "Not Found endpoint within app. Endpoint Status received: $status_code"
        ;;
    (5*)
        echo "Internal Server Error. Endpoint Status received: $status_code"
        ;;
    (000)
        echo "Unreachable URL (timeout). Status received: $status_code"
        ;;
esac
