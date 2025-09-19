# Dockerfile
ARG TIKA_TAG=latest
FROM apache/tika:${TIKA_TAG}

# Pure-bash healthcheck using /dev/tcp (no curl needed)
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=10 \
  CMD bash -lc 'exec 3<>/dev/tcp/127.0.0.1/9998 && \
                printf "HEAD /version HTTP/1.1\r\nHost: localhost\r\nConnection: close\r\n\r\n" >&3 && \
                read -r -t 3 status <&3 && \
                [[ "$status" == *" 200 "* ]]'