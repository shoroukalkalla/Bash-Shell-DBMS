#! /bin/bash


function createMetaData {
	# ---- Parameters ------
	# $1 => directory path
	# $2 => Type of cols [int, string, date, bool, ... and so on]
	# -----------------------------------------------------------

	dataPath=$1
	touch ${dataPath}metaData.db
	metaData=$1metaData.db # metaData Path
	echo "" >> metaData.db

		echo "--- metadat file --" 
		echo $2
		echo "-----------"
        if [[ -s "$data" && -z "$(tail -c 1 "$data")" ]]
        then
                #echo "Newline at end of file!"
                echo -n $2 >> $metaData
        else
                #echo "No newline at end of file!"
                echo -n " | $2" >> $metaData
        fi
}

#createMetaData DB/iti/students/ hello_test
