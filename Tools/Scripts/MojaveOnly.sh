if [ -z "$SELF_PATH" ]; then
    echo "Use Build.sh, aborting..."
    exit 1
fi

# Paths
MOJAVE_ONLY_PATH="$SELF_PATH/MojaveOnly"

# Copy kexts
# Mojave installer can be started on 10.8+

# Mountain Lion
mkdir -p "$BUILD_PATH/Clover/kexts/10.8"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.8"

# Maverics
mkdir -p "$BUILD_PATH/Clover/kexts/10.9"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.9"

# Yosemite
mkdir -p "$BUILD_PATH/Clover/kexts/10.10"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.10"

# El Capitan
mkdir -p "$BUILD_PATH/Clover/kexts/10.11"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.11"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.12"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.12"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.13"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.13"

# Mojave
mkdir -p "$BUILD_PATH/Clover/kexts/10.14"
cp -v -R "$MOJAVE_ONLY_PATH/Kexts/." "$BUILD_PATH/Clover/kexts/10.14"

# Copy mojave2core tool
cp -v "$MOJAVE_ONLY_PATH/Tools/mojave2core" "$BUILD_PATH/"
