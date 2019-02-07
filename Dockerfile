FROM library/node:10-alpine

LABEL maintainer="Rodrigo Fernandes <rodrigo@codacy.com>"

RUN apk add --no-cache curl tar make gcc g++ python git su-exec && \
  npm install dredd api2html swagger-cli widdershins && \
  apk del make gcc g++ python

RUN \
    curl -L -o shell2http.tar.gz https://github.com/msoap/shell2http/releases/download/1.13/shell2http-1.13.linux.386.tar.gz && \
    tar -xvf shell2http.tar.gz shell2http && \
    chmod +x shell2http && \
    rm -rf shell2http.tar.gz

COPY shell2http-api.sh /shell2http-api.sh

ENV PATH ${PATH}:/node_modules/.bin

CMD []
