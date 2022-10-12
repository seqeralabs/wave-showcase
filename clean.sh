docker-rmi wave
docker-rmi pditommaso
docker-cleanup
docker logout

find . -name work | xargs  rm -rf 
find . -name results | xargs  rm -rf 
find . -name '.nextflow*' | xargs rm -rf

git reset --hard origin/master

