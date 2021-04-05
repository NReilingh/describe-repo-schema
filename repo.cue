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
    target: "Bitbucket Pipelines"
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
    description: "Test Examples"
    script: "./test.sh"
    consumes: CUE
    yields: stream: "stdout"
  }
]
