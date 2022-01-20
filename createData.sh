#! /bin/bash

function createData {
        # ---- Parameters ------
        # $1 => directory path
	# $2 => newline
        # $3 => data [ cols name or values]
        # -----------------------------------------------------------

        metaPath=$1
        if [ ! -f ${metaPath}data.db ]
        then
                touch ${metaPath}data.db
        fi

        data=${metaPath}data.db # data Path
	if [[ $2 = false ]]
	then
		insertData $3
	else
		echo -e "\n" >> $data
		insertData $3
	fi
}

function insertData {
	if [ -s $data ]
        then
       		 echo -n " |#| $1" >> $data
        else
                echo -n $1 >> $data
        fi
}

#createData DB/iti/students/ true hello_test

