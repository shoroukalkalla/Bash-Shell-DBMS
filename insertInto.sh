#!/bin/bash

. ./createData.sh

function insertInto {
	currentDir=DB/iti/
	NC='\033[0m' # No Color
	GREEN='\033[0;32m'
	RED='\033[0;31m'
    read -p "Enter table name: " tableName
    if [ -d ${currentDir}$tableName ]
    then
       currentDir=${currentDir}$tableName/

       # awk 'BEGIN{FS="|"}{for(i=1;i<=NF;i++) read -p enter $i test}' ${currentDir}data.db

        colNumbers=`awk 'BEGIN{FS="|"}END{print NF}' ${currentDir}data.db`
       counter=1
      # echo -e "\n" >> ${currentDir}data.db
       echo  "" >> ${currentDir}data.db
       while [[ $counter -le $colNumbers ]]
       do
            colName=`awk 'BEGIN{FS="|"}{if(NR==2)print $c}' c=$counter ${currentDir}data.db`
            colType=`awk 'BEGIN{FS="|"}{if(NR==1) print $c}' c=$counter ${currentDir}metaData.db`

            read -p "Enter value of => $colName($colType): " value
            if [ $colType = int ]
            then
                    validateData 'int' $value
                    value=$?
            fi

            createData ${currentDir} false $value

            let counter+=1
        done

    else
        echo -e "${RED}Table wasn't found ${NC}"
    fi

}

function validateData {
    # $1 => data type
    # $2 => data
    #-----------------
    colType=$1
    data=$2
    if [[ $colType=='int' ]]
    then
        while ! [[ $data =~ [0-9\ ] ]]
        do
            read -p "Please, enter a valid number: " data
        done
    fi
    return $data
}

# validateData 'int' test
# echo $?

insertInto