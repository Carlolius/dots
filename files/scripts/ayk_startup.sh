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
launch_if_not_running /usr/sbin/super-productivity  super-productivity

# Sin este wait, el script (ExecStart) termina antes de que los kstart en
# background hayan completado la activación D-Bus. Al ser Type=oneshot sin
# RemainAfterExit, systemd mata el cgroup entero en cuanto ExecStart sale,
# matando los kstart que aún no habían terminado (bug: solo abría la primera app).
wait
