docker build \
    --build-arg USER=$(id -un) \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --build-arg DOCKER_GID=$(getent group docker | cut -d: -f3) \
    -t nautobot_devenv .
