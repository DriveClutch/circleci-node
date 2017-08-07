#!/bin/bash -e

if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

curl -u${BINTRAY_USER}:${BINTRAY_PASSWORD} https://api.bintray.com/npm/driveclutch/clutch-ui/auth/scope/clutch > ~/.npmrc
