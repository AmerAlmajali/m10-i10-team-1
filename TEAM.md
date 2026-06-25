# Team Roster - Module 10 Integration

This file tracks the two-member role split for the Module 10 four-service
Docker Compose Integration task.

Do not put personal names here. Use anonymized initials, role tokens, or
team-chosen identifiers. Fill the remaining placeholders manually before
opening the PR.


## Team Identity

- **Team name:** team-1
- **Team Slack channel:** N/A
- **Team-formation date:** 2026-06-24
- **Designated team submitter:** IL-01


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
| Backend lead | BL-01 | Instructional team | `backend/api-endpoints` | Frontend lead | `api/main.py`, `api/models.py`, `api/rag.py`, `api/deps.py`, `api/Dockerfile` |
| Frontend lead + Infra-Integration lead | IL-01 | Instructional team | `frontend/nextjs-pages` + `infra/docker-compose` | Backend lead | `web/pages/{extract,kg,rag}.tsx`, `web/lib/types.ts`, `web/Dockerfile`, `docker-compose.yml`, `seed_neo4j.sh`, `seed_weaviate.sh`, `.env.example`, `README.md`, `tests/` |

> **2-Team-Member fallback:** Frontend and Infra-Integration roles are
> merged per the fallback composition rule. IL-01 owns all `web/`,
> `docker-compose.yml`, and `seed_*.sh` files.

---

## Per-Role File Checklist

### Backend lead (BL-01)

- [x] `api/main.py` — path operations, `lifespan`, CORS middleware
- [x] `api/models.py` — Pydantic shapes
- [x] `api/rag.py` — RAG composer with grounding contract
- [x] `api/deps.py` — `Depends()` functions
- [x] `api/Dockerfile` — single-stage Python

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

---

## Submission

1. The team submitter (IL-01) pastes the team fork URL into
   TalentLMS → Module 10 → Integration Task.
2. Each Team Member separately submits the participation-confirmation
   TalentLMS unit naming their assigned role and the files they authored.
