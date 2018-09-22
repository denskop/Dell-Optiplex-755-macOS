if [ -z "$SELF_PATH" ]; then
    echo "Use Build.sh, aborting..."
    exit 1
fi

# Filenames
SETTINGS_PLIST="$SELF_PATH/Settings.plist"
CLOVER_CONFIG_PLIST="$BUILD_PATH/Clover/config.plist"

function IsTrue()
{
    VAL=$(/usr/libexec/PlistBuddy -c "Print $1" $2)

    if [ "$VAL" == "true" ]; then
        return 1
    fi

    return 0
}

function AddSetting()
{
    /usr/libexec/PlistBuddy -c "Add $1 $3 $2" $CLOVER_CONFIG_PLIST
}

function MoveSetting()
{
    VAL=$(/usr/libexec/PlistBuddy -c "Print $1" $SETTINGS_PLIST)

    if [ "$VAL" != "" ]; then
        /usr/libexec/PlistBuddy -c "Add $2 $3 $VAL" $CLOVER_CONFIG_PLIST
    fi
}

# Set BoardInfo
MoveSetting ":BoardInfo:ProductName" ":SMBIOS:ProductName" string
MoveSetting ":BoardInfo:BoardSerialNumber" ":SMBIOS:BoardSerialNumber" string
MoveSetting ":BoardInfo:SerialNumber" ":SMBIOS:SerialNumber" string
MoveSetting ":BoardInfo:MLB" ":RtVariables:MLB" string
#MoveSetting ":BoardInfo:ROM" ":RtVariables:ROM" data

# Set Boot
MoveSetting ":Boot:Arguments" ":Boot:Arguments" string

# Set GUI
MoveSetting ":GUI:Language" ":GUI:Language" string
MoveSetting ":GUI:ScreenResolution" ":GUI:ScreenResolution" string

IsTrue ":GUI:DarkTheme" "$SETTINGS_PLIST"
if [ "$?" -eq 1 ]; then
    AddSetting ":GUI:Theme" "AppleBlack" string
else
    AddSetting ":GUI:Theme" "AppleGray" string
fi

# Set SIP
MoveSetting ":SIP:CsrActiveConfig" ":RtVariables:CsrActiveConfig" string
MoveSetting ":SIP:BooterConfig" ":RtVariables:BooterConfig" string

# Videocard
MoveSetting ":Videocard:Nvidia:Inject" ":Graphics:Inject:NVidia" bool
MoveSetting ":Videocard:Nvidia:NvidiaWeb" ":SystemParameters:NvidiaWeb" bool