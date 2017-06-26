#!/bin/sh -xe

#
# main entry point to run s3cmd
#
S3CMD_PATH=/opt/s3cmd/s3cmd

#
# Check for required parameters
#
if [ -z "${aws_key}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${aws_secret}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

#
# Replace key and secret in the /.s3cfg file with the one the user provided
#
cp /opt/.s3cfg $HOME/.s3cfg
echo "access_key=${aws_key}" >> $HOME/.s3cfg
echo "secret_key=${aws_secret}" >> $HOME/.s3cfg


#
# Finished setup
#
echo "Finished s3cmd setup"

#
# Run Commands
#
if [ "${cmd}" = "sync-s3-to-local" ]; then
  ${S3CMD_PATH} --config=/.s3cfg  sync ${SRC_S3} /opt/dest/
elif [ "${cmd}" = "sync-local-to-s3" ]; then
  ${S3CMD_PATH} --config=/.s3cfg sync /opt/src/ ${DEST_S3}
elif [ "${cmd}" != "interactive" ]; then
  echo "COMMAND: $@"
  PRIMARY_CMD=$@
  ${PRIMARY_CMD}
fi
