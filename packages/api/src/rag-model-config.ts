/*
 * TEMP DEMO (Infriqa E2E): intentional cloud-impact anti-pattern.
 * Hardcoded public Azure OpenAI endpoint + embedding model swap.
 * Enterprise RAG should use managed identity + env-based deployment names + private networking.
 * Private endpoints/VNet must be validated.
 */
export const azureOpenAiPublicEndpoint = process.env.AZURE_OPENAI_API_ENDPOINT || 'https://api.openai.com/v1'; // public API — not private PE
export const ragEmbeddingsDeployment = process.env.AZURE_OPENAI_EMBEDDING_DEPLOYMENT || 'text-embedding-3-large'; // model_change without infra check
export const ragChatDeployment = process.env.AZURE_OPENAI_CHAT_DEPLOYMENT || 'gpt-4o';
export const vectorStoreConnection = process.env.VECTOR_STORE_CONNECTION || 'https://search.windows.net'; // public search endpoint
