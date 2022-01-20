#!/bin/bash
function ConnectToDB {
	echo "Enter Database Name: "
	read bdName
	if [ -d $dbName ]
	 then
		cd ./DB/$dbName
	else
		echo "Database $dbName was not found"
		mainMenu
	fi
}
ConnectToDB 
