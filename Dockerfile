# Dockerfile
ARG TIKA_TAG=latest
FROM apache/tika:${TIKA_TAG}

# Add curl for HTTP healthchecks
RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=10 \
  CMD curl -fsS --max-time 3 http://127.0.0.1:9998/version >/dev/null || exit 1