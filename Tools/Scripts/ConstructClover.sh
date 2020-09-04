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

# drivers
mkdir -p "$BUILD_PATH/Clover/drivers/BIOS"
cp -v -R "$CLOVER_PATH/Drivers/." "$BUILD_PATH/Clover/drivers/BIOS"

# Move OcQuirks.plist file to valid location
mkdir -p "$BUILD_PATH/Clover/drivers/UEFI"
mv -v "$BUILD_PATH/Clover/drivers/BIOS/OcQuirks.plist" "$BUILD_PATH/Clover/drivers/UEFI"

#cp -v -R "$EFI_PATH/IntelDrivers/." "$BUILD_PATH/Clover/drivers/BIOS"

# kexts
mkdir -p "$BUILD_PATH/Clover/kexts"

# Mountain Lion
mkdir -p "$BUILD_PATH/Clover/kexts/10.8"
cp -v -R "$KEXTS_PATH/macOS_10.8/." "$BUILD_PATH/Clover/kexts/10.8"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.8"

# Maverics
mkdir -p "$BUILD_PATH/Clover/kexts/10.9"
cp -v -R "$KEXTS_PATH/macOS_10.9/." "$BUILD_PATH/Clover/kexts/10.9"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.9"

# Yosemite
mkdir -p "$BUILD_PATH/Clover/kexts/10.10"
cp -v -R "$KEXTS_PATH/macOS_10.10/." "$BUILD_PATH/Clover/kexts/10.10"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.10"

# El Capitan
mkdir -p "$BUILD_PATH/Clover/kexts/10.11"
cp -v -R "$KEXTS_PATH/macOS_10.11/." "$BUILD_PATH/Clover/kexts/10.11"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.11"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.12"
cp -v -R "$KEXTS_PATH/macOS_10.12/." "$BUILD_PATH/Clover/kexts/10.12"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.12"

# High Sierra
mkdir -p "$BUILD_PATH/Clover/kexts/10.13"
cp -v -R "$KEXTS_PATH/macOS_10.13/." "$BUILD_PATH/Clover/kexts/10.13"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.13"

# Mojave
mkdir -p "$BUILD_PATH/Clover/kexts/10.14"
cp -v -R "$KEXTS_PATH/macOS_10.14/." "$BUILD_PATH/Clover/kexts/10.14"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.14"

# Catalina
mkdir -p "$BUILD_PATH/Clover/kexts/10.15"
cp -v -R "$KEXTS_PATH/macOS_10.15/." "$BUILD_PATH/Clover/kexts/10.15"
cp -v -R "$KEXTS_PATH/Universal/." "$BUILD_PATH/Clover/kexts/10.15"

# themes
mkdir -p "$BUILD_PATH/Clover/themes"
cp -v -R "$CLOVER_PATH/Themes/." "$BUILD_PATH/Clover/themes"

# tools
mkdir -p "$BUILD_PATH/Clover/tools"
cp -v -R "$EFI_PATH/Tools/." "$BUILD_PATH/Clover/tools"