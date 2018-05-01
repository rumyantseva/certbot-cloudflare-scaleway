# certbot-cloudflare-scaleway

Generate Let's Encrypt certificates automatically with CloudFlare and Scaleway.

If you use CloudFlare to manage your domains and Scaleway to run virtual machines,
this repo will help you to automate creation of the certificates.
The certificate you create will contain the domain itself and its wildcard subdomains.
E.g. if your domain is `my.domain`, you'll get the certificates for `my.domain` and `*.my.domain`

Provide all necessary credentials via environment variables with `Makefile` commands
to create an instance.


## How to run

## Environment variables



REGION?=ams1
ORG?=my_org
TOKEN?=my_token

# Cloudflare parameters
CLOUDFLARE_EMAIL?=my_email
CLOUDFLARE_API_KEY?=my_api_key
DOMAIN?=my.domain
