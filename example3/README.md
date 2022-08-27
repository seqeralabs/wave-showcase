# Build and deliver Nextflow module containers to a private repository 

### Summary 

This example shows how to associate a Dockerfile to a Nextflow module
and push it to a preferred private repository.

When executing a pipeline script with the Wave plugin enabled, the Dockerfile 
is uploaded to the Wave service, a container is built on-the-fly, and pushed to
the repository you have specified.

The repository access key needs to be provided using the [Tower credentials](https://help.tower.nf/22.2/credentials/overview/) 
associated with your own account. 

To access your Tower account, specify your Tower access token in the Nextflow config
file (see below).

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

Note: the process does not need to declare any `container` to be used. Instead,
it references the `Dockerfile` included in the module directory.

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

### Nextflow config 

```
docker { 
  enabled = true
} 

wave { 
  build.repository = 'docker.io/pditommaso/cowsay-demo'
}

tower {
  accessToken = "$TOWER_ACCESS_TOKEN"
}
```

The `docker` scope is only needed to run the example in your local computer using Docker. 

Note: the user of the `build.repository` setting to push the container image built by 
Wave to your own repository. Replace the repository name with one of your choice. 

### Run it 

```bash
nextflow run demo.nf -with-wave
```
 