#!/usr/bin/env bash
# Seed the running Weaviate service with the chunked-docs fixture.
#
# Idempotent: api/seed_weaviate.py skips chunk_ids already present. The
# seeder runs inside the api container so it uses the same Python
# dependencies and Compose service DNS as the backend.

set -euo pipefail

docker compose exec -T api python api/seed_weaviate.py

echo "Weaviate seeded successfully."