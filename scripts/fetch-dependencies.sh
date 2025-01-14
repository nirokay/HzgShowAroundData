#!/usr/bin/env bash

function fetch() {
    FILE=$1
    URL=$2
    [ "$FILE" == "" ] && {
        echo -e "Empty file name"
        return 1
    }
    [ "$URL" == "" ] && {
        echo -e "Url empty for file $FILE"
        return 1
    }

    DIRECTORY="lib"
    [ ! -d "$DIRECTORY" ] && DIRECTORY="scripts/lib"
    [ ! -d "$DIRECTORY" ] && {
        echo -e "Failed to get the target directory"
        return 1
    }

    curl "$URL" > "$DIRECTORY/$FILE"
}

# fetch "xml2lua.lua" "https://raw.githubusercontent.com/manoelcampos/xml2lua/master/xml2lua.lua"
# Lua-Socket: `sudo zypper install lua54-luasocket`
