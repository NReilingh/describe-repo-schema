provides: [...#Output]
runs: [...#Execution]

#Output: #FileType & {
  path?: string
  description?: string
  from?: #Generator
}

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
  consumes?: [...#Input]
}

#Script: [...string]

#Input: #ExternalType
#ExternalType: #Platform | #Consumer | #Path | #Environment | #Tool | string

// A special kind of consumer that consumes compiled binaries
#Platform: "x86-64_linux" | "arm64_darwin" | string

// Path means specifically a file path relative to the repo root.
// May not be absolute.
#Path: {
  path: =~ "^[^/\\]"
}

#Environment: {
  env?: [...string]
}

#Consumer: string
#Tool: string
