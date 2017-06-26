# Description

s3cmd in a Docker container.  This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running a container.

Using [Alpine linux](https://hub.docker.com/_/alpine/).  This image is 31MB.

# Usage Instruction

## Run s3cmd against IBM COS S3:
    ACCESS_KEY_ID=<YOUR AWS KEY>
    SECRET_ACCESS_ID=<YOUR AWS SECRET>
    LOCAL_DIR=/path/to/my/files

    docker run \
    --env ACCESS_KEY_ID=${ACCESS_KEY_ID} \
    --env SECRET_ACCESS_ID=${SECRET_ACCESS_ID} \
    --env cmd=sync-local-to-s3 \
    --env DEST_S3=${BUCKET}  \
    -v ${LOCAL_DIR}:/store \
    rjminsha/docker-ibmcos-s3cmd s3cmd <commands>

    * where commands are for example:
      - ls
    * Change `LOCAL_DIR` to local folder you want to use with s3

## Copy from local to IBM COS S3:

    ACCESS_KEY_ID=<YOUR AWS KEY>
    SECRET_ACCESS_ID=<YOUR AWS SECRET>
    BUCKET=s3://charts-ibmcloud-na-qa
    LOCAL_FILE=/tmp/charts

    docker run \
    --env ACCESS_KEY_ID=${ACCESS_KEY_ID} \
    --env SECRET_ACCESS_ID=${SECRET_ACCESS_ID} \
    --env cmd=sync-local-to-s3 \
    --env DEST_S3=${BUCKET}  \
    -v ${LOCAL_FILE}:/opt/src \
    rjminsha/docker-ibmcos-s3cmd

* Change `LOCAL_FILE` to file/folder you want to upload to S3

## Copy from IBM COS S3 to local:

    ACCESS_KEY_ID=<YOUR AWS KEY>
    SECRET_ACCESS_ID=<YOUR AWS SECRET>
    BUCKET=s3://charts-ibmcloud-na-qa
    LOCAL_FILE=/tmp

    docker run \
    --env ACCESS_KEY_ID=${ACCESS_KEY_ID} \
    --env SECRET_ACCESS_ID=${SECRET_ACCESS_ID} \
    --env cmd=sync-s3-to-local \
    --env SRC_S3=${BUCKET} \
    -v ${LOCAL_FILE}:/opt/dest \
    rjminsha/docker-ibmcos-s3cmd

* Change `LOCAL_FILE` to the file/folder where you want to download the files from S3 to the local computer

## Run interactively with s3cmd

    ACCESS_KEY_ID=<YOUR AWS KEY>
    SECRET_ACCESS_ID=<YOUR AWS SECRET>

    docker run -it \
    --env ACCESS_KEY_ID=${ACCESS_KEY_ID} \
    --env SECRET_ACCESS_ID=${SECRET_ACCESS_ID} \
    --env cmd=interactive \
    -v /:/opt/dest \
    rjminsha/docker-ibmcos-s3cmd /bin/sh

Then execute the `main.sh` script to setup the s3cmd config file

    /opt/main.sh

Now you can run `s3cmd` commands

    s3cmd ls /

# Credits
Based off of https://hub.docker.com/r/garland/docker-s3cmd/ 
