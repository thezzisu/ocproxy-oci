# ocproxy-oci

OCI Image for [cernekee/ocproxy](https://github.com/cernekee/ocproxy)

## Usage

This image reads following environment variables:

| env        | required | description                          |
|------------|----------|--------------------------------------|
| USER       | \*       | VPN username                         |
| PASS       | \*       | VPN password                         |
| URL        | \*       | VPN url                              |
| OC_ARGS    |          | Additional arguments for openconnect |
| PROXY_ARGS |          | Additional arguments for ocproxy     |

To use this image, simply set those envs.

## Examples

### PKU VPN

Content of pku.env:
```
USER=Your student ID
PASS=Your password
URL=vpn.pku.edu.cn
OC_ARGS=--protocol=pulse
ID_CARD=Your ID card last 6 digits
PHONE_NUMBER=The 4th to 7th digits of your mobile phone number. e.g. 12345678910 -> 4567
```
Command:
```sh
podman run -d --name pku-vpn --env-file=pku.env -p 11080:1080 ghcr.io/thezzisu/ocproxy:latest
# or simple docker
docker run -d --name pku-vpn --env-file=pku.env -p 11080:1080 ghcr.io/thezzisu/ocproxy:latest
```
Access local port 11080 for a socks5 proxy.
