#! /bin/bash

function dropTable {
   echo "Enter Table Name: "
   read tableName
   currentDir=./DB/iti/$tableName
	if [ -d $currentDir ]
        then
          rm -rf $currentDir
	  echo "Table Dropped Successfully"
        else
          echo "Table was not found"
        fi
}
dropTable
