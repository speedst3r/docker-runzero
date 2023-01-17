# runZero Explorer
Run a runZero explorer in a Docker container.

## Introduction
This Docker image will download the latest runZero explorer and launch it in manual mode.

## Usage
1. Obtain your Explorer organisation download code from the runZero console (Deploy > Deploy Explorers). The download code is the string beginning with `DT`
2. Generate a 32-byte host identifier so when the container launches it is identified as the same agent. Example:
    ```bash
    $ openssl rand -hex 16
    c55636d323b2deea91f2f7d9a632cd7f
    ```
3. Create the Docker container:
    ```bash
    docker run --name=runzero\
        -e RUNZERO_ORG_CODE=<org code> \
        -e RUMBLE_AGENT_HOST_ID=<host id> \
        --restart=unless-stopped\
        ghcr.io/speedst3r/docker-runzero:master
    ```
4. The explorer should register to your organisation and be visible in the console

### Updating
1. Restart the container, the latest version will be downloaded when the container starts.
