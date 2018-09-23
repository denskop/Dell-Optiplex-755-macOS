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

# Remove dsl folder
rm -rf "$TEMP_PATH/Dsl"

## Disassemble acpi tables

# SSDT, DSDT
$IASL -dl -da "$ORIGIN_PATH/SSDT"* "$ORIGIN_PATH/DSDT.aml"

# Other tables
$IASL -dl "$ORIGIN_PATH/APIC.aml"
$IASL -dl "$ORIGIN_PATH/ASF!.aml"
$IASL -dl "$ORIGIN_PATH/HPET.aml"
$IASL -dl "$ORIGIN_PATH/MCFG.aml"

# Move dsl
mkdir -p "$TEMP_PATH/Dsl"
mv "$ORIGIN_PATH/"*.dsl "$TEMP_PATH/Dsl"

## Rename acpi tables
mv "$TEMP_PATH/Dsl/SSDT-0-st_ex.dsl" "$TEMP_PATH/Dsl/SSDT_st_ex.dsl" 
mv "$TEMP_PATH/Dsl/SSDT-1-Cpu0Ist.dsl" "$TEMP_PATH/Dsl/SSDT_Cpu0Ist.dsl"
mv "$TEMP_PATH/Dsl/SSDT-2-Cpu1Ist.dsl" "$TEMP_PATH/Dsl/SSDT_Cpu1Ist.dsl"
mv "$TEMP_PATH/Dsl/SSDT-3-CpuPm.dsl" "$TEMP_PATH/Dsl/SSDT_CpuPm.dsl"

## Patch acpi tables

# DSDT

# Fix ACPI errors (Minimum set for compilation)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixErrors.txt
#$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixCRS_Ver1.txt

# Fix ACPI warnings (from IASL)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixFields.txt

# Fix macOS errors (bad work)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixHPET.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixMutex.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddFakeEC.txt

# Dependencies
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_RemoveCRS.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixADR.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Rename.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"xSDT_RenameLPC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AppleSpecific.txt

# Fix ACPI warnings (from kernel log)
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_PCI.txt


# Apple style fixes
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_CpuSection.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixIPIC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_HideUseless.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddSmbus.txt

# Other fixes
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixUHCI.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixUID.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixPTS.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixWAK.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddAPIC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddBBN.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddGFX0.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddGLAN.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddOSC.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddOther.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddUART.txt
$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Sata.txt

# Deal with EC emulation
#if [ $ADD_EC_DEVICE = "Yes" ]; then
    #$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_PSKbAsEC.txt
#else
    #$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_HidePSKb.txt
    #$PATCH "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_AddFakeEC.txt
#fi

# SSDT
$PATCH "$TEMP_PATH/Dsl/"SSDT_Cpu0Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu0Ist.txt
$PATCH "$TEMP_PATH/Dsl/"SSDT_Cpu1Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu1Ist.txt
$PATCH "$TEMP_PATH/Dsl/"SSDT_CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm.txt

## Patch2 acpi tables

# SSDT
$PATCH "$TEMP_PATH/Dsl/"SSDT_st_ex.dsl "$ACPI_PATCHES_PATH/"xSDT_RenameLPC.txt

# DSDT
$PATCH2 "$TEMP_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Header.txt

# SSDT
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_st_ex.dsl "$ACPI_PATCHES_PATH/"SSDT_External.txt
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_Cpu0Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu0Ist.txt
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_Cpu1Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu1Ist.txt
$PATCH2 "$TEMP_PATH/Dsl/"SSDT_CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm.txt

# More
#$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"APIC.txt
$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$TEMP_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

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

$IASL -ve "$TEMP_PATH/Dsl/"*.dsl
$IASL -ve "$ACPI_EXTRA_PATH/"*.dsl
