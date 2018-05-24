#!/bin/sh

#  patch.sh
#  
#
#  Created by denskop on 23.05.2018.
#

find_prefix="Find: "
replace_prefix="Replace: "

function patch()
{
    find=""
    replace=""

    while IFS='' read -r line || [[ -n "$line" ]]; do
        # Find
        if [[ $line = "$find_prefix"* ]]; then
            find=${line#$find_prefix}
            #echo "Find: $find"
        fi

        # Replace
        if [[ $line = "$replace_prefix"* ]]; then
            replace=${line#$replace_prefix}
            #echo "Replace: $replace"
        fi

        # Patch
        if [[ $find != "" && $replace != "" ]]; then
            echo "Patch: $find -> $replace"
            sed -i '' -e 's/'"$find"'/'"$replace"'/g' "$1"
            find=""
            replace=""
        fi
    done < "$2"
}

patch "$1" "$2"
