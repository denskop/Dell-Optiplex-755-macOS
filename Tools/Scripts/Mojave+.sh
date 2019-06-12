if [ -z "$SELF_PATH" ]; then
    echo "Use Build.sh, aborting..."
    exit 1
fi

# Paths
MOJAVE_PLUS_PATH="$SELF_PATH/Mojave+"

# Copy kexts
# Mojave installer can be started on 10.8+

# Mountain Lion
mkdir -p "$BUILD_PATH/Clover/kexts/10.8"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.8"

# Maverics
mkdir -p "$BUILD_PATH/Clover/kexts/10.9"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.9"

# Yosemite
mkdir -p "$BUILD_PATH/Clover/kexts/10.10"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.10"

# El Capitan
mkdir -p "$BUILD_PATH/Clover/kexts/10.11"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.11"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.12"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.12"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.13"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.13"

# Mojave
mkdir -p "$BUILD_PATH/Clover/kexts/10.14"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.14"

# Catalina
mkdir -p "$BUILD_PATH/Clover/kexts/10.15"
cp -v -R "$MOJAVE_PLUS_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.15"

# Restore Atheros WiFi kext
if [ $ATH9_KEXT_RESTORE == "1" ]; then
    cp -v -R "$MOJAVE_PLUS_PATH/CatalinaRollback/." "$BUILD_PATH/Clover/kexts/10.15"
fi

# Copy mojave2core tool
#cp -v "$MOJAVE_PLUS_PATH/Tools/mojave2core" "$BUILD_PATH/"

# Copy removeTelemetry tool
cp -v "$MOJAVE_PLUS_PATH/Tools/removeTelemetry" "$BUILD_PATH/"
