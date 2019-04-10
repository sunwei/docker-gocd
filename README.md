# Docker with GoCD

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Install

### Prerequisites
[Docker](https://www.docker.com/)

### Installing
Download this repo:

```console
git clone git@github.com:sunwei/docker-gocd.git
cd ./docker-gocd
```

## Usage

1. Generate password file for [authentication](https://docs.gocd.org/current/configuration/dev_authentication.html).
```console
# Take `secrets/users.env.example` for example.
mv ./secrets/users.env.example ./secrets/users.env
make gen-pwd
```

2. Use [Let's Encrypt WWW](https://github.com/sunwei/letsencrypt-www) to apply certificate
```console
# Install letsencrypt-www submodule
make update-lib
# Issue domain 
make issue domain=cicd.sunzhongmou.com gpg=/me@sunwei.xyz.asc
```

3. Docker compose up
```console
make up
```

### Demo

[Live](https://cicd.sunzhongmou.com)

Test account: 

username:user1
 
password:password

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details
