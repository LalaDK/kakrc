#! /usr/bin/env bash
SCRIPT=$(readlink -f "${BASH_SOURCE[0]}")
SCRIPTDIR=$(dirname $SCRIPT)
mkdir -pv "$HOME/.config/kak/"
ln -sv $SCRIPTDIR/* "$HOME/.config/kak/"
