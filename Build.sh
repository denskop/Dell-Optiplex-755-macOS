#!/bin/bash

SELF_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# EC
ADD_EC_DEVICE="No"

# Additional paths
ORIGIN_PATH="$SELF_PATH/OriginA22"

TOOLS_PATH="$SELF_PATH/Tools"
SCRIPTS_PATH="$TOOLS_PATH/Scripts"

## ACPI
source "$SCRIPTS_PATH/PatchAcpi.sh"

## Bootloader
source "$SCRIPTS_PATH/ConstructClover.sh"

## Settings
source "$SCRIPTS_PATH/ApplySettings.sh"