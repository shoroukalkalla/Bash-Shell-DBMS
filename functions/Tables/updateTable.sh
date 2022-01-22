#!/bin/bash

# . ./insertInto.sh # we need validate function inside it

function updateTable {
	currentDir=	currentDir=DBMS/$connectedDatabase/
    read -p "Enter table name: " tableName
	dataHomeDirectory=${currentDir}$tableName/ # the directory of [data.db]
	currentDataPath=${currentDir}$tableName/data.db
	metaDataPath=${currentDir}$tableName/metaData.db
	columnsName=${Cyan}`awk 'BEGIN{FS="|"}{print "-"$1"("$2") "}' $metaDataPath`${NC}
	if [ -d ${currentDir}$tableName ]
	then
		echo -e $columnsName
		read -p "Update condition by primary key column name: " colName
		columnPosition=$(awk -v colName=$colName 'BEGIN{FS="|"}{if(NR==2)for(i=1;i<=NF;i++){if($i==colName) print i}}' $currentDataPath)
		
		if [ $columnPosition ]
		then
			checkPrimaryKey=$(awk -v colName=$colName 'BEGIN{FS="|"}{for(i=1;i<=NF;i++)if($i==colName) print $3}' $metaDataPath)

			if [ ! -z $checkPrimaryKey ]
			then
				read -p "Condition value when: $colName = " conditionValue
				checkConditionValue=`awk -v columnPosition=$columnPosition -v conditionValue=$conditionValue 'BEGIN{FS="|"}{if($columnPosition==conditionValue)print NR}' $currentDataPath`

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
					colType=`awk 'BEGIN{FS="|"}{if($1==fieldName) print $2}' fieldName=$fieldName $metaDataPath`
					fieldNamePosition=`awk 'BEGIN{FS="|"}{if(NR==2)for(i=1;i<=NF;i++)if($i==fieldName) print i}' fieldName=$fieldName $metaDataPath`
					colValueName=`awk 'BEGIN{FS="|"}{if(NR==checkConditionValue) print $fieldNamePosition}' fieldNamePosition=$fieldNamePosition checkConditionValue=$checkConditionValue $currentDataPath`

					echo "___colvalue___"
					echo fieldNamePosition
					echo $colValue
					echo "_______________________"
					
					validatePrimaryKey $fieldName $colType
				else
					DisplayMessages "Error: condition wasn't found" "error"
				fi
			else
					echo "This field is not a primary key"
			fi



		else
			DisplayMessages "Invalid Column Name" "error"
		fi
	else
        DisplayMessages "Table wasn't found" "error"
	fi
}

function validatePrimaryKey {
	# validation of primary key
	colName=$1
	colType=$2
	currentDir=$3
	if [[ $colKey ]] 
	then    
		pKColumnPosition=$(awk -v c=$colName 'BEGIN{FS="|"}{for(i=1;i<=NF;i++){gsub(/ /,"");if($i==c)print i}}' $currentDataPath)


		while true
		do
			read -p "Enter value of => $colName($colType): " value
			field=$(awk -v value=$value -v pkPos=$pKColumnPosition 'BEGIN{FS="|"}{if($pkPos==value)print"yes"}' $currentDataPath)

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
		validateData $colType $value

		sed -e "s/$colValueName/$value|$conditionValue/" $currentDataPath > data.db
		rm -rf $currentDataPath
		mv data.db $dataHomeDirectory/

		# result=$(sed -e "s/$colValueName/$value|$conditionValue/" $currentDataPath)
		# echo -e $result
		
}
