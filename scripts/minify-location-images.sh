#!/usr/bin/env bash

if ! ffmpeg --help &> /dev/null; then
    echo -e "Dependency missing: ffmpeg"
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
            if [[ "$ITEM" =~ .*\_mini\.webp ]] || [[ "$ITEM" =~ .*\_nano\.webp ]]; then
                rm "$ITEM"
            fi
            if [[ "$ITEM" =~ .*\.webp ]]; then
                TARGET=${ITEM//.webp/_mini.webp}
                echo -e "Converting: $ITEM -> $TARGET"
                ffmpeg -i "$ITEM" -vf scale=640:480 "$TARGET" &
            fi
            if [[ "$ITEM" =~ .*\.webp ]]; then
                TARGET=${ITEM//.webp/_nano.webp}
                echo -e "Converting: $ITEM -> $TARGET"
                ffmpeg -i "$ITEM" -vf scale=320:240 "$TARGET" &
            fi
        fi
    done

    cd ..
}

convert_subdirectory "resources/images/locations/"

true
