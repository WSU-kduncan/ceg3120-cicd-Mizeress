#!/bin/bash
# Pull a docker image and replace the currently running container with the new image
# intended to be placed in /usr/local/bin called DockerSwap with execute permissions for the ec2-user

# Usage DockerSwap -i <dockerRepo/image:tag> -c <containerName>

# Docker Path to pull from
image=""

# Name of local container to replace
containerName=""

getops ":i:c:" opt
while getopts ":i:c:" opt; do
    case $opt in
        i) image="$OPTARG"
        ;;
        c) containerName="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

echo "Pulling image: ${image}"
# Pull the latest image from the repository
docker pull ${image}

# Stop the currently running container
docker stop ${containerName}
echo "Stopped container: ${containerName}"

# Remove the stopped container
docker rm ${containerName}
echo "Removed container: ${containerName}"

# Run the new container
docker run -d --name ${containerName} -p 80:80 --restart=always ${image}
echo "Started new container: ${containerName} with image: ${image}"

exit 0