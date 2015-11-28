FROM ioft/armhf-debian:jessie

RUN sed 's/main/main non-free contrib/' /etc/apt/sources.list > /tmp/sources.list && \
    mv /tmp/sources.list /etc/apt/sources.list && \
    apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        psmisc \
        python \
        python-setuptools \
    && apt-get clean

RUN env DEBIAN_FRONTEND=noninteractive apt-get install -yq ca-certificates gcc
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -yq python-dev
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -yq libavahi-compat-libdnssd1
RUN easy_install pip pybonjour
ADD . /OctoPrint
WORKDIR /OctoPrint
RUN python setup.py install

EXPOSE 5000

CMD /usr/local/bin/octoprint --config /Octoprint/dot_octoprint.yaml --iknowwhatimdoing
