#set($line='#!/bin/bash')
${line}
#set($line='# Spring Boot Startup Script')
${line}

#set($line="APP_NAME='${artifactId}-start'")
${line}
#set($line='JARFILE="${APP_NAME}.jar"')
${line}

#set($line='JAVA_OPTS=''-server -XX:+UseG1GC -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=logs/heap.hprof -Duser.timezone=GMT+8''')
${line}

#set($line='if [ "$2" = "product" ]; then')
${line}
#set($line='  JAVA_OPTS="$JAVA_OPTS -Xms2g -Xmx2g -XX:ConcGCThreads=3 -XX:ParallelGCThreads=3 -XX:+UseFastAccessorMethods"')
${line}
#set($line='fi')
${line}

#set($line='JAVA_OPTS="$JAVA_OPTS -Dspring.profiles.active=$2"')
${line}

#set($line='MODE="service"')
${line}

#set($line='[[ -n "$DEBUG" ]] && set -x')
${line}

#set($line='# Initialize variables that cannot be provided by a .conf file')
${line}
#set($line='WORKING_DIR="$(pwd)"')
${line}
#set($line='# shellcheck disable=SC2153')
${line}
#set($line='[[ -n "$JARFILE" ]] && jarfile="$JARFILE"')
${line}
#set($line='[[ -n "$APP_NAME" ]] && identity="$APP_NAME"')
${line}

#set($line='# Follow symlinks to find the real jar and detect init.d script')
${line}
#set($line='cd "$(dirname "$0")" || exit 1')
${line}
#set($line='[[ -z "$jarfile" ]] && jarfile=$(pwd)/$(basename "$0")')
${line}
#set($line='while [[ -L "$jarfile" ]]; do')
${line}
#set($line='  if [[ "$jarfile" =~ init\.d ]]; then')
${line}
#set($line='    init_script=$(basename "$jarfile")')
${line}
#set($line='  else')
${line}
#set($line='    configfile="${jarfile%.*}.conf"')
${line}
#set($line='    # shellcheck source=/dev/null')
${line}
#set($line='    [[ -r ${configfile} ]] && source "${configfile}"')
${line}
#set($line='  fi')
${line}
#set($line='  jarfile=$(readlink "$jarfile")')
${line}
#set($line='  cd "$(dirname "$jarfile")" || exit 1')
${line}
#set($line='  jarfile=$(pwd)/$(basename "$jarfile")')
${line}
#set($line='done')
${line}
#set($line='jarfolder="$( (cd "$(dirname "$jarfile")" && pwd -P) )"')
${line}
#set($line='cd "$WORKING_DIR" || exit 1')
${line}

#set($line='# Inline script specified in build properties')
${line}


#set($line='# Source any config file')
${line}
#set($line='configfile="$(basename "${jarfile%.*}.conf")"')
${line}

#set($line='# Initialize CONF_FOLDER location defaulting to jarfolder')
${line}
#set($line='[[ -z "$CONF_FOLDER" ]] && CONF_FOLDER="${jarfolder}"')
${line}
#set($line='# shellcheck source=/dev/null')
${line}
#set($line='[[ -r "${CONF_FOLDER}/${configfile}" ]] && source "${CONF_FOLDER}/${configfile}"')
${line}

#set($line='# ANSI Colors')
${line}
#set($line='echoRed() { echo $''\e[0;31m''"$1"$''\e[0m''; }')
${line}
#set($line='echoGreen() { echo $''\e[0;32m''"$1"$''\e[0m''; }')
${line}
#set($line='echoYellow() { echo $''\e[0;33m''"$1"$''\e[0m''; }')
${line}

#set($line='# Initialize PID/LOG locations if they weren''t provided by the config file')
${line}
#set($line='[[ -z "$PID_FOLDER" ]] && PID_FOLDER="/var/run"')
${line}
#set($line='[[ -z "$LOG_FOLDER" ]] && LOG_FOLDER="/var/log"')
${line}
#set($line='! [[ "$PID_FOLDER" == /* ]] && PID_FOLDER="$(dirname "$jarfile")"/"$PID_FOLDER"')
${line}
#set($line='! [[ "$LOG_FOLDER" == /* ]] && LOG_FOLDER="$(dirname "$jarfile")"/"$LOG_FOLDER"')
${line}
#set($line='! [[ -x "$PID_FOLDER" ]] && echoYellow "PID_FOLDER $PID_FOLDER does not exist. Falling back to /tmp" && PID_FOLDER="/tmp"')
${line}
#set($line='! [[ -x "$LOG_FOLDER" ]] && echoYellow "LOG_FOLDER $LOG_FOLDER does not exist. Falling back to /tmp" && LOG_FOLDER="/tmp"')
${line}

