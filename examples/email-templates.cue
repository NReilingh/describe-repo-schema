provides: [
  {
    description: "Tessitura Razor Templates"
    path: "build/*.cshtml"
    from: {
      build: "./build.sh"
      source: [
        "template-keys.list",
        "*.inject.cshtml"
      ]
      consumes: [
        "bash",
        "jfrog-cli",
        {
          description: "artifactory"
          repo: "assets"
        }
      ]
    }
  }
]
