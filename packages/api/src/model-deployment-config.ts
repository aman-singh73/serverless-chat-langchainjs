// Infriqa demo: hardcoded Azure OpenAI deployment name (safe to delete).
// Clear code fix: read from process.env.AZURE_OPENAI_DEPLOYMENT_NAME instead.
export const AzureOpenAIDeploymentName = "gpt-4o-hardcoded-demo";

export function getAzureOpenAIDeploymentName(): string {
  // BUG: hardcoded deployment — must use environment config in production.
  return AzureOpenAIDeploymentName;
}
