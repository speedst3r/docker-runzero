#!/bin/bash

# if org code hasn't been provided, exit out
if [ -z "RUNZERO_ORG_CODE" ]
then
	echo "Organisation download code not provided. Please obtain code from https://console.runzero.com/deploy/download/explorers"
	echo "Run the container with the download code set to environment variable RUNZERO_ORG_CODE"
	exit 1
fi

# Determine the architecture, only arm64/amd64 is supported
MACHINE=`uname -m`

case $MACHINE in
	aarch64)
		ARCH=arm64
		;;
	x86_64)
		ARCH=amd64
		;;
esac

if [ -z "$ARCH" ];
then
	echo "Unable to determine machine architecture -- exiting"
	exit 1
fi

# construct the URL from the explorer ID and architecture
CACHE_BREAK=$(echo $RANDOM | md5sum | head -c 8)
AGENT_URL=https://console.runzero.com/download/explorer/${RUNZERO_ORG_CODE}/${CACHE_BREAK}/runzero-explorer-linux-${ARCH}.bin

mkdir -p /opt/rumble

curl -o /opt/rumble/runzero-explorer.bin ${AGENT_URL}

if [ ! -f /opt/rumble/runzero-explorer.bin ]
then
	echo "Explorer download failed -- exiting"
	exit 1
fi

chmod +x /opt/rumble/runzero-explorer.bin

# Start explorer in manual mode
/opt/rumble/runzero-explorer.bin manual
