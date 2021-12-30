FROM tezos/tezos:v11.0
#FROM tezos/tezos:master

# Install AWS CLI

USER root
RUN cat /etc/os-release
RUN \
    apk -Uuv add groff less python2 py2-pip curl jq && \
    pip install awscli && \
    apk --purge -v del py-pip && \
    rm /var/cache/apk/*

COPY ./start-updater.sh /home/tezos/start-updater.sh
RUN chmod 755 /home/tezos/start-updater.sh

USER tezos
EXPOSE 8732 9732
ENTRYPOINT ["/home/tezos/start-updater.sh"]