#set($line='# Set up defaults')
${line}
#set($line='[[ -z "$MODE" ]] && MODE="auto" # modes are "auto", "service" or "run"')
${line}
#set($line='[[ -z "$USE_START_STOP_DAEMON" ]] && USE_START_STOP_DAEMON="true"')
${line}

#set($line='# Create an identity for log/pid files')
${line}
#set($line='if [[ -z "$identity" ]]; then')
${line}
#set($line='  if [[ -n "$init_script" ]]; then')
${line}
#set($line='    identity="${init_script}"')
${line}
#set($line='  else')
${line}
#set($line='    identity=$(basename "${jarfile%.*}")_${jarfolder//\//}')
${line}
#set($line='  fi')
${line}
#set($line='fi')
${line}

#set($line='# Initialize log file name if not provided by the config file')
${line}
#set($line='[[ -z "$LOG_FILENAME" ]] && LOG_FILENAME="${identity}.log"')
${line}

#set($line='# Initialize stop wait time if not provided by the config file')
${line}
#set($line='[[ -z "$STOP_WAIT_TIME" ]] && STOP_WAIT_TIME="60"')
${line}

#set($line='# Utility functions')
${line}
#set($line='checkPermissions() {')
${line}
#set($line='  touch "$pid_file" &> /dev/null || { echoRed "Operation not permitted (cannot access pid file)"; return 4; }')
${line}
#set($line='  touch "$log_file" &> /dev/null || { echoRed "Operation not permitted (cannot access log file)"; return 4; }')
${line}
#set($line='}')
${line}

#set($line='isRunning() {')
${line}
#set($line='  ps -p "$1" &> /dev/null')
${line}
#set($line='}')
${line}

#set($line='await_file() {')
${line}
#set($line='  end=$(date +%s)')
${line}
#set($line='  let "end+=10"')
${line}
#set($line='  while [[ ! -s "$1" ]]')
${line}
#set($line='  do')
${line}
#set($line='    now=$(date +%s)')
${line}
#set($line='    if [[ $now -ge $end ]]; then')
${line}
#set($line='      break')
${line}
#set($line='    fi')
${line}
#set($line='    sleep 1')
${line}
#set($line='  done')
${line}
#set($line='}')
${line}

#set($line='# Determine the script mode')
${line}
#set($line='action="status"')
${line}
#set($line='if [[ "$MODE" == "auto" && -n "$init_script" ]] || [[ "$MODE" == "service" ]]; then')
${line}
#set($line='  action="$1"')
${line}
#set($line='  shift')
${line}
#set($line='fi')
${line}

#set($line='# Build the pid and log filenames')
${line}
#set($line='PID_FOLDER="$PID_FOLDER/${identity}"')
${line}
#set($line='pid_file="$PID_FOLDER/${identity}.pid"')
${line}
#set($line='log_file="$LOG_FOLDER/$LOG_FILENAME"')
${line}

#set($line='# Determine the user to run as if we are root')
${line}
#set($line='# shellcheck disable=SC2012')
${line}
#set($line='[[ $(id -u) == "0" ]] && run_user=$(ls -ld "$jarfile" | awk ''{print $3}'')')
${line}

#set($line='# Issue a warning if the application will run as root')
${line}
#set($line='[[ $(id -u ${run_user}) == "0" ]] && { echoYellow "Application is running as root (UID 0). This is considered insecure."; }')
${line}

#set($line='# Find Java')
${line}
#set($line='if [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]]; then')
${line}
#set($line='    javaexe="$JAVA_HOME/bin/java"')
${line}
#set($line='elif type -p java > /dev/null 2>&1; then')
${line}
#set($line='    javaexe=$(type -p java)')
${line}
#set($line='elif [[ -x "/usr/bin/java" ]];  then')
${line}
#set($line='    javaexe="/usr/bin/java"')
${line}
#set($line='else')
${line}
#set($line='    echo "Unable to find Java"')
${line}
#set($line='    exit 1')
${line}
#set($line='fi')
${line}

