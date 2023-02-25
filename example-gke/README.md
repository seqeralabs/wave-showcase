# Run a pipeline with Wave and Fusion with Google Kubernetes Engine

### Summary 

This example shows how to use Wave to provision the [Fusion file system](https://www.nextflow.io/docs/latest/fusion.html) and run it in a Google Kubernetes Engine (GKE) cluster using a Google Storage bucket as pipeline work directory.

### Cluster preparation

1. Create a GKE "standard" cluster ("Autopilot" is not supported yet). See [Google documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-zonal-cluster) for details. 
2. Make sure to use instance types with 2 or more CPUs and providing SSD instance storage (families: `n1`,`n2`,`c2`, `m1`, `m2`, `m3`)
3. Make sure to enable the *Workload identity* feature when creating (or updating) the cluster. 
   - "Enable Workload Identity" in the cluster "Security" setting 
   - "Enable GKE Metadata Server" in the node group "Security" settings
   - Configure the cluster following the See the [Google documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity#kubectl) for details. documentation
    - The following values were used in this example (replace them with values corresponding your environment):
      - CLUSTER_NAME: the GKE cluster name e.g. `cluster-2`
      - COMPUTE_REGION: the GKE cluster region e.g. `europe-west1`
      - NAMESPACE: the GKE namespace e.g. `wave-demo`
      - KSA_NAME: the GKE service account name e.g. `wave-sa`
      - GSA_NAME: the Google service account e.g. `gsa-demo`
      - GSA_PROJECT: the Google project id e.g.  `my-nf-project-261815`
      - PROJECT_ID: the Google project id e.g. `my-nf-project-261815`
      - ROLE_NAME: the role to grant access permission to the Google Storage bucket e.g. `roles/storage.admin`
    - Create the K8s *role* and *rolebinding* required to run Nextflow applying the manifest include in this directory: 
      ```
      kubectl apply -f gke.yml
      ``` 

### Config file 

Nextflow configuration template for the deploying a Nextflow pipeline in a GKE cluster using Wave and Fusion.

```
wave {
  enabled = true
}

fusion {
  enabled = true
}

process {
   executor = 'k8s'
   scratch = false
}

workDir = 'gs://<YOUR-BUCKET>/work'

k8s {
    context = '<YOUR-GKE-CLUSTER-CONTEXT>'
    namespace = 'wave-demo'
    serviceAccount = 'wave-sa'
    pod.nodeSelector = 'iam.gke.io/gke-metadata-server-enabled=true'
}
```

### Run it 

```
nextflow run rnaseq-nf \
  -with-wave \
  -work-dir gs://<YOUR-BUCKET>/work
```

Make sure to specify a Google Storage bucket to which you have read-write access as work directory. 

