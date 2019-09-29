FROM alpine:latest

RUN apk --update add --no-cache openssh-client coreutils bash

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
