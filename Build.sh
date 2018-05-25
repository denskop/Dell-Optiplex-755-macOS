#!/bin/bash

SELF_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# EC
ADD_EC_DEVICE="Yes"

# Additional paths
ACPI_PATCHES_PATH="$SELF_PATH/AcpiPatches"
BUILD_PATH="$SELF_PATH/Build"
CLOVER_PATH="$SELF_PATH/Clover"
ORIGIN_PATH="$SELF_PATH/OriginA12"
TOOLS_PATH="$SELF_PATH/Tools"

# Tools
IASL="$TOOLS_PATH/iasl"
IASL_FLAGS=""
PATCH="$TOOLS_PATH/patchmatic"
PATCH2="$TOOLS_PATH/patch.sh"

## Disassemble acpi tables

# SSDT, DSDT
$IASL -dl -da "$ORIGIN_PATH/AcpiDump/SSDT"* "$ORIGIN_PATH/AcpiDump/DSDT.aml"

# Other tables
$IASL -dl "$ORIGIN_PATH/AcpiDump/APIC.aml"
$IASL -dl "$ORIGIN_PATH/AcpiDump/ASF!.aml"
$IASL -dl "$ORIGIN_PATH/AcpiDump/HPET.aml"
$IASL -dl "$ORIGIN_PATH/AcpiDump/MCFG.aml"

# Move dsl
mkdir -p "$BUILD_PATH/Dsl"
mv "$ORIGIN_PATH/AcpiDump/"*.dsl "$BUILD_PATH/Dsl"

## Patch acpi tables

# DSDT

# Minimum set for compilation
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixErrors.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixFields.txt

# Custom
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_CpuSection.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixHPET.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixIPIC.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_FixMutex.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_HideDevices.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_RenameLPC.txt
$PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Rename.txt

# Deal with EC emulation
if [ $ADD_EC_DEVICE = "Yes" ]; then
    $PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_PSKbAsEC.txt
else
    $PATCH "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_HidePSKb.txt
fi

## Patch2 acpi tables

# SSDT
$PATCH "$BUILD_PATH/Dsl/"SSDT-0-st_ex.dsl "$ACPI_PATCHES_PATH/"DSDT_RenameLPC.txt

# DSDT
$PATCH2 "$BUILD_PATH/Dsl/"DSDT.dsl "$ACPI_PATCHES_PATH/"DSDT_Header.txt

# SSDT
$PATCH2 "$BUILD_PATH/Dsl/"SSDT-0-st_ex.dsl "$ACPI_PATCHES_PATH/"SSDT_External.txt
$PATCH2 "$BUILD_PATH/Dsl/"SSDT-1-Cpu0Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu0Ist.txt
$PATCH2 "$BUILD_PATH/Dsl/"SSDT-2-Cpu1Ist.dsl "$ACPI_PATCHES_PATH/"SSDT_Cpu1Ist.txt
$PATCH2 "$BUILD_PATH/Dsl/"SSDT-3-CpuPm.dsl "$ACPI_PATCHES_PATH/"SSDT_CpuPm.txt

# More
#$PATCH2 "$BUILD_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"APIC.txt
$PATCH2 "$BUILD_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$BUILD_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$BUILD_PATH/Dsl/"APIC.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

$PATCH2 "$BUILD_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"ASF!.txt
$PATCH2 "$BUILD_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$BUILD_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$BUILD_PATH/Dsl/"ASF!.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

$PATCH2 "$BUILD_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"HPET.txt
$PATCH2 "$BUILD_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$BUILD_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$BUILD_PATH/Dsl/"HPET.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt

$PATCH2 "$BUILD_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"MCFG.txt
$PATCH2 "$BUILD_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"Table_Loki.txt
$PATCH2 "$BUILD_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"Table_OemID.txt
$PATCH2 "$BUILD_PATH/Dsl/"MCFG.dsl "$ACPI_PATCHES_PATH/"Table_OemTableID.txt
