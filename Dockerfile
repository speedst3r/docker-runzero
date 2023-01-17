FROM debian:stable-slim

RUN apt update && \    
    apt install -y curl wireless-tools 

# This ID is used to track the Explorer even if the container is rebuilt.
# Set it to a unique 32 character hex ID. You can generate one via:
#
# $ openssl rand -hex 16
#
ENV RUMBLE_AGENT_HOST_ID=c55636d323b2deea91f2f7d9a632cd7f

# If you need to set environment variables to change the Explorer behavior,
# you can do so via the ENV directive. Example:
#
# ENV RUMBLE_AGENT_LOG_DEBUG=true

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

# For full functionality the runZero scanner needs to send and receive raw 
# packets, which requires elevated privileges. 
USER root

# entrypoint script downloads and starts runZero explorer
ENTRYPOINT [ "/entrypoint.sh" ]
