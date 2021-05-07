#!/usr/bin/env bash

cd "$(dirname "$0")" && rm -rf dist || exit 1
mkdir -p dist/support > /dev/null
cp -r ../schema dist/support/
cp repovet dist/
cp ../spec/integration/model-example.cue dist/support
