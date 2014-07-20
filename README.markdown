# Docker S3 Sync

A docker container to periodically fetch files from S3.

It's useful for provisioning sensitive credentials.

AWS credentials are assumed to be provided via an IAM instance profile.

## Usage:
```
# Copy s3://mybucket/authorized_keys to /root/.ssh/authorized_keys
docker run -e S3_BUCKET=mybucket -e S3_KEY=authorized_keys -e DESTINATION=/root/.ssh/authorized_keys --rm ktheory/docker-s3-sync
```
