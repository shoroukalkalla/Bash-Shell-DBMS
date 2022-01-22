#! /bin/bash

# --------- Include Files -------------

. ${databaseDirectoryPath}createDB.sh
. ${databaseDirectoryPath}connectDB.sh
. ${databaseDirectoryPath}dropDB.sh
#--------------------------------------

if [ ! -d DBMS ]
then
        mkdir DBMS
fi

clear

function mainMenu {
	PS3="Please enter your choice: "
	options=(
		"Create Database"
		"List Database"
		"Connect To Database"
		"Drop Database"
		"Exit"
	)

	select opt in "${options[@]}"
	do
		case $opt in 
			"Create Database")
				createDB
				mainMenu
				;;
			"List Database")
				ls DBMS
				;;
			"Connect To Database")
				ConnectToDB
				;;
			"Drop Database")
				dropDB
				mainMenu
				;;
			"Exit")
				exit
				;;
			*)
				DisplayMessages "Invalid Option" "error"
				mainMenu
				;;
		esac
	done
}
