#!/bin/bash

. ./createData.sh
. ./createMetaData.sh

function createTable {
	currentDir=DB/iti/
	NC='\033[0m' # No Color
	GREEN='\033[0;32m'
	RED='\033[0;31m'

	read -p "Enter table name: " tableName
	if [ -d $currentDir${tableName} ]
	then
		echo -e "${RED}Table $tableName already exists${NC}"

		select choices in "try again" "back"
		do
			case $REPLY in 
				again | 1) ;;
				back | 2) exit;;
				*) echo $REPLY incorrect choice;;
			esac

			createTable # Call createTable again
		done

	else
		mkdir $currentDir${tableName}
		echo -e "$GREEN Table $tableName has been created successfully $NC"
		currentDir=$currentDir${tableName}/
		touch ${currentDir}metaData.db # create MetaData file
		touch ${currentDir}data.db # create Data file
		echo "" > ${currentDir}data.db
		
		read -p "Columns number: " colsNumber
		counter=0
		pKey=''
		while [ $counter -lt $colsNumber ]
		do
			createTableStructure
			let counter=$counter+1
		done
		#echo -e "\n" >> ${currentDir}data.db
	fi

	echo -e "\n"

	./TablesMenu.sh
}

function createTableStructure {
	# ------ Create Data file --------
	read -p "column name: " colName

	if [[ -s "${currentDir}data.db" && -z "$(tail -c 1 "${currentDir}data.db")" ]]
	then
			#echo "Newline at end of file!"
			echo -n $colName >> ${currentDir}data.db
	else
			#echo "No newline at end of file!"
			echo -n "|$colName" >> ${currentDir}data.db
	fi


	# --- Create MetaData File -------
	echo "Data type: "
	datatype=""
	select choice in "int" "string"
	do
		case $choice in
		int) datatype=int; break;;
		string) datatype=string; break;;
		*) echo "Invalid Choice";;
		esac
	done

	metaValues=""
	if [ -z $pKey ] # pkey is empty
	then
		echo "Put Primary Key ? "
		select choice in "yes" "no"
		do
			case $choice in
				yes) 
					pKey="PK"; 
					metaValues=$colName"|"$datatype"|"$pKey
					break;;
				no) metaValues=$colName"|"$datatype; break;;
				*) echo "Invalid Choice";;
			esac
		done
		else
			metaValues=$colName"|"$datatype
	fi
	echo $metaValues >> ${currentDir}metaData.db
}

createTable


