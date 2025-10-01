#!/bin/bash
#
# VARIABLES
CURL_PATH=$(which curl)
declare -A query_output

function get_instance_user_config {
        output=$(${CURL_PATH} -s --unix-socket /dev/lxd/sock http://localhost/1.0/config | jq -r '.[]')

for o in $output ; do
        for val in $(echo ${o} | sed -e 's/\/1.0\/config\/user\.//') ; do
                #echo "user.${val} = $(${CURL_PATH} -s --unix-socket /dev/lxd/sock http://localhost/1.0/config/user.${val})"
                query_output[${val}]=$(${CURL_PATH} -s --unix-socket /dev/lxd/sock http://localhost/1.0/config/user.${val})
        done
done

}

get_instance_user_config
#for key in "${!query_output[@]}"; do echo -n "--arg ${key} ${query_output[${key}]} "; done


for key in "${!query_output[@]}"; do
        printf '%s\0%s\0' "$key" "${query_output[$key]}"
done |
        jq -MRs '
                split("\u0000")
                | . as $a
                | reduce range(0; (length-1)/2) as $i
                        ({}; . + {($a[2*$i]): ($a[2*$i + 1])})'
