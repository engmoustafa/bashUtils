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
function split_to_list {
    delimiter=$'\n'
    s=$1$delimiter
    targetArray_array=();
    while [[ $s ]]; do
        targetArray_array+=( "${s%%"$delimiter"*}" );
        s=${s#*"$delimiter"};
    done
    echo "$(declare -p targetArray_array)"
    #echo $targetArray_array
}
function select_app {
    AVAILABLE_APPS="$(kubectl get deployments -n payments -o jsonpath='{.items[*].metadata.name}' | tr ' ' '\n')"
    eval $(split_to_list "${AVAILABLE_APPS}")
    PS3='Please select App:'
    select opt in "${targetArray_array[@]}" "Quit"; do
        case $(($REPLY < ${#targetArray_array[@]}+2 && $REPLY > 0)) in
            0) echo "None of the above";;
            1) echo "You picked $opt which is option $REPLY"; break;;
        esac
    done
    SELETECTED_APP=$opt
    ARTEFACT=$SELETECTED_APP

    echo $SELETECTED_APP
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
if [[ ${ARTEFACT} == "" ]]; then
    select_app
fi

if [[ ${ARTEFACT} != "Quit!!!" ]]; then

    if [[ ${CONTAINER} == "" ]]; then
        #CONTAINER=${ARTEFACT}
        CONTAINER=$ARTEFACT
    fi


    #echo "kubectl logs " ${POD} "-n payments " -c ${CONTAINER} "-f"
    #kubectl logs ${POD} -n payments ${CONTAINER} -f

    LogCommand="kubectl -n payments logs -f deployment/"${ARTEFACT}" -c "${CONTAINER}
    #$(kubectl logs "${POD}" -n payments " -c '${artifactAppName}' -f")

fi
echo $LogCommand
exec $LogCommand
#eval $LogCommand