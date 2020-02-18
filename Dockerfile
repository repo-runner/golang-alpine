FROM golang:alpine

LABEL maintainer Knut Ahlers <knut@ahlers.me>

COPY build.sh /usr/local/bin/

RUN set -ex \
 && apk --no-cache add \
      bash \
 && /usr/local/bin/build.sh

ENTRYPOINT ["/usr/local/bin/inner-runner"]
CMD ["--"]
