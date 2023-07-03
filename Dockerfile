# development environment

# https://levelup.gitconnected.com/how-to-access-host-resources-from-a-docker-container-317e0d1f161e

FROM docker.io/python:3.10-bookworm

ARG USER
ARG UID
ARG GID
ARG DOCKER_GID

RUN mkdir /run/sshd
RUN apt-get update
RUN apt-get -y install ca-certificates curl gnupg openssh-server sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# install docker-ce-cli
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get -y install docker-ce-cli
RUN echo 'docker compose "$@"' > /bin/docker-compose
RUN chmod +x /bin/docker-compose

# set up user
RUN groupadd -g $GID $USER
RUN groupadd -g $DOCKER_GID docker
RUN useradd -m -s /bin/bash -u $UID -g $GID -G sudo,docker $USER

# install additional debian packages
COPY additional_packages /tmp/additional_packages
RUN xargs -a /tmp/additional_packages -r -- apt-get -y install
CMD ["/usr/sbin/sshd", "-D"]
