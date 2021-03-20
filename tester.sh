#! /bin/bash

YELLOW="\033[0;33m"
BOLD="\033[1m"
RESET="\033[0m"

VALGRIND=0

# check and process flags
while getopts v flag
do
	case "${flag}" in

		v)
			VALGRIND=1
			;;
	esac
done

# remove valgrind report for a fresh start
if [[ $VALGRIND = 1 ]]
then
    rm valgrind-log-comp.txt > /dev/null 2>&1
fi

# function that runs tests
f_tester()
{
    # print what test is being run
    printf $BOLD$YELLOW"❖ testing $1\n"$RESET

    if [[ $VALGRIND = 1 ]]
    then
        # run test with valgrind
        valgrind --leak-check=full \
        --show-leak-kinds=all \
        --log-file=valgrind-log.txt \
        ../miniRT test_scenes/$1
        
        # append the valgrind-log to the log compilation
        cat valgrind-log.txt >> valgrind-log-comp.txt
        
        # add seperator in valgrind report between tests 
        echo -e "\n\n\n" >> valgrind-log-comp.txt
    else
        # run tests without valgrind
        ../miniRT test_scenes/$1
    fi

    # add empty line between tests in stdout
    echo
}

# scene files to test
f_tester bullshit_1.rt
f_tester bullshit_2.rt
f_tester bullshit_3.rt
f_tester bullshit_4.rt
f_tester bullshit_5.rt
f_tester bullshit_6.rt
f_tester l_bad_colour_2.rt
f_tester l_bad_colour_3.rt
f_tester l_bad_colour.rt
f_tester l_format_1.rt
f_tester l_format_2.rt
f_tester l_missing_values_2.rt
f_tester l_missing_values_3.rt
f_tester l_missing_values.rt
f_tester missing_A.rt
f_tester missing_both_c.rt
f_tester missing_c.rt
f_tester reordered.rt
f_tester R_missing.rt
f_tester R_no_values.rt
f_tester R_one_value.rt
f_tester R_three_values.rt
f_tester R_too_high.rt
f_tester R_too_low.rt
f_tester R_very_small.rt
f_tester R_zeroes.rt
f_tester spacing.rt
f_tester template.rt
f_tester unknown_var.rt

# if -v, remove valgrind log
if [[ $VALGRIND = 1 ]]
then
    rm valgrind-log.txt > /dev/null 2>&1
fi