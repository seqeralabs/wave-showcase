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
         -w 's3://nextflow-ci/test'
```

### Run it on AWS Batch

This example is essentially the same, except that we  reference the batch pipeline profile to run it on AWS Batch. 

The batch profile definition in this case would contain the required AWS Batch and storage credentials:

```
nextflow run rnaseq-nf \
    -profile batch \
    -with-wave \
    -w 's3://nextflow-ci/test'
```
