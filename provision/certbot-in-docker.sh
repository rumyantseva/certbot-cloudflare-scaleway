#!/bin/bash

curl -fsSL https://get.docker.com/ | sh
systemctl start docker

docker pull horjulf/certbot-cloudflare

docker run --interactive --tty \
    -v /tmp:/etc/letsencrypt \
    -v /tmp:/var/log/letsencrypt \
    -v /tmp/cloudflare.ini:/etc/cloudflare.ini:ro \
    horjulf/certbot-cloudflare \
    certonly --server https://acme-v02.api.letsencrypt.org/directory --dns-cloudflare --dns-cloudflare-credentials /etc/cloudflare.ini -m ${CLOUDFLARE_EMAIL} --agree-tos --no-eff-email -d ${DOMAIN} -d *.${DOMAIN}
