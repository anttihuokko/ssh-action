#!/bin/sh

SSH_DIR=/root/.ssh

USER=user
USER_KEY=''
HOST_KEY=''
HOST=localhost
PORT=22
COMMAND='uptime'

VALID_ARGS=$(getopt -o u:k:K:h:p:c: --long user:,userkey:,hostkey:,host:,port:,command: -- "$@")
[ $? -eq 0 ] || { 
  exit 1
}
eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
  	-u | --user)
	  USER=$2
      shift 2
      ;;
    -k | --userkey)
	  USER_KEY=$2
      shift 2
      ;;
    -K | --hostkey)
	  HOST_KEY=$2
      shift 2
      ;;
    -h | --host)
	  HOST=$2
      shift 2
      ;;
    -p | --port)
	  PORT=$2
      shift 2
      ;;
    -c | --command)
	  COMMAND=$2
      shift 2
      ;;
    --)
	  shift; 
      break 
      ;;
  esac
done

mkdir -p -m 700 $SSH_DIR

if [ ! -z "$USER_KEY" ]; then
  echo "$USER_KEY" > $SSH_DIR/id_rsa
fi

if [ ! -z "$HOST_KEY" ]; then
  echo "$HOST $HOST_KEY" > $SSH_DIR/known_hosts
fi

echo "Host target" > $SSH_DIR/config
echo "  HostName $HOST" >> $SSH_DIR/config
echo "  Port $PORT" >> $SSH_DIR/config
echo "  User $USER" >> $SSH_DIR/config

chmod 600 $SSH_DIR/*

echo Starting to execute ssh command
ssh target $COMMAND
