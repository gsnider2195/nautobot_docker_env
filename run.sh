docker run \
    -v $HOME:$HOME \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 2222:22 \
    --name nautobot_devenv \
    --hostname nautobot_devenv \
    --restart=unless-stopped \
    -d nautobot_devenv
