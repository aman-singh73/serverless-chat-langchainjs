// Infriqa demo: plaintext API key (safe to delete).
// Clear code fix: use process.env.OPENAI_API_KEY or Key Vault reference.
export const openai_api_key = process.env.OPENAI_API_KEY;

export function getOpenAiApiKey(): string {
  // BUG: hardcoded api_key — must not commit secrets.
  return openai_api_key;
}