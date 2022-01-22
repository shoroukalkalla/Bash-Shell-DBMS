#!/bin/bash

function deleteFromTable {

        echo "Enter Table Name: "
        read tableName
        currentPath=DBMS/$connectedDatabase/
        if [ -d ${currentPath}$tableName ]
        then
            currentPath=${currentPath}$tableName/data.db  
            echo "Enter Column Name: "
            read fieldName
            columnPosition=$(awk -v fieldName=$fieldName 'BEGIN{FS="|"}{for(i=1;i<=NF;i++)if ($i==fieldName) print i}' $currentPath)
            if [[ $columnPosition == "" ]]
            then 
                DisplayMessages "Field is not found" "error"
                tablesMenu
            else 
                echo "Enter Condition Value: "
                read value
                rowValue=$(awk -v value=$value -v columnPosition=$columnPosition 'BEGIN{FS="|"}{if($columnPosition==value) print value}' $currentPath)

                if [[ $rowValue == "" ]]
                then
                    DisplayMessages "Value Not Found" "error"
                    tablesMenu
                else
                    rowNumber=$(awk -v value=$value -v columnPosition=$columnPosition 'BEGIN{FS="|"}{if($columnPosition==value) print NR}' $currentPath)
                    sed -i ''$rowNumber'd' $currentPath 
                    DisplayMessages "Row Deleted Successfully" "success"
                    tablesMenu
                fi
            fi
        else
            DisplayMessages "Table wasn't found " "error"
            tablesMenu
        fi
}
