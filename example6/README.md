# Run a pipeline with S3 using Wave and Fusionfs

### Summary 

This example shows how to use Wave to automatically provision the Fusionfs file system allowing  running pipeline tasks to natively access AWS S3 as a work directory.


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

Make sure to specifity an AWS S3 bucket to which you have read-write access as work directory. 

AWS credentials to access the bucket should be avaiable either via Environment variables, Amazon ECS container credentials or Instance profile credentials. 


### Run it on AWS Batch

This example is essentially the same, except that we  reference the batch pipeline profile to run it on AWS Batch. 

The batch profile definition in this case would contain the required AWS Batch and storage credentials:

```
nextflow run rnaseq-nf \
  -with-wave \
  -profile batch \
  -work-dir s3://<YOUR-BUCKET>/work
```
