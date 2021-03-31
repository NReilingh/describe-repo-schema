// https://github.com/NReilingh/describe-repo-schema

#CUE: {
  description: "cue",
  ref: "https://cuelang.org"
}

provides: {
  path: "schema.cue"
  description: "Schema Definition"
  targets: #CUE
}

runs: [
  {
    description: "Validate Self"
    shell: "cue vet schema.cue repo.cue -v -c"
    consumes: #CUE
  },
  {
    description: "Export Self"
    shell: "cue export schema.cue repo.cue"
    consumes: #CUE
  }
]
