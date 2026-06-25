# Module 10 Integration - Four-Service Docker Compose Stack

This repository integrates the recipe FastAPI backend, Next.js frontend,
Neo4j knowledge graph, and Weaviate vector index into one Docker Compose
stack.

## Team Roles

This is a two-member team:

- Backend lead: owns backend API behavior and backend source contracts.
- Frontend lead + Infra-Integration lead: owns the Next.js pages/types,
  Playwright smoke specs, Compose stack, seed scripts, and runbook.

See [TEAM.md](TEAM.md) for the roster placeholders and per-role checklist.
Do not commit `.env`, virtual environments, Docker volumes, `node_modules`,
or Next.js build output.

## Stack Services

- `neo4j`: `neo4j:5-community`, recipe knowledge graph on ports `7474` and
  `7687`, persisted in the `neo4j_data` named volume.
- `weaviate`: `semitechnologies/weaviate:1.24.10`, vector index on port
  `8080`, persisted in the `weaviate_data` named volume.
- `api`: FastAPI service built from `api/Dockerfile`, exposed on
  `http://localhost:8000`, and connected to Neo4j and Weaviate by Compose
  service DNS.
- `web`: Next.js service built from `web/Dockerfile`, exposed on
  `http://localhost:3000`, with `NEXT_PUBLIC_API_URL` baked as
  `http://localhost:8000` for browser requests.

## Fresh Clone Runbook

Run these commands from the repository root.

```bash
git clone <team-fork-url>
cd m10-i10-team-1

cp .env.example .env
# Edit .env and change NEO4J_PASSWORD from change-me-before-running.

docker compose up -d --build
bash scripts/healthcheck_stack.sh

bash scripts/seed_neo4j.sh
bash scripts/seed_weaviate.sh
```

Open the RAG page:

```text
http://localhost:3000/rag
```

Use this seeded demo question:

```text
How do I prep ginger for stir-fry?
```

Teardown, including named volumes:

```bash
docker compose down -v
```

## Local Validation

```bash
pytest tests/ -v
cd web
npm run build
cd ..
docker compose config
```

The full Docker smoke test is opt-in because it builds and starts the
stack:

```bash
RUN_STACK_E2E=1 pytest tests/integration/test_stack_e2e.py -v
```

## URLs and DNS

Use different URLs depending on where the code runs:

- Browser to API: `http://localhost:8000`
- API container to Neo4j: `bolt://neo4j:7687`
- API container to Weaviate: `http://weaviate:8080`

`localhost` inside a container means that same container. Compose service
names such as `neo4j` and `weaviate` resolve only inside the Compose
network.

## Seed Scripts

- `scripts/seed_neo4j.sh` loads `.env` when present and pipes
  `api/seed.cypher` into `cypher-shell` inside the Neo4j container.
- `scripts/seed_weaviate.sh` runs `python api/seed_weaviate.py` inside the API
  container so the seeder uses the API image dependencies and container DNS.
- `scripts/healthcheck_stack.sh` polls `docker compose ps --format json`
  until `api`, `web`, `neo4j`, and `weaviate` all report `healthy`.

Both seeders are idempotent.
