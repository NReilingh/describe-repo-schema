#!/usr/bin/env bash

schemadir="$(dirname "$0")"/schema
cue vet "$schema"/* "$1" -v -c
