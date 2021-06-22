#!/usr/bin/env bash


APA_SUMMARY_ENDPOINT="https://acknowledged-payment-aggregator.payments.svc.cluster.local:8080/processSummary"
NETWORK_STATUS_ENDPOINT="http://localhost:15020/healthz/ready"
#NETWORK_STATUS_ENDPOINT="https://www.google.com.au"

start_time=$(date)
echo "$start_time Trigger ProcessSummary endpoint of APA $APA_SUMMARY_ENDPOINT"
network_check=0
network_check_count=0
#while [ $network_check == 0] && [$network_check_count -le 12 ]
while [[ $network_check_count -le 3   && $network_check == 0 ]]
do
  network_check_count=$(($network_check_count+1))
  echo "Check network Readiness $network_check_count"
  network_status_code=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$NETWORK_STATUS_ENDPOINT")
  echo "Network Status check: $network_status_code"
  if [[ "$network_status_code" != "200" ]]; then
    echo "Network is not ready, sleep 2 sec"
    sleep 2
  else
    network_check=1
  fi
done


