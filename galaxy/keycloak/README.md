
## Galaxy keycloak docker
**Authentication and Authorization server.**  

## How to build
1. **Export your theme to ./themes/**
2. **Debug, docker build --no-cache -t c6supper/galaxy-keycloak -f Dockerfile --build-arg LIVENESS_PROBE="$(cat ../../build-env/tcp-port-wait.sh)" ./**
3. **Release, "../../build-env/build.sh c6supper galaxy-keycloak release", the built image will be push to c6supper repositories as default.**
