#!/usr/bin/env bash

function usage_and_exit {
    EXIT_CODE=0
    if [[ $1 != "" ]]; then
        echo "error: $1"
        EXIT_CODE=1
    fi
    echo "usage: $0 -p pod -a artefact -c container"
    echo "\tdefault values are based on the current directory"

    exit ${EXIT_CODE}
}

function sample_split {
    str="Learn to Split a String in Bash Scripting"
    IFS=' ' # space is set as delimiter
    read -ra ADDR <<< "$str" # str is read into an array as tokens separated by IFS
    for i in "${ADDR[@]}"; do # access each element of array
        echo "$i"
    done
}
function split_pods_list {
    delimiter=$'\n'
    s=$1$delimiter
    pod_array=();
    while [[ $s ]]; do
        pod_array+=( "${s%%"$delimiter"*}" );
        s=${s#*"$delimiter"};
    done
    echo "$(declare -p pod_array)"
    #echo $pod_array
}

function select_pod {
    #local AVAILABLE_PODS=  "$(ls )"
    AVAILABLE_PODS="$(kubectl get pods -n payments | cut -d ' ' -f 1 | grep -v NAME )"
    #echo "${AVAILABLE_PODS}"
    #options=$(available_pods)
    #options=("Option 1" "Option 2" "Option 3" "Quit")

    eval $(split_pods_list "${AVAILABLE_PODS}")
    #pod_array=$(split_pods_list "${AVAILABLE_PODS}")

    #for ((i = 0 ; i < ${#pod_array[@]} ; i++)); do
    #    echo $i ">>>>" ${pod_array[i]}
    #done
    PS3='Please select Pod:'


    select opt in "${pod_array[@]}" "Quit"; do
        case $(($REPLY < ${#pod_array[@]}+2 && $REPLY > 0)) in
        #case $(( ($REPLY > 0 && $REPLY =< 13) * 1 )) in
        #case $REPLY in
            0) echo "None of the above";;
            1) echo "You picked $opt which is option $REPLY"; break;;
            #2) echo "you chose choice $REPLY which is $opt";;
            #$(( ${#pod_array[@]}+1 )) ) echo "you chose choice $REPLY which is $opt"; break;;
            #"Quit") break ;;
            #*) echo "invalid option $REPLY";;
        esac
    done
    POD=$opt
    #Replace the last - and after
    artifactAppName=${POD%-*}
    #Replace the second last - and after
    artifactAppName=${artifactAppName%-*}
    echo $artifactAppName
}
set -e

while getopts ":p:a:c:" option; do
    case "${option}" in
        p)
            POD=${OPTARG}
            ;;
        a)
            ARTEFACT=${OPTARG}
            ;;
        c)
            CONTAINER=${OPTARG}
            ;;
        *)
            usage_and_exit
            ;;
    esac
done


#If the Pod is null, then list all available pods for selection
if [[ ${POD} == "" ]]; then
    select_pod
fi

if [[ ${POD} != "Quit!!!" ]]; then
    if [[ ${ARTEFACT} == "" ]]; then
        ARTEFACT=${PWD##*/}
    fi

    if [[ ${CONTAINER} == "" ]]; then
        #CONTAINER=${ARTEFACT}
        CONTAINER=$artifactAppName
    fi


    #echo "kubectl logs " ${POD} "-n payments " -c ${CONTAINER} "-f"
    #kubectl logs ${POD} -n payments ${CONTAINER} -f

    LogCommand="kubectl logs --tail=20 "${POD}" -f -n payments -c "${artifactAppName}
    #$(kubectl logs "${POD}" -n payments " -c '${artifactAppName}' -f")

fi
echo $LogCommand
exec $LogCommand
#eval $LogCommand