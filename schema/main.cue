package repocue

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
consumes?: #GlobalInputs

// Repo.expects isn't a thing. Expects is only to be used in relation to a
// specific DataType, like a source, output, or stream.
// It is implicit that the repo expects a hierarchical filesystem.
expects?: _|_
// Global targets -- technically this would refer to the entire repository itself
// In other words, if it defines git-hooks and is thus bound to Git as an SCM,
// you can define that with repo.targets.
targets?: #Consumers
