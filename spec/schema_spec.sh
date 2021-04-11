Context 'Integration testing'
  Context 'schema.cue validates models'
    Parameters:dynamic
      for model in spec/integration/*; do
        %data $model
      done
    End

    Parameters
      repo.cue
    End

    Specify "$1"
      When run command cue vet $1 schema/* -c -v
      The status should equal 0
      The stdout should be blank
      The stderr should be blank
    End
  End
End

Context 'Unit testing'
  Parameters:dynamic
    while read spec; do
      %data "$spec"
    done < <(./spec/support/bin/preprocess_cuespec)
  End
  Specify "$1"
    When call cuespec "$1"
    The status should equal 0
    The stdout should be blank
    The stderr should be blank
  End
End
