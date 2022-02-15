#! /bin/bash 
BASE_DIR=$(cd "$(dirname "$0")";pwd)
IMAGE_LIST=$1

for images in $(cat ${BASE_DIR}${images-list}); do
    if [[ $images =~ '#' ]]
    then
      continue
    fi

    dst=$(echo $images | cut -d " " -f 1)
    src_amd64=$(echo $images | cut -d " " -f 2)
    src_arm64=$(echo $images | cut -d " " -f 3)
    
    echo "#######################################################"
    echo "sync $dst"
    echo ""
    echo "pull $src_amd64"
    echo ""
    echo "pull $src_arm64"
    echo "#######################################################"
    
done

