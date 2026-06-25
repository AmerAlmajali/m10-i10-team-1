# Team Roster — Module 10 Integration

This file is the team roster artifact for the Module 10 four-service
Docker Compose Integration.

> **No personal names** in this file. Use anonymized initials, role
> tokens, or team-chosen identifiers. The team grading and TA
> cross-reference use `git log --author=<email>` for attribution,
> not names in this file.

---

## Team Identity

- **Team name:** team-1
- **Team Slack channel:** N/A
- **Team-formation date:** 2026-06-24
- **Designated team submitter:** IL-01

---

## Team Roster

| Role | Team Member identifier | Assigned by | Branch | Internal-PR reviewer | Primary files owned |
|---|---|---|---|---|---|
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

### Frontend lead + Infra-Integration lead (IL-01)

- [ ] `web/pages/extract.tsx`
- [ ] `web/pages/kg.tsx`
- [ ] `web/pages/rag.tsx`
- [ ] `web/lib/types.ts`
- [ ] `web/Dockerfile`
- [ ] `tests/frontend/playwright/*.spec.ts`
- [ ] `docker-compose.yml`
- [ ] `seed_neo4j.sh`
- [ ] `seed_weaviate.sh`
- [ ] `.env.example`
- [ ] `README.md` runbook
- [ ] `tests/integration/test_stack_e2e.py`

---

## Escalation Checklist (apply in order)

1. **Inline comment on the internal PR.**
2. **Support Instructor** (no Slack — escalate via cohort channel).
3. **Lead Instructor** — only if role-rebalancing is needed.

---

## Contract-Change Protocol

- **Backend lead** announces any Pydantic shape change via internal
  PR comment **before** the change lands.
- **Frontend + Infra lead** requests new backend fields via an
  internal-PR comment on the Backend lead's branch — does not assume.

---

## Submission

1. The team submitter (IL-01) pastes the team fork URL into
   TalentLMS → Module 10 → Integration Task.
2. Each Team Member separately submits the participation-confirmation
   TalentLMS unit naming their assigned role and the files they authored.