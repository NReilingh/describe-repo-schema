#!/usr/bin/env bash

cd "$(dirname "$0")"
mkdir -p dist/support > /dev/null
cp -r ../schema dist/support/
cp repovet dist/
cp ../spec/integration/model-example.cue dist/support
