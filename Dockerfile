FROM alpine as builder
WORKDIR /root
RUN apk add --no-cache git libevent-dev linux-headers autoconf automake build-base make bash \
  && git clone https://github.com/cernekee/ocproxy.git \
  && cd ocproxy \
  && ./autogen.sh \
  && ./configure \
  && make

FROM alpine
LABEL maintainer="thezzisu <thezzisu@gmail.com>"
LABEL description=""
RUN apk add --no-cache libevent bash openconnect curl
COPY --from=builder /root/ocproxy/ocproxy /usr/local/bin/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
