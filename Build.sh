#!/bin/bash

SELF_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# EC
ADD_EC_DEVICE="No"

# Default behavior
DEBUG="0"
PSKB_EN="0"
ATH9_KEXT_RESTORE="0"

for arg in "$@"; do
  shift
  case "$arg" in
    "--debug") DEBUG="1" ;;
    "--ps2kb") PSKB_EN="1" ;;
    "--ath9") ATH9_KEXT_RESTORE="1" ;;
    *)
  esac
done

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

## Mojave+ workaround
source "$SCRIPTS_PATH/Mojave+.sh"