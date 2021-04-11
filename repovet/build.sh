#!/usr/bin/env bash

cd "$(dirname "$0")"
mkdir -p dist > /dev/null
cp -r ../schema dist/
cp repovet dist/
