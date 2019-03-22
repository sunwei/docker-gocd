fqdn ?= example.sunzhongmou.com

unlock:
	./unlock.sh

update-submodule:
	git submodule update --init --recursive

tests: update-submodule
	export LETS_ENCRYPT_WWW_LIB_PATH=$(CURDIR)/lib && \
	./test/libs/bats/bin/bats ./test/*.sh

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
