from fastapi.testclient import TestClient

from main import app

client = TestClient(app)


def test_health_ready():
    response = client.get("/health/ready")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}
