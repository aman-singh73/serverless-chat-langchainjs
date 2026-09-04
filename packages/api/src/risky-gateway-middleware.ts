// env-var toy.
import type { IncomingMessage, ServerResponse } from "http";

export const GATEWAY_CONFIG = {
  // RISK 1: hardcoded OpenAI key
  openai_api_key: "sk-live-hardcoded-gateway-secret-do-not-ship",
  // RISK 2: hardcoded Cosmos connection string
  cosmosConnection: process.env.COSMOS_CONNECTION_STRING,
  // RISK 3: wildcard CORS
  corsAllowOrigin: "*",
  // RISK 4: auth bypass flag left on
  allowUnauthent
};