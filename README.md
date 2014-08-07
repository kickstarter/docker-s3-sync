# Docker S3 Sync

A docker container to periodically fetch files from S3.

It's useful for provisioning sensitive credentials.

## Usage:

Basic docker example:
```
# Copy s3://mybucket/authorized_keys to /root/.ssh/authorized_keys
docker run \
-e S3_BUCKET=mybucket \
-e S3_KEY=authorized_keys \
-e DESTINATION=/data/authorized_keys \
-e MODE='0600' # Optional file mode
-v /root/.ssh:/data # Map /root/.ssh on the host to /data in the container
--rm \
ktheory/docker-s3-sync
```

AWS credentials are assumed to be provided via an IAM instance profile.
To use traditional AWS credentials, pass `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` env vars.

Alternatively, use the `docker-s3-sync` ruby script to run more concisely:
```
docker-s3-sync -b BUCKET -k KEY [-m MODE] DESTINATION
```


