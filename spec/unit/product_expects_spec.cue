// TEST single source with expected explicit env
provides: {
  path: "index.html"
  description: "some kinda webpage"
  expects: env: [
    "MY_ENV_VAR",
    "MY_OTHER_ENV_VAR"
  ]
}
// EXPECTS
provides: {
  path: "index.html"
  description: "some kinda webpage"
  expects: {
    env: [
      "MY_ENV_VAR",
      "MY_OTHER_ENV_VAR"
    ]
    _type: "Environment"
  }
  tracked: true
  _type: "Source"
}

// TEST single output with expected explicit env
provides: {
  path: "index.html"
  from: build: "script.sh"
  expects: env: [
    "MY_ENV_VAR",
    "MY_OTHER_ENV_VAR"
  ]
}
// EXPECTS
provides: {
  path: "index.html"
  from: build: "script.sh"
  expects: {
    env: [
      "MY_ENV_VAR",
      "MY_OTHER_ENV_VAR"
    ]
    _type: "Environment"
  }
  tracked: false
  _type: "Output"
}
