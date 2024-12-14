#!/usr/bin/env sh

sed -E "s/((p|v)=|,)/ /g" "$1"| sed "s/-/¯/g" > formatted.txt
