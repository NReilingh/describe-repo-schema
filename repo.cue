provides: [
  {
    path: "schema.cue"
    description: "Schema Definition"
    targets: "cue"
  },
  {
    path: "bitbucket-pipelines.yml"
    description: "CI Configuration"
    targets: "Bitbucket Pipelines"
  }
]
runs: [
  {
    description: "Validation Example"
    shell: "cue vet schema/main.cue repo.cue -v"
    consumes: "cue"
  },
  {
    description: "Evaluation Example"
    shell: "cue export schema/main.cue repo.cue"
    consumes: "cue"
  }
]
