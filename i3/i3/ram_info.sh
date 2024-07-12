#!/bin/bash

current=$(free -mh --si | awk 'NR==2{print $3}')
total=$(free -mh --si | awk 'NR==2{print $2}')

echo " $current/$total"
