#!/bin/sh

################################################################################
# Copyright (c) 2014 University of Utah Student Computing Labs.
# All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright notice appears in all copies and
# that both that copyright notice and this permission notice appear
# in supporting documentation, and that the name of The University
# of Utah not be used in advertising or publicity pertaining to
# distribution of the software without specific, written prior
# permission. This software is supplied as is without expressed or
# implied warranties of any kind.
################################################################################

################################################################################
# BHT UI Demo.sh
#
# This script demonstrates the potential to use BigHonkingText as a light-
# weight user interface.
#
#	1.0.0	2014.08.20	Initial version. tjm
#
#
################################################################################

# Notes:
# Uses the newer version of BigHonkingText from John Kitzmiller.
# Added support for colors, opacity, and other improvements.
# https://github.com/kitzy/bighonkingtext


# Start BigHonkingText (BHT) fields and background them
/usr/local/bin/BigHonkingText -p0 -h10% -y80% BHT UI Test &
/usr/local/bin/BigHonkingText -p0 -o0.9 -y50% -fgreen Proceed &
/usr/local/bin/BigHonkingText -p0 -o0.9 -y20% -fred Cancel &

# Discover PID's of individual BHT fields
pid1=`ps -opid,command | grep BigHonkingText | grep Test | cut -d" " -f1`
pid2=`ps -opid,command | grep BigHonkingText | grep Proceed | cut -d" " -f1`
pid3=`ps -opid,command | grep BigHonkingText | grep Cancel | cut -d" " -f1`

# Continue checking that each fields PID exists until one has exited.
# When one of the fields has been found to not exist, exit the loop and record the choice
exitCondition=false
while /bin/test $exitCondition = false
do

 	pid1result=`ps -opid,command | grep $pid1 | grep -v grep | wc -l`
	if /bin/test $pid1result -ne 1
	then
		userClicked="Menu"
		exitCondition=true
	fi

 	pid2result=`ps -opid,command | grep $pid2 | grep -v grep | wc -l`
	if /bin/test $pid2result -ne 1
	then
		userClicked="Proceed"
		exitCondition=true
	fi

 	pid3result=`ps -opid,command | grep $pid3 | grep -v grep | wc -l`
	if /bin/test $pid3result -ne 1
	then
		userClicked="Cancel"
		exitCondition=true
	fi

done

# Kill the remaining instances of BHT
killall BigHonkingText

# Display results
/usr/local/bin/BigHonkingText -p2 -y45% -fyellow -o1 User selected $userClicked
