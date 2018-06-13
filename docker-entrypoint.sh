#!/bin/sh

to_file() {

	TEXT="${1}"
	FILE="${2}"
	ECHO="$(command -v echo)"

	${ECHO} "${TEXT}" >> "${FILE}"
}

cd /etc/stunnel

if [ -f stunnel.conf ]
then
    rm stunnel.conf
fi

to_file "foreground = yes
setuid = stunnel
setgid = stunnel
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
cert = /etc/stunnel/stunnel.pem
client = ${CLIENT:-no}" "stunnel.conf"

for DOM in $(echo $SNI | sed "s/,/ /g")
do
	to_file "SNI = ${DOM:-}" "stunnel.conf"
done

to_file "TIMEOUTbusy = 600
TIMEOUTclose = 600
TIMEOUTconnect = 600
TIMEOUTidle = 600

[${SERVICE}]
accept = 0.0.0.0:${ACCEPT_PORT}
connect = ${DESTINATIN_IP}:${DESTINATION_PORT}" "test.conf"

if ! [ -f stunnel.pem ]
then
    openssl req -x509 -nodes -newkey rsa:2048 -days 3650 -subj '/CN=stunnel' \
                -keyout stunnel.pem -out stunnel.pem
    chmod 600 stunnel.pem
fi

exec stunnel "$@"