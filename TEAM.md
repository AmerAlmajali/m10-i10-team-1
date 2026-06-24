# Team Roster - Module 10 Integration

This file tracks the two-member role split for the Module 10 four-service
Docker Compose Integration task.

Do not put personal names here. Use anonymized initials, role tokens, or
team-chosen identifiers. Fill the remaining placeholders manually before
opening the PR.

## Team Identity

- **Team name:** _(fill manually)_
- **Team Slack channel:** _(fill manually)_
- **Team-formation date:** _(fill manually, YYYY-MM-DD)_
- **Designated team submitter:** _(fill manually; likely Frontend + Infra-Integration lead)_

## Team Roster

| Role | Team Member identifier | Assigned by | Branch | Internal-PR reviewer | Primary files owned |
|---|---|---|---|---|---|
| Backend lead | _(teammate anon ID - fill manually)_ | Instructional team | `backend/api-endpoints` | Frontend + Infra-Integration lead | `api/main.py`, `api/models.py`, `api/rag.py`, `api/deps.py`, `api/kg.py`, `api/nlp.py`, `api/Dockerfile` |
| Frontend lead + Infra-Integration lead | _(your anon ID - fill manually)_ | Instructional team | `infra/docker-compose` | Backend lead | `web/pages/{extract,kg,rag}.tsx`, `web/lib/types.ts`, `web/Dockerfile`, `tests/frontend/playwright/*`, `docker-compose.yml`, `scripts/*.sh`, `.env.example`, `README.md`, `tests/integration/*` |

## Manual Items To Fill

- Backend lead anonymized identifier.
- Your anonymized identifier.
- Team name, Slack channel, formation date, and submitter token.
- Reviewer confirmation after the teammate reviews this branch.

## Per-Role File Checklist

The TA cross-references this checklist against the Git history on the team
fork. Check only files the assigned role confirms they authored or reviewed
as their role surface.

### Backend Lead

- [ ] `api/main.py` - path operations, lifespan, CORS middleware
- [ ] `api/models.py` - Pydantic request and response shapes
- [ ] `api/rag.py` - RAG composer with grounding contract
- [ ] `api/deps.py` - FastAPI dependency functions
- [ ] `api/kg.py` - NL-to-Cypher wrapper
- [ ] `api/nlp.py` - entity extraction helper
- [ ] `api/Dockerfile` - Python API image

### Frontend Lead + Infra-Integration Lead

- [x] `web/pages/extract.tsx` - required test id and error handling verified
- [x] `web/pages/kg.tsx` - required test id and error handling verified
- [x] `web/pages/rag.tsx` - required test id and error handling verified
- [x] `web/lib/types.ts` - TypeScript interfaces mirror backend response fields
- [x] `web/Dockerfile` - multi-stage Next.js image verified
- [x] `tests/frontend/playwright/*.spec.ts` - smoke specs authored
- [x] `docker-compose.yml` - four services, healthchecks, depends_on chain, named volumes
- [x] `scripts/seed_neo4j.sh` - Neo4j seeding through the container
- [x] `scripts/seed_weaviate.sh` - Weaviate seeding through the API container
- [x] `scripts/healthcheck_stack.sh` - stack health polling helper
- [x] `.env.example` - placeholder credentials only
- [x] `README.md` - fresh-clone runbook
- [x] `tests/integration/test_stack_e2e.py` - opt-in full stack smoke harness

## Contract-Change Protocol

- Backend lead announces Pydantic shape, route, or backend environment
  changes before they land.
- Frontend lead requests new backend fields through review comments instead
  of assuming response changes.
- Infra-Integration lead announces any `.env`, port, service DNS, or Compose
  healthcheck change before it lands.

If a disagreement comes up, start with an internal PR comment, then move to
the team Slack channel with the TA tagged, then escalate through the course
support path if needed.
