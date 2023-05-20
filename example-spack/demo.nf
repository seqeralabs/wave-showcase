process hello {
  debug true
  spack 'cowsay'
  
  """
  cowsay Hello Spack!
  """
}

workflow {
  hello()
}