#set($line='arguments=(-Dsun.misc.URLClassPath.disableJarChecking=true $JAVA_OPTS -jar "$jarfile" $RUN_ARGS "$@")')
${line}

#set($line='# Action functions')
${line}
#set($line='start() {')
${line}
#set($line='  if [[ -f "$pid_file" ]]; then')
${line}
#set($line='    pid=$(cat "$pid_file")')
${line}
#set($line='    isRunning "$pid" && { echoYellow "Already running [$pid]"; return 0; }')
${line}
#set($line='  fi')
${line}
#set($line='  do_start "$@"')
${line}
#set($line='}')
${line}

#set($line='do_start() {')
${line}
#set($line='  working_dir=$(dirname "$jarfile")')
${line}
#set($line='  pushd "$working_dir" > /dev/null')
${line}
#set($line='  if [[ ! -e "$PID_FOLDER" ]]; then')
${line}
#set($line='    mkdir -p "$PID_FOLDER" &> /dev/null')
${line}
#set($line='    if [[ -n "$run_user" ]]; then')
${line}
#set($line='      chown "$run_user" "$PID_FOLDER"')
${line}
#set($line='    fi')
${line}
#set($line='  fi')
${line}
#set($line='  if [[ ! -e "$log_file" ]]; then')
${line}
#set($line='    touch "$log_file" &> /dev/null')
${line}
#set($line='    if [[ -n "$run_user" ]]; then')
${line}
#set($line='      chown "$run_user" "$log_file"')
${line}
#set($line='    fi')
${line}
#set($line='  fi')
${line}
#set($line='  if [[ -n "$run_user" ]]; then')
${line}
#set($line='    checkPermissions || return $?')
${line}
#set($line='    if [ $USE_START_STOP_DAEMON = true ] && type start-stop-daemon > /dev/null 2>&1; then')
${line}
#set($line='      start-stop-daemon --start --quiet \')
${line}
#set($line='        --chuid "$run_user" \')
${line}
#set($line='        --name "$identity" \')
${line}
#set($line='        --make-pidfile --pidfile "$pid_file" \')
${line}
#set($line='        --background --no-close \')
${line}
#set($line='        --startas "$javaexe" \')
${line}
#set($line='        --chdir "$working_dir" \')
${line}
#set($line='        -- "${arguments[@]}" \')
${line}
#set($line='        >> "$log_file" 2>&1')
${line}
#set($line='      await_file "$pid_file"')
${line}
#set($line='    else')
${line}
#set($line='      su -s /bin/sh -c "$javaexe $(printf "\"%s\" " "${arguments[@]}") >> \"$log_file\" 2>&1 & echo \$!" "$run_user" > "$pid_file"')
${line}
#set($line='    fi')
${line}
#set($line='    pid=$(cat "$pid_file")')
${line}
#set($line='  else')
${line}
#set($line='    checkPermissions || return $?')
${line}
#set($line='    "$javaexe" "${arguments[@]}" >> "$log_file" 2>&1 &')
${line}
#set($line='    pid=$!')
${line}
#set($line='    disown $pid')
${line}
#set($line='    echo "$pid" > "$pid_file"')
${line}
#set($line='  fi')
${line}
#set($line='  [[ -z $pid ]] && { echoRed "Failed to start"; return 1; }')
${line}
#set($line='  echoGreen "Started [$pid]"')
${line}
#set($line='}')
${line}

#set($line='stop() {')
${line}
#set($line='  working_dir=$(dirname "$jarfile")')
${line}
#set($line='  pushd "$working_dir" > /dev/null')
${line}
#set($line='  [[ -f $pid_file ]] || { echoYellow "Not running (pidfile not found)"; return 0; }')
${line}
#set($line='  pid=$(cat "$pid_file")')
${line}
#set($line='  isRunning "$pid" || { echoYellow "Not running (process ${pid}). Removing stale pid file."; rm -f "$pid_file"; return 0; }')
${line}
#set($line='  do_stop "$pid" "$pid_file"')
${line}
#set($line='}')
${line}

#set($line='do_stop() {')
${line}
#set($line='  kill "$1" &> /dev/null || { echoRed "Unable to kill process $1"; return 1; }')
${line}
#set($line='  for i in $(seq 1 $STOP_WAIT_TIME); do')
${line}
#set($line='    isRunning "$1" || { echoGreen "Stopped [$1]"; rm -f "$2"; return 0; }')
${line}
#set($line='    [[ $i -eq STOP_WAIT_TIME/2 ]] && kill "$1" &> /dev/null')
${line}
#set($line='    sleep 1')
${line}
#set($line='  done')
${line}
#set($line='  echoRed "Unable to kill process $1";')
${line}
#set($line='  return 1;')
${line}
#set($line='}')
${line}

