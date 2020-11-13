FROM prom/node-exporter:v1.0.1

USER root

COPY docker-entrypoint.sh /etc/node-exporter/
COPY docker-cli-18.06.3-ce /bin/docker
COPY jq-linux64 /bin/jq

ENTRYPOINT  [ "/etc/node-exporter/docker-entrypoint.sh" ]
CMD [ "/bin/node_exporter" ]
