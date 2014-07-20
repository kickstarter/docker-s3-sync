FROM ubuntu:14.04
MAINTAINER Aaron Suggs

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y awscli

ADD sync.sh /sync.sh

CMD /sync.sh
