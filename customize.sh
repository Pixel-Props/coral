# Module variables
MOD_PROP_MODEL=`grep_prop ro.product.model $MODPATH/system.prop`
MOD_PROP_PRODUCT=`grep_prop ro.build.product $MODPATH/system.prop | tr '[:lower:]' '[:upper:]'`
MOD_PROP_VERSION=`grep_prop ro.build.version.release $MODPATH/system.prop`
MOD_PROP_SECURITYPATCH=`grep_prop ro.build.version.security_patch $MODPATH/system.prop`
MOD_PROP_VERSIONCODE=`date -d $MOD_PROP_SECURITYPATCH '+%y%m%d'`
MOD_PROP_MONTH=`date -d $MOD_PROP_SECURITYPATCH '+%B'`
MOD_PROP_YEAR=`date -d $MOD_PROP_SECURITYPATCH '+%Y'`

# Print head message
ui_print "- Installing, $MOD_PROP_MODEL ($MOD_PROP_PRODUCT) Prop - $MOD_PROP_MONTH $MOD_PROP_YEAR"

# Checking if the system sdk matches the module sdk
MOD_API=`grep_prop ro.build.version.sdk $MODPATH/system.prop | grep -ohE '[0-9]{2}'`

if [ $API -gt $MOD_API ]; then
  ui_print "- SDK=$API, running unsafe mode"
else
  sed -i 's/^ro.build.version.sdk/# ro.build.version.sdk/' $MODPATH/system.prop
  ui_print "- SDK=$API, running safe mode"
fi

# Print footer message
ui_print "- By Tesla, Telegram: @T3SL4"