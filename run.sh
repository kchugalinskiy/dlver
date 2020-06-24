#!/usr/bin/env bash

app=$1
arr=( "$@" )
unset arr[0]

args=""

if [ "${DLV_CHECK_GO_VERSION}" ]; then
  args="--check-go-version=true"
else
  args="--check-go-version=false"
fi

if [ ! -z "${DLV_ACCEPT_MULTICLIENT}" ]; then
  args="${args} --accept-multiclient"
fi

if [ ! -z "${DLV_API_VERSION}" ]; then
  args="${args} --api-version=${DLV_API_VERSION}"
fi

if [ ! -z "${DLV_LISTEN}" ]; then
  args="${args} --listen=${DLV_LISTEN}"
fi

cmd=""

if [ ! ${#arr[@]} -eq 0 ]; then
  cmd="-- ${arr[@]}"
fi

/usr/bin/dlv ${args} --headless=true --log exec ${app} ${cmd}