nextflow run nf-core/rnaseq \
	-profile test \
        -r 3.15.1 \
	--outdir s3://nextflow-ci/fusion-results \
        -w s3://nextflow-ci/test \
	-bg $1 > pipeline.log & 


