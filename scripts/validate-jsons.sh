#!/usr/bin/env bash

# Dependencies:
# * jsonschema
#   - Docker: https://github.com/sourcemeta/jsonschema/pkgs/container/jsonschema
#     (broken for me, i am using local binary)
#   - Binary: https://github.com/sourcemeta/jsonschema/releases/latest

[ ! -d ".git" ] && {
    echo -e "Please run from git root."
}

SCHEMA_DIR="templates/.schemas"

METHOD=""
function validator() {
    if ~/.local/bin/jsonschema version > /dev/null; then # does not find just 'jsonschema' anymore, here a hacky workaround :>
        METHOD="binary"
        ~/.local/bin/jsonschema $*
    elif jsonschema version > /dev/null; then
        METHOD="binary"
        jsonschema $*
    elif docker run ghcr.io/sourcemeta/jsonschema version > /dev/null; then
        METHOD="docker"
        docker run ghcr.io/sourcemeta/jsonschema $*
    elif sudo docker run ghcr.io/sourcemeta/jsonschema version > /dev/null; then
        METHOD="docker"
        sudo docker run ghcr.io/sourcemeta/jsonschema $*
    else
        METHOD="unavailable"
        echo -e "Failed to find 'jsonschema' program :(\nPlease look into script for dependencies."
        exit 1
    fi
}

FAILED_VALIDATIONS=""
function validate() {
    echo -e "Validating for '$1'..."
    if validator validate $* -d "https://json-schema.org/draft/2020-12/schema"; then
        echo -e "✅ Passed: $*"
    else
        FAILED_VALIDATIONS="${FAILED_VALIDATIONS}\n    - $*"
        echo -e "❌ Failed: $*"
    fi
}

validator version && echo -e "'jsonschema' ($METHOD) is installed and in path!"

function check() {
    NAME=$1
    PATH=$2
    validate "${SCHEMA_DIR}/${NAME}.schema.json" "${PATH}/${NAME}.json"
}
YEAR_FILES=(json/news/news-2*.json)
function checkYearNews() {
    FILE=$1
    validate "${SCHEMA_DIR}/news.schema.json" "${FILE}"
}

check articles       json/pages
check authors        json/contributors
check contributors   json/contributors
check locations      json/locations
check news-health    json/news
check offerings      json/pages
check tour_locations json/locations
check travel         json/pages
check changelog      json/pages
for YEAR in "${YEAR_FILES[@]}"; do
    checkYearNews $YEAR
done

if [ "$FAILED_VALIDATIONS" == "" ]; then
    echo -e "\n✅ All checks passed successfully!"
else
    echo -e "\n\n❌ Some errors encountered:\n${FAILED_VALIDATIONS}"
fi
