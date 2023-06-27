# development environment
# to use with podman:
# systemctl --user start podman.socket
# podman run -it -v $XDG_RUNTIME_DIR/podman/podman.sock:/var/run/docker.sock -v .:$(pwd) -w $(pwd) --net=host devenv bash

# https://levelup.gitconnected.com/how-to-access-host-resources-from-a-docker-container-317e0d1f161e

FROM docker.io/python:3.10-bookworm
RUN apt-get update
RUN apt-get -y install ca-certificates curl gnupg vim less
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get -y install docker-ce-cli
RUN echo 'docker compose "$@"' > /bin/docker-compose
RUN chmod +x /bin/docker-compose
WORKDIR /root/
CMD ["bash"]
