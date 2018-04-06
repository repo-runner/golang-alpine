FROM golang:alpine

LABEL maintainer Knut Ahlers <knut@ahlers.me>

COPY build.sh /usr/local/bin/

RUN set -ex \
 && apk --no-cache add \
      bash \
      ca-certificates \
      curl \
      docker \
      git \
      jq \
      make \
 && /usr/local/bin/build.sh \
 && apk --no-cache del --purge jq

ENTRYPOINT ["/usr/local/bin/inner-runner"]
CMD ["--"]
