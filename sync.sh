#!/bin/bash -e

if [ -z "$S3_BUCKET" ] || [ -z "$S3_KEY" ] || [ -z "$DESTINATION" ]; then
  echo "Must set S3_BUCKET, S3_KEY, and DESTINATION env vars" 1>&2
  exit 1
fi

# Fetch to temp file to move atomically
aws s3api get-object --bucket $S3_BUCKET --key $S3_KEY /tmp/out
mv /tmp/out $DESTINATION
