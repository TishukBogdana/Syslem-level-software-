#!/usr/bin/sh
ls -al "$1" 2>> lab2_err |tr -s \ | cut -d \  -f 5,9 | sort -n | cut -d \  -f 2  | grep '[^:alpha:]'
