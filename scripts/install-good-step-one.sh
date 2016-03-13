#!/bin/sh
cd /Applications/Xcode.app/Contents/Developer
echo "$GOOD_ZIP"

for file in "$GOOD_ZIP"
do
    tar -xvf "$file"
done

cd ./Good.Platform

mkdir "$FIPS_DIR"

cp "$FIPS_FILE" ./"$FIPS_DIR"

cd ./"$FIPS_DIR"

for file2 in $FIPS_FILE
do
  tar -xvf "$file2"
done

rm "$FIPS_FILE"
cd ../
rm "$FIPS_FILE"