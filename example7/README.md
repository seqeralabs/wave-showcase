# Run nf-core/rnaseq using Conda-based containers and Fusion file system

### Summary 

This example shows how to run the [nf-core/rnaseq](https://nf-co.re/rnaseq) pipeline with AWS Batch using 
[Fusion](https://www.nextflow.io/docs/latest/fusion.html) to access the AWS S3 storage and the Wave service 
to provision the pipeline containers on-demand, by using the Conda recipes defined in the pipeline configuration. 


### Config 

```
wave {
  enabled = true
  strategy = 'conda,container'
}
 
docker {
  enabled = true
}

fusion {
  enabled = true
  exportStorageCredentials = true
}
```

### Run it 

```
nextflow run nf-core/rnaseq \
	-profile conda,test \
        -work-dir s3://<YOUR BUCKET>/work \
        --outdir s3://<YOUR BUCKET>/results
```

Note: Make sure to specify an AWS S3 bucket to which you have read-write access as work directory. 

AWS credentials to access the bucket should be available either via Environment variables, Amazon ECS container credentials or Instance profile credentials. 
