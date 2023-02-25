# Run a pipeline on a remote Kubernetes cluster (EKS) using Wave and Fusion

### Summary

This example shows how to deploy a pipeline for execution on a remote 
AWS EKS cluster using the [Fusion file system](https://www.nextflow.io/docs/latest/fusion.html) as pipeline work directory.

### Kubernetes config 

You will need to create a namespace and a service account in your 
Kubernetes cluster to run the job submitted by the pipeline execution.

The following manifest shows the bare minimum configuration.


```
---
apiVersion: v1
kind: Namespace
metadata:
  name: wave-demo
---
apiVersion: v1
kind: ServiceAccount
metadata:
  namespace: wave-demo
  name: wave-sa
  annotations:
    eks.amazonaws.com/role-arn: "arn:aws:iam::011206878118:role/wave-demo-role" 
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: wave-demo
  name: wave-role
rules:
  - apiGroups: [""]
    resources: ["pods", "pods/status", "pods/log", "pods/exec"]
    verbs: ["get", "list", "watch", "create", "delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: wave-demo
  name: wave-rolebind
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: wave-role
subjects:
  - kind: ServiceAccount
    name: wave-sa
...
```

The AWS IAM role should provide read-write permission to the S3 bucket used as the pipeline work directory. For example:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::wave-store"
            ]
        },
        {
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:PutObjectTagging",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::wave-store/*"
            ],
            "Effect": "Allow"
        }
    ]
}
```

Also, make sure that the role defines a trust relationship similar to this:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<YOUR ACCOUNT ID>:oidc-provider/oidc.eks.eu-west-2.amazonaws.com/id/<YOUR CLUSTER ID>"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.eu-west-2.amazonaws.com/id/<YOUR CLUSTER ID>":aud": "sts.amazonaws.com",
                    "oidc.eks.eu-west-2.amazonaws.com/id/<YOUR CLUSTER ID>":sub": "system:serviceaccount:wave-demo:wave-sa"
                }
            }
        }
    ]
}
```


### Config 

The Nextflow pipeline uses this configuration: 

```
wave {
  enabled = true
}

fusion {
  enabled = true
}

process {
   executor = 'k8s'
}

k8s {
    context = '<YOUR K8S CLUSTER CONTEXT>'
    namespace = 'wave-demo'
    serviceAccount = 'wave-sa'
}
```

Note: in the configuration replace the context, namespace and serviceAccount  
with the names matching your cluster configuration. 

### Run it 

```
nextflow run rnaseq-nf -work-dir 's3://<YOUR BUCKET>/work'
```

Make sure to specify an AWS S3 bucket to which you have read-write access as work directory. 

AWS credentials to access the bucket should be available either via Environment variables, Amazon ECS container credentials or Instance profile credentials.
