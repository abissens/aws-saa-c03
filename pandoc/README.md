```shell
docker build -t pandoc-easyprint -f ./pandoc/Dockerfile ./pandoc
docker run --rm -it --volume ${PWD}:/data --entrypoint /data/pandoc/print-md.sh pandoc-easyprint 

```