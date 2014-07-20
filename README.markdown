# Docker Sync S3 SSH Key tool

A docker container to periodically fetch SSH authorized keys from S3 to the host container.

AWS credentials are assumed to be provided via an IAM instance profile.

## TODO:
1. Make this a generic tool for syncing any file from S3 to the host container
2. Find a better name for it.
3. Move file into place atomically
4. Publish it in the public docker hub
