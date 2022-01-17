#shellcheck shell=dash
log 'INFO' 'Running update check'
ui_print "- Checking for module updates"
updateChecker 'self'
log 'INFO' "Remote version $response, local version $MODULE_VERSIONCODE"
if [ $response -gt "$MODULE_VERSIONCODE" ]; then
  ui_print " "
  ui_print "! Module updates found"
  ui_print "! Please update before installing"
  ui_print "! Installation aborted"
  ui_print " "
  abort "! Module updates found"
fi
ui_print "- Copying CA certificates"
mkdir -p "$MODPATH"/system/etc/security/cacerts
cp -f /data/misc/user/0/cacerts-added/* "$MODDIR"/system/etc/security/cacerts
chown -R 0:0 "$MODPATH"/system/etc/security/cacerts

default_selinux_context=u:object_r:system_file:s0
# shellcheck disable=SC2012
selinux_context=$(ls -Zd /system/etc/security/cacerts | awk '{print $1}')

if [ -n "$selinux_context" ] && [ "$selinux_context" != "?" ]; then
    chcon -R "$selinux_context" "$MODDIR"/system/etc/security/cacerts
else
    chcon -R $default_selinux_context "$MODDIR"/system/etc/security/cacerts
fi

am start -a android.intent.action.VIEW -d "https://www.androidacy.com/install-done/?f=movecert%20install&r=movecerts&v=$MODULE_VERSION" &>/dev/null
