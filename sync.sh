#!/bin/bash -e

if [ -z "$S3_BUCKET" ] || [ -z "$S3_KEY" ] || [ -z "$DESTINATION" ]; then
  echo "Must set S3_BUCKET, S3_KEY, and DESTINATION env vars" 1>&2
  exit 1
fi

##
# Fetch file for S3, move it in place atomically
function do_sync {
  aws s3api get-object --bucket $S3_BUCKET --key $S3_KEY /tmp/out > /dev/null

  # Optionally set file permissions
  if [ -n "$MODE" ]; then
    chmod "$MODE" /tmp/out
  fi

  mv /tmp/out $DESTINATION
}

if [ -z "$INTERVAL" ]; then
  # Run once
  do_sync
else
  # Loop every $INTERVAL seconds
  while true; do
    s=`date +'%s'`

    do_sync

    sleep $(( $INTERVAL - (`date +'%s'` - $s) ))
  done
fi
