FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install \
        curl \
        wget \
        postgresql \
        mount \
        psmisc \
        dpkg \
        apt \
        lsb-release \
        sudo \
        gnupg \
        apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

COPY ./ubnt-tools_1.0.deb put-unifi-protect-deb-here/*.deb /
RUN dpkg -i /*.deb \
    && rm -f /*.deb

VOLUME ["/srv/unifi-protect", "/var/lib/postgresql/10/main"]

EXPOSE 7080/tcp 7443/tcp 7444/tcp 7447/tcp 7550/tcp 7442/tcp

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./protect.sh /protect.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/protect.sh"]
