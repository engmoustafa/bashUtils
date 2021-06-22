#!/usr/bin/env bash

ACCOUNT_ROLE=ReadOnly
AWS_ACCOUNT=dev
KUBENETES_ACCOUNT=dev
ACCOUNT_PARAM_INDEX=0
ROLE_PARAM_INDEX=0

#echo "Array of args are " $@
#echo "Try that" "${ACCOUNT_PARAM_INDEX}"




args=("$@")
echo Account Arg: ${args[ACCOUNT_PARAM_INDEX]}
function usage_and_exit {
    EXIT_CODE=0
    if [[ $1 != "" ]]; then
        echo "error: $1"
        EXIT_CODE=1
    fi
    echo "Switch AWS and kubenetes profiles\\n\\tusage: $0 <dev|pit|stg|prd>"

    exit ${EXIT_CODE}
}

function checkProvidedRole {
    EXIT_CODE=0
    #echo Role Should be ${args[ROLE_PARAM_INDEX]}
    if [[ ${args[ROLE_PARAM_INDEX]} == "ReadOnly" ]]; then
        ACCOUNT_ROLE="ReadOnly"
    elif [[ ${args[ROLE_PARAM_INDEX]} == "DevAdmin" ]]; then
        ACCOUNT_ROLE="DevAdmin"
    elif [[ ${args[ROLE_PARAM_INDEX]} == "AppDeployer" ]]; then
        ACCOUNT_ROLE="AppDeployer"
    fi
    echo Role is set to ${ACCOUNT_ROLE}
    #exit ${EXIT_CODE}
}
function checkProvidedAccount {
    EXIT_CODE=0
    #echo Environemnt Should be ${args[ACCOUNT_PARAM_INDEX]}
    if [[ ${args[ACCOUNT_PARAM_INDEX]} == "pit" ]]; then
        AWS_ACCOUNT=pit
        KUBENETES_ACCOUNT=pit
    elif [[ ${args[ACCOUNT_PARAM_INDEX]} == "stg" ]]; then
        AWS_ACCOUNT=stg
        KUBENETES_ACCOUNT=stg
    elif [[ ${args[ACCOUNT_PARAM_INDEX]} == "prd" ]]; then
        AWS_ACCOUNT=prd
        KUBENETES_ACCOUNT=prd
    fi
    echo Environemnt is to be ${KUBENETES_ACCOUNT}

    #exit ${EXIT_CODE}
}

set -e

while getopts "h?a:r:" option; do
    case "${option}" in
        h)
            usage_and_exit
            ;;
        a)
            AWS_ACCOUNT=${OPTARG}
            ;;
        r)
            ACCOUNT_ROLE=${OPTARG}
            ;;
        *)
            usage_and_exit
            ;;
    esac
done

#if [[ ${args[ACCOUNT_PARAM_INDEX]} == "-h" ]]; then
#    usage_and_exit
#elif [[ ${args[ACCOUNT_PARAM_INDEX]} == "-a" ]]; then
#    ACCOUNT_PARAM_INDEX=1
#    ROLE_PARAM_INDEX=2;
#fi
#
#checkProvidedAccount
#
#if [[ ${args[ROLE_PARAM_INDEX]} == "-r" ]]; then
#    ROLE_PARAM_INDEX=$ROLE_PARAM_INDEX+1
#fi
#checkProvidedRole


echo "Switching AWS and Kubenetes profiles"

echo    corectl id aws --app Identity --account ${AWS_ACCOUNT} --role ${ACCOUNT_ROLE}
corectl id aws --app Identity --account ${AWS_ACCOUNT} --role ${ACCOUNT_ROLE}
#kubectl config use-context tap.${KUBENETES_ACCOUNT}.tyro.cloud
aws eks update-kubeconfig --name tap
