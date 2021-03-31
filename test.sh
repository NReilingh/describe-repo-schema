#!/usr/bin/env bash

cd "$(dirname "$0")"
error=0

vet () {
  echo "Vetting $1:"
  cue vet $1 schema.cue -c -v
  if [ $? -ne 0 ]; then
    error=1
  fi
  echo "Done"
}

for model in examples/*; do
  vet $model
done

vet repo.cue

exit $error
