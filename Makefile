fqdn ?= cicd.sunzhongmou.com

unlock:
	./unlock.sh

update-submodule:
	git submodule update --init --recursive \
	&& cd lib/letsencrypt \
	&& git pull origin master

gen-pwd:
	./scripts/1.gen-pwd.sh

issue:
	./scripts/4.issue.sh $(fqdn)

up:
	docker-compose up -d

gitcrypt:
	git-crypt init && \
	git-crypt add-gpg-user me@sunwei.xyz

letsencrypt:
	cd lib && git submodule add -f git@github.com:sunwei/letsencrypt-www.git letsencrypt
