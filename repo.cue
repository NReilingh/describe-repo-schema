// https://repo.fyi -- coming soon

let CUE = {
  description: "cue"
  ref: "https://cuelang.org"
}

provides: [
  {
    path: "schema/main.cue"
    description: "Schema Definition"
    targets: CUE
  },
  {
    path: "spec/integration/*.cue"
    description: "Model repo.cue examples"
    targets: CUE
  },
  {
    path: "repovet/dist/"
    description: "Schema validation CLI tool"
    from: {
      build: "repovet/build.sh"
      source: "repovet/"
    }
    expects: CUE
    targets: {
      description: "bash"
      exec: "./repovet"
    }
  },
  {
    path: ".github/workflows"
    descriptions: "GitHub Actions"
    expects: {
      env: {
        name: "HOMEBREW_TAP_COMMITTER_TOKEN"
        description: "GitHub token with write access to nreilingh/homebrew-tap"
      }
    }
    targets: [
      "GitHub",
      {
        description: "homebrew"
        ref: "https://brew.sh"
        exec: "brew install nreilingh/tap/repovet"
      }
    ]
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
