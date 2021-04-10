// TEST source product with env expected
provides: "decoy.txt"
product: #Product
product: #ContentType
product: {
  path: "."
  expects: {
    env: [
      "SOMETHING"
    ]
  }
}
// EXPECTS
product: {
  path: "."
  expects: {
    env: [
      "SOMETHING"
    ]
    _type: "Environment"
  }
  _type: "Source"
}

// TEST output product with env expected
provides: "decoy.txt"
product: #Product
product: #ContentType
product: {
  path: "."
  from: build: "."
  expects: env: [
    "MY_ENV_VAR",
    "MY_OTHER_ENV_VAR"
  ]
}
// EXPECTS
product: {
  path: "."
  from: build: "."
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
