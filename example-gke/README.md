# Run Nextflow with Wave and Fusion with Google Kubernetes engine


1. Deploy a GKE cluster (classic, not via "Autopilot" )
2. Add a node group using machine types with a least 2 cpus 
3. Add the cluster config to your local `~/.kube/config`
4. Create namespace, roles, etc as shown in the `gke.yml` manifest.
5. Update the `nextflow.config` with your bucket name and cluster context.
6. Launch nextflow using custom build from master using the `nextflow.config` included