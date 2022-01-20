#!/usr/bin/env bash
set -eu -o pipefail

VERSION=$1
CATALOG=$2

OS=$(uname -s | tr '[:upper:]' '[:lower:]')             
ARCH=$(uname -m | sed 's/x86_64/amd64/')

if [[ "${VERSION}" == "latest" ]]; then
	VERSION=$(curl -sL https://api.github.com/repos/operator-framework/operator-registry/releases/latest | jq -r '.tag_name')
fi

curl -sLO "https://github.com/operator-framework/operator-registry/releases/download/${VERSION}/${OS}-${ARCH}-opm" && chmod +x "${OS}-${ARCH}-opm" && mv "${OS}-${ARCH}-opm" "/usr/local/bin/opm"

CATALOG_DIR="${CATALOG}"
if [[ ! -d "${CATALOG}" ]]; then
	TMPDIR=$(mktemp -d)
	mkdir -p ${TMPDIR}/catalog
	opm render "${CATALOG}" > ${TMPDIR}/catalog/catalog.json
	CATALOG_DIR=${TMPDIR}/catalog
fi
set -x
opm validate "${CATALOG_DIR}"
