#!/bin/bash
function ConnectToDB {
	echo "Enter Database Name: "
	read bdName
	if [ -d $bdName ]
	 then
		cd ./DB/$dbName
	else
		echo "Database $dbName was not found"
		mainMenu
	fi
}
