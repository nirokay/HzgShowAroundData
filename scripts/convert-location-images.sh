#!/usr/bin/env bash

CONVERT_EXTENTION=$1
CONVERT_TARGET=$2

[ "$CONVERT_EXTENTION" == "" ] && CONVERT_EXTENTION=jpg
[ "$CONVERT_TARGET" == "" ] &&    CONVERT_TARGET=webp

echo -e "Converting $CONVERT_EXTENTION to $CONVERT_TARGET!"

printf "Is this correct? [y/n] "
read -r CONSENT
if [ "$CONSENT" != "y" ] && [ "$CONSENT" != "Y" ]; then
    echo -e "Aborting..."
    exit 1
fi

function convert_subdirectory() {
    DIR=$1
    cd "$DIR" || {
        echo -e "Failed to cd into directory $DIR"
        return 1
    }
    echo -e " -> $DIR"
    ITEMS=( * )
    for ITEM in "${ITEMS[@]}"; do
        if [ -d "$ITEM" ]; then
            convert_subdirectory "$ITEM"
        fi
        if [ -f "$ITEM" ]; then
            if [[ "$ITEM" == *.$CONVERT_EXTENTION ]]; then
                TARGET=${ITEM//.$CONVERT_EXTENTION/.$CONVERT_TARGET}
                echo -e "Converting: $ITEM -> $TARGET"
                ffmpeg -i "$ITEM" "$TARGET"
            fi
        fi
    done

    cd ..
}

convert_subdirectory "resources/images/locations/"
