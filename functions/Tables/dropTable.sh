#! /bin/bash

function dropTable {
   echo "Enter Table Name: "
   read tableName
   currentDir=./DBMS/$connectedDatabase/$tableName
	if [ -d $currentDir ]
        then
          rm -rf $currentDir
	        DisplayMessages "Table $tableName Dropped Successfully" "success"
        else
          DisplayMessages "Table was not found" "error"
        fi
}
