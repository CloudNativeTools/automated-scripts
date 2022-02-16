#! /bin/bash
BASE_DIR=$(cd "$(dirname "$0")";pwd)
IMAGE_LIST=$1

IMAGE_LIST_DIR=${BASE_DIR}/${IMAGE_LIST}

#for line in $(cat ${IMAGE_LIST_DIR})
while read line
do

    if [[ $line =~ '#' ]]
    then
      continue
    fi

    dst=$(echo $line | cut -d " " -f 1)
    src_amd64=$(echo $line | cut -d " " -f 2)
    src_arm64=$(echo $line | cut -d " " -f 3)

    echo "sync $dst"
    echo "#######################################################"
    echo ""
    echo "pull $src_amd64"
    echo ""
    docker pull $src_amd64 --platform amd64
    docker tag $src_amd64 $dst-amd64
    echo "push $dst-amd64"
    docker push $dst-amd64
    echo ""
    echo "pull $src_arm64"
    echo ""
    docker pull $src_arm64 --platform arm64
    docker tag $src_arm64 $dst-arm64
    echo "push $dst-arm64"
    docker push $dst-arm64
    echo ""
    echo "combine && push image: $dst"
    docker manifest create $dst $dst-amd64 $dst-arm64 --amend --insecure
    docker manifest annotate --arch arm64 $dst $dst-arm64
    docker manifest push $dst --insecure
    echo ""
    echo "#######################################################"

done < ${IMAGE_LIST_DIR}
