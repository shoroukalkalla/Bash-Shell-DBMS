#!/bin/bash

function createDB {
	echo "Enter Database Name: "
	read dbName
	if [ -d ./DBMS/$dbName ]
	then
		DisplayMessages "Database already exists" "error"
	else
		DisplayMessages "Database has been created sucessfully" "success"
		mkdir ./DBMS/$dbName
	fi
}
