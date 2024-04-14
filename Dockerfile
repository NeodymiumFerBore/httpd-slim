# Build busybox with httpd applet only
ARG FROM=alpine:3.18.6
FROM ${FROM} AS builder

ARG BUSYBOX_VERSION=1.36.1

# Install build dependencies
RUN apk add gcc musl-dev make perl

# Download busybox files
ADD https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2 /
RUN tar xf busybox-${BUSYBOX_VERSION}.tar.bz2 && \
  mv /busybox-${BUSYBOX_VERSION} /busybox

WORKDIR /busybox
COPY .config .

# Build busybox
RUN make && make install

# Add non-root user
RUN adduser -D httpd

# Build main image
FROM scratch AS main
EXPOSE 8080

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /busybox/_install/bin/busybox /busybox

# Create a blank httpd.conf. CMD uses it, so it's easy to
# configure httpd by overriding this file without having to change CMD
COPY httpd.conf /httpd.conf

USER httpd
WORKDIR /www

CMD ["/busybox", "httpd", "-f", "-v", "-p", "8080", "-c", "/httpd.conf"]
