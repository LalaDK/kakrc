#! /usr/bin/env bash
SCRIPT=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPTDIR=$(dirname $SCRIPT)
ln -sv $SCRIPTDIR "$HOME/.config/kak/"
