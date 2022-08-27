# Augment existing containers with Nextflow process resources 

This example shows how to augment containers used by your pipeline by making 
content contained in a  module `resources` directory available inside your container

This allows developers to make the contents of arbitrary files available to modules executing in containers at runtime. It is worth noting that in this case, the container is *not* re-built.

### Config file 

```
docker.enabled = true
```

### Run it 

```
nextflow run demo.nf -with-wave
```
