#!/bin/bash

function selectFromTable {
	currentDir=DBMS/$connectedDatabase/
    read -p "Enter table name: " tableName

    if [ -d ${currentDir}$tableName ]
    then
        echo -e "\n"
        DisplayMessages "Table Data "
        awk '{print $0}' ${currentDir}$tableName/data.db
        echo -e "\n"
    else
        DisplayMessages "Table wasn't found " "error"
        tablesMenu
    fi
}