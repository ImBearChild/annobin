#!/bin/bash
# vim: dict+=/usr/share/beakerlib/dictionary.vim cpt=.,w,b,u,t,i,k
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   runtest.sh of /tools/annobin/Regression/lto-preprocessor-options
#   Description: lto-preprocessor-options
#   Author: Martin Cermak <mcermak@redhat.com>
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   Copyright (c) 2020 Red Hat, Inc.
#
#   This program is free software: you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation, either version 2 of
#   the License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
#   PURPOSE.  See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see http://www.gnu.org/licenses/.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Include Beaker environment
. /usr/share/beakerlib/beakerlib.sh || exit 1

PACKAGE="annobin"

rlJournalStart
    rlPhaseStartTest
        b=`mktemp`
        rlRun "rpm -qa | fgrep -e redhat-rpm-config -e gcc -e annobin -e binutils | sort"
        rlRun "cflags=\"$(rpm --eval '%build_cflags')\""
        rlRun "ldflags=\"$(rpm --eval '%build_ldflags')\""
        rlRun "echo 'int main (void) { return 0; }' | gcc -xc -o $b $cflags $ldflags  -flto  - "
        rlRun "annocheck -v $b"
        rm $b
    rlPhaseEnd
rlJournalPrintText
rlJournalEnd
