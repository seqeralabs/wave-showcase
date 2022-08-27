nextflow run nf-core/rnaseq \
	-profile conda,test \
        -r 3.9 \
	--outdir s3://nextflow-ci/fusion-results \
        -w s3://nextflow-ci/test \
	-bg $1 > pipeline.log & 


