#!/usr/bin/env bash
# Seed the running Neo4j container with the recipe fixture.
#
# Idempotent: `MERGE` and `CREATE CONSTRAINT IF NOT EXISTS` in seed.cypher
# mean repeat runs do not duplicate nodes.

set -euo pipefail

if [[ -f .env ]]; then
  set -a
  source .env
  set +a
fi

: "${NEO4J_USER:=neo4j}"
: "${NEO4J_PASSWORD:?NEO4J_PASSWORD must be set. Copy .env.example to .env and fill it in.}"

docker compose exec -T neo4j cypher-shell \
  -u "$NEO4J_USER" \
  -p "$NEO4J_PASSWORD" < api/seed.cypher

echo "Neo4j seeded successfully."