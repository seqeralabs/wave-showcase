### Summary 

This example shows how to access a private container repository 
in your Nextflow pipeline using the Wave service. 

### Pipeline script 

```nextflow
process foo {
  container 'docker.io/pditommaso/my-secret-container:latest'
  debug true

  """
  my-secret-script.sh
  """
}

workflow { 
  foo()
}
```

### Nextflow config 

```
docker {
  enabled = true
} 

tower {
  accessToken = "$TOWER_ACCESS_TOKEN"
}
```

In the above script, replace the container image with your own private repository. 


### Run it 

```bash
nextflow run demo.nf 
```


