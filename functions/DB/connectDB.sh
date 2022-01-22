#!/bin/bash
function ConnectToDB {
	echo "Enter Database Name: "
	read dbName
	if [ -d ./DBMS/$dbName ]
	 then
		cd ./DBMS/$dbName
	else
		DisplayMessages "Database $dbName was not found" "error"
		mainMenu
	fi
}
