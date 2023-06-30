#!/bin/bash

# sample() {
#     echo -e "\e[35mI am in the function\e[0m"
# }

# echo "Calling function"

# sample

stat() {
    echo -e "Opened sessions: \e[33m$(who | wc -l)\e[0m"
    echo -e "Todays date: \e[34m$(date +%F)\e[0m"
    echo -e "Load average in one minute: $(uptime | awk -F : '{print NF}' | awk -F , '{print $1}')"
}

stat