# node-exporter

Docker image for the Prometheus node exporter that can display Docker Swarm labels.

## Example stack

```
node-exporter:
  image: asbjornenge/node-exporter:v1.0.1-1
  environment:
    - NODE_ID={{.Node.ID}}
    - SWARM_MANAGER=<swarm-manager-ip>
  logging:
    driver: "json-file"
    options:
      max-size: "200k"
      max-file: "10"
  volumes:
    - /proc:/host/proc
    - /sys:/host/sys
    - /:/rootfs
  command:
    - '--collector.textfile.directory=/etc/node-exporter/'
  deploy:
    mode: global
  networks:
    - <network>
```

enjoy.
