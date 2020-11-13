#!/bin/sh -e

NODE_LABELS=$(docker -H tcp://$SWARM_MANAGER:4243 node inspect $NODE_ID \
| jq -s '.[] | .[] | {
  id: .ID,
  hostname : .Description.Hostname,
  ip: .Status.Addr,
  name: .Spec.Labels.name,
  type: .Spec.Labels.type,
  zone: .Spec.Labels.zone,
  cloud: .Spec.Labels.cloud,
  state: .Status.State,
}')
NODE_LABEL_IP=$(echo $NODE_LABELS | jq .ip)
NODE_LABEL_NAME=$(echo $NODE_LABELS | jq .name)
NODE_LABEL_TYPE=$(echo $NODE_LABELS | jq .type)
NODE_LABEL_ZONE=$(echo $NODE_LABELS | jq .zone)
NODE_LABEL_CLOUD=$(echo $NODE_LABELS | jq .cloud)
NODE_LABEL_STATE=$(echo $NODE_LABELS | jq .state)

echo "node_meta{node_id=\"$NODE_ID\", container_label_com_docker_swarm_node_id=\"$NODE_ID\", node_name=\"$NODE_NAME\", node_label_name=$NODE_LABEL_NAME, node_label_type=$NODE_LABEL_TYPE, node_label_zone=$NODE_LABEL_ZONE, node_label_cloud=$NODE_LABEL_CLOUD, node_label_state=$NODE_LABEL_STATE, node_label_ip=$NODE_LABEL_IP} 1" > /etc/node-exporter/node-meta.prom

set -- /bin/node_exporter "$@"

exec "$@"
