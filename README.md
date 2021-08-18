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
