#!/usr/bin/env bash
# Simple webhook listener that triggers Ansible on POST /alert
# Requires: netcat (nc) and ansible installed on host

PORT=5001
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ANSIBLE_PLAYBOOK="$ROOT_DIR/ansible/restart_nginx.yml"
INVENTORY="$ROOT_DIR/ansible/inventory.ini"

echo "🔥 Webhook listener starting on port ${PORT} — watching for Alertmanager POSTs..."

# Use socat or netcat depending on environment. This uses netcat traditional behavior.
# On systems with ncat or busybox nc, flags may differ.
while true; do
  # Listen for one HTTP request, capture headers and body (very small, for Alertmanager).
  # The -l -p flags work on many netcat versions. If your nc doesn't accept -p, run: nc -l ${PORT}
  REQUEST=$(nc -l -p "${PORT}" -q 1 2>/dev/null)
  if echo "$REQUEST" | grep -q "POST /alert"; then
    echo "[$(date +'%F %T')] 🚨 ALERT received from Alertmanager"
    echo "Triggering Ansible playbook: $ANSIBLE_PLAYBOOK"
    ansible-playbook -i "$INVENTORY" "$ANSIBLE_PLAYBOOK"
    echo "[$(date +'%F %T')] ✅ Ansible playbook finished"
  else
    # minimal health output
    echo "[$(date +'%F %T')] Received non-alert or empty request"
  fi
done
