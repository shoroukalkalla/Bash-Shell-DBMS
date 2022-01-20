#!/bin/bash

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
			list | 1) echo list;;
			create | 2) echo create;;
			insert | 3) echo insert;;
			select | 4) echo select;;
			update | 5) echo update;;
			delete | 6) echo delete;;
			drop | 7) echo drop;;
			back | 8) echo back;;
			exit | 9) exit;;
			*) echo $REPLY is not of the choices;;

		esac
	done
}
tablesMenu
