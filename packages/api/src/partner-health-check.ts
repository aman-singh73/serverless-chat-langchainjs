/**
 * Infriqa accuracy — external API call only (safe to delete).
 * Expected: advisory / investigate — NOT Create fix PR.
 */
export async function pingPartnerApi(): Promise<Response> {
  return fetch("https://api.example-partner.com/v1/health");
}
