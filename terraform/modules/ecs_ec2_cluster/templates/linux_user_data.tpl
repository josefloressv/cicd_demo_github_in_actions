#! /bin/bash

set -euxo pipefail
cat << EOF >> /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
ECS_IMAGE_PULL_BEHAVIOR=always
EOF

${extra_user_data}