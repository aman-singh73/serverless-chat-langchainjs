/**
 * Infriqa accuracy demo — new Redis / cache dependency (safe to delete).
 * Expected:
 *   Impact: cache + infra_change_required
 *   Create fix PR: tofu/ + golden azure-redis-cache module (not raw resource, not app invent).
 */
import Redis from "ioredis";

export type SessionCache = {
  get(key: string): Promise<string | null>;
  set(key: string, value: string, ttlSeconds: number): Promise<void>;
};

/**
 * App now depends on Azure Cache for Redis for session state.
 * Infra (Redis cache + network access) must exist before this runs in Azure.
 */
export function createSessionCache(redisHost: string, credential: unknown): SessionCache {
  const client = new Redis({
    host: redisHost,
    port: 6380,
    tls: {},
    // credential wiring omitted for demo
  });
  return {
    async get(key: string) {
      return client.get(key);
    },
    async set(key: string, value: string, ttlSeconds: number) {
      await client.set(key, value, "EX", ttlSeconds);
    },
  };
}
