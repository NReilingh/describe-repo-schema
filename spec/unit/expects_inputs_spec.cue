// TEST IDENTITY single external type string
provides: {
  path: "server.js"
  targets: "Node.js"
  expects: "some external type"
}

// TEST single external type struct
provides: {
  path: "server.js"
  targets: "Node.js"
  expects: description: "Lambda runtime"
}
// EXPECTS
provides: {
  path: "server.js"
  targets: "Node.js"
  _type: "Source"
  expects: {
    description: "Lambda runtime"
    _type: "ExternalType"
  }
}

// TEST single env var string
provides: {
  path: "server.js"
  targets: "Node.js"
  expects: env: "MY_ENV_VAR"
}
// EXPECTS
provides: {
  path: "server.js"
  targets: "Node.js"
  expects: {
    env: "MY_ENV_VAR"
    _type: "Environment"
  }
}

// TEST single UntrackedContent
provides: {
  path: "server.js"
  targets: "Node.js"
  expects: [{
    path: "some/untracked/path"
  }]
}
provides: #Source
// EXPECTS
provides: {
  path: "server.js"
  targets: "Node.js"
  _type: "Source"
  tracked: true
  // expects: {
  //   path: "some/untracked/path"
  //   tracked: false
  //   _type: "UntrackedContent"
  // }
}
