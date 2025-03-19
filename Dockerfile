FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update && apt-get install -y \
    curl apt-transport-https ca-certificates gnupg2 \
    software-properties-common lsb-release \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# install docker
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
    docker-ce-cli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /usr/local \
    && curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s

ARG DOCKER_GROUP_GID=999
RUN groupadd -o -g ${DOCKER_GROUP_GID} docker
RUN usermod -g docker jenkins

USER jenkins
ARG JAVA_OPTS
COPY --chown=jenkins ./plugins.txt ./plugins.txt
RUN jenkins-plugin-cli --plugin-file ./plugins.txt
