if [ -z "$SELF_PATH" ]; then
    echo "Use Build.sh, aborting..."
    exit 1
fi

# Paths
BUILD_PATH="$SELF_PATH/Build"
KEXTS_PATH="$SELF_PATH/Kexts" 
EFI_PATH="$SELF_PATH/EFI"
CLOVER_PATH="$EFI_PATH/Clover"

# Remove build folder
rm -rf "$BUILD_PATH"

## Combine acpi tables
mkdir -p "$BUILD_PATH/Clover/ACPI/patched"
mv "$TEMP_PATH/Dsl/"*.aml "$BUILD_PATH/Clover/ACPI/patched"
mv "$ACPI_EXTRA_PATH/"*.aml "$BUILD_PATH/Clover/ACPI/patched"

if [ $ADD_EC_DEVICE != "Yes" ]; then
    rm "$BUILD_PATH/Clover/ACPI/patched/"ECDT.aml
fi

## Copy bootloader

# Clover
mkdir -p "$BUILD_PATH/Clover"
cp -v "$CLOVER_PATH/CLOVERX64.efi" "$BUILD_PATH/Clover"
cp -v "$CLOVER_PATH/config.plist" "$BUILD_PATH/Clover"

# drivers64
mkdir -p "$BUILD_PATH/Clover/drivers64"
cp -v -R "$CLOVER_PATH/Drivers/." "$BUILD_PATH/Clover/drivers64"
cp -v -R "$EFI_PATH/IntelDrivers/." "$BUILD_PATH/Clover/drivers64"

# kexts
mkdir -p "$BUILD_PATH/Clover/kexts"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.13"
cp -v -R "$KEXTS_PATH/macOS_10.13/." "$BUILD_PATH/Clover/kexts/10.13"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.13"

# themes
mkdir -p "$BUILD_PATH/Clover/themes"
cp -v -R "$CLOVER_PATH/Themes/." "$BUILD_PATH/Clover/themes"

# tools
mkdir -p "$BUILD_PATH/Clover/tools"
cp -v -R "$EFI_PATH/Tools/." "$BUILD_PATH/Clover/tools"