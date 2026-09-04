// Infriqa demo: restrict CORS to known frontends.
export const CORS_ORIGINS = process.env.CORS_ORIGINS || "https://example.com";

export function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": CORS_ORIGINS,
  };
}