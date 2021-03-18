import "list"

provides: list.MinItems(1) & [...#Product] | #Product
runs?: [...#Execution] | #Execution

#Product: #Output | #Source

#Output: #FileType & {
  path?: #Path
  description?: string
  from?: #Generator
}

#Source: #FileType | #Path

#FileType: #ExecutableFile | *#StaticFile
#FileType: {
  executable: bool
  targets?: #Platform | #Consumer
  ...
}
#ExecutableFile: {
  executable: true
  expects?: [...#Input]
  ...
}
#StaticFile: {
  executable: false
  ...
}

#Execution: {
  description?: string
  shell: #Script,
  consumes?: [...#Input]
}

#Generator: {
  build: #Script
  source?: [...#Path]
  consumes?: [...#Input]
}

#Script: [...string]

#Input: #ExternalType
#ExternalType: #Platform | #Consumer | #Path | #Environment | #Tool | string

// A special kind of consumer that consumes compiled binaries
#Platform: "x86-64_linux" | "arm64_darwin" | string

// Path means specifically a file path relative to the repo root.
// May not be absolute.
#Path: =~ "^[^/\\\\]"
// This is a JSON-like string syntax, so quad-backslashes are required
// in order to have one escaped backslash in the regex.

#Environment: {
  env?: [...string]
}

#Consumer: string
#Tool: string
