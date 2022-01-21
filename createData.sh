#! /bin/bash

function createData {
        # ---- Parameters ------
        # $1 => directory path
	# $2 => newline
        # $3 => data [ cols name or values]
        # -----------------------------------------------------------

        dataPath=$1
        if [ ! -f ${dataPath}data.db ]
        then
                touch ${dataPath}data.db
                echo  "" > ${dataPath}data.db
        fi

        data=${dataPath}data.db # data Path
	if [[ $2 = false ]]
	then
		insertData $3
	else
		echo -e "\n" >> $data
		insertData $3
	fi
}

function insertData {
        if [[ -s "$data" && -z "$(tail -c 1 "$data")" ]]
        then
                #echo "Newline at end of file!"
                echo -n $1 >> $data
        else
                #echo "No newline at end of file!"
                echo -n " | $1" >> $data
        fi
}

#createData DB/iti/students/ true hello_test

