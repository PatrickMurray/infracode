#!/bin/bash


ARCHIVE_DIRECTORY_PATH="{{ minecraft_server.archive.path }}"

CONTAINER_NAME="minecraft-server"
CONTAINER_VOLUME="minecraft"
CONTAINER_VOLUME_PATH="/var/lib/docker/volumes/${CONTAINER_VOLUME}/_data"


usage() {
        echo "Usage: ${0} [-a] [-r TIMESTAMP]" 1>&2;
        
        exit 1;
}


# Helper Functions


log() {
        MESSAGE="${1}"
        ERROR="${2}"

        # Validate optional parameters
        if [[ -z "${ERROR}" ]];
        then
                ERROR="False"
        fi


        # If flagged as a daemon executor, use the syslog logger facilities
        if [[ "${FLAG_DAEMON,,}" == "true" ]];
        then
                if [[ "${ERROR,,}" == "true" ]];
                then
                        logger          \
                          --tag "${0}"  \
                          --stderr      \
                          "${MESSAGE}";
                else
                        logger          \
                          --tag "${0}"  \
                          "${MESSAGE}";
                fi
        else
                if [[ "${ERROR,,}" == "true" ]];
                then
                        echo "${MESSAGE}" 1>&2;
                else
                        echo "${MESSAGE}"
                fi
        fi
}


debug() {
        MESSAGE="${1}"

        if [[ "${FLAG_DEBUG,,}" == "true" ]];
        then
                log "Debug: ${MESSAGE}"
        fi
}


error() {
        MESSAGE="${1}"

        log "Error: ${MESSAGE}" "True"
}



# Archival Functions


archive() {
        log "Stopping Docker container: ${CONTAINER_NAME}"
        docker stop "${CONTAINER_NAME}"
        
        TIMESTAMP=$(date --utc +"%Y-%m-%d_%H%M%S")
        
        mkdir -p "${ARCHIVE_DIRECTORY_PATH}"
        ARCHIVE_PATH="${ARCHIVE_DIRECTORY_PATH}/${TIMESTAMP}.tar.gz"

        log "Archiving: ${CONTAINER_VOLUME_PATH} => ${ARCHIVE_PATH}"

        tar          \
          --create   \
          --gzip     \
          --verbose  \
          --file      "${ARCHIVE_PATH}"  \
          --directory "${CONTAINER_VOLUME_PATH}"  \
          .;

        log "Completed archive."

        log "Starting Docker container: ${CONTAINER_NAME}"
        docker start "${CONTAINER_NAME}"
}


restore() {
        ARCHIVE_PATH="${1}"

        if [[ ! -f "${ARCHIVE_PATH}" ]];
        then
                error "Unable to locate archive: ${ARCHIVE_PATH}"
                exit -1
        fi

        log "Stopping Docker container: ${CONTAINER_NAME}"
        docker stop "${CONTAINER_NAME}"
        

        #rm -r ${CONTAINER_VOLUME_PATH}/*

        log "Restoring: ${ARCHIVE_PATH} => ${CONTAINER_VOLUME_PATH}"

        tar          \
          --extract  \
          --gzip     \
          --verbose  \
          --file      "${ARCHIVE_PATH}"  \
          --directory "${CONTAINER_VOLUME_PATH}";
        
        log "Starting Docker container: ${CONTAINER_NAME}"
        docker start "${CONTAINER_NAME}"
}


# Argument Parsing


# Defaults
FLAG_ARCHIVE="False"
FLAG_DAEMON="False"
FLAG_DEBUG="False"
FLAG_FORCE="False"
FLAG_RESTORE="False"


while getopts "adfr:" OPTION;
do
        case "${OPTION}" in
                a)
                        FLAG_ARCHIVE="True"
                        ;;
                d)
                        FLAG_DAEMON="True"
                        ;;
                f)
                        FLAG_FORCE="True"
                        ;;
                r)
                        FLAG_RESTORE="True"
                        FLAG_RESTORE_ARCHIVE_PATH="${OPTARG}"
                        ;;
                :)
                        echo "ERROR: Option -${OPTARG} requires an argument" 1>&2;
                        usage
                        ;;
                ?)
                        echo "ERROR: Invalid option -${OPTARG}" 1>&2;
                        usage
                        ;;
        esac
done

shift $((OPTIND-1))


# Check that parameters are provided
#if [[ -z "${r}" ]];
#then
#    usage
#fi


# Debug Arguments
debug "FLAG_ARCHIVE = ${FLAG_ARCHIVE}"
debug "FLAG_DAEMON  = ${FLAG_DAEMON}"
debug "FLAG_FORCE   = ${FLAG_FORCE}"
debug "FLAG_RESTORE = ${FLAG_RESTORE}"


# Operational Sequence


if [[ "${FLAG_ARCHIVE,,}" == "true" ]];
then
        archive
elif [[ "${FLAG_RESTORE,,}" == "true" ]];
then
        restore "${FLAG_RESTORE_ARCHIVE_PATH}"
fi
