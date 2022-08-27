process foo {
  container 'quay.io/nextflow/bash'
  debug true
  """
  say-hello.sh
  """
}


