#!/usr/bin/env python

# Copyright (c) 2015 University of Utah Student Computing Labs. ################
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

# BHT UI Demo.py ###############################################################
#
#
# This script demonstrates the potential to use BigHonkingText as a light-
# weight user interface.
#
#	1.0.0	2015.10.09	Rewrite of shell script version. tjm
#
################################################################################

# Notes: #######################################################################
#
# Uses the newer version of BigHonkingText (v1.06) from John Kitzmiller.
# Added support for colors, opacity, and other improvements.
# https://github.com/kitzy/bighonkingtext
#
################################################################################

import subprocess

bht_path = "/usr/local/bin/BigHonkingText"

pid1 = subprocess.Popen([bht_path, "-p0", "-h10%", "-y80%", "BHT UI Test"])
pid2 = subprocess.Popen([bht_path, "-p0", "-o0.9", "-y50%", "-fgreen", "Proceed"])
pid3 = subprocess.Popen([bht_path, "-p0", "-o0.9", "-y20%", "-fred", "Cancel"])

exit_condition = False

while not exit_condition:
	process1 = pid1.poll()
	process2 = pid2.poll()
	process3 = pid3.poll()

	if process1 != None:
		exit_statement = 'Title Bar'
		pid2.kill()
		pid3.kill()
		exit_condition = True
	if process2 != None:
		exit_statement = 'Proceed'
		pid1.kill()
		pid3.kill()
		exit_condition = True
	if process3 != None:
		exit_statement = 'Cancel'
		pid1.kill()
		pid2.kill()
		exit_condition = True

subprocess.call([bht_path, "-p2", "-o1", "-y45%", "-fyellow", "User selected " + exit_statement])
