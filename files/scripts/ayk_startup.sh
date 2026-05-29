#!/bin/bash

launch_if_not_running() {
    local proc="$1"
    shift
    if ! pgrep -f "$proc" >/dev/null; then
        kstart "$@" &
    fi
}

launch_if_not_running /usr/sbin/teams-for-linux    teams-for-linux
launch_if_not_running /usr/sbin/thunderbird        thunderbird
launch_if_not_running /usr/sbin/discord            discord
launch_if_not_running /usr/sbin/superproductivity  superproductivity
