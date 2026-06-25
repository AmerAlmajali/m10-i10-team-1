"""Optional end-to-end smoke harness for the four-service stack.

This test is intentionally opt-in because it builds and starts Docker
images. Run it locally with RUN_STACK_E2E=1 after creating .env.
"""
import json
import os
import subprocess
import urllib.request

import pytest


pytestmark = pytest.mark.skipif(
    os.environ.get("RUN_STACK_E2E") != "1",
    reason="set RUN_STACK_E2E=1 to run the Docker stack smoke test",
)


def run(command: list[str], timeout: int = 600) -> None:
    subprocess.run(command, check=True, timeout=timeout)


def post_json(url: str, payload: dict) -> dict:
    data = json.dumps(payload).encode("utf-8")
    request = urllib.request.Request(
        url,
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    with urllib.request.urlopen(request, timeout=60) as response:
        assert response.status == 200
        return json.loads(response.read().decode("utf-8"))


def test_stack_e2e_seeded_rag_query():
    run(["docker", "compose", "up", "-d", "--build"], timeout=1800)
    run(["bash", "scripts/healthcheck_stack.sh"], timeout=120)
    run(["bash", "scripts/seed_neo4j.sh"], timeout=120)
    run(["bash", "scripts/seed_weaviate.sh"], timeout=900)

    payload = post_json(
        "http://localhost:8000/rag/answer",
        {"question": "How do I prep ginger for stir-fry?", "k": 4},
    )
    assert payload["answer"]
    assert payload["citations"]
