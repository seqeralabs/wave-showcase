# Run a pipeline with S3 using Wave and Fusion file system

### Summary 

This example shows how to use the Wave service to automatically provision 
the [Fusion file system](https://www.nextflow.io/docs/latest/fusion.html) in your pipeline containers, 
and run it with AWS Batch using AWS S3 as a work directory.


### Config file 


```
docker {
  enabled = true
}

wave { 
  enabled = true
} 

fusion {
  enabled = true
}
```

### Run it 

This example runs the pipeline on your local computer (local executor). However 
the pipeline uses an AWS bucket as a work directory:

```
nextflow run rnaseq-nf \
  -with-wave \
  -work-dir s3://<YOUR-BUCKET>/work
```

Make sure to specify an AWS S3 bucket to which you have read-write access as work directory. 

AWS credentials to access the bucket should be available either via Environment variables, Amazon ECS container credentials or Instance profile credentials. 


### Run it on AWS Batch

This example is essentially the same, except that we  reference the batch pipeline profile to run it on AWS Batch. 

The batch profile definition in this case would contain the required AWS Batch and storage credentials:

```
nextflow run rnaseq-nf \
  -with-wave \
  -profile batch \
  -work-dir s3://<YOUR-BUCKET>/work
```
