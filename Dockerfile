FROM        alpine:latest

LABEL       maintainer="https://github.com/Hermsi1337"

ENV         ACCEPT_PORT=80 \
            SERVICE=httpsconnect \
            DESTINATION_PORT=443 \
            DESTINATION_IP=0.0.0.0 \
            CLIENT=yes

COPY        docker-entrypoint.sh /entrypoint.sh

RUN         apk add --no-cache stunnel libressl && \
            chmod +x /entrypoint.sh

CMD         ["/entrypoint.sh"]