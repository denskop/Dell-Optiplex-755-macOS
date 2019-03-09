#!/bin/bash

SELF_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# EC
ADD_EC_DEVICE="No"

if [ "$1" == "--debug" ]; then
	DEBUG="1"
else
	DEBUG="0"
fi

# Additional paths
ORIGIN_PATH="$SELF_PATH/Origin"

TOOLS_PATH="$SELF_PATH/Tools"
SCRIPTS_PATH="$TOOLS_PATH/Scripts"

## ACPI
source "$SCRIPTS_PATH/PatchAcpi.sh"

## Bootloader
source "$SCRIPTS_PATH/ConstructClover.sh"

## Settings
source "$SCRIPTS_PATH/ApplySettings.sh"

## Mojave workaround
source "$SCRIPTS_PATH/MojaveOnly.sh"