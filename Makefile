fqdn ?= cicd.sunzhongmou.com
host ?= ihakula.com
gpg ?= /me@sunwei.xyz.asc

unlock:
	./unlock.sh

gen-pwd:
	./scripts/1.gen-pwd.sh

issue:
	./scripts/4.issue.sh $(fqdn) $(gpg)

up:
	docker-compose up -d

encrypt:
	git-crypt init && \
	git-crypt add-gpg-user me@sunwei.xyz

update-lib:
	git submodule update --init --recursive \
	&& cd lib/letsencrypt \
	&& git pull origin master \

init-lib:
	cd lib && \
	git submodule add -f git@github.com:sunwei/letsencrypt-www.git letsencrypt && \

