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
    if jsonschema version > /dev/null; then
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
    validate "${SCHEMA_DIR}/${NAME}.schema.json" "${NAME}.json"
}
function checkYearNews() {
    NAME=$1
    validate "${SCHEMA_DIR}/${NAME}.schema.json" "${NAME}"-2*.json
}

check articles
check authors
check contributors
check locations
check news-health
checkYearNews news
check offerings
check tour_locations

if [ "$FAILED_VALIDATIONS" == "" ]; then
    echo -e "\n✅ All checks passed successfully!"
else
    echo -e "\n❌ Some errors encountered:\n${FAILED_VALIDATIONS}"
fi
