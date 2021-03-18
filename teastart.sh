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
                        sleep 1
                    else
                        break
                    fi
                    c=$(($c+1))
                done

        stop_server
    ;;
    restart)
        $0 stop && $0 start ${COMMANDLINE_PARAMETERS} || exit 1
    ;;
    status)
        status_server
    ;;
    reload)
        execute_command "config reload"
        exit 0
    ;;
    execute)
        execute_command "${@:2}"
        exit 0
    ;;
    *)
        echo "Invalid usage: ${0} {start|stop|restart|status|reload|execute}"
        exit 2
esac
exit 0
