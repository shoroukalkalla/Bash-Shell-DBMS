#!/bin/bash

# --------- Include Files -------------
. ${tablesDirectoryPath}createTable.sh
. ${tablesDirectoryPath}insertInto.sh
. ${tablesDirectoryPath}dropTable.sh
. ${tablesDirectoryPath}selectFromTable.sh
. ${tablesDirectoryPath}updateTable.sh
. ${tablesDirectoryPath}deleteFromTable.sh

. ${databaseDirectoryPath}mainMenu.sh
# -------------------------------------

function tablesMenu {
	options=(
		"List Tables"
		"Create Table"
		"Insert Into Table"
		"Select Table"
		"Update Table"
		"Delete From Table"
		"Drop Table"
		"Back To Main Menu"
		"Exit"
	)

	select choice in "${options[@]}"
	do
		case $REPLY in
			list | 1) ls DBMS/$connectedDatabase/;;
			create | 2) createTable;;
			insert | 3) insertInto;;
			select | 4) selectFromTable;;
			update | 5) updateTable;;
			delete | 6) deleteFromTable;;
			drop | 7) dropTable;;
			back | 8) mainMenu;;
			exit | 9) exit;;
			*) echo $REPLY is not of the choices;;

		esac
	done
}
