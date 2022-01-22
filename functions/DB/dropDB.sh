#!/bin/bash

function dropDB {
   echo "Enter Database Name: "
   read dbName
   currentDir=./DBMS/$dbName
	if [ -d $currentDir ]
        then
          rm -rf $currentDir
	        DisplayMessages "Database Dropped Successfully" "success"
        else
          DisplayMessages "Database was not found" "error"
        fi
}

