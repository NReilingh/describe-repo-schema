Describe 'schema.cue'
  Describe 'model validation'
    Parameters:dynamic
      for model in spec/examples/*; do
        %data $model
      done
    End
    Specify "$1 is valid"
      When run command cue vet $1 schema.cue -c -v
      The status should equal 0
      The stdout should be blank
      The stderr should be blank
    End
  End

  Describe 'self validation'
    Specify 'repo.cue is valid'
      When run command cue vet repo.cue schema.cue -c -v
      The status should equal 0
      The stdout should be blank
      The stderr should be blank
    End
  End
End
