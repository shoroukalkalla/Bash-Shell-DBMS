#!/bin/bash

function createTable {
	currentDir=DBMS/$connectedDatabase/

	read -p "Enter table name: " tableName
	if [ -d $currentDir${tableName} ]
	then
		DisplayMessages "Table $tableName already exists$" "error"

		select choices in "try again" "back"
		do
			case $REPLY in 
				again | 1) createTable;;
				back | 2) tablesMenu; break ;;
				*) DisplayMessages "$REPLY incorrect choice" "error";;
			esac

			#createTable # Call createTable again
		done

	else
		mkdir $currentDir${tableName}
		DisplayMessages "Table $tableName has been created successfully" "success"
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
	fi

	echo -e "\n"

	tablesMenu
}

function createTableStructure {
	# ------ Create Data file --------
	read -p "column name: " colName

	if [[ -s "${currentDir}data.db" && -z "$(tail -c 1 "${currentDir}data.db")" ]]
	then
			echo -n $colName >> ${currentDir}data.db
	else
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
		*) DisplayMessages "Invalid Choice" "error";;
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
				*) DisplayMessages "Invalid Choice" "error";;
			esac
		done
		else
			metaValues=$colName"|"$datatype
	fi
	echo $metaValues >> ${currentDir}metaData.db
}


