#!/bin/bash
#this is here to display the display the help message
if [ -z $3 ]
then
	echo "$0 [date] [month] [year]"
	exit
fi

#gets today's date
cur_date=$(date +%d)
cur_month=$(date +%m)
cur_year=$(date +%Y)
#sets the given dates. We'll just increment and use these
arg_date=$1
arg_month=$2
arg_year=$3

#the base link we'll build upon this
base_link=https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/

#makes a directory for the year its working on
if [ ! -e $arg_year ]
then
	#make the dir
	mkdir $arg_year/
fi
#creates a directory for the current month
mkdir $arg_year/$arg_month/

#runs the loop while the date 
while [ $arg_date -lt $cur_date ] || [ $arg_month -ne $cur_month ] || [ $arg_year -ne $cur_year ]
do
	#does a stupid check to add zeros to months and dates less than 10
	if [ $arg_month -lt 10 ]
	then
		if [ $arg_date -ge 10 ]
		then
			filenam=$arg_year-0$arg_month-$arg_date.gif
			wget -O $PWD/$arg_year/$arg_month/$filenam $base_link$arg_year/$arg_year-0$arg_month-$arg_date.gif
		fi
		if [ $arg_date -lt 10 ]
		then
			filenam=$arg_year-0$arg_month-0$arg_date.gif
			wget -O $PWD/$arg_year/$arg_month/$filenam $base_link$arg_year/$arg_year-0$arg_month-0$arg_date.gif
		fi		
	fi
	if [ $arg_month -ge 10 ]
	then
		if [ $arg_date -ge 10 ]
		then
			filenam=$arg_year-$arg_month-$arg_date.gif
			wget -O $PWD/$arg_year/$arg_month/$filenam $base_link$arg_year/$arg_year-$arg_month-$arg_date.gif
		fi
		if [ $arg_date -lt 10 ]
		then
			filenam=$arg_year-$arg_month-0$arg_date.gif
			wget -O $PWD/$arg_year/$arg_month/$filenam $base_link$arg_year/$arg_year-$arg_month-0$arg_date.gif
		fi		
	fi
	#increments the date its working on
	let arg_date=arg_date+1
	#if date is greater than 31, reset it to 1
	if [ $arg_date -gt 31 ]
	then
		arg_date=1
		#increment month
		let arg_month=arg_month+1
		#if month is greater than 12, reset it to 1, and then increment the year
		if [ $arg_month -gt 12 ]
		then
			arg_month=1
			let arg_year=arg_year+1
		fi
		#check to create the year's folder, if it doesn't exist
		if [ ! -e $arg_year ]
		then
			mkdir $arg_year	
		fi
		#creates the month's folder
		mkdir $arg_year/$arg_month
	fi
done

# https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/2016/2016-10-27.gif
