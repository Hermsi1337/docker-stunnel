ARG         ALPINE_VERSION=${ALPINE_VERSION:-3.9}
FROM        alpine:${ALPINE_VERSION}

LABEL       maintainer="https://github.com/Hermsi1337"

ARG         STUNNEL_VERSION=${STUNNEL_VERSION:-5.48-r0}
ARG         LIBRESSL_VERSION=${LIBRESSL_VERSION:-2.7.5-r0}
ENV         ACCEPT_PORT=80 \
            SERVICE=httpsconnect \
            DESTINATION_PORT=443 \
            DESTINATION_IP=0.0.0.0 \
            CLIENT=yes \
            STUNNEL_VERSION=${STUNNEL_VERSION}

COPY        docker-entrypoint.sh /

RUN         apk add --no-cache stunnel=${STUNNEL_VERSION} libressl==${LIBRESSL_VERSION}

ENTRYPOINT ["/docker-entrypoint.sh"]