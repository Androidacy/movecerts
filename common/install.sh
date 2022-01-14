#shellcheck shell=dash
ui_print "- Checking for module updates"
updateChecker
if [ $response -gt 1 ]; then
  ui_print " "
  ui_print "! Module updates found"
  ui_print "! Please update before installing"
  ui_print "! Installation aborted"
  ui_print " "
  abort "! Module updates found"
fi
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