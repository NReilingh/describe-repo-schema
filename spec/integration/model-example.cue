// consumes: #GlobalInputs
// targets: #Consumers

provides: [ // #Products
  "lib/", // #Source in #Path string form
  { // #Source
    path: "lib/", // remaining fields optional, from #DataType
    description: "Some library code provided as is"
    expects: [ // #Inputs
      { // #UntrackedContent, also has optional #DataType fields
        path: "temp/"
        description: "Some untracked content needed for execution"
      },
      "somedevtool", // #ExternalType in string form
      { // #Environment, short form
        env: "SOME_IMPORTANT_ENV_VAR"
      }
    ]
    targets: { // #ExternalType in struct form. All fields optional.
      description: "node"
      ref: "https://nodejs.org"
      exec: "node"
      // Struct is open
    },
    ref: "https://someformat.org"
  },
  { // #Output
    path: "dist/" // Same optional fields as #Source, but
    from: { // #Generator -- 'from' turns a #Source into an #Output
      build: [ // #Script
        "run command one",
        "run command two"
      ]
      source: "src/" // #Sources
      consumes: { // #Inputs -- #Environment long form here
        env: [ // #EnvVars
          "SIMPLE_ENV_VAR",
          {
            name: "COMPLEX_ENV_VAR"
            description: "What it is and what it does."
            // Struct is open
          }
        ]
      }
    }
  }
]

runs: { // #Execution; can also be [...#Execution]
  script: "some command" // #Script, all other fields optional
  description: "Description of what the command does"
  source: "src/" // #Sources
  consumes: "shellspec" // #Inputs
  yields: [ // #OutputTypes
    "coverage/", // #Path
    { // #UntrackedContent
      path: "coverage/"
    },
    { // #Stream, is #DataType
      stream: "stdout"
      description: "TAP output"
      ref: "https://testanything.org"
    }
  ]
}
