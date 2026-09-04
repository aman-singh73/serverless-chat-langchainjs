// Infriqa demo: wildcard CORS (safe to delete).
// Clear code fix: restrict Access-Control-Allow-Origin to known frontends / env.
export const CORS_ORIGINS = "*";

export function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": CORS_ORIGINS,
  };
}
