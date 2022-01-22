#! /bin/bash

# ----- Global Variables --------------
connectedDatabase=""

databaseDirectoryPath="./functions/DB/"
tablesDirectoryPath="./functions/Tables/"
. ${databaseDirectoryPath}MainMenu.sh

. ${tablesDirectoryPath}tablesMenu.sh
. ${tablesDirectoryPath}createData.sh


#   --- Colors ----
Red='\033[0;31m'
Green='\033[0;32m' 
NC='\033[0m' # No Color
Cyan='\033[0;36m'
# --------------------------------

# ----- Helper Functions ----------

function DisplayMessages {
    # $1 => Data
    # $2 => message Type
    #-------------------
    if [[ $2 == 'error' ]]
    then
        echo -e "${Red}$1${NC}"
    elif [[ $2 == 'success' ]]
    then
        echo -e "${Green}$1${NC}"
    else
        echo -e "${Cyan}$1${NC}"
    fi
}

# ----------------------------------

# ----- Run Main Menu -------------

mainMenu

# --------------------------------
