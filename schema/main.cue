// Products are what every repo provides.
// Some have more than one, but zero have none.
provides: [#Product, ...#Product] | #Product

// Executions output artifacts that are internal to the repo.
// Examples might be unit tests or code coverage.
// They do NOT directly output the repo's products.
runs?: [...#Execution] | #Execution

// =============================================================================

/*
A product is defined in terms of a relative path under the root of the repo.
An #Output path is not stored to the repository, rather,
it is expected to be in a `.gitignore`d parent and generated from a build.
A #Source path is stored in the repository,
and therefore cannot be the result of a build.
*/
#Product: #Output | #Source

// A FileType describes a file that is found at a given path.
// This is done in terms of what it is meant to consume and be consumed by,
// not just by what "file extension" it has (though this can also be described).
// This type is also left open for the user to add additional properties to.
#FileType: {
  path: #Path
  description?: string
  expects?: [...#Input]
  targets?: [...#Consumer]
  ...
}

// Outputs and Sources are both FileTypes, which means they are paths
// for whom inputs and consumers can be defined.
#Output: #FileType & {
  from: #Generator
}
// For convenience, non-generated sources can be specified as a simple #Path
// instead of a full #FileType type.
#Source: #FileType | #Path

// Inputs and Consumers are both external types.
// An input can also be the environment.
#Input: #ExternalType | #Environment
#Consumer: #ExternalType

// External types are not strictly defined
// so the type is open and can also just be a string.
#ExternalType: {
  description?: string
  ...
} | string

// An environment spec can be implicit as a sub-array,
// or explicit as a value of `env:`.
#Environment: {
  env: [#EnvVar, ...#EnvVar]
} | [#EnvVar, ...#EnvVar]

// The var itself can be defined as a string,
// or given a description and other properties.
#EnvVar: {
  name: string
  description?: string
  ...
} | string

// Generators and Executions are two sides of the same coin,
// except that we define generators in terms of the internal
// source that they consume.
// When you want to have an effect on the production output of the repo,
// you want to know where to look.
// Executions don't generate production output, so they implicitly
// are affected by the contents of the repo.
#Generator: {
  build: #Script
  source?: [...#Source]
  consumes?: [...#Input]
}

#Execution: {
  shell: #Script,
  description?: string
  consumes?: [...#Input]
}

// A shell script or build script is simply an example of what you would enter
// at a command line prompt in order to generate the
// internal or production output, respectively.
#Script: [string, ...string] | string

// Path means specifically a file path relative to the repo root.
// May not be absolute.
#Path: =~ "^[^/\\\\]"
// This is a JSON-like string syntax, so quad-backslashes are required
// in order to have one escaped backslash in the regex.