consumes: "Node.js"
provides: [
  {
    path: "."
    description: "Express http server"
    targets: {
      description: "Node.js"
      exec: "node start.js"
    }
    expects: #RuntimeEnv
    from: {
      build: [
        "npm install",
        "npm run build"
      ]
      consumes: #BuildEnv
    }
  },
  {
    path: "app.yaml",
    targets: "Google App Engine"
    from: {
      build: "npx envsub app.tpl.yaml app.yaml"
      consumes: #RuntimeEnv
    }
  },
  {
    path: "bitbucket-pipelines.yml"
    targets: "Bitbucket Pipelines"
    expects: env:
      #BuildEnv.env + #RuntimeEnv.env + [
        "SNYK_TOKEN",
        "GCP_KEY_FILE",
        "GCP_PROJECT"
      ]
  }
]

#BuildEnv: env: [
  "AIRTABLE_API_KEY",
  "AIRTABLE_BASE"
]

#RuntimeEnv: env: [
  "TNEW_DOMAIN",
  "V6_PROCEDURE_ID",
  "V6_VALIDATION_POINT",
  "V7_PROCEDURE_ID"
]

runs: [
  {
    description: "Run local dev server"
    script: [
      "npm install",
      "npm run build",
      "npm run test:watch",
      "npm run start-dev"
    ]
    consumes: env: #BuildEnv.env + #RuntimeEnv.env
  },
  {
    description: "Run unit tests"
    script: [
      "npm install",
      "npm run build",
      "npm run test"
    ]
    source: "test/"
    consumes: #BuildEnv
    yields: "coverage/"
  }
]
