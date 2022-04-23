#!/data/adb/magisk/busybox ash
# shellcheck shell=dash
MODDIR=${0%/*}

log() {
  # Send output to logcat
  command log -p "$1" -t "movecerts" "$2"
}

errtrap() {
  local r=$?
  if [ $r -ne 0 ]; then
    log "e" "Command failed with return code $r"
    exit 1
  else
    log 'd' "Al commands completed successfully"
    exit 0
  fi
}

trap 'errtrap' exit
# List of files to be moved
FILES=$(ls /data/misc/user/0/cacerts-added/)

# Log the files to be moved to logcat
log "d" "Files to be moved: $FILES"

{CMD} -f /data/misc/user/0/cacerts-added/* "$MODDIR"/system/etc/security/cacerts
chown -R 0:0 "$MODDIR"/system/etc/security/cacerts

[ "$(getenforce)" = "Enforcing" ] || exit 0

default_selinux_context=u:object_r:system_file:s0
# shellcheck disable=SC2012
selinux_context=$(ls -Zd /system/etc/security/cacerts | awk '{print $1}')

if [ -n "$selinux_context" ] && [ "$selinux_context" != "?" ]; then
    chcon -R "$selinux_context" "$MODDIR"/system/etc/security/cacerts
else
    chcon -R "$default_selinux_context" "$MODDIR"/system/etc/security/cacerts
fi

exit 0
