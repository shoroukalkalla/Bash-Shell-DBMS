#!/bin/bash

function deleteFromTable {
    currentDir=DBMS/$connectedDatabase/
    read -p "Enter table name: " tableName

    if [ -d ${currentDir}$tableName ]
    then
        echo -e "\n"
        
        awk 'BEGIN{FS="|"}{print $0}' ${currentDir}$tableName/data.db
        echo -e "\n"
    else
        DisplayMessages "Table wasn't found " "error"
        tablesMenu
    fi
}