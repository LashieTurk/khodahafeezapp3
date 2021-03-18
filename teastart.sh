#!/bin/bash

TERMINAL_PIPE="/tmp/teaspeak_\${pid}_\${direction}.term"
COMMANDLINE_PARAMETERS="${@:2}" #add any command line parameters you want to pass here

file_base=$(readlink -f "$0")
file_base="$0"
directory_base=$(dirname ${file_base})
cd ${directory_base} || exit 1

LIBRARYPATH="./libs/"
PRELOADPATH="./libs/libjemalloc.so.2"
BINARYNAM
                    if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
                        echo -n "."
 
