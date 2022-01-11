#shellcheck shell=dash
ui_print "- Setting up CA certificates"
mkdir -p "$MODPATH"/system/etc/security/cacerts
cp -f "$MODPATH"/system/etc/security/cacerts/* "$MODPATH"/system/etc/security/cacerts/
chown -R 0:0 "$MODPATH"/system/etc/security/cacerts

default_selinux_context=u:object_r:system_file:s0
# shellcheck disable=SC2012
selinux_context=$(ls -Zd /system/etc/security/cacerts | awk '{print $1}')

if [ -n "$selinux_context" ] && [ "$selinux_context" != "?" ]; then
    chcon -R "$selinux_context" "$MODDIR"/system/etc/security/cacerts
else
    chcon -R $default_selinux_context "$MODDIR"/system/etc/security/cacerts
fi