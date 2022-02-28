#!/usr/bin/env bash

# Copyright © 2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
echo 1..1
pdir="${0%/*}/.."
prog="$pdir/diffcmd"

out=$("$prog" -h)
if [ -n "$out" ]
then
    sed -e 's/^/# /' <<< "$out"
    echo ok 1
else
    echo not ok 1
    exit 1
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
