#! /bin/bash

if [ -d DB ]
then
        echo "DB already exists"
else
        mkdir DB
fi

clear

function mainMenu {
PS3="Please enter your choice: "
options=("Create Database" "List Database" "Connect To Database" "Drop Database" "Exit")

select opt in "${options[@]}"
do
  	case $opt in 
               "Create Database")
                      ./createDB.sh
			;;
		"List Database")
			ls DB
			;;
		"Connect To Database")
			ConnectDB.sh
			;;
		"Drop Database")
			DropDB
			;;
		"Exit")
			exit
			;;
		*)
			echo "Invalid Option"
			;;
	esac
done
}

mainMenu
