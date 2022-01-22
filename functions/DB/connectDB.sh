#!/bin/bash
function ConnectToDB {
	echo "Enter Database Name: "
	read dbName
	if [ -d ./DBMS/$dbName ]
	 then
		connectedDatabase=$dbName
		tablesMenu 
	else
		DisplayMessages "Database $dbName was not found" "error"
		mainMenu
	fi
}
