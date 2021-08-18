FROM alpine as builder
WORKDIR /root
RUN sed -i 's/dl-cdn.alpinelinux.org/opentuna.cn/g' /etc/apk/repositories \
  && apk add --no-cache git libevent-dev linux-headers autoconf automake build-base make bash \
  && git clone https://github.com/cernekee/ocproxy.git \
  && cd ocproxy \
  && ./autogen.sh \
  && ./configure \
  && make

FROM alpine
LABEL maintainer="thezzisu <thezzisu@gmail.com>"
LABEL description=""
RUN sed -i 's/dl-cdn.alpinelinux.org/opentuna.cn/g' /etc/apk/repositories \
  && apk add --no-cache libevent bash openconnect
COPY --from=builder /root/ocproxy/ocproxy /usr/local/bin/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
