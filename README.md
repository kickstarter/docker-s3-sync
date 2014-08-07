# Docker S3 Sync

A docker container to periodically fetch files from S3.

It's useful for provisioning sensitive credentials.

## Usage:

Basic example:
```
# Copy s3://mybucket/authorized_keys to /root/.ssh/authorized_keys
docker run \
-e S3_BUCKET=mybucket \
-e S3_KEY=authorized_keys \
-e DESTINATION=/root/.ssh/authorized_keys \
-e UMASK='u=rwx,g=,r=' # Optional umask
-v /root/.ssh:/root/.ssh
--rm \
ktheory/docker-s3-sync
```

AWS credentials are assumed to be provided via an IAM instance profile.
To use traditional AWS credentials, pass `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` env vars.
