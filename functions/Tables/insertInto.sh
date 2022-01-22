#!/bin/bash

. ${tablesDirectoryPath}createData.sh

function insertInto {
	currentDir=DBMS/$connectedDatabase/
    read -p "Enter table name: " tableName

    if [ -d ${currentDir}$tableName ]
    then
       currentDir=${currentDir}$tableName/

       colNumbers=`awk 'BEGIN{FS="|"}END{print NF}' ${currentDir}data.db`
       counter=1
       echo  "" >> ${currentDir}data.db
       while [[ $counter -le $colNumbers ]]
       do
            colName=`awk 'BEGIN{FS="|"}{if(NR==2) print $c}' c=$counter ${currentDir}data.db`
            colType=`awk 'BEGIN{FS="|"}{if(NR==c) print $2}' c=$counter ${currentDir}metaData.db`
            colKey=`awk 'BEGIN{FS="|"}{if(NR==c) print $3}' c=$counter ${currentDir}metaData.db`

            # validation of primary key
            if [[ $colKey ]] 
            then    
                pKColumnPosition=$(awk -v c=$colName 'BEGIN{FS="|"}{for(i=1;i<=NF;i++){gsub(/ /,"");if($i==c)print i}}' ${currentDir}data.db)


                while true
                do
                    read -p "Enter value of => $colName($colType): " value
                    field=$(awk -v value=$value -v pkPos=$pKColumnPosition 'BEGIN{FS="|"}{if($pkPos==value)print"yes"}' ${currentDir}data.db)

                    if [ -z $field ]
                    then
                        break;
                    else
                        DisplayMessages "Duplicated Primary Key" "error"
                    fi
                done
            else
                read -p "Enter value of => $colName($colType): " value
            fi

            # validation of number
            if [ $colType = int ]
            then
                    validateData 'int' $value
                    value=$? #return value from function.
            fi

            createData ${currentDir} false $value

            let counter+=1
        done

    else
        DisplayMessages "Table wasn't found " "error"
        tablesMenu
    fi

}


#two parameters => 
    # $1 => data type.
    # $2 => data.
function validateData {
    colType=$1
    data=$2
    if [[ $colType=='int' ]]
    then
        while ! [[ $data =~ [0-9\ ] ]]
        do
            DisplayMessages "Please, enter a valid number: " "error"
            read -p "Enter a number: " data
        done
    fi
    return $data
}
