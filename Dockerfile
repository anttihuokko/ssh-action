FROM alpine:3.18

RUN set -eux && \
  apk update && \
  apk upgrade && \
  apk --no-cache add curl ca-certificates vim curl openssh && \
  rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
