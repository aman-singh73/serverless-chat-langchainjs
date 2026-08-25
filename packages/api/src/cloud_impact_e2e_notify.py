import requests

# Change Intelligence Task 6b E2E — external/internal HTTP call pattern
def ping_internal_health():
    return requests.get("https://api.internal.company/health")