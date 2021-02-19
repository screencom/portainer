# Deploy

On the docker server, run 

```shell
git clone git@github.com:screencom/portainer.git
cd portainer
make up
```

To update the repo

```shell
cd portainer
make update
```

This stops and updates the repo and images, then restarts it

# Linking it

To link this node to your portainer installation, just add `hostname:9001` as a new Agent endpoint
