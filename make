#!/bin/bash

echo -n "Module name: "

read HANDLE

cd modules

mkdir $HANDLE

mkdir $HANDLE/manifests/
mkdir $HANDLE/templates/

touch $HANDLE/manifests/init.pp
touch $HANDLE/readme.md

echo "class $HANDLE { }" >> $HANDLE/manifests/init.pp


echo -n "Give module description: "
read COMMENT

echo "## Module $HANDLE" >> $HANDLE/readme.md
echo $COMMENT >> $HANDLE/readme.md

cd ..

echo $HANDLE " module and subfolders created"
