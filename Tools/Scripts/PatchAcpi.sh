if [ -z "$SELF_PATH" ]; then
    echo "Use Build.sh, aborting..."
    exit 1
fi

# Paths
ACPI_EXTRA_PATH="$SELF_PATH/AcpiExtra"
ACPI_PATCHES_PATH="$SELF_PATH/AcpiPatches"
TEMP_PATH="/tmp"

# Tools
IASL="$TOOLS_PATH/iasl"
IASL_FLAGS=""
PATCH="$TOOLS_PATH/patchmatic"
PATCH2="$TOOLS_PATH/patch.sh"

# Clover
CLOVER_CONFIG_PLIST="$SELF_PATH/EFI/Clover/config.plist"

# Clover settings
SMBIOS=$(/usr/libexec/PlistBuddy -c "Print :SMBIOS:ProductName" "$CLOVER_CONFIG_PLIST")

# Remove dsl folder
rm -rf "$TEMP_PATH/Dsl"

# Check origin folder
cpu_cores_array=(2 2 4)
dump_bios_array=(A12 A22 A22)
cpu_cores_array_len=${#cpu_cores_array[@]}
dump_bios_array_len=${#dump_bios_array[@]}

if ((cpu_cores_array_len != dump_bios_array_len)); then
    echo "ERROR: cpu_cores_array != dump_bios_array"
    exit 1
fi

if (( "$(find "$ORIGIN_PATH/"*.aml -type f | wc -l)" == 0)); then
    echo "No ACPI tables found. Origin folder is empty!"
    echo "Available dumps:"

    for ((i=0; i<$cpu_cores_array_len; i++)); do
        echo "[ $i ] CPU ${cpu_cores_array[$i]} Cores; BIOS ${dump_bios_array[$i]};"
    done
    echo "[ q ] quit;"
    read -p "Select choose: " dumpIndex || exit 1

    # Quit
    if (( dumpIndex == q )); then exit 1 ; fi

    # Set origin path
    ORIGIN_PATH="$SELF_PATH/Origin${dump_bios_array[$dumpIndex]}/Dump_${cpu_cores_array[$dumpIndex]}Cores"
fi

## Disassemble acpi tables

pushd "$ORIGIN_PATH" > /dev/null

# SSDT, DSDT
$IASL -dl -in -da SSDT*.aml DSDT.aml

# Other tables
# $IASL -dl "$ORIGIN_PATH/APIC.aml"
$IASL -dl ASF!.aml
$IASL -dl HPET.aml
$IASL -dl MCFG.aml

popd > /dev/null

# Move dsl
mkdir -p "$TEMP_PATH/Dsl"
mv "$ORIGIN_PATH/"*.dsl "$TEMP_PATH/Dsl"

# Rename ssdt tables
pushd "$TEMP_PATH/Dsl" > /dev/null

for ssdt in *; do
    mv "$ssdt" $(echo "$ssdt" | sed -e 's/-[0-9]*-/_/g')
done

# Count speedstep tables
SSDT_IST_COUNT=$(ls -1 SSDT*Cpu*Ist.dsl 2>/dev/null | wc -l | grep -o "[0-9]")

mkdir -p "$TEMP_PATH/Dsl/Build"
case "$SSDT_IST_COUNT" in
    "2")
    echo "#define CPU_CORES_NUM 2" >> "$TEMP_PATH/Dsl/Build/Config.dsl"
    echo "#define IMAC_10_1_PM" >> "$TEMP_PATH/Dsl/Build/Config.dsl"
    ;;
    "4")
    echo "#define CPU_CORES_NUM 4" >> "$TEMP_PATH/Dsl/Build/Config.dsl"
    echo "#define MAC_PRO_5_1_PM" >> "$TEMP_PATH/Dsl/Build/Config.dsl"
    ;;
    *)
    echo "Bad count of speedstep tables"
    exit 1
    ;;
esac

if [ "$DEBUG" == "1" ]; then
    echo "#define DEBUG" >> "$TEMP_PATH/Dsl/Build/Config.dsl"  
fi

if [ "$PSKB_EN" == "1" ]; then
    echo "#define PSKB_ENABLED" >> "$TEMP_PATH/Dsl/Build/Config.dsl"
