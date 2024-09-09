#!/bin/bash
#
IMAGE_LST=${IMAGE_LST-"images.txt"}
REPO=$1

while read line; do
    if [[ $line =~ ^# ]]; then
        continue
    fi
    read -r -a arr <<< "$line"
    image=${arr[0]}
    if [ ${#arr[@]} -eq 2 ]; then
        new_image=${arr[1]}
    else
        new_image=$(echo $image | awk -v REPO=$REPO -F"/" '{printf("%s/%s", REPO, $NF)}')
    fi
    echo $image" -> "$new_image
    #docker pull --platform linux/arm64 --platform linux/amd64 $image
    docker buildx imagetools create --tag $new_image $image
    #docker tag $image $new_image
    #docker push $new_image


done < $IMAGE_LST
