#! /bin/bash

if [ ! -d DB ]
then
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
			mainMenu
			;;
		"List Database")
			ls DB
			;;
		"Connect To Database")
			./connectDB.sh
			;;
		"Drop Database")
			./dropDB.sh
			mainMenu
			;;
		"Exit")
			exit
			;;
		*)
			echo "Invalid Option"
			mainMenu
			;;
	esac
done
}

mainMenu
