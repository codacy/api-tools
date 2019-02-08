# api-tools

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/efc2aea3f63c404b9237478bd8dc370d)](https://www.codacy.com/app/Codacy/api-tools?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=codacy/api-tools&amp;utm_campaign=Badge_Grade)
[![CircleCI](https://circleci.com/gh/codacy/api-tools.svg?style=svg)](https://circleci.com/gh/codacy/api-tools)
[![](https://images.microbadger.com/badges/version/codacy/api-tools.svg)](https://microbadger.com/images/codacy/api-tools "Get your own version badge on microbadger.com")

Docker with all the API tools used at Codacy

## Tools

* npmjs.org
    * dredd
    * api2html
    * swagger-cli
    * widdershins

## Usage

```sh
docker run --rm=true -v $PWD:/app --entrypoint=<tool> codacy/api-tools:latest
```

### Validate Specification

#### swagger-cli

```sh
docker run --rm=true -v $PWD:/app \
    --entrypoint=swagger-cli codacy/api-tools:latest validate /app/server/src/main/resources/api.yaml
```

### Generate Documentation

#### api2html

```sh
docker run --rm=true -v $PWD:/app -v /tmp:/tmp \
    --entrypoint=api2html codacy/api-tools:latest -o /tmp/helloworld.html /app/server/src/main/resources/api.yaml
```

#### widdershins

```sh
docker run --rm=true -v $PWD:/app -v /tmp:/tmp \
    --entrypoint=widdershins codacy/api-tools:latest --expandBody /app/server/src/main/resources/api.yaml -o /tmp/worker-api.md
```

## Automated Testing

#### dredd

```sh
docker run --rm=true -v $PWD:/app \
    --net=host \
    --entrypoint=dredd codacy/api-tools:latest /app/server/src/main/resources/api.yaml http://127.0.0.1:8080
```

## Server

This docker provides a server to run tests by performing HTTP requests to this docker.

> Start shell2http server

```sh
docker run --rm=true -v $PWD:/app \
    --net=host \
    -e SHELL2HTTP_PORT=8090
    --entrypoint=/shell2http-api.sh codacy/api-tools:latest
```

#### dredd

> Start application server

```sh
sbt run
```

> Perform request to run dredd

```sh
curl 'http://127.0.0.1:8090/dredd?SWAGGER_LOCATION=%2Fapp%2Fserver%2Fsrc%2Fmain%2Fresources%2Fapi.yaml&SERVER_URL=http%3A%2F%2F127.0.0.1%3A8080'
```

#### swagger-cli

> Perform request to run swagger-cli

```sh
curl 'http://127.0.0.1:8090/swaggerCli?SWAGGER_LOCATION=%2Fapp%2Fserver%2Fsrc%2Fmain%2Fresources%2Fapi.yaml'
```

## Build and Publish

The pipeline in `circleci` can deploy this for you when the code is pushed to the remote.

You can also run everything locally using the makefile:

```sh
$ make help

build and deploy help
---------------------
build                          build docker image
get-next-version-number        get next version number
git-tag                        tag the current commit with the next version and push
push-docker-image              push the docker image to the registry (DOCKER_USER and DOCKER_PASS mandatory)
push-latest-docker-image       push the docker image with the "latest" tag to the registry (DOCKER_USER and DOCKER_PASS mandatory)
```
