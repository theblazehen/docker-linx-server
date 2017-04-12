FROM golang:alpine 

VOLUME ["/data"]

ENV bind=0.0.0.0:8080
ENV sitename="Linx server"
ENV siteurl="http://example.com"
ENV filespath="/data/files"
ENV metapath="/data/meta"

RUN set -ex \
        && apk add --no-cache --virtual .build-deps git mercurial \
        && go get github.com/andreimarcu/linx-server \
        && apk del .build-deps \
        && mkdir -p /data/{files,meta}

COPY config.ini /data/config/config.ini

EXPOSE 8080
ENTRYPOINT ["/go/bin/linx-server", "-bind", $bind, "-sitename", $sitename, "-siteurl", $siteurl, "-filespath", $filespath, "-metapath", $metapath, "-allowhotlink", "-nologs", "-realip"]

