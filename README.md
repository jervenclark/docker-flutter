# Docker Flutter

This is a fully set up flutter development environment to simplify and accelerate workflow. Included tools are:
- android sdk
- build-tools
- flutter (stable)
- dart


## Build

This `Dockerfile` utilizes experimental docker buildkit syntax and has to be run with docker buildkit enabled. To do so, refer to this part of the [documentation](https://docs.docker.com/develop/develop-images/build_enhancements/).

```
DOCKER_BUILDKIT=1 docker build -t flutter .
```

