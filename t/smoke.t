#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
echo 1..3
pdir="${0%/*}/.."
prog="$pdir/diffcmd"
tmpdir=$(mktemp -d -t diffcmd.test.XXXXXX)
export XDG_DATA_HOME="$tmpdir/data"
export XDG_CACHE_HOME="$tmpdir/cache"
out=$("$prog" -n test -- bash -c 'echo foo')
if [ -n "$out" ]
then
    sed -e 's/^/# /' <<< "$out"
    echo ok 1
else
    echo not ok 1
    exit 1
fi
out=$("$prog" -n test -- bash -c 'echo foo')
if [ -z "$out" ]
then
    echo ok 2
else
    sed -e 's/^/# /' <<< "$out"
    echo not ok 2
    exit 1
fi
out=$("$prog" -n test -- bash -c 'echo bar')
if [ -n "$out" ]
then
    sed -e 's/^/# /' <<< "$out"
    echo ok 3
else
    echo not ok 3
    exit 1
fi
rm -rf "$tmpdir"

# vim:ts=4 sts=4 sw=4 et ft=sh
