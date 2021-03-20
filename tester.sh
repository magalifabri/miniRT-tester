#! /bin/bash

YELLOW="\033[0;33m"
RED="\033[0;31m"
GREEN="\033[0;32m"
HONEY="\e[38;5;214m"
GREY="\e[38;5;245m"
BOLD="\033[1m"
REVERSED="\033[7m"
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
    rm valgrind-log-concat.txt > /dev/null 2>&1
fi

# function that runs tests
f_tester()
{
    # print what test is being run
    printf $BOLD$YELLOW"❖ testing $1\n"$RESET

    if [[ $VALGRIND = 1 ]]
    then
        # run test (comment out valgrind part if desired)
        valgrind --leak-check=full \
        --show-leak-kinds=all \
        --log-file=valgrind-log.txt \
        ../a.out test_scenes/$1
        
        # add the valgrind-log to 
        cat valgrind-log.txt >> valgrind-log-concat.txt
        
        # add seperator in valgrind report between tests 
        echo -e "\n\n\n" >> valgrind-log-concat.txt
    else
        ../a.out test_scenes/$1
    fi

    # add empty line between tests in stdout
    echo
}

# scene files to test
f_tester bullshit_1.rt
f_tester bullshit_2.rt
f_tester bullshit_3.rt
# f_tester bullshit_4.rt
# f_tester bullshit_5.rt
# f_tester bullshit_6.rt
# f_tester l_bad_colour_2.rt
# f_tester l_bad_colour_3.rt
# f_tester l_bad_colour.rt
# f_tester l_format_1.rt
# f_tester l_format_2.rt
# f_tester l_missing_values_2.rt
# f_tester l_missing_values_3.rt
# f_tester l_missing_values.rt
# f_tester missing_A.rt
# f_tester missing_both_c.rt
# f_tester missing_c.rt
# f_tester reordered.rt
# f_tester R_missing.rt
# f_tester R_no_values.rt
# f_tester R_one_value.rt
# f_tester R_three_values.rt
# f_tester R_too_high.rt
# f_tester R_too_low.rt
# f_tester R_very_small.rt
# f_tester R_zeroes.rt
# f_tester spacing.rt
# f_tester template.rt
# f_tester unknown_var.rt

# remove valgrind log
rm valgrind-log.txt > /dev/null 2>&1
