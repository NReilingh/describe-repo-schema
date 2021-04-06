consumes: [
  "Node.js",
  {
    setup: script: "npm install"
  }
]
provides: [
  {
    path: "dist/lightbox.*.js"
    description: "Browser JavaScript inject"
    from: build: "npm run build"
  },
  {
    path: "bitbucket-pipelines.yml"
    targets: "Bitbucket Pipelines"
  }
]
runs: [
  {
    description: "Unit tests"
    script: "npm run test"
  },
  {
    description: "Unit tests for CI",
    script: "npm run test-ci"
  }
]
