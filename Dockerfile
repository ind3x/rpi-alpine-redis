# Pull base image
FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER Imanol Urra <index02@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S redis && adduser -S -g redis redis

ENV REDIS_VERSION 3.2.0-r0
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update \
        bash \
        gosu@testing \
        redis=${REDIS_VERSION}

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 6379
CMD [ "redis-server" ]
