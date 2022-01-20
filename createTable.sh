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
		
		read -p "Columns number: " colsNumber
		counter=0
		while [ $counter -lt $colsNumber ]
		do
						#directory path	  // new line
			createTableStructure $currentDir${tableName}/ false
			let counter=$counter+1
		done
	fi

	echo -e "\n"

	./TablesMenu.sh
}

function createTableStructure {
	read -p "column name: " colName
	createData $1 $2 $colName
	read -p "Data type: " datatype
	createMetaData $1 $datatype
}

createTable


