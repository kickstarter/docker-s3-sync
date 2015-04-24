#!/bin/bash -e

if [ -z "$S3_BUCKET" ] || [ -z "$S3_KEY" ] || [ -z "$LOCALFILE" ] || [ -z "$ACTION" ]; then
  echo "Must set S3_BUCKET, S3_KEY, LOCALFILE and ACTION env vars" 1>&2
  exit 1
fi

##
# Fetch file for S3, move it in place atomically
function fetch {
  aws s3api get-object --bucket $S3_BUCKET --key $S3_KEY /tmp/out > /dev/null

  # Optionally set file permissions
  if [ -n "$MODE" ]; then
    chmod "$MODE" /tmp/out
  fi

  mv /tmp/out $LOCALFILE
}

##
# Put file to S3
function put {
  aws s3api put-object --bucket $S3_BUCKET --key $S3_KEY --body $LOCALFILE > /dev/null
}

if [ -z "$INTERVAL" ]; then
  # Run once
  $ACTION
else
  # Loop every $INTERVAL seconds
  while true; do
    s=`date +'%s'`

    $ACTION

    sleep $(( $INTERVAL - (`date +'%s'` - $s) ))
  done
fi
