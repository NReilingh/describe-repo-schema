#FileType: {
  executable?: bool
  expects?: [...#Input]
  ...
}

#Output: #FileType & {
  path?: string
  description?: string
  from?: #Generator
}

#Generator: {
  consumes?: [...#Input]
  build: [...string]
}

// yeah I have no idea.
#Need: {
  path: #RepoPath
}

#Input: #RepoPath | #EnvironmentResource | #EnvironmentVars

#RepoPath: #Output | {
  path?: string
}
#EnvironmentResource: string
#EnvironmentVars: {
  env?: [...string]
}

#Type: #Build | #Deployment | *#Asset

provides: [...#Output]
