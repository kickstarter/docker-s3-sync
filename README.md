# Docker S3 Sync

A docker container to periodically fetch files from S3.

It's useful for provisioning sensitive credentials.

* Docker registry: [kickstarter/docker-s3-sync](https://registry.hub.docker.com/u/kickstarter/docker-s3-sync/)
* GitHub: [kickstarter/docker-s3-sync](https://github.com/kickstarter/docker-s3-sync)

## Usage:

Basic docker example:
```
# Copy s3://mybucket/authorized_keys to /root/.ssh/authorized_keys
docker run \
-e S3_BUCKET=mybucket \
-e S3_KEY=authorized_keys \
-e DESTINATION=/data/authorized_keys \
-e MODE='0600' # Optional file mode
-e OWNER_UID='1000' # Optional file owner
-e OWNER_GID='1000' # Optional file group
-v /root/.ssh:/data # Map /root/.ssh on the host to /data in the container
--rm \
kickstarter/docker-s3-sync
```

AWS credentials are assumed to be provided via an IAM instance profile.
To use traditional AWS credentials, pass `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` env vars.

### Convenient `docker-s3-sync` script

A small ruby script is included to use the container more concisely.

Install it:
```
curl -O /usr/local/bin/docker-s3-sync https://raw.githubusercontent.com/kickstarter/docker-s3-sync/v0.5.0/docker-s3-sync
chmod +x /usr/local/bin/docker-s3-sync
```

Use it:
```
docker-s3-sync -b BUCKET -k KEY [-i INTERVAL ] [-m MODE] [-u UID] [-g GID] DESTINATION

# For example:
docker-s3-sync -b mybucket -k authorized_keys -m 0600 /root/.ssh/authorized_keys
```


