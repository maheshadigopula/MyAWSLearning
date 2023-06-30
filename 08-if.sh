#!/bin/bash

a="aud"

if [ "$a" == "asd" ]; then
    echo "Value is in if"
elif [ "$a" == "aud" ]; then
    echo "Value is in elif"
else
    echo "Value is not in both"
fi