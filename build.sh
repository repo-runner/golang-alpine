#!/bin/bash
set -euxo pipefail

# Packages required to build the image
pkg_build=(
	jq
	tar
)

# Packages kept for the final image
pkg_img=(
	bash
	ca-certificates
	curl
	docker
	git
	make
)

# Install required packages
apk --no-cache add "${pkg_build[@]}" "${pkg_img[@]}"

function get_asset_url() {
	curl -sSfL "https://api.github.com/repos/${1}/releases/latest" |
		jq -r '.assets | .[] | .browser_download_url' |
		grep -E 'linux.*amd64.tar.gz'
}

# Download latest release of inner-runner
curl -sSfL "$(get_asset_url repo-runner/repo-runner | grep inner-runner)" | tar -xzf - -C /usr/local/bin
mv /usr/local/bin/inner-runner* /usr/local/bin/inner-runner

# Download latest release of golangci-lint
curl -sSfL "$(get_asset_url golangci/golangci-lint)" | tar -xzf - -C /usr/local/bin --wildcards '*/golangci-lint' --strip-components=1

# Purge build-packages
apk --no-cache del --purge "${pkg_build[@]}"
