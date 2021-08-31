FROM rust
LABEL maintainer=neilli-sable

###############
# General
###############
RUN apt-get update -y
RUN apt-get install -y build-essential libssl-dev curl upx sudo

###############
# Rust
###############
RUN cargo install just
RUN rustup component add rustfmt

##############
# Docker
##############
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce
RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
COPY docker-lib.sh /docker-lib.sh
