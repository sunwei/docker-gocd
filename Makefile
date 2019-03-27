fqdn ?= example.sunzhongmou.com

unlock:
	./unlock.sh

update-submodule:
	git submodule update --init --recursive

gen-pwd:
	./scripts/1.gen-pwd.sh

build:
	docker-compose build letsencrypt-www

push: unlock
	./docker-push.sh

issue:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml run --rm \
	-e FQDN=$(fqdn) letsencrypt-www

shell:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml run --rm \
	 -e FQDN=$(fqdn) letsencrypt-www \
	/bin/bash

gitcrypt:
	git-crypt init && \
	git-crypt add-gpg-user me@sunwei.xyz

watch:
	ls -d **/* | entr make tests

letsencrypt:
	cd lib && git submodule add -f git@github.com:sunwei/letsencrypt-www.git letsencrypt