fi

popd > /dev/null

## Patch acpi tables

# DSDT

# Obsolete
#$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixCRS_Ver1.txt
#$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixGPE.txt
#$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixIPIC.txt
#$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixPTS.txt

# Fix ACPI errors (Minimum set for compilation)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixErrors.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_RemoveCRS.txt

# Fix ACPI warnings (from IASL)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixFields.txt

# Dependencies
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixADR.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Rename.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"xSDT_RenameLPC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AppleSpecific.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixPTS2.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixWAK.txt

# Fix macOS errors (bad work)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixHPET.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixRTC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixIRQ.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixMutex.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddFakeEC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixOSInit.txt
$PATCH "$TEMP_PATH/Dsl/"SSDT_st_ex.dsl "$ACPI_PATCHES_PATH/"SSDT_External.txt

if [[ "$SMBIOS" == iMac* ]]; then
    $PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddSLPB.txt
elif [[ "$SMBIOS" == MacPro* ]]; then
    $PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixPWRB.txt
fi

# Dell specific
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_DellSpecific.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixPowerDialog.txt

# Fix ACPI warnings (from kernel log)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_PCI.txt

# Apple style fixes
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_CpuSection.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_HideUseless.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddSmbus.txt

# Other fixes
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixEHCI.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixUHCI.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixUID.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddAPIC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddBBN.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddGFX0.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddGLAN.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddOSC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddOther.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddPciDev.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddPNOT.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddTempSensors.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddUART.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_GRFX.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Sata.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_ConfigPSKb.txt

# SSDT
for i in `seq 0 $((SSDT_IST_COUNT - 1))`; do
    $PATCH "$TEMP_PATH/Dsl/"SSDT_Cpu"$i"Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu"$i"Ist.txt
done

$PATCH "$TEMP_PATH/Dsl/"SSDT_CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm.txt

case "$SSDT_IST_COUNT" in
    "2")
    $PATCH "$TEMP_PATH/Dsl/"SSDT_CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm_Core2Duo.txt
    ;;
    "4")
    $PATCH "$TEMP_PATH/Dsl/"SSDT_CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm_Core2Quad.txt
    ;;
    *)
    echo "Bad count of speedstep tables"
    exit 1
    ;;
esac

## Patch2 acpi tables

# SSDT
$PATCH "$TEMP_PATH/Dsl/"SSDT_st_ex.dsl "$ACPI_PATCHES_PATH/"xSDT_RenameLPC.txt

# DSDT
if [[ "$SMBIOS" == iMac* ]]; then
    $PATCH2 "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Header_iMac.txt
elif [[ "$SMBIOS" == MacPro* ]]; then
    $PATCH2 "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Header_MacPro.txt
fi

# SSDT
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_st_ex.dsl "$ACPI_PATCHES_PATH/"SSDT_External.txt
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_Cpu0Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu0Ist.txt
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_Cpu1Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu1Ist.txt
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm.txt

# More
#$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"APIC.txt
#$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
#$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
#$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

$PATCH2 "$TEMP_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"ASF!.txt
$PATCH2 "$TEMP_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$TEMP_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$TEMP_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

$PATCH2 "$TEMP_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"HPET.txt
$PATCH2 "$TEMP_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$TEMP_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$TEMP_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

$PATCH2 "$TEMP_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"MCFG.txt
$PATCH2 "$TEMP_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$TEMP_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$TEMP_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

## Compile acpi tables

$IASL -I "$TEMP_PATH/Dsl/Build" -ve "$TEMP_PATH/Dsl/"*.dsl

pushd "$ACPI_EXTRA_PATH" > /dev/null

for file in *; do
    if [[ "$file" =~ ^SSDT_Cpu.*\.dsl ]] && [ "$(echo $file | grep -o "[0-9]")" -ge "$SSDT_IST_COUNT" ]; then
        echo "Skip $file"
        continue
    fi
    
    echo "Compile $file"
    $IASL -I "$TEMP_PATH/Dsl/Build" -ve "$file"
done

popd > /dev/null