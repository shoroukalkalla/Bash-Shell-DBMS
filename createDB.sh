#!/bin/bash

function createDB {
   echo "Enter Database Name: "
   read dbName
	if [ -d $dbName ]
	then
	  echo "Database already exists"
	else
   	  mkdir ./DB/$dbName
	fi
}
createDB
