FROM ubuntu:14.04
MAINTAINER Aaron Suggs

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y awscli

# SSH config dir (~/.ssh on the host)
VOLUME ["/ssh"]

ENV AUTHORIZED_KEYS_PATH /ssh/authorized_keys
CMD aws s3api get-object --bucket $S3_BUCKET --key $S3_KEY $AUTHORIZED_KEYS_PATH
