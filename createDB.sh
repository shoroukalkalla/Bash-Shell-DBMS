#!/bin/bash

echo "hello there"

function createDB {
   echo "Enter Database Name: "
   read dbName
	if [ -d $bdName ]
	then
	  echo "Database already exists"
	else
   	  mkdir ./DB/$dbName
	fi
}
export -f createDB
./MainMenu.sh
