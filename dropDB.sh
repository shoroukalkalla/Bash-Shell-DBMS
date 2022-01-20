#!/bin/bash

function dropDB {
   echo "Enter Database Name: "
   read dbName
   currentDir=./DB/$dbName
	if [ -d $currentDir ]
        then
          rm -rf $currentDir
	  echo "Database Dropped Successfully"
        else
          echo "Database was not found"
        fi
}
dropDB

