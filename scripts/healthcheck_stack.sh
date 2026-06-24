#!/usr/bin/env bash
# Poll docker compose ps until api, web, neo4j, and weaviate are healthy.

set -euo pipefail

services=(api web neo4j weaviate)
max_attempts="${STACK_HEALTHCHECK_ATTEMPTS:-45}"
sleep_seconds="${STACK_HEALTHCHECK_SLEEP_SECONDS:-2}"

check_health() {
  local ps_json
  if ! ps_json="$(docker compose ps --format json 2>/dev/null)"; then
    echo "docker compose ps is not available yet"
    return 1
  fi

  PS_JSON="$ps_json" python - "${services[@]}" <<'PY'
import json
import os
import sys

required = set(sys.argv[1:])
raw = os.environ.get("PS_JSON", "").strip()
items = []

if raw:
    try:
        parsed = json.loads(raw)
        if isinstance(parsed, list):
            items.extend(parsed)
        elif isinstance(parsed, dict):
            items.append(parsed)
    except json.JSONDecodeError:
        for line in raw.splitlines():
            line = line.strip().rstrip(",")
            if not line:
                continue
            try:
                parsed = json.loads(line)
            except json.JSONDecodeError:
                continue
            if isinstance(parsed, list):
                items.extend(parsed)
            elif isinstance(parsed, dict):
                items.append(parsed)


def service_name(item):
    name = item.get("Service") or item.get("service") or item.get("Name") or item.get("name")
    if not name:
        return ""
    if name in required:
        return name
    normalized = str(name).replace("_", "-")
    for svc in required:
        if normalized == svc or f"-{svc}-" in normalized or normalized.endswith(f"-{svc}-1"):
            return svc
    return str(name)


states = {}
for item in items:
    svc = service_name(item)
    if svc not in required:
        continue
    health = str(item.get("Health") or item.get("health") or "").lower()
    state = str(
        item.get("State")
        or item.get("state")
        or item.get("Status")
        or item.get("status")
        or ""
    ).lower()
    states[svc] = health or state

not_ready = [
    f"{svc}={states.get(svc, 'missing')}"
    for svc in sorted(required)
    if states.get(svc) != "healthy"
]
if not_ready:
    print(", ".join(not_ready))
    sys.exit(1)
PY
}

for ((attempt = 1; attempt <= max_attempts; attempt++)); do
  if status="$(check_health 2>&1)"; then
    echo "All stack services are healthy."
    exit 0
  fi

  echo "Waiting for stack health (${attempt}/${max_attempts}): ${status}"
  sleep "$sleep_seconds"
done

echo "Timed out waiting for healthy services: ${services[*]}" >&2
docker compose ps >&2 || true
exit 1
