#!/bin/bash -e

[ -f ".circleci/debuglog" ] && set -x

echo "@clutch:registry=${arty_npmrc_registry:-https://artifactory.coxautoinc.com/artifactory/api/npm/clutch-npm/}
//artifactory.coxautoinc.com/artifactory/api/npm/clutch-npm/:_authToken=${arty_npmrc_token:-}
//artifactory.coxautoinc.com/artifactory/api/npm/clutch-npm-local/:_authToken=${arty_npmrc_token:-}
email=${arty_npmrc_email:-rory.kiefer@driveclutch.com}
always-auth=true
" > ~/.npmrc