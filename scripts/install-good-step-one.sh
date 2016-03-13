#!/bin/sh
pwd
for file in "$GOOD_ZIP"
do
    tar -xvf "$file"
done