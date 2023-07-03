docker run \
    -v $HOME:$HOME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --network=host \
    --name nautobot_devenv \
    --hostname nautobot_devenv \
    --restart=unless-stopped \
    -d nautobot_devenv
