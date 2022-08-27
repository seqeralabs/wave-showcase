# Run nf-core/rnaseq using Conda-based containers and Fusionfs 

### Summary 

This example shows how to run the nf-core/rnaseq pipeline using AWS S3 as a Fusionfs mounted work directory and use Wave containers built on-demand using the `conda` directive defined in the pipeline. 


### Config 

```
wave {
  enabled = true
  strategy = 'conda,container'
  build.conda.commands = [
    'USER root',
    'RUN apt-get update -y && apt-get install -y procps'
  ]
}
 
docker {
  enabled = true
}

fusion {
  enabled = true
}
```

### Run it 

```
nextflow run nf-core/rnaseq \
	-profile conda,test \
        --outdir s3://nextflow-ci/fusion-results \
        -w s3://nextflow-ci/test \
	-bg > pipeline.log & 
```
