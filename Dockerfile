FROM prom/node-exporter:v1.0.1

USER root

# Copy binaries and the linking script
COPY docker-aarch64 /usr/bin/docker-aarch64
COPY docker-x86_64 /usr/bin/docker-x86_64
COPY jq-aarch64 /usr/bin/jq-aarch64
COPY jq-x86_64 /usr/bin/jq-x86_64
COPY link-binaries.sh /usr/local/bin/link-binaries.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/link-binaries.sh

# Run the linking script
RUN /usr/local/bin/link-binaries.sh

ENTRYPOINT [ "/etc/node-exporter/docker-entrypoint.sh" ]
CMD [ "/bin/node_exporter" ]

