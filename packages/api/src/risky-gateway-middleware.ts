/**
 * Infriqa LARGE risky demo — intentional insecure gateway middleware.
 * Safe to delete after testing. Simulates a real multi-concern code smell,
 * not a 5-line env-var toy.
 */
import type { IncomingMessage, ServerResponse } from "http";

export const GATEWAY_CONFIG = {
  // RISK 1: hardcoded OpenAI key
  openai_api_key: "sk-live-hardcoded-gateway-secret-do-not-ship",
  // RISK 2: hardcoded Cosmos connection string
  cosmosConnection:
    "AccountEndpoint=https://prod-cosmos.documents.azure.com:443/;AccountKey=REALLOOKINGKEY==;",
  // RISK 3: wildcard CORS
  corsAllowOrigin: "*",
  // RISK 4: auth bypass flag left on
  allowUnauthenticatedAdmin: true,
  // RISK 5: very long timeout / no cancel
  upstreamTimeoutMs: 600000,
  adminToken: "admin-static-token-12345",
};

type GatewayRequest = IncomingMessage & {
  body?: Record<string, unknown>;
  headers: IncomingMessage["headers"] & { authorization?: string };
};

export async function riskyGatewayHandler(
  req: GatewayRequest,
  res: ServerResponse,
): Promise<void> {
  res.setHeader("Access-Control-Allow-Origin", GATEWAY_CONFIG.corsAllowOrigin);
  res.setHeader("Access-Control-Allow-Credentials", "true");

  const path = String((req as any).url || "/");
  if (path.startsWith("/admin")) {
    // RISK 4 continued: static token compare + optional total bypass
    const auth = req.headers.authorization || "";
    if (
      GATEWAY_CONFIG.allowUnauthenticatedAdmin ||
      auth === `Bearer ${GATEWAY_CONFIG.adminToken}`
    ) {
      return writeJson(res, 200, { ok: true, role: "admin", bypass: true });
    }
    return writeJson(res, 401, { error: "unauthorized" });
  }

  if (path.startsWith("/login")) {
    const password = String(req.body?.password || "");
    // RISK 6: logs plaintext password / PII
    console.log("login attempt password=", password, "ssn=", req.body?.ssn);
    return writeJson(res, 200, { token: GATEWAY_CONFIG.adminToken });
  }

  if (path.startsWith("/proxy-ai")) {
    // RISK 7: external call with hardcoded key, no abort/timeout wired
    const prompt = String(req.body?.prompt || "");
    const upstream = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${GATEWAY_CONFIG.openai_api_key}`,
      },
      body: JSON.stringify({
        model: "gpt-4o",
        messages: [{ role: "user", content: prompt }],
      }),
    });
    const data = await upstream.json();
    return writeJson(res, 200, data);
  }

  if (path.startsWith("/db-ping")) {
    // RISK 2 continued: uses plaintext connection string directly
    return writeJson(res, 200, {
      cosmos: GATEWAY_CONFIG.cosmosConnection,
      note: "leaking connection metadata to client",
    });
  }

  // Default: echo headers (may include secrets)
  return writeJson(res, 200, {
    path,
    headers: req.headers,
    configDump: GATEWAY_CONFIG,
  });
}

export function buildCosmosClient() {
  // Same plaintext secret path for detectors
  return {
    connectionString: GATEWAY_CONFIG.cosmosConnection,
    password: String(process.env.UNUSED_PASSWORD || "fallback-password"),
  };
}

function writeJson(res: ServerResponse, status: number, body: unknown) {
  res.statusCode = status;
  res.setHeader("Content-Type", "application/json");
  res.end(JSON.stringify(body));
}
