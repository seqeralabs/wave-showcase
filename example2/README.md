# Build and deliver Nextflow module containers

### Summary 

This example shows how to associate a Dockerfile with a Nextflow module.

When executing a pipeline script enabling the Wave plugin, the Dockerfile 
is uploaded to the Wave service, a container is built on-the-fly, and pushed to
a temporary repository. The container name is automatically included in the 
process execution and used to run the task.

### Pipeline script 

The pipeline script includes a simple module and uses it in the workflow:

```nextflow
include { hello } from './modules/foo'

workflow {
  hello()
}

```

### Module script 

```nextflow
process hello {
  debug true
  """
  cowsay Hello Summit! 
  """
}

```

Note: the process does not need to declare any `container` to used. Instead, a `Dockerfile` is included in the module directory.

### Dockerfile 

The Dockerfile defines the software to be installed.

```Dockerfile
FROM alpine 

RUN apk update && apk add bash cowsay \
        --update-cache \
        --repository https://alpine.global.ssl.fastly.net/alpine/edge/community \
        --repository https://alpine.global.ssl.fastly.net/alpine/edge/main \
        --repository https://dl-3.alpinelinux.org/alpine/edge/testing

```


### Run it 

```bash
nextflow run demo.nf -with-wave
```
