# Build a container based on Conda packages

### Summary 

This example shows how to use the Conda packages defined a in 
Nextflow pipeline via the `conda` directive to assemble 
the corresponding containers on-demand and provision for the 
pipeline execution. 

### Config file 

```
docker {
  enabled = true
  runOptions = '-u $(id -u):$(id -g)'
}

wave {
  strategy = 'conda'
}
```

The above setting instructs Wave to only use the `conda` directive to provision the pipeline containers, ignoring the use of the container directive and any Dockerfile(s).


### Run it 

```
run rnaseq-nf -with-wave
```
