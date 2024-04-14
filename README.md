# httpd-slim

Scratch image with BusyBox built with httpd applet only. Run as non-root.

Ideal for static web content in environments where disk space is very limited.

## Usage

```Dockerfile
FROM ndfeb/httpd-slim:latest
COPY . .
```

## Customise

You can write a custom `/httpd.conf` without having to change `CMD`.

## Credits

Greatly inspired by [Florin Lipan's article](https://lipanski.com/posts/smallest-docker-image-static-website).
