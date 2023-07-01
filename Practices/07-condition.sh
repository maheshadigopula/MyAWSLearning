#!/bin/bash

action=$1

case $action in
    start)
        echo "Service started"
        ;;
    stop)
        echo "Service stopped"
        ;;
    *)
        echo "Pleas enter start or stop only"
esac
