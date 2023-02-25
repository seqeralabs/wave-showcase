# Run a pipeline with Google Storage using Wave and Fusion file system

### Summary

This example shows how to use Wave to provision the [Fusion file system](https://www.nextflow.io/docs/latest/fusion.html) 
in the pipeline containers and access Google Storage as a work directory.

### Config file 

```
google {
  executor = 'google-batch'
  location  = 'europe-west2'
}

wave {
  enabled = true
}

fusion {
  enabled = true
}

```

### Run it 

```
nextflow run rnaseq-nf \
  -with-wave \
  -work-dir gs://<YOUR-BUCKET>/work
```

Make sure to specify a Google Storage bucket to which you have read-write access as work directory. 

Google credentials should be provided via the `GOOGLE_APPLICATION_CREDENTIALS` environment variable
or by using the `gcloud auth application-default login` command. You can find more details at in the 
[Nextflow documentation](https://www.nextflow.io/docs/latest/google.html#credentials).


