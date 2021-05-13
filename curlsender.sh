#!/bin/bash

ASTERISK_IP=127.0.0.1
ASTERISK_PORT=8088
ARI_USER=asterisk
ARI_PASS=asterisk
CALL_FROM='Local/000@Routiner'
CALL_TO_CONTEXT=Routiner
CALL_TIMEOUT=1
SLEEP=3

# 196 is routiner inward access, and sets a random channel timeout
# ATE50/7A PAX
GROUP1=(
	04155
	04140
	04199
	04167
	04126
	04177
	)

# ATE20/2A PAX
GROUP2=(
	04239
	04248
	04200
	04262
	04247
	04255
	)

for i in {1..5}; do 
  # Call a random number from GROUP1
  CALL_TO_EXTN=$(IFS=$'\n'; echo "${GROUP1[*]}" | shuf -n1)
  curl -v -u ${ARI_USER}:${ARI_PASS} -X POST "http://${ASTERISK_IP}:${ASTERISK_PORT}/ari/channels?endpoint=${CALL_FROM}&extension=${CALL_TO_EXTN}&context=${CALL_TO_CONTEXT}&priority=1&timeout=${CALL_TIMEOUT}"

  sleep ${SLEEP}

  # Call a random number from GROUP2
  CALL_TO_EXTN=$(IFS=$'\n'; echo "${GROUP2[*]}" | shuf -n1)
  curl -v -u ${ARI_USER}:${ARI_PASS} -X POST "http://${ASTERISK_IP}:${ASTERISK_PORT}/ari/channels?endpoint=${CALL_FROM}&extension=${CALL_TO_EXTN}&context=${CALL_TO_CONTEXT}&priority=1&timeout=${CALL_TIMEOUT}"

  sleep ${SLEEP}
done
