FROM jdxcode/mise AS mise

FROM debian:trixie-slim
RUN <<EOT
apt-get update
apt-get install -y --no-install-recommends bubblewrap ca-certificates
rm -rf /var/lib/apt/lists/*
EOT

COPY --from=mise /usr/local/bin/mise /usr/local/bin/mise
ENV MISE_DATA_DIR=/mise
ENV MISE_CONFIG_DIR=/mise
ENV MISE_CACHE_DIR=/mise/cache
ENV PATH=/mise/shims:$PATH

ARG AI_JAIL_VERSION=2.5.0
RUN <<EOT
mise use -g github:akitaonrails/ai-jail@${AI_JAIL_VERSION}
ai-jail --version
EOT

RUN groupadd -g 1000 alice && useradd -m -u 1000 -g 1000 -s /bin/bash alice
USER alice
WORKDIR /home/alice
RUN mkdir /home/alice/foo
COPY --chmod=755 test.sh /usr/local/bin/test.sh
CMD ["test.sh"]
