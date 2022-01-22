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
            colName=`awk 'BEGIN{FS="|"}{if(NR==2) print $c}' c=$counter ${currentDir}data.db`
            colType=`awk 'BEGIN{FS="|"}{if(NR==c) print $2}' c=$counter ${currentDir}metaData.db`
            colKey=`awk 'BEGIN{FS="|"}{if(NR==c) print $3}' c=$counter ${currentDir}metaData.db`

            # field=$(awk -v fieldName=$fieldName 'BEGIN{FS="|"}{if(NR==2){for(i=1;i<=NF;i++){gsub(/ /,""); if($i==fieldName) print $i}}}' $currentPath)

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
                        echo -e "${RED}Duplicated Primary Key${NC}"
                    fi
                done
            else
                read -p "Enter value of => $colName($colType): " value
            fi

            # validation of number
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
            echo -e "${RED}Please, enter a valid number: ${NC}"
            read -p "Enter a number: " data
        done
    fi
    return $data
}

# validateData 'int' test
# echo $?

insertInto