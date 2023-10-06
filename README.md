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
OC_ARGS=--protocol=nc
```
Command:
```sh
podman run -d --name pku-vpn --env-file=pku.env -p 11080:1080 ghcr.io/thezzisu/ocproxy:latest
```
Access local port 11080 for a socks5 proxy.
