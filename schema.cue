// Provided products are the content that a repo is initialized to track.
// (See `$ man git` -- "the stupid content tracker")
// At least one product must be specified to be valid.
// In the "repo as pure function" metaphor, Products are the "output".
provides: [#Product, ...#Product] | #Product

// Executions output artifacts that are internal to the repo.
// Examples might be unit tests or code coverage.
// They do NOT directly output the repo's products.
runs?: [...#Execution] | #Execution

// Global consumes -- where to define dependencies for all builds from this repo
// consumes?: #GlobalInputs
consumes?: #Inputs

// =============================================================================

// A product is defined in terms of a relative path under the root of the repo.
// An #Output path is not stored to the repository, rather,
// it is expected to be in a `.gitignore`d parent and generated from a build.
// A #Source path is stored in the repository,
// and therefore cannot be the result of a build.
#Product: #Output | *#Source

// Outputs and Sources are both ContentTypes, which means they are paths
// for whom inputs and consumers can be defined.
// Outputs are produced by a Generator.
#Output: #UntrackedContent & {
  from: #Generator
  _type: "Output"
}

// For convenience, non-generated sources can be specified as a simple #Path
// instead of a full #ContentType type.
#Sources: [...#Source] | #Source
#Source: #TrackedContent & {
  from?: _|_
  _type: "Source"
} | #Path

// We specify two subtypes of #ContentType
// depending on whether the content is tracked.
#TrackedContent: #ContentType & {
  tracked: true
  _type: string | *"TrackedContent"
}

#UntrackedContent: #ContentType & {
  env?: _|_
  tracked: false
  _type: string | *"UntrackedContent"
}
// A ContentType describes a file that is found at a given Path.
#ContentType: {
  #DataType
  path: #Path
  tracked: bool
  _type: string | *"ContentType"
  ...
}

// =============================================================================

// Generators and Executions both describe procedures (or scripts)
// that use the repo's tracked content as input.
// Generators are only defined within the context of an #Output,
// which is a ContentType describing what is produced by the generator script.
// Since a single repo may have many outputs from many generators,
// source is used to specify which repo paths directly affect this generator.
// Inputs consumed, in comparison, are not tracked content,
// but can be nearly anything else.
#Generator: {
  build:     #Script
  source?:   #Sources
  consumes?: #Inputs
  _type: "Generator"
}

// Executions are basically the same,
// except with different nomenclature for the Script type property,
// and additional properties available for description and yields.
#Execution: {
  script:       #Script
  description?: string
  source?:      #Sources
  consumes?:    #Inputs
  yields?:      [...#OutputType] | #OutputType
  _type: "Execution"
}

// An OutputType yielded from an execution can also be a stream,
// for example, TAP (Test Anything Protocol) on stdout.
#OutputType: #UntrackedContent | *#Stream | #Path

#Stream: {
  #DataType
  stream: "stdout" | "stderr" | *true
  _type: "Stream"
}

// =============================================================================

// Inputs and Consumers are both external types.
// An input can also be the environment.
// #GlobalInputs: *[...#GlobalInput] | #GlobalInput
// #GlobalInput:  #ExternalType | #Environment | #Setup
#Inputs: [...#Input] | #Input
#Input: *(#ExternalType | #Environment) | #UntrackedContent

// External types are not strictly defined
// so the type is open and can also just be a string.
#ExternalType: {
  path?: _|_
  env?: _|_
  description?: string
  ref?:         #Url
  exec?:        string
  _type: "ExternalType"
  ...
} | string

// An environment spec can be implicit as a sub-array,
// or explicit as a value of `env:`.
#Environment: {
  env: [#EnvVar, ...#EnvVar] | #EnvVar
  _type: "Environment"
}
// | [#EnvVar, ...#EnvVar]
// Yeah, this probably won't ever work. Wish I could figure out why, though!

// The var itself can be defined as a string,
// or given a description and other properties.
#EnvVar: {
  name:         string
  description?: string
  ...
} | string


#Consumer: #ExternalType
#Setup: {
  setup: #Execution
}

// DataType is extremely generic and is used to add additional context
// and requirements to any data object referenced,
// whether it be a tracked file, untracked file, or stream.
// This is done in terms of what it is meant to consume and be consumed by,
// not just by what "file extension" it has (though this can also be described).
// This type is also left open for the user to add additional properties to.
#DataType: {
  description?: string
  expects?: #Inputs
  targets?: [...#Consumer] | #Consumer
  ref?: #Url
}

// Path means specifically a file path relative to the repo root.
// May not be absolute.
#Path: =~"^[^/\\\\]"

// This is a JSON-like string syntax, so quad-backslashes are required
// in order to have one escaped backslash in the regex.
#Url: =~"^[a-z][a-z0-9.+-]*:\\S+"

// A shell script or build script is simply an example of what you would enter
// at a command line prompt in order to generate the
// internal or production output, respectively.
#Script: [string, ...string] | string
