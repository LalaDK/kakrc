#! /usr/bin/env bash
SCRIPT=$(readlink -f "$0")
SCRIPTDIR=$(dirname $SCRIPT)
ln -sv $SCRIPTDIR "$HOME/.config/kak"
