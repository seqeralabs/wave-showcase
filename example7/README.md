# Run nf-core/rnaseq using Conda-based containers and Fusion file system

### Summary 

This example shows how to run the nf-core/rnaseq pipeline using AWS S3 as a [Fusion](https://www.nextflow.io/docs/latest/fusion.html) mounted work directory and use Wave containers built on-demand using the `conda` directive defined in the pipeline. 


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
        -work-dir s3://<YOUR BUCKET>/work \
        --outdir s3://<YOUR BUCKET>/results
```

Note: Make sure to specifity an AWS S3 bucket to which you have read-write access as work directory. 

AWS credentials to access the bucket should be avaiable either via Environment variables, Amazon ECS container credentials or Instance profile credentials. 