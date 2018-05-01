
# Scaleway parameters
# region possible values: par1, ams1
REGION?=ams1
ORG?=my_org
TOKEN?=my_token

# Cloudflare parameters
CLOUDFLARE_EMAIL?=my_email
CLOUDFLARE_API_KEY?=my_api_key
DOMAIN?=my.domain

init:
	terraform init

plan:
	terraform plan \
                    -var 'region=${REGION}' \
                    -var 'organization=${ORG}' \
                    -var 'token=${TOKEN}' \
                    -var 'cloudflare_email=${CLOUDFLARE_EMAIL}' \
                    -var 'cloudflare_api_key=${CLOUDFLARE_API_KEY}' \
                    -var 'domain=${DOMAIN}'


apply:
	terraform apply \
                    -var 'region=${REGION}' \
                    -var 'organization=${ORG}' \
                    -var 'token=${TOKEN}' \
                    -var 'cloudflare_email=${CLOUDFLARE_EMAIL}' \
                    -var 'cloudflare_api_key=${CLOUDFLARE_API_KEY}' \
                    -var 'domain=${DOMAIN}'

destroy:
	terraform destroy \
                    -var 'region=${REGION}' \
                    -var 'organization=${ORG}' \
                    -var 'token=${TOKEN}' \
                    -var 'cloudflare_email=${CLOUDFLARE_EMAIL}' \
                    -var 'cloudflare_api_key=${CLOUDFLARE_API_KEY}' \
                    -var 'domain=${DOMAIN}'
