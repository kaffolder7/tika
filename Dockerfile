# Dockerfile
ARG TIKA_TAG=latest
FROM apache/tika:${TIKA_TAG}

# Healthcheck using bash + /dev/tcp (no curl needed)
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=10 \
  CMD-SHELL bash -lc ' \
    exec 3<>/dev/tcp/127.0.0.1/9998 && \
    printf "HEAD /version HTTP/1.1\r\nHost: localhost\r\n\r\n" >&3 && \
    timeout 3 cat <&3 | grep -q "200 OK" \
  '