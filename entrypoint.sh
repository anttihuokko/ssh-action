#!/bin/sh

set -eu
export GITHUB=true

echo Your container args are: "$@"
env
pwd
ls -lash ~
echo ok
