FROM node:11.9.0

RUN apt-get update \
    && apt-get install -y \
	  openssh-client \
	  ca-certificates \
	  tar \
	  gzip \
	  python-dev \
	  python-pip \
      lsb-release \
      xvfb \
      libgtk-3-dev \
      libnotify-dev \
      libgconf-2-4 \
      libnss3 \
      libxss1 \
      libasound2 \
	&& npm install -g gulp \
    && export DOCKER_VERSION=$(curl --silent --fail --retry 3 https://download.docker.com/linux/static/stable/x86_64/ | grep -o -e 'docker-[.0-9]*-ce\.tgz' | sort -r | head -n 1) \
    && DOCKER_URL="https://download.docker.com/linux/static/stable/x86_64/${DOCKER_VERSION}" \
    && echo Docker URL: $DOCKER_URL \
    && curl --silent --show-error --location --fail --retry 3 --output /tmp/docker.tgz "${DOCKER_URL}" \
    && ls -lha /tmp/docker.tgz \
    && tar -xz -C /tmp -f /tmp/docker.tgz \
    && mv /tmp/docker/* /usr/bin \
    && rm -rf /tmp/docker /tmp/docker.tgz \
    && curl -LO https://kubernetes-helm.storage.googleapis.com/helm-v2.9.0-linux-amd64.tar.gz \
    && tar -xzvf helm-v2.9.0-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/bin/helm \
        && helm init --client-only \
        && helm plugin install https://github.com/nouney/helm-gcs \
    && pip install --upgrade awscli \
      && echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
      && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
      && apt-get update \
      && apt-get install -y google-cloud-sdk kubectl

COPY tools/* /tools/
