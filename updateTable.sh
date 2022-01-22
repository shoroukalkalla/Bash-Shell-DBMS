#!/bin/bash

#. ./insertInto.sh # we need validate function inside it

function updateTable {
	currentDir=DB/iti/
	NC='\033[0m' # No Color
	GREEN='\033[0;32m'
	RED='\033[0;31m'
	Cyan='\033[0;36m'  
	Yellow='\033[0;33m'
    read -p "Enter table name: " tableName
	currentDataPath=${currentDir}$tableName/data.db
	metaDataPath=${currentDir}$tableName/metaData.db
	columnsName=${Cyan}`awk 'BEGIN{FS="|"}{print "-"$1"("$2") "}' $metaDataPath`${NC}
	if [ -d ${currentDir}$tableName ]
	then
		echo -e $columnsName
		read -p "Update condition by select column name: " colName
		columnPosition=$(awk -v colName=$colName 'BEGIN{FS="|"}{if(NR==2)for(i=1;i<=NF;i++){if($i==colName) print i}}' $currentDataPath)
		echo $columnPosition
		if [ $columnPosition ]
		then
			read -p "Condition value when: $colName = " conditionValue
			checkConditionValue=`awk -v columnPosition=$columnPosition -v conditionValue=$conditionValue 'BEGIN{FS="|"}{if($columnPosition==conditionValue)print NR}' $currentDataPath`

			echo "______________________"
			echo $checkConditionValue
			echo "______________________"

			# check if the value of condition is found or not
			if [ $checkConditionValue ]
			then
				echo "__- ------------ ___"
				echo $checkConditionValue
				echo "_______________"

				echo "Update row by column Name: "
				echo -e $columnsName
				read -p "Update: " fieldName 
				colKey=`awk 'BEGIN{FS="|"}{if($1==fieldName) print $3}' fieldName=$fieldName $metaDataPath`
				
				validatePrimaryKey $colName $colType
			else
				echo -e "${RED}Error: condition wasn't found${NC}"
			fi
		else
			echo -e "${RED}Invalid Column Name${NC}"
		fi
	else
        echo -e "${RED}Table wasn't found ${NC}"
	fi
}

function validatePrimaryKey {
	# validation of primary key
	colName=$1
	colType=$2
	currentDir=$3
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
}


updateTable
