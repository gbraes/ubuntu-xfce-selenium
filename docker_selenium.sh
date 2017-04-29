#!/bin/bash
if $(docker ps |  grep --quiet selenium)  ; then
	echo "Killing...."
	docker kill selenium
fi
docker run -p 2222:22 -t -d  -v $(pwd):/data -e PS=$1 --rm --name selenium  german/ubuntu-xfce-selenium
