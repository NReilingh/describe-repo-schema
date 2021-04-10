// https://github.com/NReilingh/describe-repo-schema

let CUE = {
  description: "cue"
  ref: "https://cuelang.org"
}

provides: [
  {
    path: "schema.cue"
    description: "Schema Definition"
    targets: CUE
  },
  {
    path: "bitbucket-pipelines.yml"
    targets: "Bitbucket Pipelines"
  }
]

runs: [
  {
    description: "Validate Self"
    script: "cue vet schema.cue repo.cue -v -c"
    consumes: CUE
  },
  {
    description: "Export Self"
    script: "cue export schema.cue repo.cue"
    consumes: CUE
  },
  {
    description: "Validation Testing"
    script: "shellspec"
    consumes: [
      CUE,
      {
        description: "ShellSpec",
        ref: "https://shellspec.info"
      }
    ]
    yields: stream: "stdout"
  }
]
