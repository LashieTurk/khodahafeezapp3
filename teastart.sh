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
    if [
    echo "${*}"

    echo -e "\n${*}" > "$pipe_in"
erver running. Possibly your previously started server crashed"
            echo "Please view the logfile for details."
            rm ${PID_FILE}
        fi
    fi
        done
        echo "!"
    fi

    echo -n "Starting the TeaSpeak server"
    if [[ -e "$BINARYNAME" ]]; then
        if [[ ! -x "$BINARYNAME" ]]; then
            echo -e "\n${BINARYNAME} is not executable, trying to set it"
            chmod u+x "${BINARYNAME}"
        fi
        if [[ -x "$BINARYNAME" ]]; then
            export LD_LIBRARY_PATH="${LIBRARYPATH}:${LD_LIBRARY_PATH}"
            export LD_PRELOAD="${PRELOADPATH}"
            "./${BINARYNAME}" --pipe-path "$TERMINAL_PIPE" ${COMMANDLINE_PARAMETERS} < /dev/null > /dev/null 2>&1 &
             PID=$!
            ps -p ${PID} > /dev/null 2>&1
            if [[ "$?" -ne "0" ]]; then
                echo -e "\nTeaSpeak server could not start (PID == 0)"
            else
                echo ${PID} > ${PID_FILE}

                c=1
                while [[ "$c" -le 3 ]]; do
                    if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
                        echo -n "."
                        sleep 1
                    else
                        break
                    fi
                    c=$(($c+1))
                done

                if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
                    echo -e "\nTeaSpeak server started, for details please view the log file"
                else
                    echo -e "\nCould not start TeaSpeak server."
                    echo "Last log entries:"
                    if [[ -d logs/ ]]; then
                        LF=$(find logs/* -printf '%p\n' | sort -r | head -1)
                        cat ${LF}
                    else
                        echo "ERROR: Could not resolve log file"
                    fi
                    rm ${PID_FILE}
                fi
            fi
        else
            echo -e "\n${BINARNAME} is not executable, cannot start TeaSpeak server"
        fi
    else
        echo -e "\nCould not find binary, aborting"
        exit 5
    fi
}

stop_server() {
    if [[ -e ${PID_FILE} ]]; then
        echo -n "Stopping the TeaSpeak server"
        if ( kill -TERM $(cat ${PID_FILE}) 2> /dev/null ); then
            c=1
            while [[ "$c" -le 30 ]]; do
                if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
                    echo -n "."
                    sleep 1
                else
                    break
                fi
                c=$(($c+1))
            done
        fi
        if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
            echo -e "\nServer is not shutting down cleanly - killing"
            kill -KILL $(cat ${PID_FILE})
        else
            echo -e "\ndone"
        fi
        rm ${PID_FILE}
    else
        echo "No server running (${PID_FILE} is missing)"
        exit 7
    fi
}

status_server() {
    if [[ -e ${PID_FILE} ]]; then
        if ( kill -0 $(cat ${PID_FILE}) 2> /dev/null ); then
            echo "Server is running"
            exit 0
        else
            echo "Server seems to have died"
            exit 1
        fi
    else
        echo "No server running (${PID_FILE} is missing)"
        exit 1
    fi
}

case "$1" in
    start)
        start_server
    ;;
    stop)
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
