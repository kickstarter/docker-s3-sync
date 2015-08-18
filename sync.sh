#!/bin/bash -e
CURRENT_ETAG=''

if [ -z "$S3_BUCKET" ] || [ -z "$S3_KEY" ] || [ -z "$DESTINATION" ]; then
  echo "Must set S3_BUCKET, S3_KEY, and DESTINATION env vars" 1>&2
  exit 1
fi

# OWNER_UID defaults to 0
if [ -z "$OWNER_UID" ]; then
  OWNER_UID=0
fi

# OWNER_GID default to OWNER_UID
if [ -z "$OWNER_GID" ]; then
  OWNER_GID=$OWNER_UID
fi

##
# Fetch file for S3, move it in place atomically
function do_sync {
  FILE_ETAG=$(aws s3api head-object --bucket $S3_BUCKET --key $S3_KEY | grep -i etag | tr -d ',')
  if [ "$FILE_ETAG" == "$CURRENT_ETAG" ]; then
    return 0
  fi
  CURRENT_ETAG=$FILE_ETAG
  
  aws s3api get-object --bucket $S3_BUCKET --key $S3_KEY /tmp/out > /dev/null

  # Optionally set file permissions
  if [ -n "$MODE" ]; then
    chmod "$MODE" /tmp/out
  fi

  chown $OWNER_UID:$OWNER_GID /tmp/out

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
