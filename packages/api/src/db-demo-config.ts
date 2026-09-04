// Infriqa demo: hardcoded Cosmos connection (safe to delete).
// Clear code fix: read connection string from Key Vault / process.env.COSMOS_CONNECTION_STRING.
export const CosmosClientConnectionString =
  "AccountEndpoint=https://demo-cosmos.documents.azure.com:443/;AccountKey=DEMOKEY==;";

export function createCosmosClient() {
  // BUG: plaintext connection string — use env / Key Vault.
  return { connectionString: CosmosClientConnectionString };
}
