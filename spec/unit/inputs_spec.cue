// TEST IDENTITY external type string
provides: "decoy.txt"
inputs: #Inputs
inputs: "some external type"

// TEST IDENTITY array of external type string
provides: "decoy.txt"
inputs: #Inputs
inputs: [ "some external type" ]

// TEST external type struct
provides: "decoy.txt"
inputs: #Inputs
inputs: description: "Lambda runtime"
// EXPECTS
inputs: {
  description: "Lambda runtime"
  _type: "ExternalType"
}

// TEST array of external type struct
provides: "decoy.txt"
inputs: #Inputs
inputs: [
  {
    description: "Lambda runtime"
  }
]
// EXPECTS
inputs: [
  {
    description: "Lambda runtime"
    _type: "ExternalType"
  }
]

// TEST explicit env single string
provides: "decoy.txt"
inputs: #Inputs
inputs: env: "MY_ENV_VAR"
// EXPECTS
inputs: {
  env: "MY_ENV_VAR"
  _type: "Environment"
}

// TEST explicit env string array
provides: "decoy.txt"
inputs: #Inputs
inputs: env: [
  "MY_ENV_VAR",
  "MY_OTHER_ENV_VAR",
]
// EXPECTS
inputs: {
  env: [
    "MY_ENV_VAR",
    "MY_OTHER_ENV_VAR",
  ]
  _type: "Environment"
}

// TEST explicit env single struct
provides: "decoy.txt"
inputs: #Inputs
inputs: env: {
  name: "MY_ENV_VAR"
  customField: "aws key"
}
// EXPECTS
inputs: {
  env: {
    name: "MY_ENV_VAR"
    customField: "aws key"
  }
  _type: "Environment"
}

// TEST explicit env struct array
provides: "decoy.txt"
inputs: #Inputs
inputs: env: [
  {
    name: "MY_ENV_VAR"
    description: "I don't know"
  },
  {
    name: "MY_OTHER_VAR"
    customField: "something else"
  }
]
// EXPECTS
inputs: {
  env: [
    {
      name: "MY_ENV_VAR"
      description: "I don't know"
    },
    {
      name: "MY_OTHER_VAR"
      customField: "something else"
    }
  ]
  _type: "Environment"
}

// TEST explicit env mixed array
provides: "decoy.txt"
inputs: #Inputs
inputs: env: [
  "MY_ENV_VAR",
  {
    name: "OTHER_VAR"
  }
]
// EXPECTS
inputs: {
  env: [
    "MY_ENV_VAR",
    {
      name: "OTHER_VAR"
    }
  ]
  _type: "Environment"
}

// TEST UntrackedContent
provides: "decoy.txt"
inputs: #Inputs
inputs: path: "some/untracked/path"
// EXPECTS
inputs: {
  path: "some/untracked/path"
  tracked: false
  _type: "UntrackedContent"
}

// TEST mixed array with explicit env
provides: "decoy.txt"
inputs: #Inputs
inputs: [
  {
    path: "some/untracked/path"
  },
  "An External Type",
  {
    description: "an explicit external type"
  },
  {
    env: [
      "MY_ENV_VAR",
      {
        name: "OTHER_VAR"
      }
    ]
  }
]
// EXPECTS
inputs: [
  {
    path: "some/untracked/path"
    tracked: false
    _type: "UntrackedContent"
  },
  "An External Type",
  {
    description: "an explicit external type"
    _type: "ExternalType"
  },
  {
    env: [
      "MY_ENV_VAR",
      {
        name: "OTHER_VAR"
      }
    ]
    _type: "Environment"
  }
]