#set($line='force_stop() {')
${line}
#set($line='  [[ -f $pid_file ]] || { echoYellow "Not running (pidfile not found)"; return 0; }')
${line}
#set($line='  pid=$(cat "$pid_file")')
${line}
#set($line='  isRunning "$pid" || { echoYellow "Not running (process ${pid}). Removing stale pid file."; rm -f "$pid_file"; return 0; }')
${line}
#set($line='  do_force_stop "$pid" "$pid_file"')
${line}
#set($line='}')
${line}

#set($line='do_force_stop() {')
${line}
#set($line='  kill -9 "$1" &> /dev/null || { echoRed "Unable to kill process $1"; return 1; }')
${line}
#set($line='  for i in $(seq 1 $STOP_WAIT_TIME); do')
${line}
#set($line='    isRunning "$1" || { echoGreen "Stopped [$1]"; rm -f "$2"; return 0; }')
${line}
#set($line='    [[ $i -eq STOP_WAIT_TIME/2 ]] && kill -9 "$1" &> /dev/null')
${line}
#set($line='    sleep 1')
${line}
#set($line='  done')
${line}
#set($line='  echoRed "Unable to kill process $1";')
${line}
#set($line='  return 1;')
${line}
#set($line='}')
${line}

#set($line='restart() {')
${line}
#set($line='  stop && start')
${line}
#set($line='}')
${line}

#set($line='force_reload() {')
${line}
#set($line='  working_dir=$(dirname "$jarfile")')
${line}
#set($line='  pushd "$working_dir" > /dev/null')
${line}
#set($line='  [[ -f $pid_file ]] || { echoRed "Not running (pidfile not found)"; return 7; }')
${line}
#set($line='  pid=$(cat "$pid_file")')
${line}
#set($line='  rm -f "$pid_file"')
${line}
#set($line='  isRunning "$pid" || { echoRed "Not running (process ${pid} not found)"; return 7; }')
${line}
#set($line='  do_stop "$pid" "$pid_file"')
${line}
#set($line='  do_start')
${line}
#set($line='}')
${line}

#set($line='status() {')
${line}
#set($line='  working_dir=$(dirname "$jarfile")')
${line}
#set($line='  pushd "$working_dir" > /dev/null')
${line}
#set($line='  [[ -f "$pid_file" ]] || { echoRed "Not running"; return 3; }')
${line}
#set($line='  pid=$(cat "$pid_file")')
${line}
#set($line='  isRunning "$pid" || { echoRed "Not running (process ${pid} not found)"; return 1; }')
${line}
#set($line='  echoGreen "Running [$pid]"')
${line}
#set($line='  return 0')
${line}
#set($line='}')
${line}

#set($line='run() {')
${line}
#set($line='  pushd "$(dirname "$jarfile")" > /dev/null')
${line}
#set($line='  "$javaexe" "${arguments[@]}"')
${line}
#set($line='  result=$?')
${line}
#set($line='  popd > /dev/null')
${line}
#set($line='  return "$result"')
${line}
#set($line='}')
${line}

#set($line='# Call the appropriate action function')
${line}
#set($line='case "$action" in')
${line}
#set($line='start)')
${line}
#set($line='  start "$@"; exit $?;;')
${line}
#set($line='stop)')
${line}
#set($line='  stop "$@"; exit $?;;')
${line}
#set($line='force-stop)')
${line}
#set($line='  force_stop "$@"; exit $?;;')
${line}
#set($line='restart)')
${line}
#set($line='  restart "$@"; exit $?;;')
${line}
#set($line='force-reload)')
${line}
#set($line='  force_reload "$@"; exit $?;;')
${line}
#set($line='status)')
${line}
#set($line='  status "$@"; exit $?;;')
${line}
#set($line='run)')
${line}
#set($line='  run "$@"; exit $?;;')
${line}
#set($line='*)')
${line}
#set($line='  echo "Usage: $0 {start|stop|force-stop|restart|force-reload|status|run}"; exit 1;')
${line}
#set($line='esac')
${line}

exit 0