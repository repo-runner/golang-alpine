#!/bin/bash
set -euxo pipefail

# Download latest release of inner-runner
DOWNLOAD=$(curl -sSfL https://api.github.com/repos/repo-runner/repo-runner/releases/latest |
	jq -r '.assets | .[] | select(.name == "inner-runner_linux_amd64.tar.gz") | .browser_download_url')
curl -sSfL "${DOWNLOAD}" | tar -xzf - -C /usr/local/bin
mv /usr/local/bin/inner-runner* /usr/local/bin/inner-runner
