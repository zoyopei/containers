#!/bin/bash
#
IMAGE_LST=${IMAGE_LST-"images.txt"}
REPO=$1

while read image; do
    if [[ $image =~ ^# ]]; then
        continue
    fi
    new_image=$(echo $image | awk -v REPO=$REPO -F"/" '{printf("%s/%s", REPO, $NF)}')
    docker pull $image
    docker tag $image $new_image
    docker push $new_image
    echo $image" -> "$new_image


done < $IMAGE_LST
