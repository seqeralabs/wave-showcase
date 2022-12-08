process foo {
  container 'docker.io/pditommaso/my-secret-container@sha256:0a64a312f20a4b7bcf5ab9d22b152affa8db69758629e5e9bb98fe6213460e4b'
  debug true

  """
  my-secret-script.sh
  """
}

workflow { 
  foo()
}
