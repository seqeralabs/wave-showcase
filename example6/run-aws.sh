nextflow run rnaseq-nf \
	 -profile batch \
	 -with-wave \
         -w 's3://nextflow-ci/test'

