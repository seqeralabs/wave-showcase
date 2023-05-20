# Build a container based on Spack packages

### Summary 

This example shows how to use the [Spack packages](https://spack.io/) defined in 
Nextflow pipeline via the `spack` directive to assemble the corresponding containers 
on-demand and provision for the pipeline execution. 

### Config file 

```
docker {
  enabled = true
  runOptions = '-u $(id -u):$(id -g)'
}

wave {
  strategy = 'spack'
}
```

The above setting instructs Wave to only use the `spack` directive to provision the pipeline containers, ignoring the use of the container directive and any Dockerfile(s).


### Run it 

```
nextflow run demo.nf -with-wave
```
