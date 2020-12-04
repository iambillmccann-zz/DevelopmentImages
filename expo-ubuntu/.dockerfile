FROM ubuntu:latest
LABEL version=1.0.0

# Step 1. Setup the dev user account
ENV USERNAME dev
RUN adduser --system --home /home/dev --shell /bin/bash --uid 1005  ${USERNAME}
RUN usermod -aG sudo dev

# Step 2. Install software
RUN apt update && apt install -y \
    git \
    procps \
    sudo
RUN sudo apt-get install apt-utils

RUN sudo apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo apt-get install nodejs

# These are the ports we will expose
EXPOSE 19000
EXPOSE 19001
EXPOSE 19002

# Step 3. Set environment variables
#used by react native builder to set the ip address, other wise 
#will use the ip address of the docker container.
ENV REACT_NATIVE_PACKAGER_HOSTNAME="10.0.0.2"
ENV NPM_CONFIG_PREFIX="/home/$USERNAME/.npm-global"

# Step 4. Copy over the bash scripts
#         entrypoint.sh: Start the container
#         get-source.sh: Pull the source code
COPY *.sh /
RUN chmod +x /entrypoint.sh \
    && chmod +x /get-source.sh

USER $USERNAME

#set the npm global location for dev user
RUN mkdir -p ~/src \
    && mkdir ~/.npm-global \
    && npm install expo-cli --global

#append the .npm-global to path, other wise globally installed packages 
#will not be available in bash
ENV PATH="/home/$USERNAME/.npm-global:/home/$USERNAME/.npm-global/bin:${PATH}"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--gitRepo","NOTSET","--pat","NOTSET","--folder","NOTSET"]