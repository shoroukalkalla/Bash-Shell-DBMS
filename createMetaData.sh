#! /bin/bash


function createMetaData {
	# ---- Parameters ------
	# $1 => directory path
	# $2 => Type of cols [int, string, date, bool, ... and so on]
	# -----------------------------------------------------------

	dataPath=$1
	touch ${dataPath}metaData.db
	metaData=DB/iti/students/metaData.db # metaData Path
	if [ -s $metaData ]
	then
		echo -n " | $2" >> $metaData
	else
		echo -n $2 >> $metaData
	fi
}

#createMetaData DB/iti/students/ hello_test
